<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
<%@ page import="model.Utente" %>
<jsp:include page="header.jsp" />
<main>
<%
    Utente utente = (Utente) session.getAttribute("utente");
%>

<div class="catalogo-wrapper">
    <h2 class="catalogo-titolo">
        🎛️ Catalogo Prodotti
        <% if (utente != null) { %>
            – Benvenuto, <%= utente.getNome() %>!
        <% } else { %>
            – Benvenuto ospite!
        <% } %>
    </h2>

    <div class="catalogo-grid">
        <%
            List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
            for (Prodotto p : prodotti) {
        %>
        <div class="prodotto-card">
            <img src="<%= p.getImmagine() %>" alt="<%= p.getNome() %>" class="prodotto-img">
            <div class="prodotto-info">
                <h3><%= p.getNome() %></h3>
                <p class="prodotto-desc"><%= p.getDescrizione() %></p>
                <p class="prodotto-prezzo">€ <%= p.getPrezzo() %></p>

                <form action="aggiungiCarrello" method="post">
                    <input type="hidden" name="idProdotto" value="<%= p.getId() %>">
                    <button type="submit" class="btn">🛒 Aggiungi al carrello</button>
                </form>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>

</main>
<jsp:include page="footer.jsp" />
