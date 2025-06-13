<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ProdottoDAO, model.Prodotto" %>
<%@ page import="java.sql.*" %>
<jsp:include page="header.jsp" />

<%
    String idParam = request.getParameter("id");
    Prodotto prodotto = null;
    
    if (idParam != null) {
        try {
            int id = Integer.parseInt(idParam);
            prodotto = new ProdottoDAO().doRetrieveById(id);
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
        }
    }
%>

<main>
    <div class="ordine-confermato-container">
        <% if (prodotto != null) { %>
            <h2 class="ordine-confermato-titolo"><%= prodotto.getNome() %></h2>
            <img src="<%= prodotto.getImmagine() %>" alt="<%= prodotto.getNome() %>" class="prodotto-img" style="max-width:300px; margin: 20px 0;">
            <p class="ordine-confermato-testo"><%= prodotto.getDescrizione() %></p>
            <p class="ordine-confermato-testo"><strong>Prezzo:</strong> € <%= prodotto.getPrezzo() %></p>

            <form action="aggiungiCarrello" method="post" style="margin-top: 20px;">
                <input type="hidden" name="idProdotto" value="<%= prodotto.getId() %>">
                <button type="submit" class="btn">🛒 Aggiungi al carrello</button>
            </form>

            <div class="ordine-confermato-link" style="margin-top: 30px;">
                <a href="home">← Torna al catalogo</a>
            </div>
        <% } else { %>
            <p class="ordine-confermato-testo">Prodotto non trovato.</p>
            <div class="ordine-confermato-link">
                <a href="home">← Torna al catalogo</a>
            </div>
        <% } %>
    </div>
</main>

<jsp:include page="footer.jsp" />
