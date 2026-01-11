package omat.pbo.servis.mobil.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import omat.pbo.servis.mobil.dao.AdminDAO;
import omat.pbo.servis.mobil.model.Admin;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        AdminDAO adminDAO = new AdminDAO();
        String adminData = adminDAO.validateLogin(user, pass);

        if (adminData != null) {
            // Format String dari DAO: "ID#NAMA#NIP"
            String[] parts = adminData.split("#");
            int idValue = Integer.parseInt(parts[0]);
            String namaLengkap = parts[1];
            String nipValue = (parts.length > 2) ? parts[2] : "-";

            // Buat objek Admin
            Admin adminSession = new Admin();
            adminSession.setId(idValue);
            adminSession.setNamaLengkap(namaLengkap);
            adminSession.setNip(nipValue);

            // --- SIMPAN SESSION LENGKAP ---
            HttpSession session = request.getSession();
            session.setAttribute("isLoggedIn", true);
            session.setAttribute("admin", adminSession);       
            session.setAttribute("nama_lengkap", namaLengkap); 
            session.setAttribute("nip", nipValue);
            
            // [PENTING] Simpan ID terpisah agar mudah dipanggil BookingServlet
            session.setAttribute("admin_id", idValue); 

            response.sendRedirect(request.getContextPath() + "/dashboard");
        } else {
            // Login Gagal
            response.sendRedirect("login.jsp?error=Username atau Password Salah!");
        }
    }
}