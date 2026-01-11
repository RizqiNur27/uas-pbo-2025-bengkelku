package omat.pbo.servis.mobil.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import omat.pbo.servis.mobil.dao.ServiceDAO;
import omat.pbo.servis.mobil.model.Service;

@WebServlet(name = "ServiceServlet", urlPatterns = {"/ServiceServlet"})
public class ServiceServlet extends HttpServlet {

    private final ServiceDAO dao = new ServiceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "list";
        HttpSession session = request.getSession();

        if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.deleteService(id); 
                session.setAttribute("alertStatus", "success");
                session.setAttribute("alertMessage", "Layanan berhasil dihapus.");
            } catch (Exception e) {
                session.setAttribute("alertStatus", "error");
                session.setAttribute("alertMessage", "Gagal hapus data! Layanan mungkin sedang digunakan dalam transaksi.");
            }
            response.sendRedirect("ServiceServlet?action=list");
            
        } else {
            // ACTION LIST: Mengambil data dari database
            List<Service> list = dao.getAllServices();
            request.setAttribute("listService", list);
            
            // Forward ke JSP View
            request.getRequestDispatcher("data_layanan.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        try {
            String nama = request.getParameter("serviceName"); 
            String kategori = request.getParameter("category");
            String hargaStr = request.getParameter("price");
            
            // Bersihkan format harga dari karakter non-angka
            String cleanHarga = hargaStr.replace("Rp", "").replace(".", "").replace(",", "").trim();
            double harga = Double.parseDouble(cleanHarga);

            Service s = new Service();
            s.setServiceName(nama);
            s.setCategory(kategori);
            s.setPrice(harga);
            s.setDuration(0); 

            if ("add".equals(action)) {
                dao.insertService(s);
                session.setAttribute("alertStatus", "success");
                session.setAttribute("alertMessage", "Layanan baru berhasil ditambahkan.");
            } else if ("update".equals(action)) {
                s.setId(Integer.parseInt(request.getParameter("id")));
                dao.updateService(s);
                session.setAttribute("alertStatus", "success");
                session.setAttribute("alertMessage", "Data layanan berhasil diperbarui.");
            }
        } catch (Exception e) {
            session.setAttribute("alertStatus", "error");
            session.setAttribute("alertMessage", "Gagal menyimpan: " + e.getMessage());
        }
        response.sendRedirect("ServiceServlet?action=list");
    }
}