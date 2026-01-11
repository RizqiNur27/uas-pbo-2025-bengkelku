package omat.pbo.servis.mobil.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import omat.pbo.servis.mobil.config.KoneksiDB;
import omat.pbo.servis.mobil.model.Mechanic;

public class MechanicDAO {

    private Connection getConnection() {
        return KoneksiDB.getConnection();
    }

    // Ambil Semua Mekanik
    public List<Mechanic> getAllMechanics() {
        List<Mechanic> list = new ArrayList<>();
        String sql = "SELECT * FROM mechanics ORDER BY id ASC";
        
        try (Connection conn = getConnection(); 
             Statement stmt = conn.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Mechanic m = new Mechanic();
                m.setId(rs.getInt("id"));
                m.setNamaMekanik(rs.getString("nama_mekanik"));
                m.setSpesialisasi(rs.getString("spesialisasi"));
                m.setStatus(rs.getString("status"));
                list.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Hitung Mekanik Tersedia (Dashboard)
    public int countActiveMechanics() {
        String sql = "SELECT COUNT(*) FROM mechanics WHERE status = 'Available'";
        try (Connection conn = getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql); 
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Hitung Total Mekanik
    public int countTotalMechanics() {
        String sql = "SELECT COUNT(*) FROM mechanics";
        try (Connection conn = getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql); 
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Tambah Mekanik
    public boolean insertMechanic(Mechanic m) {
        String sql = "INSERT INTO mechanics (nama_mekanik, spesialisasi, status) VALUES (?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, m.getNamaMekanik());
            ps.setString(2, m.getSpesialisasi());
            ps.setString(3, m.getStatus()); 
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update Mekanik
    public boolean updateMechanic(Mechanic m) {
        String sql = "UPDATE mechanics SET nama_mekanik = ?, spesialisasi = ?, status = ? WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, m.getNamaMekanik());
            ps.setString(2, m.getSpesialisasi());
            ps.setString(3, m.getStatus());
            ps.setInt(4, m.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Hapus Mekanik
    public boolean deleteMechanic(int id) {
        String sql = "DELETE FROM mechanics WHERE id=?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Gagal menghapus: Mekanik sedang digunakan di data Booking.");
            return false;
        }
    }

    // Update Status (Helper)
    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE mechanics SET status = ? WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}