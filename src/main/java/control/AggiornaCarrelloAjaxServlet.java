package control;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.Carrello;
import model.ElementoCarrello;

import java.io.IOException;
import java.io.PrintWriter;

public class AggiornaCarrelloAjaxServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Carrello carrello = (Carrello) session.getAttribute("carrello");

        int idProdotto = Integer.parseInt(request.getParameter("idProdotto"));
        int quantita = Integer.parseInt(request.getParameter("quantita"));

        if (carrello != null) {
            if (quantita <= 0) {
                carrello.rimuoviProdotto(idProdotto);
            } else {
                carrello.aggiornaQuantita(idProdotto, quantita);
            }
        }

        // Prepara la risposta JSON
        double subtotale = 0;
        if (carrello != null) {
            for (ElementoCarrello ec : carrello.getElementi()) {
                if (ec.getProdotto().getId() == idProdotto) {
                    subtotale = ec.getTotale();
                    break;
                }
            }
        }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print("{\"subtotale\": " + subtotale + ", \"totale\": " + carrello.getTotale() + "}");
        out.flush();
    }
}
