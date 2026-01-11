<%@page import="java.util.List"%>
<%@page import="omat.pbo.servis.mobil.dao.ServiceDAO"%>
<%@page import="omat.pbo.servis.mobil.dao.MechanicDAO"%>
<%@page import="omat.pbo.servis.mobil.model.Service"%>
<%@page import="omat.pbo.servis.mobil.model.Mechanic"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservasi Servis Online | BengkelKu</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="css/reservasi_online_website.css" rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    
</head>
<body>

    <div class="hero-section text-center">
        <div class="container position-relative">
            <h1 class="fw-bold mb-2">Reservasi Servis Mobil</h1>
            <p class="opacity-75 mb-4 lead">Solusi perawatan kendaraan profesional tanpa antre lama</p>
            <a href="index.jsp" class="btn btn-sm btn-outline-light rounded-pill px-4 py-2">
                <i class="fas fa-arrow-left me-1"></i> Kembali ke Beranda
            </a>
        </div>
    </div>

    <div class="container pb-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="form-card">
                    
                    <form action="BookingServlet" method="POST" id="bookingForm">
                        <input type="hidden" name="action" value="add_online">
                        <input type="hidden" name="tipe_reservasi" value="Online">
                        <input type="hidden" name="total_biaya" id="hiddenTotalBiaya" value="0">

                        <div class="mb-4">
                            <div class="section-title"><i class="fas fa-user-circle"></i> Data Diri</div>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="text" name="nama_customer" class="form-control" id="floatingNama" placeholder="Nama Lengkap" required>
                                        <label for="floatingNama">Nama Lengkap</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="number" name="whatsapp" class="form-control" id="floatingWA" placeholder="08xxx" required>
                                        <label for="floatingWA">Nomor WhatsApp</label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="form-floating">
                                        <textarea name="alamat" class="form-control" id="floatingAlamat" style="height: 80px" placeholder="Alamat"></textarea>
                                        <label for="floatingAlamat">Alamat Domisili</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <div class="section-title"><i class="fas fa-car"></i> Data Kendaraan</div>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="text" name="merek_mobil" class="form-control" id="floatingMobil" placeholder="Contoh: Honda Jazz" required>
                                        <label for="floatingMobil">Merek & Tipe Mobil</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="text" name="nopol" class="form-control" id="floatingPlat" placeholder="B 1234 XX" required>
                                        <label for="floatingPlat">Plat Nomor</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <div class="section-title"><i class="fas fa-calendar-alt"></i> Jadwal Servis</div>
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <div class="form-floating">
                                        <input type="date" name="tanggal" class="form-control" id="floatingDate" required>
                                        <label for="floatingDate">Tanggal</label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-floating">
                                        <select name="jam_booking" class="form-select" id="floatingJam" required>
                                            <option value="" selected disabled>Pilih...</option>
                                            <option value="08:00">08:00 WIB</option>
                                            <option value="09:00">09:00 WIB</option>
                                            <option value="10:00">10:00 WIB</option>
                                            <option value="11:00">11:00 WIB</option>
                                            <option value="13:00">13:00 WIB</option>
                                            <option value="14:00">14:00 WIB</option>
                                            <option value="15:00">15:00 WIB</option>
                                        </select>
                                        <label for="floatingJam">Jam Kedatangan</label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-floating">
                                        <select name="mechanic_id" class="form-select" id="floatingMekanik">
                                            <option value="" selected>Acak / Random</option>
                                            <%
                                                MechanicDAO mechDao = new MechanicDAO();
                                                List<Mechanic> mechanics = mechDao.getAllMechanics();
                                                if (mechanics != null) {
                                                    for (Mechanic m : mechanics) {
                                            %>
                                                <option value="<%= m.getId() %>"><%= m.getNamaMekanik() %></option>
                                            <% 
                                                    }
                                                }
                                            %>
                                        </select>
                                        <label for="floatingMekanik">Mekanik (Opsional)</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <div class="section-title"><i class="fas fa-tools"></i> Pilih Layanan</div>
                            <div class="row g-3" id="serviceContainer">
                                <% 
                                    ServiceDAO svcDao = new ServiceDAO();
                                    List<Service> listService = svcDao.getAllServices();
                                    if(listService != null) {
                                        for(Service s : listService) {
                                %>
                                <div class="col-md-6">
                                    <label class="service-option-card w-100">
                                        <input type="checkbox" name="layanan_items" value="<%= s.getId() %>|<%= s.getPrice() %>" onchange="hitungTotal()">
                                        <div class="service-card-content">
                                            <div class="icon-box">
                                                <i class="fas fa-wrench"></i>
                                            </div>
                                            <div class="flex-grow-1">
                                                <div class="fw-bold text-dark"><%= s.getServiceName() %></div>
                                                <div class="small service-price text-muted">Rp <%= String.format("%,.0f", s.getPrice()) %></div>
                                            </div>
                                            <div class="check-indicator text-primary">
                                                <i class="fas fa-check-circle fa-lg"></i>
                                            </div>
                                        </div>
                                    </label>
                                </div>
                                <% 
                                        }
                                    } 
                                %>
                            </div>
                        </div>

                        <div class="mb-4">
                            <div class="total-card d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="mb-1 text-muted text-uppercase fw-bold" style="font-size: 0.8rem;">Estimasi Biaya</h6>
                                    <div class="small text-muted">*Belum termasuk sparepart tambahan jika ada</div>
                                </div>
                                <div class="text-end">
                                    <h3 class="fw-bold text-primary mb-0" id="displayTotal">Rp 0</h3>
                                </div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <div class="section-title"><i class="fas fa-wallet"></i> Metode Pembayaran</div>
                            <div class="form-floating">
                                <select name="metode_bayar" class="form-select" id="floatingBayar">
                                    <option value="Cash" selected>Cash / Bayar di Tempat</option>
                                    <option value="Transfer">Transfer Bank</option>
                                </select>
                                <label for="floatingBayar">Rencana Pembayaran</label>
                            </div>
                        </div>

                        <div class="mb-4">
                            <div class="section-title"><i class="fas fa-comment-dots"></i> Keluhan / Catatan</div>
                            <div class="form-floating">
                                <textarea name="keluhan" class="form-control" id="floatingKeluhan" style="height: 100px" placeholder="Tulis keluhan..."></textarea>
                                <label for="floatingKeluhan">Contoh: Rem bunyi berdecit, AC panas...</label>
                            </div>
                        </div>

                        <div class="row g-3 mt-5">
                            <div class="col-md-4 order-md-1 order-2">
                                <button type="button" class="btn btn-cancel w-100" onclick="konfirmasiBatal()">
                                    <i class="fas fa-times me-2"></i> Batalkan
                                </button>
                            </div>
                            <div class="col-md-8 order-md-2 order-1">
                                <button type="submit" class="btn btn-primary btn-submit text-white shadow w-100">
                                    <i class="fas fa-paper-plane me-2"></i> Kirim Reservasi
                                </button>
                            </div>
                        </div>

                    </form>

                </div>
            </div>
        </div>
    </div>

    <script>
        // --- 1. Fungsi Hitung Total Biaya ---
        function hitungTotal() {
            let total = 0;
            const checkboxes = document.querySelectorAll('input[name="layanan_items"]:checked');
            
            checkboxes.forEach((checkbox) => {
                // Value format: "ID|PRICE" (contoh: "1|50000.0")
                const val = checkbox.value;
                const parts = val.split('|');
                
                if (parts.length > 1) {
                    const price = parseFloat(parts[1]);
                    if (!isNaN(price)) {
                        total += price;
                    }
                }
            });

            // Update Tampilan (Format Rupiah)
            document.getElementById('displayTotal').innerText = formatRupiah(total);
            
            // Update Input Hidden untuk dikirim ke Servlet
            document.getElementById('hiddenTotalBiaya').value = total;
        }

        function formatRupiah(angka) {
            return 'Rp ' + angka.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
        }

        // --- 2. Fungsi Konfirmasi Batal ---
        function konfirmasiBatal() {
            Swal.fire({
                title: 'Batalkan Reservasi?',
                text: "Data yang telah Anda isi akan hilang dan tidak tersimpan.",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#ef4444', // Merah
                cancelButtonColor: '#6b7280', // Abu-abu
                confirmButtonText: 'Ya, Batalkan',
                cancelButtonText: 'Lanjut Mengisi',
                reverseButtons: true
            }).then((result) => {
                if (result.isConfirmed) {
                    // Redirect ke index atau halaman lain
                    window.location.href = 'index.jsp';
                }
            });
        }
    </script>

    <%
        String success = (String) session.getAttribute("swal_success");
        String error = (String) session.getAttribute("swal_error");

        if (success != null) {
    %>
        <script>
            Swal.fire({
                icon: 'success',
                title: 'Reservasi Berhasil!',
                text: '<%= success %>',
                confirmButtonColor: '#2563eb',
                confirmButtonText: 'Selesai'
            }).then(() => {
                // Opsional: Redirect setelah sukses jika perlu
                // window.location.href = 'history.jsp';
            });
        </script>
    <%
            session.removeAttribute("swal_success");
        }

        if (error != null) {
    %>
        <script>
            Swal.fire({
                icon: 'error',
                title: 'Terjadi Kesalahan',
                text: '<%= error %>',
                confirmButtonColor: '#d33'
            });
        </script>
    <%
            session.removeAttribute("swal_error");
        }
    %>
    
</body>
</html>