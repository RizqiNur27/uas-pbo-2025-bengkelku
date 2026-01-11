package omat.pbo.servis.mobil.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDateTime;

public class Booking {

    private int id;
    private int customerId;         // FK: customer_id
    private int userId;             // FK: user_id 
    private int mechanicId;         // FK: mechanic_id
    private String merekMobil;      // merek_mobil
    private String nopol;           // nopol
    private int kmMobil;            // km_mobil
    private String layanan;         // layanan
    private Date tanggal;           // tanggal
    private Time jam;               // jam
    private String keluhan;         // keluhan
    private String metodePembayaran; // metode_pembayaran
    private String status;          // status
    private BigDecimal totalBiaya;  // total_biaya 
    private String tipeReservasi;   // tipe_reservasi
    private String whatsapp;        // whatsapp
    private LocalDateTime createdAt; // created_at

    // --- FIELD BANTUAN / HELPER (Hasil JOIN & Dashboard) ---
    private String customerName;    // Dari tabel customers
    private String mechanicName;    // Dari tabel mechanics
    private String alamatCustomer;  // Dari tabel customers

    // Field Tambahan (Compatibility Field untuk Dashboard logic di DAO)
    private double totalHarga;      // Versi double dari totalBiaya (untuk grafik/dashboard)
    private String namaPelanggan;   // Alias untuk customerName
    private LocalDateTime tanggalBooking; // Alias untuk createdAt

    public Booking() {
    }

    // --- GETTERS & SETTERS UTAMA ---
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getMechanicId() {
        return mechanicId;
    }

    public void setMechanicId(int mechanicId) {
        this.mechanicId = mechanicId;
    }

    public String getMerekMobil() {
        return merekMobil;
    }

    public void setMerekMobil(String merekMobil) {
        this.merekMobil = merekMobil;
    }

    public String getNopol() {
        return nopol;
    }

    public void setNopol(String nopol) {
        this.nopol = nopol;
    }

    public int getKmMobil() {
        return kmMobil;
    }

    public void setKmMobil(int kmMobil) {
        this.kmMobil = kmMobil;
    }

    public String getLayanan() {
        return layanan;
    }

    public void setLayanan(String layanan) {
        this.layanan = layanan;
    }

    public Date getTanggal() {
        return tanggal;
    }

    public void setTanggal(Date tanggal) {
        this.tanggal = tanggal;
    }

    public Time getJam() {
        return jam;
    }

    public void setJam(Time jam) {
        this.jam = jam;
    }

    public String getKeluhan() {
        return keluhan;
    }

    public void setKeluhan(String keluhan) {
        this.keluhan = keluhan;
    }

    public String getMetodePembayaran() {
        return metodePembayaran;
    }

    public void setMetodePembayaran(String metodePembayaran) {
        this.metodePembayaran = metodePembayaran;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getTotalBiaya() {
        return totalBiaya;
    }

    public void setTotalBiaya(BigDecimal totalBiaya) {
        this.totalBiaya = totalBiaya;
    }

    public String getTipeReservasi() {
        return tipeReservasi;
    }

    public void setTipeReservasi(String tipeReservasi) {
        this.tipeReservasi = tipeReservasi;
    }

    public String getWhatsapp() {
        return whatsapp;
    }

    public void setWhatsapp(String whatsapp) {
        this.whatsapp = whatsapp;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    // --- GETTERS & SETTERS HELPER (JOIN & DASHBOARD) ---
    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getMechanicName() {
        return mechanicName;
    }

    public void setMechanicName(String mechanicName) {
        this.mechanicName = mechanicName;
    }

    public String getAlamatCustomer() {
        return alamatCustomer;
    }

    public void setAlamatCustomer(String alamatCustomer) {
        this.alamatCustomer = alamatCustomer;
    }

    public double getTotalHarga() {
        return totalHarga;
    }

    public void setTotalHarga(double totalHarga) {
        this.totalHarga = totalHarga;
    }

    public String getNamaPelanggan() {
        return namaPelanggan;
    }

    public void setNamaPelanggan(String namaPelanggan) {
        this.namaPelanggan = namaPelanggan;
    }

    public LocalDateTime getTanggalBooking() {
        return tanggalBooking;
    }

    public void setTanggalBooking(LocalDateTime tanggalBooking) {
        this.tanggalBooking = tanggalBooking;
    }
}
