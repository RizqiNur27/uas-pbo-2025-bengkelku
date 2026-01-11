package omat.pbo.servis.mobil.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import omat.pbo.servis.mobil.dao.BookingDAO;
import omat.pbo.servis.mobil.model.Booking;

@WebServlet("/dashboard")
public class AdminServlet extends HttpServlet {

    private BookingDAO bookingDAO;

    @Override
    public void init() {
        bookingDAO = new BookingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Proteksi Keamanan: Cek Session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("isLoggedIn") == null) {
            response.sendRedirect("login.jsp?error=Silakan Login Dulu");
            return;
        }

        // Routing Konten Berdasarkan Parameter 'p'
        String pageTarget = request.getParameter("p");
        if (pageTarget == null || pageTarget.isEmpty()) {
            pageTarget = "dashboard_content"; // Halaman default saat pertama masuk
        }

        // Persiapan Data Berdasarkan Halaman yang Dibuka
        if (pageTarget.equals("dashboard_content")) {
            // Ambil Statistik & Antrean Terbaru untuk Dashboard Utama
            Map<String, Object> stats = bookingDAO.getDashboardStats();
            request.setAttribute("stats", stats);
            request.setAttribute("pageTitle", "Overview Dashboard");

        } else if (pageTarget.equals("booking_list")) {
            // Ambil semua data booking untuk halaman Antrean
            List<Booking> list = bookingDAO.getAllBookings();
            request.setAttribute("listBooking", list);
            request.setAttribute("pageTitle", "Daftar Antrean");

        } else if (pageTarget.equals("laporan_keuangan_harian")) {
            // Ambil statistik (termasuk incomeToday) untuk halaman Laporan
            Map<String, Object> stats = bookingDAO.getDashboardStats();
            request.setAttribute("stats", stats);
            request.setAttribute("pageTitle", "Laporan Keuangan");
        }

        request.setAttribute("includePage", pageTarget + ".jsp");

        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
}