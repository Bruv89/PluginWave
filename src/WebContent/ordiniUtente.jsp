<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.OrdineDTO, model.RigaOrdineDTO" %>
<jsp:include page="header.jsp" />

<h2 style="padding: 20px;">I tuoi ordini</h2>

<%
    Collection<OrdineDTO> ordini = (Collection<OrdineDTO>) request.getAttribute("ordini");

    if (ordini == null || ordini.isEmpty()) {
%>
    <p style="padding: 20px;">Non hai ancora effettuato ordini.</p>
<%
    } else {
        for (OrdineDTO ordine : ordini) {
%>
    <div style="border: 1px solid #ccc; margin: 20px; padding: 15px;">
        <h3>Ordine #<%= ordine.id %> – <%= ordine.data %></h3>
        <p>Spedizione a: <%= ordine.indirizzo %>, <%= ordine.cap %> <%= ordine.citta %></p>
        <table border="1" cellpadding="5" cellspacing="0">
            <tr>
                <th>Prodotto</th><th>Quantità</th><th>Prezzo</th><th>Subtotale</th>
            </tr>
            <%
                for (RigaOrdineDTO r : ordine.righe) {
            %>
            <tr>
                <td><%= r.nomeProdotto %></td>
                <td><%= r.quantita %></td>
                <td>€ <%= r.prezzo %></td>
                <td>€ <%= r.prezzo * r.quantita %></td>
            </tr>
            <% } %>
        </table>
        <p><strong>Totale ordine:</strong> € <%= ordine.totale %></p>
    </div>
<%
        }
    }
%>

<!-- ✅ Bottone per tornare alla dashboard -->
<p style="padding: 20px;">
    <a href="userDashboard.jsp">
        <button>← Torna alla tua area personale</button>
    </a>
</p>

<jsp:include page="footer.jsp" />


