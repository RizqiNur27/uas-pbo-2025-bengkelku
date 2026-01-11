<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Admin | BengkelKu</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
        <link href="css/Login.css" rel="stylesheet">
    </head>
    <body>
        <div class="split-screen">
            <div class="left-side">
                <div class="overlay"></div>
                <div class="content-text">
                    <h1 class="brand-title">BengkelKu</h1>
                    <p class="brand-subtitle">Manajemen Bengkel Profesional dalam Satu Genggaman.</p>
                </div>
            </div>

            <div class="right-side">
                <div class="login-box">
                    <h2 class="form-title">Selamat Datang</h2>
                    <p class="form-subtitle">Masuk untuk mengelola bengkel Anda.</p>

                    <form action="${pageContext.request.contextPath}/LoginServlet" method="POST">                    <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" name="username" class="form-control" placeholder="Masukkan Username Anda" required>
                        </div>
                        <div class="mb-4">
                            <label class="form-label">Password</label>
                            <input type="password" name="password" class="form-control" placeholder="Masukkan Password Anda" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 py-2 fw-bold mb-3">MASUK</button>

                        <div class="text-center">
                            <p class="small text-muted">Belum punya akun? <a href="register.jsp" class="text-primary fw-bold text-decoration-none">Daftar Admin</a></p>
                        </div>
                    </form>

                    <div class="footer-copy text-center">
                        &copy; 2025 BengkelKu System
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            const urlParams = new URLSearchParams(window.location.search);
            const status = urlParams.get('status');
            const error = urlParams.get('error');

            // 1. Alert Error (Login Gagal)
            if (error) {
                Swal.fire({
                    icon: 'error',
                    title: 'Gagal Masuk',
                    text: error,
                    confirmButtonColor: '#d33'
                });
            }

            // 2. Alert Logout Berhasil
            if (status === 'logout') {
                Swal.fire({
                    icon: 'success',
                    title: 'Berhasil Keluar',
                    text: 'Sampai jumpa kembali!',
                    timer: 2000,
                    showConfirmButton: false
                });
            }

            // 3. Alert Registrasi Berhasil (Redirect dari RegisterServlet)
            if (status === 'reg_success') {
                Swal.fire({
                    icon: 'success',
                    title: 'Pendaftaran Berhasil!',
                    text: 'Akun Anda telah dibuat. Silakan login.',
                    confirmButtonColor: '#0d6efd'
                });
            }
        </script>
    </body>
</html>