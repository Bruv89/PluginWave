package control;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.ProdottoDAO;
import model.Utente;

import java.io.IOException;
import java.sql.SQLException;

public class EliminaProdottoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utente admin = (session != null) ? (Utente) session.getAttribute("utente") : null;

        if (admin == null || !"admin".equals(admin.getRuolo())) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            new ProdottoDAO().doDelete(id);
            response.sendRedirect("gestioneProdotti");
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }
}
