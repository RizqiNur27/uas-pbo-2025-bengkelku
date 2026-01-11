<%@page import="java.util.List"%>
<%@page import="omat.pbo.servis.mobil.model.Mechanic"%>
<%@page import="omat.pbo.servis.mobil.model.Service"%>
<%@page import="omat.pbo.servis.mobil.model.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // --- 1. CEK LOGIN ---
    if (session.getAttribute("isLoggedIn") == null || !(Boolean) session.getAttribute("isLoggedIn")) {
        response.sendRedirect("login.jsp?error=Silakan login terlebih dahulu");
        return;
    }
    // --- AMBIL DATA DARI SERVLET ---
    List<Customer> listCustomer = (List<Customer>) request.getAttribute("customers");
    List<Mechanic> listMekanik = (List<Mechanic>) request.getAttribute("mechanics");
    List<Service> listService = (List<Service>) request.getAttribute("services");
    // Validasi Null Safety (Agar tidak error jika dibuka langsung)
    if (listCustomer == null || listMekanik == null || listService == null) {
        response.sendRedirect("BookingServlet?action=form");
        return;
    }
%>

<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Input Order - POS Bengkel</title>

        <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link href="css/reservasi_offline_admin.css" rel="stylesheet">
    </head>
    <body style="padding-bottom: 90px;"> <form action="BookingServlet" method="post" id="formBooking">
            <input type="hidden" name="action" value="add_offline">
            <input type="hidden" name="tipe_reservasi" value="Offline">
            <input type="hidden" name="total_biaya" id="inputTotalBiaya" value="0">

            <input type="hidden" name="customer_id" id="custId" value="0">

            <div class="app-container">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h4 class="fw-800 m-0 text-dark"><i class="fas fa-file-invoice me-2 text-primary"></i>Input Order Baru</h4>
                        <p class="text-muted m-0 small">Formulir penerimaan servis (Walk-in Customer)</p>
                    </div>
                    <div class="text-end">
                        <span class="badge bg-primary bg-opacity-10 text-primary px-3 py-2 rounded-pill">
                            <i class="fas fa-user-circle me-1"></i> Admin: <%= session.getAttribute("nama_lengkap") != null ? session.getAttribute("nama_lengkap") : "Staff"%>
                        </span>
                    </div>
                </div>

                <div class="row g-4">
                    <div class="col-lg-4">
                        <div class="card-panel">
                            <div class="section-header">1. Informasi Pelanggan</div>

                            <div class="mb-3 position-relative">
                                <label class="form-label">CARI NAMA / ID PELANGGAN</label>
                                <div class="input-group">
                                    <input type="text" name="nama_customer" id="nama_customer" class="form-control" 
                                           list="listDataPelanggan" placeholder="Ketik nama..." required autocomplete="off"
                                           onchange="tarikDataOtomatis()"> <button class="btn btn-outline-secondary" type="button" onclick="tarikDataOtomatis()">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>

                                <datalist id="listDataPelanggan">
                                    <% for (Customer c : listCustomer) {%>
                                    <option value="<%= c.getNama()%>">ID: <%= c.getId()%></option>
                                    <% } %>
                                </datalist>
                                <div id="statusPelanggan" class="form-text mt-1"></div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">WHATSAPP</label>
                                <input type="number" name="whatsapp" id="whatsapp" class="form-control" placeholder="08..." required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">ALAMAT</label>
                                <textarea name="alamat" id="alamat" class="form-control" rows="2" placeholder="Alamat lengkap..."></textarea>
                            </div>

                            <hr class="border-light my-4">
                            <div class="section-header border-0 p-0 mb-3">2. Kendaraan</div>

                            <div class="row g-2 mb-3">
                                <div class="col-6">
                                    <label class="form-label">NO. POLISI</label>
                                    <input type="text" name="nopol" id="in_nopol" class="form-control fw-bold text-uppercase" placeholder="B 1234 XYZ" required>
                                </div>
                                <div class="col-6">
                                    <label class="form-label">MEREK/TIPE</label>
                                    <input type="text" name="merek_mobil" class="form-control" placeholder="Contoh: Avanza" required>
                                </div>
                            </div>

                            <div class="mb-2">
                                <label class="form-label">KELUHAN / CATATAN</label>
                                <textarea name="keluhan" class="form-control" rows="2" placeholder="Contoh: Ganti oli, rem bunyi..."></textarea>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-8">
                        <div class="card-panel">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div class="section-header m-0 border-0">3. Pilih Layanan</div>
                                <input type="text" id="cariLayanan" class="form-control form-control-sm w-50" placeholder="Cari layanan servis...">
                            </div>

                            <div class="service-grid mb-4" id="containerLayanan">
                                <% for (Service s : listService) {%>
                                <div class="service-item" data-nama="<%= s.getServiceName().toLowerCase()%>">
                                    <input type="checkbox" class="chk-layanan d-none" 
                                           id="srv<%= s.getId()%>" 
                                           name="layanan_items" 
                                           value="<%= s.getId()%>|<%= s.getPrice()%>"
                                           onchange="hitungTotal()">

                                    <label class="service-box" for="srv<%= s.getId()%>">
                                        <span class="service-title"><%= s.getServiceName()%></span>
                                        <span class="service-price">Rp <%= String.format("%,.0f", s.getPrice())%></span>
                                        <i class="fas fa-check-circle icon-check"></i>
                                    </label>
                                </div>
                                <% } %>
                            </div>

                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label class="form-label">TANGGAL REESRVASI</label>
                                    <input type="date" name="tanggal" id="tanggalInput" class="form-control" required>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">JAM</label>
                                    <input type="time" name="jam_booking" value="08:00" class="form-control" required>
                                </div>
                                <div class="col-md-5">
                                    <label class="form-label">PILIH MEKANIK</label>
                                    <select name="mechanic_id" class="form-select" required>
                                        <option value="">-- Pilih Mekanik --</option>
                                        <% for (Mechanic m : listMekanik) {
                                                if ("Available".equalsIgnoreCase(m.getStatus())) {%>
                                        <option value="<%= m.getId()%>"><%= m.getNamaMekanik()%> (<%= m.getSpesialisasi()%>)</option>
                                        <%   }
                                            }%>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="bottom-bar">
                <div class="container d-flex justify-content-between align-items-center" style="max-width: 1200px;">
                    <div class="d-flex align-items-center gap-3">
                        <div class="bg-light px-3 py-2 rounded border">
                            <small class="text-muted d-block fw-bold" style="font-size: 10px;">METODE BAYAR</small>
                            <select name="metode_bayar" class="form-select form-select-sm border-0 bg-transparent p-0 fw-bold text-dark" style="width: 120px;">
                                <option value="Cash">Tunai / Cash</option>
                                <option value="Transfer">Transfer</option>
                                <option value="QRIS">QRIS</option>
                            </select>
                        </div>
                        <div>
                            <small class="text-muted d-block fw-bold">TOTAL ESTIMASI</small>
                            <h3 class="m-0 fw-bold text-primary" id="txtTotalDisplay">Rp 0</h3>
                        </div>
                    </div>

                    <div class="d-flex gap-2">
                        <a href="BookingServlet?action=dashboard" class="btn btn-light border fw-bold px-4">Batal</a>
                        <button type="submit" class="btn btn-primary fw-bold px-5">
                            <i class="fas fa-paper-plane me-2"></i> Buat Order
                        </button>
                    </div>
                </div>
            </div>
        </form>

        <script>
            // 1. Set Tanggal Hari Ini Default
            document.getElementById('tanggalInput').value = new Date().toISOString().split('T')[0];

            // 2. Auto UpperCase Nopol
            document.getElementById('in_nopol').addEventListener('input', function (e) {
                this.value = this.value.toUpperCase();
            });

            // 3. Pencarian Layanan (Filter Frontend)
            document.getElementById('cariLayanan').addEventListener('keyup', function () {
                let val = this.value.toLowerCase();
                let items = document.querySelectorAll('.service-item');
                items.forEach(el => {
                    let nama = el.getAttribute('data-nama');
                    el.style.display = nama.includes(val) ? 'block' : 'none';
                });
            });

            // 4. Hitung Total Biaya
            function hitungTotal() {
                let total = 0;
                let checkboxes = document.querySelectorAll('.chk-layanan:checked');
                checkboxes.forEach(chk => {
                    // Value format: "ID|Harga"
                    let parts = chk.value.split('|');
                    total += parseFloat(parts[1]);
                });

                // Update Tampilan & Input Hidden
                document.getElementById('inputTotalBiaya').value = total;
                document.getElementById('txtTotalDisplay').innerText = "Rp " + total.toLocaleString('id-ID');
            }

            // 5. --- FITUR AUTOFILL PELANGGAN (AJAX Fetch) ---
            function tarikDataOtomatis() {
                let keyword = document.getElementById("nama_customer").value;
                let statusEl = document.getElementById("statusPelanggan");

                if (keyword.length < 1)
                    return;

                statusEl.innerHTML = "<span class='text-primary'><i class='fas fa-spinner fa-spin'></i> Mencari data...</span>";

                // Memanggil Servlet GetCustomerServlet yang sudah dibuat
                fetch("GetCustomerServlet?keyword=" + encodeURIComponent(keyword))
                        .then(response => response.json())
                        .then(data => {
                            if (data.status === "found") {
                                // Data Ditemukan
                                document.getElementById("whatsapp").value = data.wa;
                                document.getElementById("alamat").value = data.alamat;
                                document.getElementById("custId").value = data.id; // Simpan ID di hidden input

                                // Update Nama agar sesuai database (opsional)
                                document.getElementById("nama_customer").value = data.nama;

                                statusEl.innerHTML = "<span class='text-success fw-bold'><i class='fas fa-check-circle'></i> Data Ditemukan</span>";

                                // Visual feedback
                                document.getElementById("whatsapp").style.backgroundColor = "#dcfce7";
                                setTimeout(() => document.getElementById("whatsapp").style.backgroundColor = "white", 1500);

                            } else {
                                document.getElementById("custId").value = "0"; 
                                document.getElementById("whatsapp").value = "";
                                document.getElementById("alamat").value = "";
                                statusEl.innerHTML = "<span class='text-muted fst-italic'>Data belum ada. Silakan isi manual sebagai <b>Pelanggan Baru</b>.</span>";
                            }
                        })
                        .catch(err => {
                            console.error(err);
                            statusEl.innerHTML = "<span class='text-danger'>Gagal koneksi server.</span>";
                        });
            }

            // 6. Validasi Submit
            document.getElementById('formBooking').addEventListener('submit', function (e) {
                let total = document.getElementById('inputTotalBiaya').value;
                if (total == 0) {
                    e.preventDefault();
                    Swal.fire('Eits!', 'Pilih minimal satu layanan servis dulu ya.', 'warning');
                    return;
                }

                e.preventDefault();
                Swal.fire({
                    title: 'Konfirmasi',
                    text: "Proses order ini sekarang?",
                    icon: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#4361ee',
                    confirmButtonText: 'Ya, Proses!',
                    cancelButtonText: 'Batal'
                }).then((result) => {
                    if (result.isConfirmed) {
                        this.submit();
                    }
                });
            });
        </script>
    </body>
</html>