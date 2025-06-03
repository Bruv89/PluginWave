package control;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.Prodotto;
import model.ProdottoDAO;

import java.io.IOException;
import java.sql.SQLException;

public class InserisciProdottoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(((model.Utente) session.getAttribute("utente")).getRuolo())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String nome = request.getParameter("nome");
        String descrizione = request.getParameter("descrizione");
        double prezzo = Double.parseDouble(request.getParameter("prezzo"));
        String immagine = request.getParameter("immagine");
        String categoria = request.getParameter("categoria"); // ✅ manca nel tuo codice

        Prodotto p = new Prodotto();
        p.setNome(nome);
        p.setDescrizione(descrizione);
        p.setPrezzo(prezzo);
        p.setImmagine(immagine);
        p.setCategoria(categoria); // ✅ ora sì

        try {
            new ProdottoDAO().doSave(p);
            response.sendRedirect("adminDashboard.jsp?inserito=ok");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
