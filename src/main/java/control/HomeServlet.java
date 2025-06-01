package control;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.Prodotto;
import model.ProdottoDAO;
import model.Utente;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class HomeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔐 Controllo accesso
        HttpSession session = request.getSession(false);
        Utente utente = (Utente) (session != null ? session.getAttribute("utente") : null);

        if (utente == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // ✅ Utente loggato → carica prodotti e mostra home.jsp
        try {
            List<Prodotto> prodotti = new ProdottoDAO().doRetrieveAll();
            request.setAttribute("prodotti", prodotti);
            RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}


