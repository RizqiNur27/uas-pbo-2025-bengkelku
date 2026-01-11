# 🚗 BengkelKu - Sistem Informasi Servis Mobil

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Bootstrap](https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white)

**BengkelKu** adalah aplikasi berbasis web yang dirancang untuk memudahkan pelanggan dalam melakukan reservasi servis mobil secara online dan membantu admin mengelola data antrian servis. Proyek ini dikembangkan sebagai **Final Project (UAS)** mata kuliah **Pemrograman Berorientasi Objek (PBO)**.

---

## 📋 Fitur Utama

### 🏠 Halaman Utama (Landing Page)
Halaman depan yang berfungsi sebagai pusat informasi dan navigasi utama:
* **Navigasi Akses:**
    * **Reservasi Online:** Tombol khusus untuk **Pelanggan** memulai proses booking servis.
    * **Login Admin:** Tombol akses khusus **Admin** yang terletak di **pojok kanan atas** halaman.
* **Informasi Lengkap:** Menampilkan profil bengkel, daftar layanan, tim mekanik, serta testimoni pelanggan.

### 👤 Halaman Pelanggan (User)
* **Form Reservasi:** Mengisi data diri, memilih jenis servis, tanggal, dan metode pembayaran.
* **Informasi Layanan:** Melihat detail diagnosa kerusakan dan estimasi pengerjaan.
* **Cek Status:** Memantau riwayat booking apakah sudah disetujui atau belum.

### 🛠 Halaman Admin (Dashboard)
Pusat kontrol pengelolaan bengkel dengan tampilan antarmuka yang responsif:
* **Dashboard Overview:** Menampilkan kartu statistik ringkas (Total Reservasi, Jumlah Mekanik, Data Pelanggan) untuk pemantauan cepat.
* **Manajemen Reservasi:** Tabel daftar booking masuk dengan fitur konfirmasi (Setujui/Tolak) reservasi.
* **Kelola Data Master (CRUD):**
    * Menambah dan mengedit data **Mekanik**.
    * Mengupdate daftar dan harga **Jenis Layanan**.
    * Mengelola data **Pelanggan** terdaftar.

---

## 💻 Teknologi yang Digunakan

Aplikasi ini dibangun menggunakan teknologi standar industri:

* **Backend:**
    * Java Development Kit (JDK 17/21)
    * Java Server Pages (JSP) & Servlet
* **Database:**
    * PostgreSQL
    * JDBC Driver (Koneksi Java ke Database)
* **Frontend:**
    * HTML5 & CSS3
    * **Bootstrap 5** (Framework CSS untuk tampilan responsif)
    * **FontAwesome** (Ikon antarmuka)
* **Tools & Lainnya:**
    * **Apache NetBeans** (IDE)
    * **Apache Maven** (Manajemen Project & Dependency)
    * **Git & GitHub** (Version Control)

---

## ⚙️ Cara Menjalankan Project (Instalasi)

Ikuti langkah-langkah ini untuk menjalankan aplikasi di komputer lokal:

### 1. Persiapan Database
1.  Pastikan **PostgreSQL** sudah terinstall.
2.  Buka **pgAdmin 4**.
3.  Buat database baru dengan nama `pbo_servis_mobil`.
4.  Klik kanan database tersebut -> **Restore**.
5.  Pilih file **`pbo_servis_mobil.sql`** yang ada di dalam repository ini.

### 2. Konfigurasi Koneksi
1.  Buka project di **NetBeans**.
2.  Cari file koneksi database bernama **`KoneksiDB.java`** (biasanya di package `util` atau `config`).
3.  Sesuaikan **Username** dan **Password** database PostgreSQL kamu:
    ```java
    // Contoh konfigurasi di KoneksiDB.java
    String url = "jdbc:postgresql://localhost:5432/pbo_servis_mobil";
    String user = "postgres";      // Ganti dengan username pgAdmin kamu
    String pass = "password_kamu"; // Ganti dengan password pgAdmin kamu
    ```

### 3. Run Project
1.  Klik kanan pada project di NetBeans.
2.  Pilih **Clean and Build** (Tunggu sampai sukses).
3.  Klik **Run**.
4.  Aplikasi akan terbuka otomatis di browser (biasanya di `http://localhost:8080/pbo-servis-mobil`).

---

## 👥 Anggota Kelompok

Proyek ini dikerjakan oleh tim mahasiswa **STT Terpadu Nurul Fikri (Angkatan 2024)**:

| No | Nama Lengkap | NIM |
| :---: | :--- | :--- |
| 1 | **Adzani Naufaldo Arifuddin** | 0110224119 |
| 2 | **Al Hijir** | 0110224222 |
| 3 | **Muhammad Rizqi Nurrohmat** | 0110224001 |
| 4 | **Salsabila** | 0110224031 |
| 5 | **Yanti Elnaya Putri** | 0110224097 |

---
