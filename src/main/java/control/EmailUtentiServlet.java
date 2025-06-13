package control;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.OrdineDAO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/email-utenti")
public class EmailUtentiServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        List<String> emailList = OrdineDAO.getEmailUniche(); 
        String json = new Gson().toJson(emailList);
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
}
