package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	private static final String URL = "jdbc:mysql://localhost:3306/pluginwave";
    private static final String USER = "root"; 
    private static final String PASSWORD = "el92"; 

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

public static void main(String[] args) {
    try (Connection conn = getConnection()) {
        System.out.println("✅ Connessione riuscita!");
    } catch (SQLException e) {
        System.err.println("❌ Connessione fallita: " + e.getMessage());
    }
}
}
