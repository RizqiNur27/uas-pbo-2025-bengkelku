package omat.pbo.servis.mobil.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import omat.pbo.servis.mobil.dao.CustomerDAO;
import omat.pbo.servis.mobil.model.Customer;

@WebServlet(name = "CustomerServlet", urlPatterns = {"/CustomerServlet"})
public class CustomerServlet extends HttpServlet {

    // --- METHOD GET: Untuk Menampilkan Halaman / Hapus Data / Ambil Data Edit ---
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        CustomerDAO dao = new CustomerDAO();
        HttpSession session = request.getSession();

        try {
            switch (action) {
                case "delete":
                    // --- LOGIKA HAPUS ---
                    handleDelete(request, session, dao);
                    response.sendRedirect("CustomerServlet?action=list");
                    break;

                case "edit":
                    // --- LOGIKA AMBIL 1 DATA (Untuk Form Edit) ---
                    handleEdit(request, dao);
                    request.getRequestDispatcher("data_pelanggan.jsp").forward(request, response);
                    break;

                default:
                    // --- LOGIKA LIST (DEFAULT) ---
                    List<Customer> list = dao.getAllCustomers();
                    if (list == null) {
                        list = new ArrayList<>();
                    }

                    request.setAttribute("listPelanggan", list);
                    request.getRequestDispatcher("data_pelanggan.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("alertStatus", "error");
            session.setAttribute("alertMessage", "Terjadi kesalahan sistem: " + e.getMessage());
            response.sendRedirect("CustomerServlet?action=list");
        }
    }

    // --- METHOD POST: Untuk Simpan Baru / Update Data ---
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        CustomerDAO dao = new CustomerDAO();
        HttpSession session = request.getSession();
        Customer c = new Customer();

        try {
            // Ambil Data dari Form
            c.setNama(request.getParameter("nama"));
            c.setWhatsapp(request.getParameter("whatsapp"));
            c.setAlamat(request.getParameter("alamat"));

            if ("add".equals(action)) {
                // --- INSERT ---
                boolean success;
                success = dao.insertCustomer(c);
                if (success) {
                    session.setAttribute("alertStatus", "success");
                    session.setAttribute("alertMessage", "Pelanggan berhasil ditambahkan!");
                } else {
                    throw new Exception("Gagal menyimpan ke database.");
                }

            } else if ("update".equals(action)) {
                // --- UPDATE ---
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    c.setId(Integer.parseInt(idStr));
                    boolean success = dao.updateCustomer(c);

                    if (success) {
                        session.setAttribute("alertStatus", "success");
                        session.setAttribute("alertMessage", "Data berhasil diperbarui!");
                    } else {
                        throw new Exception("Gagal update data.");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("alertStatus", "error");
            session.setAttribute("alertMessage", "Gagal memproses data: " + e.getMessage());
        }

        response.sendRedirect("CustomerServlet?action=list");
    }

    // --- HELPER METHODS  ---
    private void handleDelete(HttpServletRequest request, HttpSession session, CustomerDAO dao) {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            boolean success = dao.deleteCustomer(id);

            if (success) {
                session.setAttribute("alertStatus", "success");
                session.setAttribute("alertMessage", "Data pelanggan berhasil dihapus!");
            } else {
                session.setAttribute("alertStatus", "error");
                session.setAttribute("alertMessage", "Gagal hapus! Data mungkin sedang digunakan di transaksi.");
            }
        }
    }

    private void handleEdit(HttpServletRequest request, CustomerDAO dao) {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);

        }
        request.setAttribute("listPelanggan", dao.getAllCustomers());
    }
}