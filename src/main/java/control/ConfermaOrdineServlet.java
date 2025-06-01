package control;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.*;

import java.io.IOException;
import java.sql.*;
import java.util.Collection;

public class ConfermaOrdineServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Utente utente = (Utente) session.getAttribute("utente");
        Carrello carrello = (Carrello) session.getAttribute("carrello");

        if (utente == null || carrello == null || carrello.isVuoto()) {
            response.sendRedirect("login.jsp");
            return;
        }

        String indirizzo = request.getParameter("indirizzo");
        String citta = request.getParameter("citta");
        String cap = request.getParameter("cap");

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false); // Transazione

            // Inserimento ordine
            String sqlOrdine = "INSERT INTO ordine (id_utente, indirizzo, citta, cap, totale) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement psOrdine = con.prepareStatement(sqlOrdine, Statement.RETURN_GENERATED_KEYS);
            psOrdine.setInt(1, utente.getId());
            psOrdine.setString(2, indirizzo);
            psOrdine.setString(3, citta);
            psOrdine.setString(4, cap);
            psOrdine.setDouble(5, carrello.getTotale());
            psOrdine.executeUpdate();

            ResultSet rs = psOrdine.getGeneratedKeys();
            rs.next();
            int idOrdine = rs.getInt(1);

            // Inserimento righe ordine
            String sqlRiga = "INSERT INTO riga_ordine (id_ordine, id_prodotto, quantita, prezzo) VALUES (?, ?, ?, ?)";
            PreparedStatement psRiga = con.prepareStatement(sqlRiga);

            for (ElementoCarrello ec : carrello.getElementi()) {
                psRiga.setInt(1, idOrdine);
                psRiga.setInt(2, ec.getProdotto().getId());
                psRiga.setInt(3, ec.getQuantita());
                psRiga.setDouble(4, ec.getProdotto().getPrezzo());
                psRiga.addBatch();
            }

            psRiga.executeBatch();
            con.commit();

            session.removeAttribute("carrello"); // svuota carrello
            response.sendRedirect("ordineConfermato.jsp");

        } catch (SQLException e) {
            throw new ServletException("Errore nel salvataggio ordine", e);
        }
    }
}



