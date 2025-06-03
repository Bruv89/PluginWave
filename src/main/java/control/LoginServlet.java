package control;

import model.Utente;
import model.UtenteDAO;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Utente u = new UtenteDAO().checkLogin(email, password);
            if (u != null) {
                HttpSession session = request.getSession();
                session.setAttribute("utente", u);

                // Redirect dinamico se esiste
                String redirect = (String) session.getAttribute("redirectAfterLogin");
                if (redirect != null) {
                    session.removeAttribute("redirectAfterLogin");
                    response.sendRedirect(redirect);
                    return;
                }

                // Altrimenti redirect classico
                if ("admin".equals(u.getRuolo())) {
                    response.sendRedirect("adminDashboard.jsp");
                } else {
                    response.sendRedirect("userDashboard.jsp");
                }

            } else {
                request.setAttribute("errore", "Email o password errati.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
