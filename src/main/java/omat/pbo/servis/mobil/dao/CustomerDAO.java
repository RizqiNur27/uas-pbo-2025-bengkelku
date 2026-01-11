package omat.pbo.servis.mobil.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import omat.pbo.servis.mobil.config.KoneksiDB;
import omat.pbo.servis.mobil.model.Customer;

public class CustomerDAO {

    private Connection getConnection() {
        return KoneksiDB.getConnection();
    }

    public List<Customer> getAllCustomers() {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT * FROM customers ORDER BY id DESC";

        try (Connection conn = getConnection(); 
             Statement stmt = conn.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Customer c = new Customer();
                c.setId(rs.getInt("id"));
                c.setNama(rs.getString("nama"));
                c.setWhatsapp(rs.getString("whatsapp"));
                c.setAlamat(rs.getString("alamat"));

                Timestamp ts = rs.getTimestamp("created_at");
                if (ts != null) {
                    c.setCreatedAt(ts.toLocalDateTime());
                }

                list.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int addCustomerAndGetId(Customer c) throws SQLException {
        String sql = "INSERT INTO customers (nama, whatsapp, alamat) VALUES (?, ?, ?)";
        try (Connection conn = KoneksiDB.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, c.getNama());
            ps.setString(2, c.getWhatsapp());
            ps.setString(3, c.getAlamat());

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); 
                    }
                }
            }
        }
        return 0; 
    }

    public boolean insertCustomer(Customer c) {
        try {
            int id = addCustomerAndGetId(c);
            return id > 0; 
        } catch (SQLException e) {
            e.printStackTrace();
            return false; 
        }
    }

    public boolean updateCustomer(Customer c) {
        String sql = "UPDATE customers SET nama=?, whatsapp=?, alamat=? WHERE id=?";
        try (Connection conn = getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, c.getNama());
            ps.setString(2, c.getWhatsapp());
            ps.setString(3, c.getAlamat());
            ps.setInt(4, c.getId());
            
            int rows = ps.executeUpdate();
            return rows > 0; 
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteCustomer(int id) {
        String sql = "DELETE FROM customers WHERE id=?";
        try (Connection conn = getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
 
    public Customer findCustomerByKeyword(String keyword) {
        String sql = "SELECT * FROM customers WHERE nama LIKE ? OR whatsapp LIKE ? LIMIT 1";
        try (Connection conn = getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Customer c = new Customer();
                    c.setId(rs.getInt("id"));
                    c.setNama(rs.getString("nama"));
                    c.setWhatsapp(rs.getString("whatsapp"));
                    c.setAlamat(rs.getString("alamat"));
                    return c;
                }
            }   
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}

