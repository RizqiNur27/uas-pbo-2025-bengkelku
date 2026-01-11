\# 🚗 BengkelKu - Sistem Informasi Servis Mobil



!\[Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge\&logo=openjdk\&logoColor=white)

!\[PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge\&logo=postgresql\&logoColor=white)

!\[Bootstrap](https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge\&logo=bootstrap\&logoColor=white)



\*\*BengkelKu\*\* adalah aplikasi berbasis web yang dirancang untuk memudahkan pelanggan dalam melakukan reservasi servis mobil secara online dan membantu admin mengelola data antrian servis. Proyek ini dikembangkan sebagai \*\*Final Project (UAS)\*\* mata kuliah \*\*Pemrograman Berorientasi Objek (PBO)\*\*.



---



\## 📋 Fitur Utama



\### 👤 Halaman Pelanggan (User)

\* \*\*Reservasi Online:\*\* Booking jadwal servis tanpa harus antre manual.

\* \*\*Informasi Layanan:\*\* Melihat daftar layanan servis yang tersedia.

\* \*\*Cek Status:\*\* Melihat riwayat atau status booking.



\### 🛠 Halaman Admin

\* \*\*Login Admin:\*\* Keamanan akses untuk pengelolaan data.

\* \*\*Manajemen Reservasi:\*\* Melihat, menyetujui, atau menolak reservasi masuk.

\* \*\*CRUD Data:\*\* Mengelola data pelanggan, jenis servis, dan laporan.



---



\## 💻 Teknologi yang Digunakan



Aplikasi ini dibangun menggunakan teknologi standar industri:



\* \*\*Backend:\*\* \* Java Development Kit (JDK 17/21)

&nbsp;   \* Java Server Pages (JSP) \& Servlet

\* \*\*Database:\*\* \* PostgreSQL

&nbsp;   \* JDBC Driver (Koneksi Java ke Database)

\* \*\*Frontend:\*\* \* HTML5 \& CSS3

&nbsp;   \* \*\*Bootstrap 5\*\* (Framework CSS untuk tampilan responsif)

&nbsp;   \* \*\*FontAwesome\*\* (Ikon antarmuka)

\* \*\*Tools \& Lainnya:\*\* \* \*\*Apache NetBeans\*\* (IDE)

&nbsp;   \* \*\*Apache Maven\*\* (Manajemen Project \& Dependency)

&nbsp;   \* \*\*Git \& GitHub\*\* (Version Control)



---



\## ⚙️ Cara Menjalankan Project (Instalasi)



Ikuti langkah-langkah ini untuk menjalankan aplikasi di komputer lokal:



\### 1. Persiapan Database

1\.  Pastikan \*\*PostgreSQL\*\* sudah terinstall.

2\.  Buka \*\*pgAdmin 4\*\*.

3\.  Buat database baru dengan nama `pbo\_servis\_mobil`.

4\.  Klik kanan database tersebut -> \*\*Restore\*\*.

5\.  Pilih file \*\*`pbo\_servis\_mobil.sql`\*\* yang ada di dalam repository ini.



\### 2. Konfigurasi Koneksi

1\.  Buka project di \*\*NetBeans\*\*.

2\.  Cari file koneksi database bernama \*\*`KoneksiDB.java`\*\* (biasanya di package `util` atau `config`).

3\.  Sesuaikan \*\*Username\*\* dan \*\*Password\*\* database PostgreSQL kamu:

&nbsp;   ```java

&nbsp;   // Contoh konfigurasi di KoneksiDB.java

&nbsp;   String url = "jdbc:postgresql://localhost:5432/pbo\_servis\_mobil";

&nbsp;   String user = "postgres";      // Ganti dengan username pgAdmin kamu

&nbsp;   String pass = "password\_kamu"; // Ganti dengan password pgAdmin kamu

&nbsp;   ```



\### 3. Run Project

1\.  Klik kanan pada project di NetBeans.

2\.  Pilih \*\*Clean and Build\*\* (Tunggu sampai sukses).

3\.  Klik \*\*Run\*\*.

4\.  Aplikasi akan terbuka otomatis di browser (biasanya di `http://localhost:8080/pbo-servis-mobil`).



---



\## 👥 Anggota Kelompok



Proyek ini dikerjakan oleh tim mahasiswa \*\*STT Terpadu Nurul Fikri (Angkatan 2024)\*\*:



| No | Nama Lengkap | NIM |

| :---: | :--- | :--- |

| 1 | \*\*Muhammad Rizqi Nurrohmat\*\* | 0110224001 |

| 2 | \*\*Adzani Naufaldo Arifuddin\*\* | 0110224119 |

| 3 | \*\*Al Hijir\*\* | 0110224222 |

| 4 | \*\*Salsabila\*\* | 0110224031 |

| 5 | \*\*Yanti Elnaya Putri\*\* | 0110224097 |



---

