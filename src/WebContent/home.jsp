<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
<%@ page import="model.Utente" %>
<jsp:include page="header.jsp" />

<%
    Utente utente = (Utente) session.getAttribute("utente");
%>

<h2 style="padding: 20px;">
    Catalogo prodotti
    <% if (utente != null) { %>
        – Benvenuto, <%= utente.getNome() %>!
    <% } else { %>
        – Benvenuto ospite!
    <% } %>
</h2>

<div style="display: flex; flex-wrap: wrap; gap: 20px; padding: 0 20px 20px 20px;">
    <%
        List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
        for (Prodotto p : prodotti) {
    %>
    <div style="border: 1px solid #ccc; padding: 10px; width: 250px;">
        <img src="<%= p.getImmagine() %>" alt="<%= p.getNome() %>" width="200"><br>
        <strong><%= p.getNome() %></strong><br>
        <%= p.getDescrizione() %><br>
        <span>€ <%= p.getPrezzo() %></span><br>
        <form action="aggiungiCarrello" method="post">
            <input type="hidden" name="idProdotto" value="<%= p.getId() %>">
            <button type="submit">Aggiungi al carrello</button>
        </form>
    </div>
    <%
        }
    %>
</div>

<jsp:include page="footer.jsp" />
