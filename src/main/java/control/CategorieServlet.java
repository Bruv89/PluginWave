package control;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.ProdottoDAO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/categorie")
public class CategorieServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");

	    try {
	        List<String> categorie = ProdottoDAO.getCategorieDistinte(); // Ora gestito
	        String json = new Gson().toJson(categorie);
	        PrintWriter out = response.getWriter();
	        out.print(json);
	        out.flush();
	    } catch (Exception e) {
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        response.getWriter().print("{\"error\": \"Errore durante il recupero delle categorie.\"}");
	        e.printStackTrace(); // Log utile per debugging
	    }
	}
}
