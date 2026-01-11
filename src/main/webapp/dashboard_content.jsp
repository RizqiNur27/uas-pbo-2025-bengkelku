<%@page import="omat.pbo.servis.mobil.dao.BookingDAO"%>
<%@page import="java.util.*"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="omat.pbo.servis.mobil.model.Booking"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // LOGIKA DATA
    BookingDAO dao = new BookingDAO();
    Map<String, Object> stats = dao.getDashboardStats();
    List<Booking> allBookings = dao.getAllBookings();

    // Format Mata Uang
    NumberFormat rp = NumberFormat.getCurrencyInstance(new Locale("id", "ID"));
    rp.setMaximumFractionDigits(0);
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="css/dashboard_content.css" rel="stylesheet">

    
</head>
<body>

    <div class="d-flex justify-content-between align-items-end mb-5">
        <div>
            <h3 class="fw-bold text-dark m-0">Ringkasan Bengkel 👋</h3>
            <p class="text-muted m-0 mt-1">Pantau performa dan aktivitas reservasi hari ini.</p>
        </div>
        <div class="text-end">
            <span class="text-muted small fw-bold"><%= new java.text.SimpleDateFormat("EEEE, dd MMMM yyyy", new Locale("id", "ID")).format(new Date()) %></span>
        </div>
    </div>

    <div class="row g-4 mb-5">
        <div class="col-md-4">
            <div class="card-stat">
                <div class="d-flex justify-content-between align-items-start">
                    <div>
                        <div class="text-muted small fw-bold mb-1">PENDAPATAN HARI INI</div>
                        <h2 class="fw-bold text-dark m-0"><%= stats.getOrDefault("todayIncome", "0") %></h2>
                        <div class="small text-success mt-2">
                            <i class="fas fa-arrow-up me-1"></i> <span class="text-muted">Total transaksi selesai</span>
                        </div>
                    </div>
                    <div class="icon-shape icon-green">
                        <i class="fas fa-wallet"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card-stat">
                <div class="d-flex justify-content-between align-items-start">
                    <div>
                        <div class="text-muted small fw-bold mb-1">PERLU DIPROSES</div>
                        <h2 class="fw-bold text-dark m-0"><%= stats.getOrDefault("booking_pending", 0) %></h2>
                        <div class="small text-warning mt-2">
                            <i class="fas fa-clock me-1"></i> <span class="text-muted">Unit Menunggu</span>
                        </div>
                    </div>
                    <div class="icon-shape icon-orange">
                        <i class="fas fa-hourglass-half"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card-stat">
                <div class="d-flex justify-content-between align-items-start">
                    <div>
                        <div class="text-muted small fw-bold mb-1">MEKANIK AKTIF</div>
                        <h2 class="fw-bold text-dark m-0"><%= stats.getOrDefault("activeMechanics", 0) %></h2>
                        <div class="small text-primary mt-2">
                            <i class="fas fa-user-check me-1"></i> <span class="text-muted">Personel Standby</span>
                        </div>
                    </div>
                    <div class="icon-shape icon-blue">
                        <i class="fas fa-user-cog"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="data-card">
        <div class="filter-bar">
            <div>
                <h6 class="fw-bold m-0">Aktivitas Reservasi</h6>
                <span class="text-muted small"><%= allBookings.size() %> Total Data Masuk</span>
            </div>
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" class="search-input" placeholder="Cari pelanggan, nopol...">
            </div>
        </div>

        <div class="table-responsive">
            <table class="table table-hover mb-0" id="bookingTable">
                <thead>
                    <tr>
                        <th width="25%">Pelanggan</th>
                        <th width="20%">Kendaraan</th>
                        <th width="25%">Layanan & Mekanik</th>
                        <th width="10%">Tipe</th>
                        <th width="10%">Status</th>
                        <th width="10%" class="text-end">Total Biaya</th>
                    </tr>
                </thead>
                <tbody>
                    <% if(allBookings != null && !allBookings.isEmpty()) { 
                        for (Booking b : allBookings) {
                            String s = b.getStatus().toLowerCase();
                            String statusClass = "bg-waiting";
                            
                            if (s.contains("selesai") || s.contains("done")) statusClass = "bg-selesai";
                            else if (s.contains("proses") || s.contains("process")) statusClass = "bg-proses";
                            else if (s.contains("batal") || s.contains("cancel")) statusClass = "bg-cancel";

                            String resType = b.getTipeReservasi();
                            String typeIcon = (resType != null && resType.equalsIgnoreCase("Online")) ? "fa-globe text-primary" : "fa-store text-success";
                    %>
                    <tr>
                        <td>
                            <div class="fw-bold text-dark"><%= b.getCustomerName() %></div>
                            <div class="text-muted small" style="font-size: 11px;">#RSV-<%= b.getId() %></div>
                        </td>
                        <td>
                            <div class="text-dark"><%= b.getMerekMobil() %></div>
                            <div class="badge bg-light text-dark border fw-normal mt-1" style="font-size: 10px;"><%= b.getNopol() %></div>
                        </td>
                        <td>
                            <div class="fw-bold text-truncate text-dark" style="max-width: 180px; font-size: 13px;"><%= b.getLayanan() %></div>
                            <div class="text-muted small mt-1">
                                <i class="fas fa-wrench me-1 text-muted" style="font-size: 10px;"></i> <%= b.getMechanicName() %>
                            </div>
                        </td>
                        <td>
                            <span class="d-flex align-items-center small text-muted">
                                <i class="fas <%= typeIcon %> me-2"></i> <%= (resType == null) ? "Offline" : resType %>
                            </span>
                        </td>
                        <td>
                            <span class="badge-status <%= statusClass %>"><%= b.getStatus() %></span>
                        </td>
                        <td class="text-end">
                            <span class="fw-bold text-dark"><%= rp.format(b.getTotalBiaya()) %></span>
                        </td>
                    </tr>
                    <% } } else { %>
                    <tr>
                        <td colspan="6" class="text-center py-5">
                            <i class="fas fa-clipboard-list fa-3x mb-3 text-muted opacity-25"></i>
                            <p class="text-muted fw-bold">Belum ada aktivitas hari ini.</p>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        // Fitur Live Search
        document.getElementById('searchInput').addEventListener('keyup', function () {
            let filter = this.value.toLowerCase();
            let rows = document.querySelectorAll('#bookingTable tbody tr');

            rows.forEach(row => {
                let text = row.innerText.toLowerCase();
                row.style.display = text.includes(filter) ? '' : 'none';
            });
        });
    </script>
</body>
</html>