package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProdottoDAO {

    public List<Prodotto> doRetrieveAll() throws SQLException {
        List<Prodotto> prodotti = new ArrayList<>();

        String sql = "SELECT * FROM prodotto";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Prodotto p = new Prodotto();
                p.setId(rs.getInt("id"));
                p.setNome(rs.getString("nome"));
                p.setDescrizione(rs.getString("descrizione"));
                p.setPrezzo(rs.getDouble("prezzo"));
                p.setCategoria(rs.getString("categoria"));
                p.setImmagine(rs.getString("immagine"));
                p.setDisponibilita(rs.getInt("disponibilita"));

                prodotti.add(p);
            }
        }

        return prodotti;
    }

    public Prodotto doRetrieveById(int id) throws SQLException {
        String sql = "SELECT * FROM prodotto WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Prodotto p = new Prodotto();
                p.setId(rs.getInt("id"));
                p.setNome(rs.getString("nome"));
                p.setDescrizione(rs.getString("descrizione"));
                p.setPrezzo(rs.getDouble("prezzo"));
                p.setCategoria(rs.getString("categoria"));
                p.setImmagine(rs.getString("immagine"));
                p.setDisponibilita(rs.getInt("disponibilita"));
                return p;
            }

            return null;
        }
    }
    
    
    public void doSave(Prodotto prodotto) throws SQLException {
        try (Connection con = DBConnection.getConnection()) {
        	String sql = "INSERT INTO prodotto (nome, descrizione, prezzo, immagine, categoria) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, prodotto.getNome());
            ps.setString(2, prodotto.getDescrizione());
            ps.setDouble(3, prodotto.getPrezzo());
            ps.setString(4, prodotto.getImmagine());
            ps.setString(5, prodotto.getCategoria());
            ps.executeUpdate();
        }
    }

    
    public void doUpdate(Prodotto p) throws SQLException {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "UPDATE prodotto SET nome=?, descrizione=?, prezzo=?, immagine=?, categoria=? WHERE id=?")) {

            ps.setString(1, p.getNome());
            ps.setString(2, p.getDescrizione());
            ps.setDouble(3, p.getPrezzo());
            ps.setString(4, p.getImmagine());
            ps.setString(5, p.getCategoria());
            ps.setInt(6, p.getId());
            ps.executeUpdate();
        }
    }

    public void doDelete(int id) throws SQLException {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("DELETE FROM prodotto WHERE id=?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public static List<String> getCategorieDistinte() throws SQLException {
        List<String> categorie = new ArrayList<>();

        String sql = "SELECT DISTINCT categoria FROM prodotto";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                categorie.add(rs.getString("categoria"));
            }
        }

        return categorie;
    }


    
}


