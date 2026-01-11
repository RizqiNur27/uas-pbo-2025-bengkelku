package omat.pbo.servis.mobil.dao;

import java.sql.*;
import java.util.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import omat.pbo.servis.mobil.config.KoneksiDB;
import omat.pbo.servis.mobil.model.Booking;
import omat.pbo.servis.mobil.model.Customer;

public class BookingDAO {

    private Connection getConnection() throws SQLException {
        return KoneksiDB.getConnection();
    }

    // --- MAPPING HELPER (Revisi Total) ---
    private Booking mapRowToBooking(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setId(rs.getInt("id"));
        b.setCustomerId(rs.getInt("customer_id"));
        b.setMechanicId(rs.getInt("mechanic_id"));
        b.setMerekMobil(rs.getString("merek_mobil"));
        b.setNopol(rs.getString("nopol"));
        b.setKmMobil(rs.getInt("km_mobil"));
        
        String keluhan = rs.getString("keluhan");
        b.setKeluhan(keluhan != null ? keluhan : "-");
        
 
        String namaLayanan = rs.getString("list_layanan");
        if (namaLayanan == null || namaLayanan.equalsIgnoreCase("null") || namaLayanan.isEmpty()) {
            String fallback = rs.getString("layanan");
            b.setLayanan(fallback != null ? fallback : "-");
        } else {
            b.setLayanan(namaLayanan);
        }
        
        b.setTanggal(rs.getDate("tanggal"));
        b.setJam(rs.getTime("jam"));
        b.setStatus(rs.getString("status"));
        b.setTipeReservasi(rs.getString("tipe_reservasi"));
        b.setWhatsapp(rs.getString("whatsapp"));
        b.setMetodePembayaran(rs.getString("metode_pembayaran"));

        BigDecimal total = rs.getBigDecimal("total_biaya");
        if (total != null) {
            b.setTotalBiaya(total);
            b.setTotalHarga(total.doubleValue());
        } else {
            b.setTotalBiaya(BigDecimal.ZERO);
            b.setTotalHarga(0);
        }

        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) {
            b.setCreatedAt(ts.toLocalDateTime());
            b.setTanggalBooking(ts.toLocalDateTime());
        } else {
            b.setTanggalBooking(LocalDateTime.now());
        }

        String customerName = rs.getString("cust_nama");
        b.setCustomerName(customerName != null ? customerName : "Umum/Guest");
        b.setNamaPelanggan(b.getCustomerName());

        String mech = rs.getString("mech_nama");
        b.setMechanicName(mech != null ? mech : "-");

        return b;
    }

    // --- DASHBOARD STATS ---
    public Map<String, Object> getDashboardStats() {
        Map<String, Object> stats = new HashMap<>();
        String sqlBooking = "SELECT "
                + "COUNT(*) as total_all, "
                + "COUNT(CASE WHEN status IN ('Waiting', 'Pending', 'Proses') THEN 1 END) as pending_count, "
                + "COUNT(CASE WHEN status IN ('Selesai', 'Done') THEN 1 END) as completed_count, "
                + "COALESCE(SUM(CASE WHEN status IN ('Selesai', 'Done') THEN total_biaya ELSE 0 END), 0) as totalIncome "
                + "FROM bookings";

        String sqlMech = "SELECT COUNT(*) FROM mechanics WHERE status = 'Available'";

        try (Connection conn = getConnection(); Statement stmt = conn.createStatement()) {
            try (ResultSet rs = stmt.executeQuery(sqlBooking)) {
                if (rs.next()) {
                    stats.put("totalBookings", rs.getInt("total_all"));
                    stats.put("booking_pending", rs.getInt("pending_count"));
                    stats.put("booking_selesai", rs.getInt("completed_count"));

                    double income = rs.getDouble("totalIncome");
                    java.text.NumberFormat nf = java.text.NumberFormat.getInstance(new Locale("id", "ID"));
                    stats.put("todayIncome", nf.format(income));
                }
            }
            try (ResultSet rsM = stmt.executeQuery(sqlMech)) {
                if (rsM.next()) {
                    stats.put("activeMechanics", rsM.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }

    // --- CREATE BOOKING ---
    public boolean createBooking(Booking b, String[] serviceIds) {
        String sql = "INSERT INTO bookings (customer_id, user_id, mechanic_id, merek_mobil, nopol, "
                + "keluhan, tipe_reservasi, status, tanggal, jam, whatsapp, metode_pembayaran, created_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        String sqlDetail = "INSERT INTO booking_details (booking_id, service_id) VALUES (?, ?)";
        String sqlUpdateTotal = "UPDATE bookings SET total_biaya = ? WHERE id = ?";

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = KoneksiDB.getConnection();
            conn.setAutoCommit(false);

            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, b.getCustomerId());

            if (b.getUserId() > 0) ps.setInt(2, b.getUserId());
            else ps.setNull(2, java.sql.Types.INTEGER);

            if (b.getMechanicId() > 0) ps.setInt(3, b.getMechanicId());
            else ps.setNull(3, java.sql.Types.INTEGER);

            ps.setString(4, b.getMerekMobil());
            ps.setString(5, b.getNopol());
            ps.setString(6, b.getKeluhan());
            ps.setString(7, b.getTipeReservasi());
            ps.setString(8, b.getStatus());
            ps.setDate(9, b.getTanggal());
            ps.setTime(10, b.getJam());
            ps.setString(11, b.getWhatsapp());
            ps.setString(12, b.getMetodePembayaran());
            ps.setTimestamp(13, java.sql.Timestamp.valueOf(java.time.LocalDateTime.now()));

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int bookingId = generatedKeys.getInt(1);
                        double totalCalculatedCost = 0;

                        if (serviceIds != null && serviceIds.length > 0) {
                            try (PreparedStatement psDetail = conn.prepareStatement(sqlDetail)) {
                                ServiceDAO sDao = new ServiceDAO();
                                for (String sId : serviceIds) {
                                    if (sId != null && !sId.isEmpty()) {
                                        int idLayanan = Integer.parseInt(sId);
                                        double harga = sDao.getServicePrice(idLayanan);
                                        totalCalculatedCost += harga;
                                        psDetail.setInt(1, bookingId);
                                        psDetail.setInt(2, idLayanan);
                                        psDetail.addBatch();
                                    }
                                }
                                psDetail.executeBatch();
                            }
                        }

                        try (PreparedStatement psUpdate = conn.prepareStatement(sqlUpdateTotal)) {
                            psUpdate.setBigDecimal(1, BigDecimal.valueOf(totalCalculatedCost));
                            psUpdate.setInt(2, bookingId);
                            psUpdate.executeUpdate();
                        }

                        conn.commit();
                        return true;
                    }
                }
            }
            conn.rollback();
            return false;

        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) try { conn.rollback(); } catch (SQLException ex) {}
            return false;
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) { conn.setAutoCommit(true); conn.close(); } } catch (Exception e) {}
        }
    }

    // --- READ BOOKINGS (DENGAN SUBQUERY AGAR LAYANAN MUNCUL) ---
    public List<Booking> getAllBookings() {
        List<Booking> list = new ArrayList<>();
        
        String sql = "SELECT b.*, c.nama AS cust_nama, m.nama_mekanik AS mech_nama, "
                   + "(SELECT STRING_AGG(s.nama_layanan, ', ') "
                   + " FROM booking_details bd "
                   + " JOIN services s ON bd.service_id = s.id "
                   + " WHERE bd.booking_id = b.id) AS list_layanan "
                   + "FROM bookings b "
                   + "LEFT JOIN customers c ON b.customer_id = c.id "
                   + "LEFT JOIN mechanics m ON b.mechanic_id = m.id "
                   + "ORDER BY b.created_at DESC";

        try (Connection conn = getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapRowToBooking(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Booking> getRecentBookings(int limit) {
        List<Booking> list = new ArrayList<>();
        
        String sql = "SELECT b.*, c.nama AS cust_nama, m.nama_mekanik AS mech_nama, "
                   + "(SELECT STRING_AGG(s.nama_layanan, ', ') "
                   + " FROM booking_details bd "
                   + " JOIN services s ON bd.service_id = s.id "
                   + " WHERE bd.booking_id = b.id) AS list_layanan "
                   + "FROM bookings b "
                   + "LEFT JOIN customers c ON b.customer_id = c.id "
                   + "LEFT JOIN mechanics m ON b.mechanic_id = m.id "
                   + "ORDER BY b.created_at DESC LIMIT ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRowToBooking(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Booking getBookingById(int id) {
        Booking b = null;
        String sql = "SELECT b.*, c.nama AS cust_nama, m.nama_mekanik AS mech_nama, "
                   + "(SELECT STRING_AGG(s.nama_layanan, ', ') "
                   + " FROM booking_details bd "
                   + " JOIN services s ON bd.service_id = s.id "
                   + " WHERE bd.booking_id = b.id) AS list_layanan "
                   + "FROM bookings b "
                   + "LEFT JOIN customers c ON b.customer_id = c.id "
                   + "LEFT JOIN mechanics m ON b.mechanic_id = m.id "
                   + "WHERE b.id = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    b = mapRowToBooking(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return b;
    }

    // --- UPDATE STATUS ---
    private boolean updateStatusCombined(int bId, int mId, String bStatus, String mStatus) {
        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement p1 = conn.prepareStatement("UPDATE bookings SET status = ? WHERE id = ?"); 
                 PreparedStatement p2 = conn.prepareStatement("UPDATE mechanics SET status = ? WHERE id = ?")) {

                p1.setString(1, bStatus);
                p1.setInt(2, bId);
                p1.executeUpdate();

                if (mId > 0) {
                    p2.setString(1, mStatus);
                    p2.setInt(2, mId);
                    p2.executeUpdate();
                }

                conn.commit();
                return true;
            } catch (SQLException e) {
                conn.rollback();
                return false;
            }
        } catch (SQLException e) {
            return false;
        }
    }

    public boolean startBookingProcess(int bId, int mId) {
        return updateStatusCombined(bId, mId, "Proses", "Busy");
    }

    public boolean completeBooking(int bId, int mId) {
        Connection conn = null;
        PreparedStatement psPayment = null;
        PreparedStatement psBooking = null;
        PreparedStatement psMech = null;

        // FIX: Menggunakan COALESCE agar jika keluhan kosong, tidak error/null
        String sqlPayment = "INSERT INTO payments (booking_id, total_bayar, metode_bayar, catatan, admin_id, tgl_bayar) "
                + "SELECT id, total_biaya, 'Cash', COALESCE(keluhan, 'Servis Rutin'), 1, CURRENT_DATE "
                + "FROM bookings WHERE id = ? "
                + "AND NOT EXISTS (SELECT 1 FROM payments WHERE booking_id = ?)";

        String sqlBooking = "UPDATE bookings SET status = 'Selesai' WHERE id = ?";
        String sqlMech = "UPDATE mechanics SET status = 'Available' WHERE id = ?";

        try {
            conn = getConnection();
            conn.setAutoCommit(false); 

            psPayment = conn.prepareStatement(sqlPayment);
            psPayment.setInt(1, bId);
            psPayment.setInt(2, bId);
            psPayment.executeUpdate();

            psBooking = conn.prepareStatement(sqlBooking);
            psBooking.setInt(1, bId);
            psBooking.executeUpdate();

            if (mId > 0) {
                psMech = conn.prepareStatement(sqlMech);
                psMech.setInt(1, mId);
                psMech.executeUpdate();
            }

            conn.commit(); 
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) try { conn.rollback(); } catch (SQLException ex) {}
            return false;
        } finally {
            try { if (psPayment != null) psPayment.close(); } catch (Exception e) {}
            try { if (psBooking != null) psBooking.close(); } catch (Exception e) {}
            try { if (psMech != null) psMech.close(); } catch (Exception e) {}
            try { if (conn != null) { conn.setAutoCommit(true); conn.close(); } } catch (Exception e) {}
        }
    }

    public boolean cancelBooking(int bId, int mId) {
        return updateStatusCombined(bId, mId, "Batal", "Available");
    }

    // --- UTILS ---
    public Customer findCustomerByKeyword(String keyword) {
        Customer c = null;
        String sql = "SELECT * FROM customers WHERE nama ILIKE ? OR CAST(id AS TEXT) = ?";

        try (Connection conn = KoneksiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, keyword);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                c = new Customer();
                c.setId(rs.getInt("id"));
                c.setNama(rs.getString("nama"));
                c.setWhatsapp(rs.getString("whatsapp"));
                c.setAlamat(rs.getString("alamat"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return c;
    }
}