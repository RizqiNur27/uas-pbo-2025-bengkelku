package omat.pbo.servis.mobil.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import omat.pbo.servis.mobil.dao.AdminDAO;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set Encoding
        request.setCharacterEncoding("UTF-8");

        // Ambil Parameter
        String nama = request.getParameter("nama_lengkap");
        String nip = request.getParameter("nip");
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        
        // Validasi Input Sederhana
        if (user == null || user.trim().isEmpty() || pass == null || pass.trim().isEmpty()) {
            String errorMsg = URLEncoder.encode("Username dan Password wajib diisi!", StandardCharsets.UTF_8);
            response.sendRedirect("register.jsp?error=" + errorMsg);
            return;
        }

        AdminDAO dao = new AdminDAO(); 

        // Proses Register
        boolean success = dao.registerAdmin(user, pass, nama, nip);

        if (success) {
           
            response.sendRedirect("login.jsp?status=reg_success");
        } else {
            String errorMsg = URLEncoder.encode("Gagal! Username mungkin sudah terpakai.", StandardCharsets.UTF_8);
            response.sendRedirect("register.jsp?error=" + errorMsg);
        }
    }
}