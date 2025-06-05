package model;

import java.sql.*;
import java.util.*;

public class OrdineDAO {

    public void doSaveOrdine(OrdineDTO ordine, int idUtente) throws SQLException {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "INSERT INTO ordine (id_utente, data, indirizzo, citta, cap, totale) VALUES (?, NOW(), ?, ?, ?, ?)",
                     Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, idUtente);
            ps.setString(2, ordine.indirizzo);
            ps.setString(3, ordine.citta);
            ps.setString(4, ordine.cap);
            ps.setDouble(5, ordine.totale);
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    ordine.id = rs.getInt(1);
                }
            }
        }
    }

    public void doSaveRigheOrdine(OrdineDTO ordine) throws SQLException {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "INSERT INTO riga_ordine (ordine_id, prodotto_id, quantita, prezzo) VALUES (?, ?, ?, ?)")) {

            for (RigaOrdineDTO r : ordine.righe) {
                ps.setInt(1, ordine.id);
                ps.setInt(2, r.idProdotto);
                ps.setInt(3, r.quantita);
                ps.setDouble(4, r.prezzo);
                ps.addBatch();
            }
            ps.executeBatch();
        }
    }

    public List<OrdineDTO> doRetrieveByUtente(int idUtente) throws SQLException {
        List<OrdineDTO> ordini = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT * FROM ordine WHERE id_utente = ? ORDER BY data DESC")) {

            ps.setInt(1, idUtente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrdineDTO o = mapOrdine(rs);
                    o.righe = doRetrieveRigheByOrdine(o.id);
                    ordini.add(o);
                }
            }
        }
        return ordini;
    }

    public List<RigaOrdineDTO> doRetrieveRigheByOrdine(int idOrdine) throws SQLException {
        List<RigaOrdineDTO> righe = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
            		 "SELECT r.*, p.nome FROM riga_ordine r JOIN prodotto p ON r.id_prodotto = p.id WHERE r.id_ordine = ?")) {

            ps.setInt(1, idOrdine);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    RigaOrdineDTO r = new RigaOrdineDTO();
                    r.idProdotto = rs.getInt("id_prodotto");
                    r.nomeProdotto = rs.getString("nome");
                    r.quantita = rs.getInt("quantita");
                    r.prezzo = rs.getDouble("prezzo");
                    righe.add(r);
                }
            }
        }
        return righe;
    }

    public List<OrdineDTO> doRetrieveByData(String da, String a) throws SQLException {
        List<OrdineDTO> ordini = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT o.*, u.email FROM ordine o JOIN utente u ON o.id_utente = u.id WHERE o.data BETWEEN ? AND ? ORDER BY o.data DESC")) {

            ps.setString(1, da);
            ps.setString(2, a);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrdineDTO o = mapOrdine(rs);
                    o.emailUtente = rs.getString("email");
                    o.righe = doRetrieveRigheByOrdine(o.id);
                    ordini.add(o);
                }
            }
        }
        return ordini;
    }

    public List<OrdineDTO> doRetrieveByEmail(String email) throws SQLException {
        List<OrdineDTO> ordini = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT o.*, u.email FROM ordine o JOIN utente u ON o.id_utente = u.id WHERE u.email = ? ORDER BY o.data DESC")) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrdineDTO o = mapOrdine(rs);
                    o.emailUtente = rs.getString("email");
                    o.righe = doRetrieveRigheByOrdine(o.id);
                    ordini.add(o);
                }
            }
        }
        return ordini;
    }

    public List<OrdineDTO> doRetrieveAll() throws SQLException {
        List<OrdineDTO> ordini = new ArrayList<>();
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT o.*, u.email FROM ordine o JOIN utente u ON o.id_utente = u.id ORDER BY o.data DESC")) {

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrdineDTO o = mapOrdine(rs);
                    o.emailUtente = rs.getString("email");
                    o.righe = doRetrieveRigheByOrdine(o.id);
                    ordini.add(o);
                }
            }
        }
        return ordini;
    }

    private OrdineDTO mapOrdine(ResultSet rs) throws SQLException {
        OrdineDTO o = new OrdineDTO();
        o.id = rs.getInt("id");
        o.data = rs.getTimestamp("data");
        o.indirizzo = rs.getString("indirizzo");
        o.citta = rs.getString("citta");
        o.cap = rs.getString("cap");
        o.totale = rs.getDouble("totale");
        return o;
    }
}
