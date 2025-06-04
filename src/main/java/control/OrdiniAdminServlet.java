package control;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.OrdineDAO;
import model.OrdineDTO;
import model.Utente;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;

public class OrdiniAdminServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utente admin = (session != null) ? (Utente) session.getAttribute("utente") : null;

        if (admin == null || !"admin".equals(admin.getRuolo())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String email = request.getParameter("email");

        try {
            OrdineDAO dao = new OrdineDAO();
            Collection<OrdineDTO> ordini;

            if (email != null && !email.isBlank()) {
                ordini = dao.doRetrieveByEmail(email);
            } else if (startDate != null && endDate != null && !startDate.isBlank() && !endDate.isBlank()) {
                ordini = dao.doRetrieveByData(startDate, endDate);
            } else {
                ordini = dao.doRetrieveAll();
            }

            request.setAttribute("ordini", ordini);
            request.getRequestDispatcher("ordiniAdmin.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}

