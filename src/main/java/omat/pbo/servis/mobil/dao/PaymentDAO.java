package omat.pbo.servis.mobil.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import omat.pbo.servis.mobil.config.KoneksiDB;
import omat.pbo.servis.mobil.model.Payment;
import omat.pbo.servis.mobil.model.Admin;

public class PaymentDAO {

    // --- METHOD INSERT ---
    public boolean insertPayment(Payment p) {
        Connection conn = null;
        String sqlPay = "INSERT INTO payments (booking_id, total_bayar, metode_bayar, catatan, admin_id, tgl_bayar) VALUES (?, ?, ?, ?, ?, NOW())";
        String sqlUpdateBook = "UPDATE bookings SET status = 'Selesai' WHERE id = ?";

        try {
            conn = KoneksiDB.getConnection();
            conn.setAutoCommit(false);

            try (PreparedStatement psPay = conn.prepareStatement(sqlPay)) {
                psPay.setInt(1, p.getBookingId());
                psPay.setBigDecimal(2, p.getTotalBayar());
                psPay.setString(3, p.getMetodeBayar());
                psPay.setString(4, p.getCatatan());
                if (p.getAdmin() != null) {
                    psPay.setInt(5, p.getAdmin().getId());
                } else {
                    psPay.setNull(5, java.sql.Types.INTEGER);
                }
                psPay.executeUpdate();
            }

            try (PreparedStatement psBook = conn.prepareStatement(sqlUpdateBook)) {
                psBook.setInt(1, p.getBookingId());
                psBook.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (Exception e) {
            if (conn != null) try { conn.rollback(); } catch (SQLException ex) {}
            e.printStackTrace();
            return false;
        } finally {
            if (conn != null) try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) {}
        }
    }

    // --- METHOD AMBIL DATA ---
    public List<Payment> getPaymentsFiltered(String start, String end) {
        List<Payment> list = new ArrayList<>();

        String sql = "SELECT p.*, "
                + "b.merek_mobil, b.nopol, b.keluhan, b.km_mobil, b.layanan, " 
                + "c.nama AS nama_customer, "
                + "m.nama_mekanik, "
                + "a.nama_lengkap AS nama_admin, a.nip AS nip_admin "
                + "FROM payments p "
                + "JOIN bookings b ON p.booking_id = b.id "
                + "JOIN customers c ON b.customer_id = c.id "
                + "LEFT JOIN mechanics m ON b.mechanic_id = m.id "
                + "LEFT JOIN admins a ON p.admin_id = a.id ";

        boolean hasFilter = (start != null && !start.isEmpty() && end != null && !end.isEmpty());
        if (hasFilter) {
            sql += " WHERE CAST(p.tgl_bayar AS DATE) BETWEEN ? AND ? ";
        }
        sql += " ORDER BY p.tgl_bayar DESC";

        try (Connection conn = KoneksiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            if (hasFilter) {
                ps.setDate(1, java.sql.Date.valueOf(start));
                ps.setDate(2, java.sql.Date.valueOf(end));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Payment p = new Payment();
                    p.setId(rs.getInt("id"));
                    p.setBookingId(rs.getInt("booking_id"));
                    p.setTglBayarFromSql(rs.getTimestamp("tgl_bayar"));
                    p.setTotalBayar(rs.getBigDecimal("total_bayar"));
                    p.setMetodeBayar(rs.getString("metode_bayar"));

                    // AMBIL DATA DARI DATABASE
                    String layananDb = rs.getString("layanan");
                    String keluhanDb = rs.getString("keluhan");
                    String catatanBayar = rs.getString("catatan");

                    // SIMPAN DATA MURNI
                    p.setLayanan(layananDb);

                    // --- LOGIKA PINTAR UNTUK TAMPILAN STRUK ---
                    if (layananDb != null && !layananDb.isEmpty()) {
                        p.setCatatan(layananDb);
                    } else if (keluhanDb != null && !keluhanDb.isEmpty()) {
                        p.setCatatan(keluhanDb);
                    } else {
                        p.setCatatan(catatanBayar != null ? catatanBayar : "-");
                    }

                    p.setNamaCustomer(rs.getString("nama_customer"));
                    p.setMerekMobil(rs.getString("merek_mobil"));
                    p.setNopol(rs.getString("nopol"));

                    try { p.setKmMobil(rs.getInt("km_mobil")); } catch (Exception e) { p.setKmMobil(0); }
                    
                    String mek = rs.getString("nama_mekanik");
                    p.setNamaMekanik(mek != null ? mek : "-");

                    Admin adm = new Admin();
                    String admName = rs.getString("nama_admin");
                    adm.setNamaLengkap(admName != null ? admName : "Admin System");
                    adm.setNip(rs.getString("nip_admin"));
                    p.setAdmin(adm);

                    list.add(p);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // --- WRAPPER METHODS ---
    public List<Payment> getPaymentsByDate(String start, String end) {
        return getPaymentsFiltered(start, end);
    }

    public List<Payment> getAllPayments() {
        return getPaymentsFiltered(null, null);
    }
}