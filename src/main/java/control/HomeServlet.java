package control;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.Prodotto;
import model.ProdottoDAO;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class HomeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProdottoDAO prodottoDAO = new ProdottoDAO();
        String categoria = request.getParameter("categoria");

        try {
            List<Prodotto> prodotti;

            if (categoria != null && !categoria.isEmpty()) {
                prodotti = prodottoDAO.doRetrieveByCategoria(categoria);  // Metodo da aggiungere in ProdottoDAO
            } else {
                prodotti = prodottoDAO.doRetrieveAll();
            }

            List<String> categorie = ProdottoDAO.getCategorieDistinte();

            request.setAttribute("prodotti", prodotti);
            request.setAttribute("categorie", categorie);
            request.setAttribute("categoriaSelezionata", categoria);

            RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
