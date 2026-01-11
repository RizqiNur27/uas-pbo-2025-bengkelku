
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard | BengkelKu</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="css/dashboard.css" rel="stylesheet">

        
    </head>
    <body>

        <aside class="sidebar">
            <div class="sidebar-header">
                <div class="logo-box"><i class="fas fa-car text-white small"></i></div>
                <span class="fw-bold fs-5 tracking-tight text-dark">Bengkel<span style="color: var(--accent-color)">Ku</span></span>
            </div>

            <div class="nav-group">
                <div class="nav-label">Analytics</div>
                <a href="dashboard_content.jsp" target="window" class="active"><i class="fas fa-home"></i> Dashboard</a>

                <a href="CustomerServlet?action=list" target="window">
                    <i class="fas fa-address-book"></i> Database Pelanggan
                </a>
                <a href="booking_list.jsp" target="window"><i class="fas fa-calendar-check"></i> Tambah Reservasi</a>
            </div>

            <div class="nav-group">
                <div class="nav-label">Operasional</div>
                <a href="MechanicServlet?action=list" target="window"><i class="fas fa-wrench"></i> Mekanik</a>                
                <a href="data_layanan.jsp" target="window"><i class="fas fa-tags"></i> Layanan</a>
            </div>

            <div class="nav-group">
                <div class="nav-label">Keuangan & Laporan</div>
                <a href="cetak_invoice_customer.jsp" target="window"><i class="fas fa-file-invoice-dollar"></i> Cetak Invoice</a>

                <a href="PaymentServlet?action=history" target="window"><i class="fas fa-chart-line"></i> Income Harian</a>
            </div>

            <div class="logout-box">
                <a href="LogoutServlet" class="btn-logout">
                    <i class="fas fa-power-off me-2"></i> Keluar Sistem
                </a>
            </div>
        </aside>

        <div class="main-container">
            <header>
                <div class="search-box">
                    <i class="fas fa-search me-2 small"></i>
                    <input type="text" id="mainSearch" placeholder="Cari data..." 
                           style="border: none; background: transparent; outline: none; font-size: 13px; width: 100%;">
                </div>

                <div class="d-flex align-items-center gap-4">
                    <div class="text-end d-none d-md-block border-end pe-4" style="border-color: var(--border-color) !important;">
                        <div id="realtime-clock" class="fw-bold text-dark" style="font-size: 14px; letter-spacing: 0.5px;"></div>
                        <div id="realtime-date" class="text-muted" style="font-size: 11px; font-weight: 600;"></div>
                    </div>

                    <div class="user-profile">
                        <div class="text-end">
                            <div class="fw-bold small text-dark">${sessionScope.nama_lengkap}</div>
                            <div style="font-size: 10px; color: var(--accent-color); font-weight: 700; letter-spacing: 0.5px;">
                                NIP ${not empty sessionScope.nip ? sessionScope.nip : "NIP TIDAK DITEMUKAN"}
                            </div>
                        </div>
                        <img src="https://ui-avatars.com/api/?name=${sessionScope.nama_lengkap}&background=10b981&color=fff&bold=true" 
                             class="rounded-circle shadow-sm" width="38" height="38">
                    </div>
                </div>
            </header>

            <iframe name="window" src="dashboard_content.jsp"></iframe>
        </div>

        <script>
            const links = document.querySelectorAll('.sidebar a');
            links.forEach(link => {
                link.addEventListener('click', function () {
                    if (this.classList.contains('btn-logout'))
                        return;
                    links.forEach(l => l.classList.remove('active'));
                    this.classList.add('active');
                });
            });

            document.querySelector('.search-box input').addEventListener('keyup', function () {
                let filter = this.value.toLowerCase();
                let iframeDoc = document.getElementsByName('window')[0].contentDocument;
                let rows = iframeDoc.querySelectorAll('#customerTable tbody tr');

                rows.forEach(row => {
                    row.style.display = row.innerText.toLowerCase().includes(filter) ? '' : 'none';
                });
            });

            document.getElementById('mainSearch').addEventListener('keyup', function () {
                let filter = this.value.toLowerCase();

                let iframe = document.getElementsByName('window')[0];
                let iframeDoc = iframe.contentDocument || iframe.contentWindow.document;

                let rows = iframeDoc.querySelectorAll('tbody tr');

                rows.forEach(row => {
                    let text = row.innerText.toLowerCase();
                    row.style.display = text.includes(filter) ? '' : 'none';
                });
            });

            function updateClock() {
                const now = new Date();

                const hours = String(now.getHours()).padStart(2, '0');
                const minutes = String(now.getMinutes()).padStart(2, '0');
                const seconds = String(now.getSeconds()).padStart(2, '0');
                document.getElementById('realtime-clock').innerText = hours + ":" + minutes + ":" + seconds;

                const options = {weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'};
                const dateString = now.toLocaleDateString('id-ID', options);
                document.getElementById('realtime-date').innerText = dateString;
            }

            setInterval(updateClock, 1000);
            updateClock();
        </script>
    </body>
</html>