package omat.pbo.servis.mobil.controller;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {
    "/dashboard.jsp",
    "/BookingServlet",
    "/PaymentServlet",
    "/booking_list.jsp",
    "/dashboard_content.jsp",
    "/reservasi_offline_admin.jsp",
    "/cetak_invoice_customer.jsp",
    "/data_layanan.jsp",
    "/data_mekanik.jsp",
    "/data_pelanggan.jsp",
    "/laporan_keuangan_harian.jsp"
})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String loginURI = httpRequest.getContextPath() + "/login.jsp";

        boolean loggedIn = (session != null && session.getAttribute("isLoggedIn") != null && (Boolean) session.getAttribute("isLoggedIn"));

        if (loggedIn) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect(loginURI + "?error=Silakan login terlebih dahulu");
        }
    }

    @Override
    public void destroy() {
    }
}