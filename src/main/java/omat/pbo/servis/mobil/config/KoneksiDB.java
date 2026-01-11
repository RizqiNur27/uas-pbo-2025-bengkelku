package omat.pbo.servis.mobil.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class KoneksiDB {
    private static final String URL = "jdbc:postgresql://localhost:5432/pbo_servis_mobil";
    private static final String USER = "postgres";
    private static final String PASS = "";

    public static Connection getConnection() {
        try {
            Class.forName("org.postgresql.Driver");
            return DriverManager.getConnection(URL, USER, PASS);
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Koneksi Error: " + e.getMessage());
            return null;
        }
    }
}