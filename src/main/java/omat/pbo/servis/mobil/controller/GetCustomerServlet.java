package omat.pbo.servis.mobil.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import omat.pbo.servis.mobil.dao.BookingDAO;
import omat.pbo.servis.mobil.model.Customer;

@WebServlet(name = "GetCustomerServlet", urlPatterns = {"/GetCustomerServlet"})
public class GetCustomerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String keyword = request.getParameter("keyword");
        PrintWriter out = response.getWriter();

        try {
            if (keyword == null || keyword.trim().isEmpty()) {
                out.print("{\"status\":\"not_found\"}");
                return;
            }

            BookingDAO dao = new BookingDAO();
            Customer c = dao.findCustomerByKeyword(keyword);

            if (c != null) {
                // Buat JSON manual
                StringBuilder json = new StringBuilder();
                json.append("{");
                json.append("\"status\":\"found\",");
                json.append("\"id\":").append(c.getId()).append(",");
                json.append("\"nama\":\"").append(c.getNama()).append("\",");

                // Handle null strings agar tidak error
                String wa = (c.getWhatsapp() != null) ? c.getWhatsapp() : "";
                String al = (c.getAlamat() != null) ? c.getAlamat().replace("\n", " ").replace("\r", "") : "";

                json.append("\"wa\":\"").append(wa).append("\",");
                json.append("\"alamat\":\"").append(al).append("\"");
                json.append("}");

                out.print(json.toString());
            } else {
                out.print("{\"status\":\"not_found\"}");
            }
        } catch (Exception e) {
            e.printStackTrace(); // Cek server log jika error
            out.print("{\"status\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
        }
    }
}
