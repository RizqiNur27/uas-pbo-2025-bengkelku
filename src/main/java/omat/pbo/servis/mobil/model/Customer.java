package omat.pbo.servis.mobil.model;

import java.time.LocalDateTime;

public class Customer {

    private int id;
    private String nama;
    private String whatsapp;
    private String alamat;
    private LocalDateTime createdAt;

    public Customer() {
    }

    public Customer(int id, String nama, String whatsapp, String alamat, LocalDateTime createdAt) {
        this.id = id;
        this.nama = nama;
        this.whatsapp = whatsapp;
        this.alamat = alamat;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNama() {
        return nama;
    }

    public void setNama(String nama) {
        this.nama = nama;
    }

    public String getWhatsapp() {
        return whatsapp;
    }

    public void setWhatsapp(String whatsapp) {
        this.whatsapp = whatsapp;
    }

    public String getAlamat() {
        return alamat;
    }

    public void setAlamat(String alamat) {
        this.alamat = alamat;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
