<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
<jsp:include page="header.jsp" />

<h2>Catalogo prodotti</h2>

<div style="display: flex; flex-wrap: wrap; gap: 20px;">
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
