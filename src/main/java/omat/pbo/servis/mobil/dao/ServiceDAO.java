package omat.pbo.servis.mobil.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import omat.pbo.servis.mobil.config.KoneksiDB; 
import omat.pbo.servis.mobil.model.Service;

public class ServiceDAO {

    private Connection getConnection() {
        return KoneksiDB.getConnection();
    }

    // AMBIL SEMUA LAYANAN
    public List<Service> getAllServices() {
        List<Service> services = new ArrayList<>();
        String query = "SELECT * FROM services ORDER BY id ASC";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Service s = new Service();
                s.setId(rs.getInt("id"));
                s.setServiceName(rs.getString("nama_layanan")); 
                s.setPrice(rs.getDouble("harga"));               
                s.setCategory(rs.getString("keterangan")); 
                
                services.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    // TAMBAH LAYANAN
    public boolean insertService(Service s) {
        String query = "INSERT INTO services (nama_layanan, harga, keterangan) VALUES (?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, s.getServiceName());
            ps.setDouble(2, s.getPrice());
            ps.setString(3, s.getCategory());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // UPDATE LAYANAN
    public boolean updateService(Service s) {
        String query = "UPDATE services SET nama_layanan=?, harga=?, keterangan=? WHERE id=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, s.getServiceName());
            ps.setDouble(2, s.getPrice());
            ps.setString(3, s.getCategory());
            ps.setInt(4, s.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // HAPUS LAYANAN
    public boolean deleteService(int id) {
        String query = "DELETE FROM services WHERE id=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // GET SERVICE BY ID (Untuk hitung total harga di BookingServlet)
    public Service getServiceById(int id) {
        String sql = "SELECT * FROM services WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Service s = new Service();
                    s.setId(rs.getInt("id"));
                    s.setServiceName(rs.getString("nama_layanan"));
                    s.setPrice(rs.getDouble("harga"));
                    return s;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
public double getServicePrice(int serviceId) {
    double price = 0;
    String sql = "SELECT harga FROM services WHERE id = ?";
    try (Connection conn = KoneksiDB.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, serviceId);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                price = rs.getDouble("harga");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return price;
}
}