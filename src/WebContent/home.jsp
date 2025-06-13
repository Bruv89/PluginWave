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

    <!-- 🔍 Filtro categoria -->
    <form method="get" action="home" class="admin-search-form">
        <label for="categoria">Filtra per categoria:</label>
        <select name="categoria" id="categoria" onchange="this.form.submit()">
            <option value="">-- Tutte le categorie --</option>
            <%
                List<String> categorie = (List<String>) request.getAttribute("categorie");
                String catSel = (String) request.getAttribute("categoriaSelezionata");
                for (String c : categorie) {
            %>
                <option value="<%= c %>" <%= (c.equals(catSel)) ? "selected" : "" %>><%= c %></option>
            <%
                }
            %>
        </select>
    </form>

    <!-- 🧱 Catalogo prodotti -->
    <div class="catalogo-grid">
        <%
            List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
            for (Prodotto p : prodotti) {
        %>
        <div class="prodotto-card">
            <a href="prodotto.jsp?id=<%= p.getId() %>">
                <img src="<%= p.getImmagine() %>" alt="<%= p.getNome() %>" class="prodotto-img">
                <div class="prodotto-info">
                    <h3><%= p.getNome() %></h3>
                    <p class="prodotto-desc"><%= p.getDescrizione() %></p>
                    <p class="prodotto-prezzo">€ <%= p.getPrezzo() %></p>
                </div>
            </a>

            <form action="aggiungiCarrello" method="post">
                <input type="hidden" name="idProdotto" value="<%= p.getId() %>">
                <button type="submit" class="btn">🛒 Aggiungi al carrello</button>
            </form>
        </div>
        <%
            }
        %>
    </div>
</div>

</main>
<jsp:include page="footer.jsp" />
