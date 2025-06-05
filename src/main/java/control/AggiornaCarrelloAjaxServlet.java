package control;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.Carrello;
import model.ElementoCarrello;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

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
        double totale = 0;
        double prezzoProdotto = 0;

        if (carrello != null) {
            for (ElementoCarrello ec : carrello.getElementi()) {
                if (ec.getProdotto().getId() == idProdotto) {
                    subtotale = ec.getTotale();
                    prezzoProdotto = ec.getProdotto().getPrezzo();
                }
            }
            totale = carrello.getTotale();
        }

        Map<String, Double> jsonResponse = new HashMap<>();
        jsonResponse.put("prezzo", prezzoProdotto);
        jsonResponse.put("subtotale", subtotale);
        jsonResponse.put("totale", totale);

        Gson gson = new Gson();
        String json = gson.toJson(jsonResponse);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
}
