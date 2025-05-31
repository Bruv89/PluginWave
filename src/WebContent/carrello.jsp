<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Carrello" %>
<%@ page import="model.ElementoCarrello" %>
<%@ page import="java.util.*" %>
<jsp:include page="header.jsp" />

<h2 style="padding: 20px;">Il tuo carrello</h2>

<%
    Carrello carrello = (Carrello) session.getAttribute("carrello");

    if (carrello == null || carrello.isVuoto()) {
%>
    <p style="padding: 20px;">Il carrello è vuoto.</p>
<%
    } else {
%>
    <form action="aggiornaCarrello" method="post">
        <table border="1" cellpadding="10" cellspacing="0" style="margin: 20px;">
            <tr>
                <th>Prodotto</th>
                <th>Quantità</th>
                <th>Prezzo</th>
                <th>Totale</th>
                <th>Rimuovi</th>
            </tr>
            <%
                for (ElementoCarrello ec : carrello.getElementi()) {
                    int id = ec.getProdotto().getId();
            %>
            <tr>
                <td><%= ec.getProdotto().getNome() %></td>
                <td>
                    <input type="number" name="quantita_<%= id %>" value="<%= ec.getQuantita() %>" min="0">
                </td>
                <td>€ <%= ec.getProdotto().getPrezzo() %></td>
                <td>€ <%= ec.getTotale() %></td>
                <td>
                    <input type="checkbox" name="rimuovi" value="<%= id %>">
                </td>
            </tr>
            <% } %>
        </table>
        <p style="margin: 20px;">
            Totale: <strong>€ <%= carrello.getTotale() %></strong>
        </p>
        <div style="margin: 20px;">
            <button type="submit">Aggiorna carrello</button>
            <a href="svuotaCarrello" style="margin-left: 10px;">Svuota tutto</a>
        </div>
    </form>
<%
    }
%>

<!-- ✅ Link visibile sempre -->
<p style="margin: 20px;">
    <a href="home">← Torna al catalogo prodotti</a>
</p>

<jsp:include page="footer.jsp" />
