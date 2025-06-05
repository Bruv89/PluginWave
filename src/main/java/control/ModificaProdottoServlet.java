package control;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.Prodotto;
import model.ProdottoDAO;

import java.io.IOException;
import java.sql.SQLException;

public class ModificaProdottoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        model.Utente admin = (session != null) ? (model.Utente) session.getAttribute("utente") : null;

        if (admin == null || !"admin".equals(admin.getRuolo())) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String nome = request.getParameter("nome");
            String descrizione = request.getParameter("descrizione");
            double prezzo = Double.parseDouble(request.getParameter("prezzo"));
            String categoria = request.getParameter("categoria");
            String immagine = request.getParameter("immagine");

            Prodotto p = new Prodotto();
            p.setId(id);
            p.setNome(nome);
            p.setDescrizione(descrizione);
            p.setPrezzo(prezzo);
            p.setCategoria(categoria);
            p.setImmagine(immagine);

            new ProdottoDAO().doUpdate(p);

            response.sendRedirect("gestioneProdotti?modifica=ok");
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }
}
