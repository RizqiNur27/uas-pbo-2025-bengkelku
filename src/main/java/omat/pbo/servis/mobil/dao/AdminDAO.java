package omat.pbo.servis.mobil.dao;

import omat.pbo.servis.mobil.config.KoneksiDB;
import java.sql.*;

public class AdminDAO {

    /**
     * Memvalidasi login dan mengembalikan data admin dalam format "Nama#NIP"
     */
    public String validateLogin(String username, String password) {
        String result = null;
        String sql = "SELECT id, nama_lengkap, nip FROM admins WHERE username = ? AND password = ?";

        try (Connection conn = KoneksiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int id = rs.getInt("id");
                    String nama = rs.getString("nama_lengkap");
                    String nip = rs.getString("nip");

                    result = id + "#" + nama + "#" + (nip != null ? nip : "-");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    /**
     * Mendaftarkan admin baru
     */
    public boolean registerAdmin(String user, String pass, String nama, String nip) {
        String sql = "INSERT INTO admins (username, password, nama_lengkap, nip) VALUES (?, ?, ?, ?)";

        try (Connection conn = KoneksiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user);
            ps.setString(2, pass);
            ps.setString(3, nama);
            ps.setString(4, nip);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error register admin: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
