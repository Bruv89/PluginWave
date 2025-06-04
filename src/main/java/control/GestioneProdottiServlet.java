package control;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.Prodotto;
import model.ProdottoDAO;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class GestioneProdottiServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        model.Utente admin = (session != null) ? (model.Utente) session.getAttribute("utente") : null;

        if (admin == null || !"admin".equals(admin.getRuolo())) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            List<Prodotto> prodotti = new ProdottoDAO().doRetrieveAll();
            request.setAttribute("prodotti", prodotti);
            request.getRequestDispatcher("gestioneProdotti.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
