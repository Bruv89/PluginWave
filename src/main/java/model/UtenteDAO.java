package model;

import java.sql.*;

public class UtenteDAO {

    public Utente checkLogin(String email, String password) throws SQLException {
        String sql = "SELECT * FROM utente WHERE email = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Utente u = new Utente();
                u.setId(rs.getInt("id"));
                u.setNome(rs.getString("nome"));
                u.setEmail(rs.getString("email"));
                u.setRuolo(rs.getString("ruolo"));
                return u;
            }
        }
        return null;
    }

    public boolean register(String nome, String email, String password) throws SQLException {
        String sql = "INSERT INTO utente(nome, email, password, ruolo) VALUES (?, ?, ?, 'user')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, nome);
            stmt.setString(2, email);
            stmt.setString(3, password);

            return stmt.executeUpdate() > 0;
        }
    }
}

