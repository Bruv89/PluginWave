package control;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.Carrello;

import java.io.IOException;
import java.util.Enumeration;

public class AggiornaCarrelloServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Carrello carrello = (Carrello) session.getAttribute("carrello");

        if (carrello != null) {
            Enumeration<String> parametri = request.getParameterNames();

            while (parametri.hasMoreElements()) {
                String param = parametri.nextElement();

                if (param.startsWith("quantita_")) {
                    int idProdotto = Integer.parseInt(param.substring(9));
                    int quantita = Integer.parseInt(request.getParameter(param));
                    if (quantita <= 0) {
                        carrello.rimuoviProdotto(idProdotto);
                    } else {
                        carrello.aggiornaQuantita(idProdotto, quantita);
                    }
                }
            }

            // Rimozione prodotti selezionati
            String[] daRimuovere = request.getParameterValues("rimuovi");
            if (daRimuovere != null) {
                for (String id : daRimuovere) {
                    carrello.rimuoviProdotto(Integer.parseInt(id));
                }
            }
        }

        response.sendRedirect("carrello.jsp");
    }
}
