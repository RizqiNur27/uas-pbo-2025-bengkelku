<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.List"%>
<%@page import="omat.pbo.servis.mobil.model.Payment"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Ambil data dari Servlet
    List<Payment> listPayment = (List<Payment>) request.getAttribute("listPayment");
    String s = request.getParameter("start");
    String e = request.getParameter("end");
    
    // Data Admin yang sedang login (untuk tanda tangan laporan di bawah)
    // Menggunakan Safe Casting agar tidak error jika session kosong
    String adminNamaLogin = (session.getAttribute("nama_lengkap") != null) ? (String) session.getAttribute("nama_lengkap") : "Administrator";
    String adminNipLogin = (session.getAttribute("nip") != null) ? (String) session.getAttribute("nip") : "-";

    // Format Waktu Cetak (Header Laporan)
    LocalDateTime now = LocalDateTime.now();
    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd MMMM yyyy, HH:mm", new Locale("id", "ID"));
    String waktuCetak = now.format(dtf);

    // Format Rupiah
    NumberFormat currency = NumberFormat.getCurrencyInstance(new Locale("id", "ID"));
    
    // Format Tanggal Tabel (lebih ringkas)
    DateTimeFormatter tableDateFmt = DateTimeFormatter.ofPattern("dd/MM/yy HH:mm");
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Laporan Detail Operasional | BengkelKu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="css/laporan_keuangan_harian.css" rel="stylesheet">

    
</head>
<body>

    <div class="no-print d-flex justify-content-between align-items-center mb-4 mx-auto" style="max-width: 297mm;">
        <div>
            <h4 class="fw-bold m-0">Audit Report System | BengkelKu</h4>
            <p class="text-muted small m-0">Data integrasi Reservasi, Pelanggan, & Transaksi</p>
        </div>
        <div class="d-flex gap-2">
            <button onclick="window.print()" class="btn btn-primary shadow-sm fw-bold">
                <i class="fas fa-file-pdf me-2"></i> Print Laporan
            </button>
            
        </div>
    </div>

    <div class="sheet shadow">
        
        <div class="kop-section d-flex justify-content-between align-items-center">
            <div>
                <div class="brand">Bengkel<span style="color: var(--success)">Ku</span></div>
                <p class="m-0 small text-muted">Jl. Margonda Raya No.123</p>
                <p class="m-0 small text-muted">Sistem Manajemen Servis Mobil Terintegrasi</p>
            </div>
            <div class="text-end">
                <h4 class="fw-800 m-0">REKAPITULASI TRANSAKSI</h4>
                <p class="small m-0">Periode: <strong><%= (s != null && !s.isEmpty()) ? s : "Semua Data" %></strong> s/d <strong><%= (e != null && !e.isEmpty()) ? e : "Hari Ini" %></strong></p>
            </div>
        </div>

        <table class="report-table">
            <thead>
                <tr class="text-center">
                    <th width="4%">No</th>
                    <th width="12%">Waktu Bayar</th>
                    <th width="16%">Detail Pelanggan</th>
                    <th width="14%">Kendaraan</th>
                    <th width="20%">Rincian Servis / Keluhan</th>
                    <th width="12%">Kasir (PIC)</th>
                    <th width="10%">Metode</th>
                    <th width="12%">Total Bayar</th>
                </tr>
            </thead>
            <tbody>
                <%
                    BigDecimal grandTotal = BigDecimal.ZERO;
                    int no = 1;
                    
                    if (listPayment != null && !listPayment.isEmpty()) {
                        for (Payment p : listPayment) {
                            // Hitung Grand Total
                            if(p.getTotalBayar() != null) {
                                grandTotal = grandTotal.add(p.getTotalBayar());
                            }
                            
                            // Ambil nama customer aman (cegah null pointer)
                            String namaCust = (p.getNamaCustomer() != null) ? p.getNamaCustomer().toUpperCase() : "-";
                            
                            // Format Tanggal Aman
                            String tglFormatted = "-";
                            if (p.getTglBayar() != null) {
                                tglFormatted = p.getTglBayar().format(tableDateFmt);
                            }
                %>
                <tr>
                    <td class="text-center"><%= no++ %></td>
                    
                    <td>
                        <span class="fw-bold d-block text-dark"><%= tglFormatted %></span>
                        <small class="text-muted">ID: #TRX-<%= p.getId() %></small>
                    </td>
                    
                    <td>
                        <div class="fw-bold text-primary"><%= namaCust %></div>
                        <small class="text-muted">Reservasi ID: #RSV-<%= p.getBookingId() %></small>
                    </td>
                    
                    <td>
                        <span class="d-block fw-600"><%= (p.getMerekMobil() != null) ? p.getMerekMobil() : "-" %></span>
                        <code class="text-dark fw-bold" style="font-size: 10px;"><%= (p.getNopol() != null) ? p.getNopol() : "-" %></code>
                    </td>
                    
                    <td>
                        <div class="text-keluhan">
                            <% if(p.getCatatan() != null && !p.getCatatan().isEmpty()) { %>
                                <%= p.getCatatan() %>
                            <% } else { %>
                                <span class="text-muted fst-italic">- Tidak ada catatan -</span>
                            <% } %>
                        </div>
                    </td>
                    
                    <td>
                        <% if (p.getAdmin() != null && p.getAdmin().getNamaLengkap() != null) { %>
                            <div class="fw-bold" style="font-size: 11px;"><%= p.getAdmin().getNamaLengkap() %></div>
                            <div class="admin-note">NIP: <%= (p.getAdmin().getNip() != null) ? p.getAdmin().getNip() : "-" %></div>
                        <% } else { %>
                            <span class="text-muted small fst-italic">System / Auto</span>
                        <% } %>
                    </td>
                    
                    <td class="text-center">
                        <span class="badge-info"><%= (p.getMetodeBayar() != null) ? p.getMetodeBayar().toUpperCase() : "CASH" %></span>
                    </td>
                    
                    <td class="text-end fw-bold text-dark">
                        <%= currency.format(p.getTotalBayar()) %>
                    </td>
                </tr>
                <%
                        } // End For Loop
                    } else { // Jika Data Kosong
                %>
                <tr>
                    <td colspan="8" class="text-center py-5 text-muted fst-italic bg-light">
                        <i class="fas fa-search mb-2 d-block" style="font-size: 20px;"></i>
                        Tidak ditemukan data transaksi pada periode yang dipilih.
                    </td>
                </tr>
                <% } %>
            </tbody>
            
            <tfoot>
                <tr style="background: #f1f5f9; border-top: 2px solid #334155;">
                    <td colspan="7" class="text-end py-3 fw-800 text-uppercase">Total Pendapatan</td>
                    <td class="text-end py-3 text-primary fw-800" style="font-size: 14px;">
                        <%= currency.format(grandTotal) %>
                    </td>
                </tr>
            </tfoot>
        </table>

        <div class="row mt-5">
            <div class="col-8">
                <div class="p-3 border rounded bg-light" style="font-size: 10px; max-width: 500px;">
                    <h6 class="fw-bold mb-1" style="font-size: 11px;">Disclaimer & Audit Trail:</h6>
                    <p class="m-0 text-secondary">
                        Laporan ini digenerate otomatis oleh sistem BengkelKu. 
                        Dicetak pada <b><%= waktuCetak %></b>. 
                        Data bersifat rahasia perusahaan.
                    </p>
                </div>
            </div>
            <div class="col-4 text-center">
                <p class="small mb-5">Mengetahui / Dicetak oleh:</p>
                <div class="mt-4 pt-3">
                    <h6 class="fw-bold mb-0 text-decoration-underline"><%= adminNamaLogin %></h6>
                    <p class="small text-muted">NIP. <%= adminNipLogin %></p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>