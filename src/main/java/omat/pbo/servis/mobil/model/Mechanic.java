package omat.pbo.servis.mobil.model;

public class Mechanic {

    private int id;
    private String namaMekanik;
    private String status;      // Available / Busy
    private String spesialisasi;

    public Mechanic() {
    }

    public Mechanic(int id, String namaMekanik, String spesialisasi, String status) {
        this.id = id;
        this.namaMekanik = namaMekanik;
        this.spesialisasi = spesialisasi;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNamaMekanik() {
        return namaMekanik;
    }

    public void setNamaMekanik(String namaMekanik) {
        this.namaMekanik = namaMekanik;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSpesialisasi() {
        return spesialisasi;
    }

    public void setSpesialisasi(String spesialisasi) {
        this.spesialisasi = spesialisasi;
    }
}
