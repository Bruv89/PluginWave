package control;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.*;

import java.io.IOException;
import java.sql.SQLException;

public class AggiungiAlCarrelloServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Carrello carrello = (Carrello) session.getAttribute("carrello");

        if (carrello == null) {
            carrello = new Carrello();
            session.setAttribute("carrello", carrello);
        }

        int idProdotto = Integer.parseInt(request.getParameter("idProdotto"));
        int quantita = 1; // puoi modificarlo se permetti scelta quantità nel form

        try {
            Prodotto prodotto = new ProdottoDAO().doRetrieveById(idProdotto);
            if (prodotto != null) {
                carrello.aggiungiProdotto(prodotto, quantita);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        response.sendRedirect("carrello.jsp");
    }
}
