package control;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.Carrello;

import java.io.IOException;

public class SvuotaCarrelloServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Carrello carrello = (Carrello) session.getAttribute("carrello");

        if (carrello != null) {
            carrello.svuota();
        }

        response.sendRedirect("carrello.jsp");
    }
}
