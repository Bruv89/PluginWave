package control;

import model.UtenteDAO;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            boolean success = new UtenteDAO().register(nome, email, password);
            if (success) {
                response.sendRedirect("login.jsp");
            } else {
                request.setAttribute("errore", "Registrazione fallita.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}

