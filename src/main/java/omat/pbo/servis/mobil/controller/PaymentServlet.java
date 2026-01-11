package omat.pbo.servis.mobil.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import omat.pbo.servis.mobil.dao.PaymentDAO;
import omat.pbo.servis.mobil.model.Payment;
import omat.pbo.servis.mobil.model.Admin;

@WebServlet(name = "PaymentServlet", urlPatterns = {"/PaymentServlet"})
public class PaymentServlet extends HttpServlet {

    // --- METHOD GET: Untuk Menampilkan Halaman Laporan / History ---
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "history";
        }

        PaymentDAO dao = new PaymentDAO();

        try {
            if ("history".equals(action)) {
                String startDate = request.getParameter("start");
                String endDate = request.getParameter("end");
                List<Payment> listPayment;

                // Logika Filter Tanggal 
                if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
                    listPayment = dao.getPaymentsByDate(startDate, endDate);
                } else {
                    listPayment = dao.getAllPayments();
                }

                request.setAttribute("listPayment", listPayment);
                request.getRequestDispatcher("laporan_keuangan_harian.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard_content.jsp");
        }
    }

    // --- METHOD POST: Untuk Memproses Pembayaran Baru ---
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        PaymentDAO paymentDao = new PaymentDAO();

        try {
            // 1. Ambil Parameter dari Form Input
            String bookingIdStr = request.getParameter("bookingId");
            String totalBayarStr = request.getParameter("totalBayar"); 
            String metodeBayar = request.getParameter("metodeBayar");
            String catatan = request.getParameter("catatan");

            // 2. Cek Login Admin (Keamanan)
            Admin loggedInAdmin = (Admin) session.getAttribute("admin");
            if (loggedInAdmin == null) {
                session.setAttribute("alertStatus", "error");
                session.setAttribute("alertMessage", "Sesi berakhir, silakan login kembali.");
                response.sendRedirect("login.jsp");
                return;
            }

            // 3. Validasi Input
            if (bookingIdStr == null || totalBayarStr == null || totalBayarStr.isEmpty()) {
                throw new Exception("Data pembayaran tidak lengkap.");
            }

            // 4. Bersihkan Format Rupiah (Hapus karakter non-angka)
            String cleanTotal = totalBayarStr.replaceAll("[^0-9]", "");
            if (cleanTotal.isEmpty()) cleanTotal = "0";

            // 5. Buat Objek Payment
            Payment p = new Payment();
            p.setBookingId(Integer.parseInt(bookingIdStr));
            p.setTotalBayar(new BigDecimal(cleanTotal));
            p.setMetodeBayar(metodeBayar);
            p.setCatatan(catatan);
            p.setAdmin(loggedInAdmin); 
            
            // 6. Simpan ke Database via DAO
            if (paymentDao.insertPayment(p)) {
                session.setAttribute("swal_success", "Pembayaran Berhasil Disimpan!");
                
                response.sendRedirect("cetak_invoice_customer.jsp?id=" + p.getBookingId());
            } else {
                throw new Exception("Gagal menyimpan ke database.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("alertStatus", "error");
            session.setAttribute("alertMessage", "Error: " + e.getMessage());
            response.sendRedirect("BookingServlet?action=list");
        }
    }
}