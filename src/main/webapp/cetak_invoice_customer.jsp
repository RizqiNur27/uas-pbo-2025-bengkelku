<%@page import="omat.pbo.servis.mobil.dao.PaymentDAO"%>
<%@page import="omat.pbo.servis.mobil.model.Payment"%>
<%@page import="omat.pbo.servis.mobil.model.Admin"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // --- 1. LOGIKA JAVA UTAMA ---
    PaymentDAO dao = new PaymentDAO();
    String idParam = request.getParameter("id");
    
    // Ambil semua data (DAO sudah dimodifikasi untuk mengambil data layanan & KM)
    List<Payment> history = dao.getAllPayments();
    Payment p = null;
    
    // Cari data berdasarkan ID yang diklik
    if (idParam != null && !idParam.trim().isEmpty()) {
        try {
            int searchId = Integer.parseInt(idParam);
            if (history != null) {
                for(Payment pay : history) {
                    if(pay.getBookingId() == searchId) {
                        p = pay;
                        break;
                    }
                }
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    // Default: Ambil data paling atas (terbaru) jika tidak ada ID dipilih
    if (p == null && history != null && !history.isEmpty()) {
        p = history.get(0);
    }
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Cetak Invoice #<%= (p != null) ? p.getBookingId() : "" %> - BengkelKu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Courier+Prime:wght@400;700&family=Inconsolata:wght@500;700&display=swap" rel="stylesheet">
    <link href="css/cetak_invoice_customer.css" rel="stylesheet">
</head>
<body>

<div class="container-fluid">
    <div class="row">
        
        <div class="col-md-4 col-lg-3 history-sidebar no-print">
            <div class="d-flex align-items-center mb-4">
                <a href="BookingServlet?action=dashboard" class="text-dark me-3"></a>
                <h5 class="fw-bold m-0">Riwayat Transaksi</h5>
            </div>
            
            <% if(history != null && !history.isEmpty()) { 
                for(Payment h : history) { 
                    boolean active = (p != null && h.getId() == p.getId());
            %>
            <div class="trans-card <%= active ? "active" : "" %>" onclick="location.href='cetak_invoice_customer.jsp?id=<%= h.getBookingId() %>'">
                <div class="d-flex justify-content-between mb-1">
                    <span class="small text-muted">#INV-<%= h.getBookingId() %></span>
                    <span class="badge bg-success-subtle text-success">Lunas</span>
                </div>
                <div class="fw-bold text-dark"><%= h.getNamaCustomer() %></div>
                <div class="text-secondary small mb-1"><%= h.getTglBayarFormatted() %></div>
                <div class="text-accent fw-bold" style="color: var(--accent)"><%= h.getTotalBayarFormatted() %></div>
            </div>
            <% } } else { %>
                <div class="text-center text-muted mt-5"><small>Belum ada transaksi.</small></div>
            <% } %>
        </div>

        <div class="col-md-8 col-lg-9 preview-area">
            <% if (p != null) { %>
            
            <div class="no-print d-flex justify-content-center gap-3 mb-4">
                <button onclick="window.print()" class="btn btn-dark px-4 shadow-sm">
                    <i class="fas fa-print me-2"></i> Cetak Struk
                </button>
            </div>

            <div id="print-area">
                <div class="invoice-paper">
                    
                    <div class="text-center">
                        <i class="fas fa-wrench fa-2x mb-2"></i>
                        <h3 class="fw-bold mb-0 header-brand">BENGKELKU</h3>
                        <p class="tagline mb-1">"Solusi Terbaik Mobil Anda"</p>
                        <p class="small mb-0">Jl. Margonda Raya No. 123</p>
                        <p class="small fw-bold">DEPOK, JAWA BARAT</p>
                    </div>

                    <div class="dashed-line"></div>

                    <div class="d-flex justify-content-between small">
                        <span>Tgl: <%= p.getTglBayarFormatted() %></span>
                        <span>ID: #INV-<%= p.getBookingId() %></span>
                    </div>

                    <div class="dashed-line"></div>

                    <div class="info-row">
                        <span class="info-label">Pelanggan</span>
                        <span class="info-sep">:</span>
                        <span class="info-val"><%= p.getNamaCustomer() %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Kendaraan</span>
                        <span class="info-sep">:</span>
                        <span class="info-val"><%= p.getMerekMobil() %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">No. Polisi</span>
                        <span class="info-sep">:</span>
                        <span class="info-val"><%= p.getNopol() %></span>
                    </div>
                    
                    <% if (p.getKmMobil() > 0) { %>
                    <div class="info-row">
                        <span class="info-label">Odometer</span>
                        <span class="info-sep">:</span>
                        <span class="info-val"><%= p.getKmMobil() %> KM</span>
                    </div>
                    <% } %>
                    
                    <div class="info-row">
                        <span class="info-label">Mekanik</span>
                        <span class="info-sep">:</span>
                        <span class="info-val"><%= p.getNamaMekanik() %></span>
                    </div>

                    <div class="dashed-line"></div>

                    <div class="detail-box">
                        <div class="fw-bold small mb-1">RINCIAN LAYANAN:</div>
                        <div style="white-space: pre-wrap; word-wrap: break-word;">
                            <%-- 
                                Disini kita memanggil getCatatan().
                                Berkat update di PaymentDAO, method ini sekarang mengembalikan:
                                Nama Layanan (jika ada) ATAU Keluhan ATAU Catatan Bayar.
                            --%>
                            <%= p.getCatatan() != null && !p.getCatatan().equals("-") ? p.getCatatan() : "Servis Rutin" %>
                        </div>
                    </div>

                    <div class="dashed-line"></div>
                    
                    <div class="info-row">
                        <span class="info-label">Metode</span>
                        <span class="info-sep">:</span>
                        <span class="info-val"><%= p.getMetodeBayar() %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Kasir</span>
                        <span class="info-sep">:</span>
                        <span class="info-val"><%= p.getAdmin() != null ? p.getAdmin().getNamaLengkap() : "Admin" %></span>
                    </div>

                    <div class="total-box"> 
                        <div class="small text-uppercase">Total Pembayaran</div>
                        <h2 class="fw-bold m-0"><%= p.getTotalBayarFormatted() %></h2>
                        <div class="badge bg-dark text-white mt-2 rounded-0">LUNAS / PAID</div>
                    </div>

                    <div class="text-center small mt-4">
                        <p class="mb-1">Terima kasih atas kepercayaan Anda</p>
                        <p class="mb-0 text-muted">*Garansi servis 7 hari (S&K berlaku).</p>
                        
                        <div class="barcode-sim mt-3"></div>
                        <small class="text-muted"><%= p.getBookingId() %>-<%= java.time.Year.now().getValue() %>-AUTOGEN</small>
                    </div>
                </div>
            </div>
            <% } else { %>
            <div class="text-center mt-5">
                <i class="fas fa-receipt fa-4x text-light mb-3"></i>
                <h4 class="text-muted">Pilih transaksi di samping untuk mencetak</h4>
            </div>
            <% } %>
        </div>
    </div>
</div>

</body>
</html>