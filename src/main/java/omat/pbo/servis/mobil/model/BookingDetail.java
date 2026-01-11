package omat.pbo.servis.mobil.model;

import java.math.BigDecimal;

public class BookingDetail {

    private int id;
    private int bookingId;
    private int serviceId;
    private BigDecimal hargaSaatIni;

    private String namaLayanan;

    public BookingDetail() {
    }

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

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public BigDecimal getHargaSaatIni() {
        return hargaSaatIni;
    }

    public void setHargaSaatIni(BigDecimal hargaSaatIni) {
        this.hargaSaatIni = hargaSaatIni;
    }

    public String getNamaLayanan() {
        return namaLayanan;
    }

    public void setNamaLayanan(String namaLayanan) {
        this.namaLayanan = namaLayanan;
    }
}
