<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.OrdineDTO, model.RigaOrdineDTO" %>
<jsp:include page="header.jsp" />

<h2 style="padding: 20px;">Visualizza Ordini</h2>

<form action="ordiniAdmin" method="get" style="padding: 20px;">
    <label>Data inizio: <input type="date" name="startDate"></label>
    <label style="margin-left: 20px;">Data fine: <input type="date" name="endDate"></label>
    <br><br>
    <label>Email cliente: <input type="email" name="email" style="width: 300px;"></label>
    <br><br>
    <button type="submit">Cerca</button>
</form>

<hr style="margin: 20px;">

<%
    Collection<OrdineDTO> ordini = (Collection<OrdineDTO>) request.getAttribute("ordini");

    if (ordini != null) {
        if (ordini.isEmpty()) {
%>
            <p style="padding: 20px;">Nessun ordine trovato.</p>
<%
        } else {
            for (OrdineDTO ordine : ordini) {
%>
    <div style="border: 1px solid #ccc; margin: 20px; padding: 15px;">
        <h3>Ordine #<%= ordine.id %> – <%= ordine.data %> – <%= ordine.emailUtente %></h3>
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
    }
%>

<p style="padding: 20px;"><a href="adminDashboard.jsp">← Torna alla Dashboard</a></p>

<jsp:include page="footer.jsp" />
