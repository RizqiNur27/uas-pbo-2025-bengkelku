package omat.pbo.servis.mobil.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.*;
import omat.pbo.servis.mobil.dao.*;
import omat.pbo.servis.mobil.model.*;

@WebServlet(name = "BookingServlet", urlPatterns = {"/BookingServlet"})
public class BookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = "dashboard";
        }

        BookingDAO dao = new BookingDAO();
        MechanicDAO mechDao = new MechanicDAO();
        HttpSession session = request.getSession();

        try {
            switch (action) {
                case "dashboard":
                    Map<String, Object> stats = dao.getDashboardStats();
                    List<Booking> recent = dao.getRecentBookings(5);

                    request.setAttribute("stats", stats);
                    request.setAttribute("recentBookings", recent);
                    request.getRequestDispatcher("dashboard_content.jsp").forward(request, response);
                    break;

                case "form":
                    CustomerDAO custDao = new CustomerDAO();
                    ServiceDAO serviceDao = new ServiceDAO();

                    request.setAttribute("customers", custDao.getAllCustomers());
                    request.setAttribute("mechanics", mechDao.getAllMechanics());
                    request.setAttribute("services", serviceDao.getAllServices());
                    request.getRequestDispatcher("reservasi_offline_admin.jsp").forward(request, response);
                    break;

                case "list":
                    request.setAttribute("listBooking", dao.getAllBookings());
                    request.getRequestDispatcher("booking_list.jsp").forward(request, response);
                    break;

                case "process":
                case "complete":
                case "cancel":
                    handleStatusChange(action, request, dao, session);
                    response.sendRedirect("BookingServlet?action=list");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("BookingServlet?action=list&error=true");
        }
    }

    private void handleStatusChange(String action, HttpServletRequest request, BookingDAO dao, HttpSession session) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Booking b = dao.getBookingById(id);

            if (b != null) {
                boolean success = false;
                String msg = "";
                if ("process".equals(action)) {
                    success = dao.startBookingProcess(id, b.getMechanicId());
                    msg = "Status diubah ke Proses!";
                } else if ("complete".equals(action)) {
                    success = dao.completeBooking(id, b.getMechanicId());
                    msg = "Servis Selesai! Siap untuk Pembayaran.";
                } else if ("cancel".equals(action)) {
                    success = dao.cancelBooking(id, b.getMechanicId());
                    msg = "Reservasi telah dibatalkan.";
                }
                if (success) {
                    session.setAttribute("swal_success", msg);
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        BookingDAO bookingDao = new BookingDAO();
        CustomerDAO custDao = new CustomerDAO();
        HttpSession session = request.getSession();

        // Handle Add Order (Online & Offline)
        if ("add_online".equals(action) || "add_offline".equals(action)) {
            try {
                String tipeReservasi = "add_online".equals(action) ? "Online" : "Offline";

                // --- AMBIL ID ADMIN DARI SESSION ---
                Integer adminId = (Integer) session.getAttribute("admin_id");

                if ("add_offline".equals(action) && adminId == null) {
                    response.sendRedirect("login.jsp?error=Sesi habis, silakan login ulang");
                    return;
                }

                // --- LOGIKA CUSTOMER (BARU vs LAMA) ---
                int finalCustId = 0;
                String wa = request.getParameter("whatsapp");
                String namaCust = request.getParameter("nama_customer");
                String custIdParam = request.getParameter("customer_id");
                String alamat = request.getParameter("alamat");

                if ("add_offline".equals(action)
                        && custIdParam != null
                        && custIdParam.matches("\\d+")
                        && !custIdParam.equals("0")) {

                    finalCustId = Integer.parseInt(custIdParam);

                } else {
                    Customer newCust = new Customer();
                    String fixNama = (namaCust != null && !namaCust.trim().isEmpty()) ? namaCust : "Pelanggan Tanpa Nama";
                    newCust.setNama(fixNama);
                    newCust.setWhatsapp(wa);
                    newCust.setAlamat(alamat);

                    finalCustId = custDao.addCustomerAndGetId(newCust);
                }

                // --- BUAT OBJEK BOOKING ---
                Booking b = new Booking();
                b.setCustomerId(finalCustId);

                if ("add_online".equals(action)) {
                    b.setUserId(1);
                } else {
                    b.setUserId(adminId);
                }

                // Set Mekanik
                String mechStr = request.getParameter("mechanic_id");
                b.setMechanicId((mechStr != null && !mechStr.isEmpty()) ? Integer.parseInt(mechStr) : 0);

                // Set Data Kendaraan & Lainnya
                b.setMerekMobil(request.getParameter("merek_mobil"));
                String nopol = request.getParameter("nopol");
                b.setNopol(nopol != null ? nopol.toUpperCase() : "");
                b.setKeluhan(request.getParameter("keluhan"));
                b.setWhatsapp(wa);
                b.setMetodePembayaran(request.getParameter("metode_bayar"));
                b.setTipeReservasi(tipeReservasi);

                // Status Awal
                b.setStatus("add_online".equals(action) ? "Pending" : "Waiting");

                try {
                    b.setTanggal(Date.valueOf(request.getParameter("tanggal")));
                    String jam = request.getParameter("jam_booking");
                    b.setJam(Time.valueOf(jam.length() == 5 ? jam + ":00" : jam));
                } catch (Exception e) {
                    b.setTanggal(new Date(System.currentTimeMillis()));
                    b.setJam(Time.valueOf("08:00:00"));
                }

                // --- HANDLING LAYANAN (CHECKBOX) ---
                String[] raw = request.getParameterValues("layanan_items");
                String[] serviceIds = null;

                if (raw != null && raw.length > 0) {
                    serviceIds = new String[raw.length];
                    for (int i = 0; i < raw.length; i++) {
                        if (raw[i].contains("|")) {
                            serviceIds[i] = raw[i].split("\\|")[0];
                        } else {
                            serviceIds[i] = raw[i];
                        }
                    }
                }

                // --- EKSEKUSI SIMPAN KE DB ---
                if (bookingDao.createBooking(b, serviceIds)) {
                    // Sukses
                    session.setAttribute("swal_success", "Order berhasil dibuat!");
                    String target = "add_online".equals(action) ? "index.html" : "BookingServlet?action=list";
                    response.sendRedirect(target);
                } else {
                    // Gagal di DAO
                    throw new Exception("Gagal menyimpan data transaksi.");
                }

            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("swal_error", "Gagal: " + e.getMessage());
                response.sendRedirect("BookingServlet?action=form");
            }
        }
    }
}
