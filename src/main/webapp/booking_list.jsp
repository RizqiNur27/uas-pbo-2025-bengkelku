<%@page import="omat.pbo.servis.mobil.dao.BookingDAO"%>
<%@page import="java.util.List"%>
<%@page import="omat.pbo.servis.mobil.model.Booking"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // LOGIKA DATA (MVC Pattern)
    List<Booking> listBooking = (List<Booking>) request.getAttribute("listBooking");

    // Fallback: Jika data null (akses langsung tanpa servlet)
    if (listBooking == null) {
        BookingDAO dao = new BookingDAO();
        listBooking = dao.getAllBookings();
    }
    
    // Notifikasi SweetAlert
    String swalSuccess = (String) session.getAttribute("swal_success");
    String swalError = (String) session.getAttribute("swal_error");
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Daftar Reservasi</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="css/booking_list.css" rel="stylesheet">

   
</head>
<body>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <% if(swalSuccess != null) { %>
        <script>
            Swal.fire({
                icon: 'success', title: 'Berhasil!', text: '<%= swalSuccess %>',
                showConfirmButton: false, timer: 2000, toast: true, position: 'top-end'
            });
        </script>
        <% session.removeAttribute("swal_success"); %>
    <% } %>
    <% if(swalError != null) { %>
        <script>
            Swal.fire({
                icon: 'error', title: 'Gagal!', text: '<%= swalError %>',
                showConfirmButton: false, timer: 2000, toast: true, position: 'top-end'
            });
        </script>
        <% session.removeAttribute("swal_error"); %>
    <% } %>

    <div class="page-header d-flex justify-content-between align-items-end">
        <div>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-2">
                    <li class="breadcrumb-item small"><a href="BookingServlet?action=dashboard">Dashboard</a></li>
                    <li class="breadcrumb-item small active">List Reservasi</li>
                </ol>
            </nav>
            <h3 class="fw-bold m-0">Daftar Reservasi</h3>
        </div>
        
        <a href="BookingServlet?action=form" class="btn btn-primary rounded-pill px-4 fw-bold shadow-sm" style="background: #4361ee; border: none;">
            <i class="fas fa-plus me-2"></i> Reservasi Baru
        </a>
    </div>

    <div class="data-card">
        <div class="filter-bar">
            <div>
                <h6 class="fw-bold m-0">Data Masuk</h6>
                <span class="text-muted small">Total <span class="fw-bold"><%= (listBooking != null) ? listBooking.size() : 0 %></span> reservasi</span>
            </div>
            
            <div class="search-group">
                <select id="statusFilter" class="form-input-custom" style="width: 160px; cursor: pointer;">
                    <option value="">Semua Status</option>
                    <option value="Waiting">Waiting</option>
                    <option value="Proses">Proses</option>
                    <option value="Selesai">Selesai</option>
                    <option value="Batal">Batal</option>
                </select>

                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchInput" class="form-input-custom search-input" placeholder="Cari pelanggan / nopol...">
                </div>
            </div>
        </div>

        <div class="table-responsive">
            <table class="table table-hover mb-0" id="bookingTable">
                <thead>
                    <tr>
                        <th width="5%">ID</th>
                        <th width="25%">Pelanggan</th>
                        <th width="20%">Kendaraan</th>
                        <th width="25%">Detail Layanan</th>
                        <th width="10%">Status</th>
                        <th width="15%" class="text-end">Tindakan</th>
                    </tr>
                </thead>
                <tbody>
                    <% if(listBooking != null && !listBooking.isEmpty()) { 
                        for(Booking b : listBooking) { 
                            String st = b.getStatus();
                            String cssClass = "bg-waiting"; // Default
                            if(st.toLowerCase().contains("proses")) cssClass = "bg-proses";
                            else if(st.toLowerCase().contains("selesai")) cssClass = "bg-selesai";
                            else if(st.toLowerCase().contains("cancel")) cssClass = "bg-cancel";
                    %>
                    <tr>
                        <td class="text-muted small fw-bold">#<%= b.getId() %></td>
                        <td>
                            <div class="fw-bold text-dark"><%= b.getCustomerName() %></div>
                            <div class="text-muted small">
                                <i class="fab fa-whatsapp text-success me-1"></i> <%= b.getWhatsapp() %>
                            </div>
                        </td>
                        <td>
                            <div class="text-dark"><%= b.getMerekMobil() %></div>
                            <span class="badge bg-light text-dark border mt-1 fw-normal" style="font-size: 10px;"><%= b.getNopol() %></span>
                        </td>
                        <td>
                            <div class="fw-bold text-dark text-truncate" style="font-size: 13px; max-width: 180px;">
                                <%= (b.getKeluhan() != null && !b.getKeluhan().isEmpty()) ? b.getKeluhan() : "Servis Rutin" %>
                            </div>
                            <div class="small text-muted mt-1">
                                <i class="fas fa-wrench me-1" style="font-size: 10px;"></i> 
                                <%= (b.getMechanicName() != null) ? b.getMechanicName() : "-" %>
                            </div>
                        </td>
                        <td>
                            <span class="badge-status <%= cssClass %>"><%= st %></span>
                        </td>
                        <td class="text-end">
                            <%-- LOGIKA TOMBOL BERDASARKAN STATUS --%>
                            
                            <% if("Waiting".equalsIgnoreCase(st) || "Pending".equalsIgnoreCase(st)) { %>
                                <a href="BookingServlet?action=process&id=<%= b.getId() %>" 
                                   class="btn-action btn-process" data-bs-toggle="tooltip" title="Mulai Kerjakan"
                                   onclick="return confirm('Mulai pengerjaan servis ini?');">
                                    <i class="fas fa-tools small"></i>
                                </a>
                                <a href="BookingServlet?action=cancel&id=<%= b.getId() %>" 
                                   class="btn-action btn-cancel" data-bs-toggle="tooltip" title="Batalkan"
                                   onclick="return confirm('Yakin ingin membatalkan booking ini?');">
                                    <i class="fas fa-times small"></i>
                                </a>
                                
                            <% } else if("Proses".equalsIgnoreCase(st)) { %>
                                <a href="BookingServlet?action=complete&id=<%= b.getId() %>" 
                                   class="btn-action btn-finish" data-bs-toggle="tooltip" title="Selesai & Bayar"
                                   onclick="return confirm('Servis selesai? Lanjut ke pembayaran?');">
                                    <i class="fas fa-check small"></i>
                                </a>
                                
                            <% } else { %>
                                <span class="text-muted opacity-25 small"><i class="fas fa-lock"></i></span>
                            <% } %>
                        </td>
                    </tr>
                    <% } } else { %>
                    <tr>
                        <td colspan="6" class="text-center py-5">
                            <i class="fas fa-clipboard-list fa-3x mb-3 text-muted opacity-25"></i>
                            <p class="text-muted fw-bold">Belum ada data reservasi ditemukan.</p>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // --- 1. Fitur Live Search ---
        document.getElementById('searchInput').addEventListener('keyup', function() {
            filterTable();
        });

        // --- 2. Fitur Filter Dropdown ---
        document.getElementById('statusFilter').addEventListener('change', function() {
            filterTable();
        });

        // --- Fungsi Filter Gabungan ---
        function filterTable() {
            let searchVal = document.getElementById('searchInput').value.toLowerCase();
            let statusVal = document.getElementById('statusFilter').value.toLowerCase();
            let rows = document.querySelectorAll('#bookingTable tbody tr');

            rows.forEach(row => {
                // Lewati baris "Belum ada data" jika ada
                if (row.cells.length < 2) return;

                let text = row.innerText.toLowerCase();
                let statusBadge = row.querySelector('.badge-status').innerText.toLowerCase();

                let matchSearch = text.includes(searchVal);
                let matchStatus = (statusVal === "") || statusBadge.includes(statusVal);

                if (matchSearch && matchStatus) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }
        
        // --- Tooltip Bootstrap (Optional) ---
        const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
        const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));
    </script>
</body>
</html>