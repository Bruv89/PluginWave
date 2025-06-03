package control;

import model.Utente;
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
            UtenteDAO dao = new UtenteDAO();
            boolean success = dao.register(nome, email, password);

            if (success) {
                // Recupera l'utente appena registrato
                Utente utente = dao.checkLogin(email, password);

                // Login automatico
                HttpSession session = request.getSession(true);
                session.setAttribute("utente", utente);

                // Redirect dinamico
                String redirect = (String) session.getAttribute("redirectAfterLogin");
                if (redirect != null) {
                    session.removeAttribute("redirectAfterLogin");
                    response.sendRedirect(redirect);
                } else {
                    response.sendRedirect("userDashboard.jsp");
                }

            } else {
                // Registrazione fallita
                request.setAttribute("errore", "Registrazione fallita.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}



