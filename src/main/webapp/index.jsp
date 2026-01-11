<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>BengkelKu | PBO 2025</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Favicon -->
        <link href="https://icons8.com/icon/35068/car-service" rel="icon">
        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Barlow:wght@600;700&family=Ubuntu:wght@400;500&display=swap"
              rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/animate/animate.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/Index.css" rel="stylesheet">
    </head>

    <body>
        <!-- Spinner Start -->
        <div id="spinner"
             class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Tunggu Sebentar</span>
            </div>
        </div>
        <!-- Spinner End -->


        <!-- Navbar Start -->
        <nav id="navbar" class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0">
            <a href="index.jsp" class="navbar-brand d-flex align-items-center px-4 px-lg-5">
                <h2 class="m-0 text-primary"><i class="fa fa-car me-3"></i>BengkelKu</h2>
            </a>
            <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <div class="navbar-nav ms-auto p-4 p-lg-0">
                    <a href="index.jsp" class="nav-item nav-link active">Beranda</a>
                    <a href="#about" class="nav-item nav-link">Tentang Kami</a>
                    <a href="#service1" class="nav-item nav-link">Layanan</a>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Menu</a>
                        <div class="dropdown-menu fade-up m-0">
                            <a href="reservasi_online_website.jsp" target="blank_" class="dropdown-item">Reservasi</a>
                            <a href="login.jsp" class="dropdown-item">Login Admin</a>
                            <a href="#service1" class="dropdown-item">Layanan</a>
                            <a href="#team" class="dropdown-item">Executive Team</a>
                            <a href="#testimonial" class="dropdown-item">Testimoni</a>
                            <a href="https://nurulfikri.ac.id/" target="blank_" class="dropdown-item">Alamat</a>
                        </div>
                    </div>
                </div>
                <div class="d-flex align-items-center ms-3 gap-3">
    <a href="reservasi_online_website.jsp" target="_blank" class="custom-btn btn-reservasi d-none d-lg-flex">Reservasi Online </a>
        <a href="login.jsp" target="_blank" class="custom-btn btn-login d-none d-lg-flex">Login</a>

                </div>
            </div>
        </nav>
        <!-- Navbar End -->


        <!-- Carousel Start -->
        <div id="carousel" class="container-fluid p-0 mb-5">
            <div id="header-carousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img class="w-100" src="img/gantiban.jpg" alt="Image">
                        <div class="carousel-caption d-flex align-items-center">
                            <div class="container">
                                <div class="row align-items-center justify-content-center justify-content-lg-start">
                                    <div class="col-10 col-lg-7 text-center text-lg-start">
                                        <h1 class="display-3 text-white mb-4 pb-3 animated slideInDown">Jasa Servis Mobil
                                            Terpercaya</h1>
                                    </div>
                                    <div class="col-lg-5 d-none d-lg-flex animated zoomIn">
                                        <img class="img-fluid" src="img/COROUSEL2.png" alt="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <img class="w-100" src="img/MobilCorousel12.jpg" alt="Image">
                        <div class="carousel-caption d-flex align-items-center">
                            <div class="container">
                                <div class="row align-items-center justify-content-center justify-content-lg-start">
                                    <div class="col-10 col-lg-7 text-center text-lg-start">
                                        <h1 class="display-3 text-white mb-4 pb-3 animated slideInDown">Solusi Perbaikan
                                            Kendaraan Andalan</h1>
                                    </div>
                                    <div class="col-lg-5 d-none d-lg-flex animated zoomIn">
                                        <img class="img-fluid" src="img/COROUSEL1.png" alt="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#header-carousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#header-carousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </div>
        <!-- Carousel End -->


        <!-- Service Start -->
        <div id="service" class="container-xxl py-5">
            <div class="container">
                <div class="row g-4">
                    <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                        <div class="d-flex bg-light py-5 px-4">
                            <i class="fa fa-certificate fa-3x text-primary flex-shrink-0"></i>
                            <div class="ps-4">
                                <h5 class="mb-3">Pelayanan Berkualitas</h5>
                                <p>Kami berkomitmen memberikan pelayanan terbaik dengan proses servis yang cepat,
                                    transparan, dan hasil yang memuaskan untuk Anda.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
                        <div class="d-flex bg-light py-5 px-4">
                            <i class="fa fa-users-cog fa-3x text-primary flex-shrink-0"></i>
                            <div class="ps-4">
                                <h5 class="mb-3">Tenaga Ahli</h5>
                                <p>Ditangani oleh teknisi berpengalaman dan tersertifikasi yang memahami berbagai jenis dan
                                    merek mobil secara profesional.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.5s">
                        <div class="d-flex bg-light py-5 px-4">
                            <i class="fa fa-tools fa-3x text-primary flex-shrink-0"></i>
                            <div class="ps-4">
                                <h5 class="mb-3">Peralatan Modern</h5>
                                <p>Didukung peralatan dan teknologi terbaru untuk memastikan diagnosa akurat serta perbaikan
                                    yang aman dan efisien.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Service End -->


        <!-- About Start -->
        <div id="about" class="container-xxl py-5">
            <div class="container">
                <div class="row g-5">
                    <div class="col-lg-6 pt-4" style="min-height: 400px;">
                        <div class="position-relative h-100 wow fadeIn" data-wow-delay="0.1s">
                            <img class="position-absolute img-fluid w-100 h-100" src="img/MobilSehatku1.jpg"
                                 style="object-fit: cover;" alt="">
                            <div class="position-absolute top-0 end-0 mt-n4 me-n4 py-4 px-5"
                                 style="background: rgba(0, 0, 0, .08);">
                                <h1 class="display-4 text-white mb-0">10 <span class="fs-4">Tahun</span></h1>
                                <h4 class="text-white">Pengalaman</h4>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <h1 class="mb-4"><span class="text-primary">Bengkelku</span> adalah layanan servis mobil
                            berkualitas tinggi dengan tenaga ahli dan peralatan modern.</h1>
                        <p class="mb-4">BengkelKu berkomitmen memberikan layanan terbaik dengan proses servis yang
                            cepat, transparan, dan hasil yang memuaskan untuk kendaraan Anda.</p>
                        <div class="row g-4 mb-3 pb-3">
                            <div class="col-12 wow fadeIn" data-wow-delay="0.1s">
                                <div class="d-flex">
                                    <div class="bg-light d-flex flex-shrink-0 align-items-center justify-content-center mt-1"
                                         style="width: 45px; height: 45px;">
                                        <span class="fw-bold text-secondary">01</span>
                                    </div>
                                    <div class="ps-3">
                                        <h6>Profesional & Ahli</h6>
                                        <span>Ditangani oleh teknisi berpengalaman dan tersertifikasi yang memahami berbagai
                                            jenis dan merek mobil secara profesional.</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 wow fadeIn" data-wow-delay="0.3s">
                                <div class="d-flex">
                                    <div class="bg-light d-flex flex-shrink-0 align-items-center justify-content-center mt-1"
                                         style="width: 45px; height: 45px;">
                                        <span class="fw-bold text-secondary">02</span>
                                    </div>
                                    <div class="ps-3">
                                        <h6>Pelayanan Berkualitas Center</h6>
                                        <span>BengkelKu memiliki layanan servis yang berkualitas dengan peralatan modern
                                            dan teknologi terbaru.</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 wow fadeIn" data-wow-delay="0.5s">
                                <div class="d-flex">
                                    <div class="bg-light d-flex flex-shrink-0 align-items-center justify-content-center mt-1"
                                         style="width: 45px; height: 45px;">
                                        <span class="fw-bold text-secondary">03</span>
                                    </div>
                                    <div class="ps-3">
                                        <h6>Kepercayaan & Kepuasan Pelanggan</h6>
                                        <span>Kepercayaan dan kepuasan pelanggan menjadi prioritas utama kami dalam setiap
                                            layanan yang kami berikan.</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <a href="#service1" class="btn btn-primary py-3 px-5">Selengkapnya<i class="fa fa-arrow-right ms-3"></i></a>
                    </div>
                </div>
            </div>
        </div>
        <!-- About End -->


        <!-- Fact Start -->
        <div id="fact" class="container-fluid fact bg-dark my-5 py-5">
            <div class="container">
                <div class="row g-4">
                    <div class="col-md-6 col-lg-3 text-center wow fadeIn" data-wow-delay="0.1s">
                        <i class="fa fa-check fa-2x text-white mb-3"></i>
                        <h2 class="text-white mb-2" data-toggle="counter-up">10</h2>
                        <p class="text-white mb-0">Tahun Pengalaman</p>
                    </div>
                    <div class="col-md-6 col-lg-3 text-center wow fadeIn" data-wow-delay="0.3s">
                        <i class="fa fa-users-cog fa-2x text-white mb-3"></i>
                        <h2 class="text-white mb-2" data-toggle="counter-up">5</h2>
                        <p class="text-white mb-0">Tenaga Ahli</p>
                    </div>
                    <div class="col-md-6 col-lg-3 text-center wow fadeIn" data-wow-delay="0.5s">
                        <i class="fa fa-users fa-2x text-white mb-3"></i>
                        <h2 class="text-white mb-2" data-toggle="counter-up">2000</h2>
                        <p class="text-white mb-0">Pelanggan Yakin</p>
                    </div>
                    <div class="col-md-6 col-lg-3 text-center wow fadeIn" data-wow-delay="0.7s">
                        <i class="fa fa-car fa-2x text-white mb-3"></i>
                        <h2 class="text-white mb-2" data-toggle="counter-up">3000</h2>
                        <p class="text-white mb-0">Mobil yang Diperbaiki</p>
                    </div>
                </div>
            </div>
        </div>
        <!-- Fact End -->

        <!-- Team Start -->
        <div id="team" class="container-xxl py-5">
            <div class="container">
                <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                    <h1 class="mb-5">Pilar BengkelKu</h1>
                </div>
                <div class="row row-cols-lg-5 row-cols-md-3 row-cols-1 g-4">
                    <div class="col wow fadeInUp" data-wow-delay="0.1s">
                        <div class="team-item">
                            <div class="position-relative overflow-hidden">
                                <img class="img-fluid" src="img/adzani1.jpg" alt="">
                                <div class="team-overlay position-absolute start-0 top-0 w-100 h-100">
                                    <a class="btn btn-square mx-1" href="https://www.instagram.com/dzannau?igsh=YW5jOXFscjJxdG1p" target="blank_"><i class="fab fa-instagram"></i></a>
                                </div>
                            </div>
                            <div class="bg-light text-center p-4">
                                <h5 class="fw-bold mb-0">Adzani Naufaldo</h5>
                                <small>Chief Executive Officer</small>
                            </div>
                        </div>
                    </div>
                    <div class="col wow fadeInUp" data-wow-delay="0.3s">
                        <div class="team-item">
                            <div class="position-relative overflow-hidden">
                                <img class="img-fluid" src="img/alhijir.jpg" alt="">
                                <div class="team-overlay position-absolute start-0 top-0 w-100 h-100">
                                    <a class="btn btn-square mx-1" href="https://www.instagram.com/alhijirr?igsh=dmg5ZTliOGNvdTlz" target="blank_"><i class="fab fa-instagram"></i></a>
                                </div>
                            </div>
                            <div class="bg-light text-center p-4">
                                <h5 class="fw-bold mb-0">Al Hijir</h5>
                                <small>Chief Operating Officer</small>
                            </div>
                        </div>
                    </div>
                    <div class="col wow fadeInUp" data-wow-delay="0.5s">
                        <div class="team-item">
                            <div class="position-relative overflow-hidden">
                                <img class="img-fluid" src="img/omat.jpg" alt="">
                                <div class="team-overlay position-absolute start-0 top-0 w-100 h-100">
                                    <a class="btn btn-square mx-1" href="https://www.instagram.com/_ikiomatt?igsh=aWxocHJ5cmVldWdp" target="blank_"><i class="fab fa-instagram"></i></a>
                                </div>
                            </div>
                            <div class="bg-light text-center p-4">
                                <h5 class="fw-bold mb-0">Rizqi Nurrohmat</h5>
                                <small>Head of Service</small>
                            </div>
                        </div>
                    </div>
                    <div class="col wow fadeInUp" data-wow-delay="0.7s">
                        <div class="team-item">
                            <div class="position-relative overflow-hidden">
                                <img class="img-fluid" src="img/salsa.jpg" alt="">
                                <div class="team-overlay position-absolute start-0 top-0 w-100 h-100">
                                    <a class="btn btn-square mx-1" href="https://www.instagram.com/slsabila__15?igsh=MWp6Nmh1M2ZvZ2Jmcg==" target="blank_"><i class="fab fa-instagram"></i></a>
                                </div>
                            </div>
                            <div class="bg-light text-center p-4">
                                <h5 class="fw-bold mb-0">Salsabila</h5>
                                <small>Head of Administration</small>
                            </div>
                        </div>
                    </div>
                    <div class="col wow fadeInUp" data-wow-delay="0.9s">
                        <div class="team-item">
                            <div class="position-relative overflow-hidden">
                                <img class="img-fluid" src="img/yanti1.jpg" alt="">
                                <div class="team-overlay position-absolute start-0 top-0 w-100 h-100">
                                    <a class="btn btn-square mx-1" href="https://www.instagram.com/elnayaputri_?igsh=MTB3aWNta2VzcHUyNQ==" target="blank_"><i class="fab fa-instagram"></i></a>
                                </div>
                            </div>
                            <div class="bg-light text-center p-4">
                                <h5 class="fw-bold mb-0">Yanti Elnaya</h5>
                                <small>Head of Finance</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Team End -->

        <!-- Service Start -->
        <div id="service1" class="container-xxl service py-5">
            <div class="container">
                <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                    <h1 class="mb-5">Layanan Terbaik untuk Kendaraan Anda</h1>
                </div>
                <div class="row g-4 wow fadeInUp" data-wow-delay="0.3s">
                    <div class="col-lg-4">
                        <div class="nav w-100 nav-pills me-4">
                            <button class="nav-link w-100 d-flex align-items-center text-start p-4 mb-4 active"
                                    data-bs-toggle="pill" data-bs-target="#tab-pane-1" type="button">
                                <i class="fa fa-car-side fa-2x me-3"></i>
                                <h4 class="m-0">Diagnosa Kerusakan</h4>
                            </button>
                            <button class="nav-link w-100 d-flex align-items-center text-start p-4 mb-4"
                                    data-bs-toggle="pill" data-bs-target="#tab-pane-2" type="button">
                                <i class="fa fa-car fa-2x me-3"></i>
                                <h4 class="m-0">Servis Mesin</h4>
                            </button>
                            <button class="nav-link w-100 d-flex align-items-center text-start p-4 mb-4"
                                    data-bs-toggle="pill" data-bs-target="#tab-pane-3" type="button">
                                <i class="fa fa-cog fa-2x me-3"></i>
                                <h4 class="m-0">Ganti Ban</h4>
                            </button>
                            <button class="nav-link w-100 d-flex align-items-center text-start p-4 mb-0"
                                    data-bs-toggle="pill" data-bs-target="#tab-pane-4" type="button">
                                <i class="fa fa-oil-can fa-2x me-3"></i>
                                <h4 class="m-0">Ganti Oli</h4>
                            </button>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="tab-content w-100">
                            <div class="tab-pane fade show active" id="tab-pane-1">
                                <div class="row g-4">
                                    <div class="col-md-6" style="min-height: 350px;">
                                        <div class="position-relative h-100">
                                            <img class="position-absolute img-fluid w-100 h-100"
                                                 src="img/diagnosakerusakan.png" style="object-fit: cover;" alt="">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <h3 class="mb-3">Diagnosa Kerusakan</h3>
                                        <p class="mb-4">BengkelKu menyediakan layanan diagnosa kerusakan yang akurat dan
                                            cepat. Tenaga ahli kami akan membantu Anda menemukan dan mengidentifikasi
                                            masalah pada kendaraan Anda.</p>
                                        <p><i class="fa fa-check text-success me-3"></i>Pelayanan Cepat & Berkualitas</p>
                                        <p><i class="fa fa-check text-success me-3"></i>Software Terbaru</p>
                                        <p><i class="fa fa-check text-success me-3"></i>Diagnosa Kerusakan secara Cepat</p>
                                        <a href="reservasi_online_website.jsp" target="blank_" class="btn btn-primary py-3 px-5 mt-3">Reservasi Sekarang<i
                                                class="fa fa-arrow-right ms-3"></i></a>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="tab-pane-2">
                                <div class="row g-4">
                                    <div class="col-md-6" style="min-height: 350px;">
                                        <div class="position-relative h-100">
                                            <img class="position-absolute img-fluid w-100 h-100" src="img/servismesin.jpg"
                                                 style="object-fit: cover;" alt="">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <h3 class="mb-3">Servis Mesin</h3>
                                        <p class="mb-4">BengkelKu berkomitmen memberikan layanan terbaik dengan proses
                                            servis yang cepat, transparan, dan hasil yang memuaskan untuk kendaraan Anda.
                                        </p>
                                        <p><i class="fa fa-check text-success me-3"></i>Suku Cadang Original</p>
                                        <p><i class="fa fa-check text-success me-3"></i>Teknisi Berpengalaman</p>
                                        <p><i class="fa fa-check text-success me-3"></i>Peralatan Modern</p>
                                        <a href="reservasi_online_website.jsp" target="blank_" class="btn btn-primary py-3 px-5 mt-3">Reservasi Sekarang<i
                                                class="fa fa-arrow-right ms-3"></i></a>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="tab-pane-3">
                                <div class="row g-4">
                                    <div class="col-md-6" style="min-height: 350px;">
                                        <div class="position-relative h-100">
                                            <img class="position-absolute img-fluid w-100 h-100" src="img/gantiban.jpg"
                                                 style="object-fit: cover;" alt="">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <h3 class="mb-3">Ganti Ban</h3>
                                        <p class="mb-4">BengkelKu menyediakan layanan ganti ban yang cepat, mudah, dan
                                            aman. Tenaga ahli kami akan membantu Anda mengganti ban pada kendaraan Anda
                                            dengan cepat dan efisien.</p>
                                        <p><i class="fa fa-check text-success me-3"></i>Kualitas 100% Original</p>
                                        <p><i class="fa fa-check text-success me-3"></i>Jaminan Garansi 1 Tahun</p>
                                        <p><i class="fa fa-check text-success me-3"></i>Peralatan Modern</p>
                                        <a href="reservasi_online_website.jsp" target="blank_" class="btn btn-primary py-3 px-5 mt-3">Reservasi Sekarang<i
                                                class="fa fa-arrow-right ms-3"></i></a>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="tab-pane-4">
                                <div class="row g-4">
                                    <div class="col-md-6" style="min-height: 350px;">
                                        <div class="position-relative h-100">
                                            <img class="position-absolute img-fluid w-100 h-100" src="img/gantioli.jpg"
                                                 style="object-fit: cover;" alt="">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <h3 class="mb-3">Ganti Oli</h3>
                                        <p class="mb-4">BengkelKu menyediakan layanan ganti oli yang cepat, mudah, dan
                                            aman. Tenaga ahli kami akan membantu Anda mengganti oli pada kendaraan Anda
                                            dengan cepat dan efisien.</p>
                                        <p><i class="fa fa-check text-success me-3"></i>Oli Berkualitas</p>
                                        <p><i class="fa fa-check text-success me-3"></i>Jaminan Anti Oli Palsu</p>
                                        <p><i class="fa fa-check text-success me-3"></i>Garansi 100%</p>
                                        <a href="reservasi_online_website.jsp" target="blank_" class="btn btn-primary py-3 px-5 mt-3">Reservasi Sekarang<i
                                                class="fa fa-arrow-right ms-3"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Service End -->


        <!-- Testimonial Start -->
        <div id="testimonial" class="container-xxl py-5 wow fadeInUp" data-wow-delay="0.1s">
            <div class="container">
                <div class="text-center">
                    <h1 class="mb-5">Testimoni</h1>
                </div>

                <div class="owl-carousel testimonial-carousel position-relative">

                    <div class="testimonial-item text-center">
                        <img class="bg-light rounded-circle p-2 mx-auto mb-3" src="img/testimoni-1.jpg"
                             style="width: 80px; height: 80px;">
                        <h5 class="mb-0">Harun Yahya</h5>
                        <p>B ***9 BVA</p>
                        <div class="testimonial-text bg-light text-center p-4">
                            <p class="mb-0">
                                Pelayanan sangat memuaskan dan penjelasan kerusakan disampaikan dengan jelas. Mobil kembali
                                nyaman digunakan.
                            </p>
                        </div>
                    </div>

                    <div class="testimonial-item text-center">
                        <img class="bg-light rounded-circle p-2 mx-auto mb-3" src="img/testimoni-1.jpg"
                             style="width: 80px; height: 80px;">
                        <h5 class="mb-0">Bili Nugraha</h5>
                        <p>AB ***0 ZJK</p>
                        <div class="testimonial-text bg-light text-center p-4">
                            <p class="mb-0">
                                Proses servis cepat dan hasilnya sesuai harapan. Mekaniknya ramah dan profesional.
                            </p>
                        </div>
                    </div>

                    <div class="testimonial-item text-center">
                        <img class="bg-light rounded-circle p-2 mx-auto mb-3" src="img/testimoni-1.jpg"
                             style="width: 80px; height: 80px;">
                        <h5 class="mb-0">Yudhistira</h5>
                        <p>F ***8 FGA</p>
                        <div class="testimonial-text bg-light text-center p-4">
                            <p class="mb-0">
                                Hasil servis sangat memuaskan. Masalah mesin langsung teratasi tanpa ribet.
                            </p>
                        </div>
                    </div>

                    <div class="testimonial-item text-center">
                        <img class="bg-light rounded-circle p-2 mx-auto mb-3" src="img/testimoni-1.jpg"
                             style="width: 80px; height: 80px;">
                        <h5 class="mb-0">Syahril Arif</h5>
                        <p>A ***7 FCV</p>
                        <div class="testimonial-text bg-light text-center p-4">
                            <p class="mb-0">
                                Pelayanan ramah, harga masuk akal, dan pengerjaan rapi. Sangat direkomendasikan.
                            </p>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <!-- Testimonial End -->

        <!-- Footer Start -->
        <div id="footer" class="container-fluid bg-dark text-light footer pt-5 mt-5 wow fadeIn" data-wow-delay="0.1s">
            <div class="container py-5">
                <div class="row g-5">
                    <div class="col-lg-3 col-md-6">
                        <h4 class="text-light mb-3">Alamat</h4>
                        <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i>Depok, Jawa Barat</p>
                        <p class="mb-2"><i class="fa fa-phone-alt me-3"></i>0812345678900</p>
                        <p class="mb-2"><i class="fa fa-envelope me-3"></i>BengkelKu                                                        @services.com</p>
                        <div class="d-flex pt-2">
                            <a class="btn btn-outline-light btn-social" href="https://github.com/RizqiNur27/uas-pbo-2025-bengkelku" target="blank_"><i class="fab fa-github"></i></a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h4 class="text-light mb-3">Jam Buka</h4>
                        <h6 class="text-light">Senin - Jumat:</h6>
                        <p class="mb-4">08.00 WIB - 17.00 WIB</p>
                        <h6 class="text-light">Sabtu - Minggu:</h6>
                        <p class="mb-0">09.00 WIB - 17.00 WIB</p>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h4 class="text-light mb-4">Layanan</h4>
                        <a class="btn btn-link" href="#service1">Diagnosa Kerusakan</a>
                        <a class="btn btn-link" href="#service1">Servis Mesin</a>
                        <a class="btn btn-link" href="#service1">Ganti Ban</a>
                        <a class="btn btn-link" href="#service1">Ganti Oli</a>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h4 class="text-light mb-4">Lokasi Kami</h4>
                        <iframe
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d15861.270082892343!2d106.8161441078125!3d-6.3529244999999985!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2e69ec6b07b68ea5%3A0x17da46bdf9308386!2sSTT%20Terpadu%20Nurul%20Fikri%20-%20Kampus%20B!5e0!3m2!1sen!2sid!4v1766873780897!5m2!1sen!2sid"
                            width="250" height="130" style="border: 0;" allowfullscreen="" loading="lazy"></iframe>
                    </div>
                </div>
                <br>
                <div class="container">
                    <div class="copyright">
                        <div class="row">
                            <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                                &copy; <a class="border-bottom" href="index.jsp">BengkelKu</a> | PBO 2025.

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer End -->


        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/wow/wow.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/counterup/counterup.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="lib/tempusdominus/js/moment.min.js"></script>
        <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
        <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

        <!-- Template JavaScript -->
        <script src="js/main.js"></script>
    </body>

</html>