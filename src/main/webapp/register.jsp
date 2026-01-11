<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daftar Admin | BengkelKu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link href="css/Login.css" rel="stylesheet">
</head>
<body>
    <div class="split-screen">
        <div class="left-side">
            <div class="overlay"></div>
            <div class="content-text">
                <h1 class="brand-title">Bergabunglah</h1>
                <p class="brand-subtitle">Kelola data pelanggan dan servis dengan lebih efisien.</p>
            </div>
        </div>

        <div class="right-side">
            <div class="login-box">
                <h2 class="form-title">Buat Akun Baru</h2>
                <p class="form-subtitle">Isi data admin di bawah ini.</p>

                <form action="RegisterServlet" method="POST">
                    <div class="mb-3">
                        <label class="form-label">Nama Lengkap</label>
                        <input type="text" name="nama_lengkap" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">NIP (Nomor Induk Pegawai)</label>
                        <input type="text" name="nip" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Username</label>
                        <input type="text" name="username" class="form-control" required>
                    </div>
                    <div class="mb-4">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-control" required>
                    </div>
                    
                    <button type="submit" class="btn btn-primary w-100 py-2 fw-bold mb-3">DAFTAR SEKARANG</button>

                    <div class="text-center">
                        <p class="small text-muted">Sudah punya akun? <a href="login.jsp" class="text-primary fw-bold text-decoration-none">Login disini</a></p>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        const urlParams = new URLSearchParams(window.location.search);
        
        // Menangani Error saat Registrasi (misal: Username sudah ada)
        if (urlParams.get('error')) {
            Swal.fire({
                icon: 'warning',
                title: 'Pendaftaran Gagal',
                text: urlParams.get('error'),
                confirmButtonColor: '#f59e0b'
            });
        }
    </script>
</body>
</html>