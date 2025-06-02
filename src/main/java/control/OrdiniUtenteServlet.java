package control;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.*;

import java.io.IOException;
import java.sql.*;
import java.util.*;

public class OrdiniUtenteServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Utente utente = (Utente) (session != null ? session.getAttribute("utente") : null);

        if (utente == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT o.id, o.data, o.totale, o.indirizzo, o.citta, o.cap, " +
                         "r.id_prodotto, r.quantita, r.prezzo, p.nome " +
                         "FROM ordine o " +
                         "JOIN riga_ordine r ON o.id = r.id_ordine " +
                         "JOIN prodotto p ON r.id_prodotto = p.id " +
                         "WHERE o.id_utente = ? " +
                         "ORDER BY o.data DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, utente.getId());
            ResultSet rs = ps.executeQuery();

            // Mappa ordine ID → lista righe
            Map<Integer, OrdineDTO> ordini = new LinkedHashMap<>();

            while (rs.next()) {
                int idOrdine = rs.getInt("id");

                OrdineDTO ordine = ordini.get(idOrdine);
                if (ordine == null) {
                    ordine = new OrdineDTO();
                    ordine.id = idOrdine;
                    ordine.data = rs.getTimestamp("data");
                    ordine.totale = rs.getDouble("totale");
                    ordine.indirizzo = rs.getString("indirizzo");
                    ordine.citta = rs.getString("citta");
                    ordine.cap = rs.getString("cap");
                    ordine.righe = new ArrayList<>();
                    ordini.put(idOrdine, ordine);
                }

                RigaOrdineDTO riga = new RigaOrdineDTO();
                riga.nomeProdotto = rs.getString("nome");
                riga.quantita = rs.getInt("quantita");
                riga.prezzo = rs.getDouble("prezzo");
                ordine.righe.add(riga);
            }

            request.setAttribute("ordini", ordini.values());
            RequestDispatcher dispatcher = request.getRequestDispatcher("ordiniUtente.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
