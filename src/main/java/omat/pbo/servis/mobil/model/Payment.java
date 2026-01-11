package omat.pbo.servis.mobil.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.sql.Timestamp;
import java.text.NumberFormat;
import java.util.Locale;
import java.time.format.DateTimeFormatter;

public class Payment {

    private int id;
    private int bookingId;
    private LocalDateTime tglBayar;
    private BigDecimal totalBayar;
    private String metodeBayar;
    private String catatan;

    // Objek relasi
    private Admin admin;

    // --- Atribut Virtual (Untuk Tampilan Join) ---
    private String namaCustomer;
    private String merekMobil;
    private String nopol;
    private int kmMobil;
    private String namaMekanik;
    private String layanan;

    // --- CONSTRUCTOR ---
    public Payment() {
        this.tglBayar = LocalDateTime.now();
    }

    // --- HELPER FORMATTING (Untuk Tampilan JSP) ---
    public String getTotalBayarFormatted() {
        if (totalBayar == null) {
            return "Rp 0";
        }
        NumberFormat nf = NumberFormat.getCurrencyInstance(new Locale("id", "ID"));
        return nf.format(totalBayar);
    }

    public String getTglBayarFormatted() {
        if (tglBayar == null) {
            return "-";
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMMM yyyy", new Locale("id", "ID"));
        return tglBayar.format(formatter);
    }

    public String getTglBayarLengkap() {
        if (tglBayar == null) {
            return "-";
        }
        return tglBayar.format(DateTimeFormatter.ofPattern("dd MMM yyyy HH:mm"));
    }

    // --- GETTER & SETTER ---
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public LocalDateTime getTglBayar() {
        return tglBayar;
    }

    public void setTglBayar(LocalDateTime tglBayar) {
        this.tglBayar = tglBayar;
    }

    public void setTglBayarFromSql(Timestamp ts) {
        if (ts != null) {
            this.tglBayar = ts.toLocalDateTime();
        }
    }

    public BigDecimal getTotalBayar() {
        return totalBayar;
    }

    public void setTotalBayar(BigDecimal totalBayar) {
        this.totalBayar = totalBayar;
    }

    public String getMetodeBayar() {
        return metodeBayar;
    }

    public void setMetodeBayar(String metodeBayar) {
        this.metodeBayar = metodeBayar;
    }

    public String getCatatan() {
        return catatan;
    }

    public void setCatatan(String catatan) {
        this.catatan = catatan;
    }

    public Admin getAdmin() {
        return admin;
    }

    public void setAdmin(Admin admin) {
        this.admin = admin;
    }

    public String getNamaCustomer() {
        return namaCustomer;
    }

    public void setNamaCustomer(String namaCustomer) {
        this.namaCustomer = namaCustomer;
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

    public String getNamaMekanik() {
        return namaMekanik;
    }

    public void setNamaMekanik(String namaMekanik) {
        this.namaMekanik = namaMekanik;
    }

    // Getter & Setter Layanan Baru
    public String getLayanan() {
        return layanan;
    }

    public void setLayanan(String layanan) {
        this.layanan = layanan;
    }
}
