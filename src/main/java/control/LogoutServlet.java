package control;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // non crearla se non esiste
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("index.jsp");
    }
}

