package omat.pbo.servis.mobil.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import omat.pbo.servis.mobil.dao.MechanicDAO;
import omat.pbo.servis.mobil.model.Mechanic;

@WebServlet(name = "MechanicServlet", urlPatterns = {"/MechanicServlet"})
public class MechanicServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = "list";
        }

        MechanicDAO dao = new MechanicDAO();
        HttpSession session = request.getSession();

        try {
            if ("list".equals(action)) {
                List<Mechanic> listMekanik = dao.getAllMechanics();
                request.setAttribute("listMechanic", listMekanik);

                request.getRequestDispatcher("data_mekanik.jsp").forward(request, response);
            } else if ("delete".equals(action)) {
                String idStr = request.getParameter("id");
                if (idStr != null) {
                    int id = Integer.parseInt(idStr);
                    boolean success = dao.deleteMechanic(id);

                    if (success) {
                        session.setAttribute("swal_success", "Data mekanik berhasil dihapus!");
                    } else {
                        session.setAttribute("alertStatus", "error");
                        session.setAttribute("alertMessage", "Gagal! Mekanik sedang menangani order.");
                    }
                }
                response.sendRedirect("MechanicServlet?action=list");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("MechanicServlet?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        MechanicDAO dao = new MechanicDAO();
        HttpSession session = request.getSession();

        try {
            Mechanic m = new Mechanic();
            m.setNamaMekanik(request.getParameter("nama"));
            m.setSpesialisasi(request.getParameter("spesialisasi"));
            m.setStatus(request.getParameter("status"));

            if ("add".equals(action)) {
                dao.insertMechanic(m);
                session.setAttribute("swal_success", "Mekanik baru berhasil ditambahkan!");
            } else if ("update".equals(action)) {
                m.setId(Integer.parseInt(request.getParameter("id")));
                dao.updateMechanic(m);
                session.setAttribute("swal_success", "Data mekanik berhasil diperbarui!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("alertStatus", "error");
            session.setAttribute("alertMessage", "Terjadi kesalahan: " + e.getMessage());
        }
        response.sendRedirect("MechanicServlet?action=list");
    }
}
