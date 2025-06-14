<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.OrdineDTO, model.RigaOrdineDTO" %>
<%@ page import="model.Utente" %>
<jsp:include page="header.jsp" />

<div class="admin-dashboard">
    <h2 class="gestione-titolo">📦 I tuoi ordini</h2>

    <%
        Collection<OrdineDTO> ordini = (Collection<OrdineDTO>) request.getAttribute("ordini");

        if (ordini == null || ordini.isEmpty()) {
    %>
        <p class="ordine-confermato-testo">Non hai ancora effettuato ordini.</p>
    <%
        } else {
            for (OrdineDTO ordine : ordini) {
    %>
        <div class="ordine-box">
            <h3>🧾 Ordine #<%= ordine.id %> – <%= ordine.data %></h3>
            <p class="ordine-indirizzo">📍 Spedizione a: <%= ordine.indirizzo %>, <%= ordine.cap %> <%= ordine.citta %></p>

            <table class="tabella-prodotti">
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

            <p class="ordine-totale"><strong>Totale ordine:</strong> € <%= ordine.totale %></p>
        </div>
    <%
            }
        }
    %>
<%
    model.Utente utente = (model.Utente) session.getAttribute("utente");
    String dashboardLink = "login.jsp"; // default fallback
    if (utente != null) {
        dashboardLink = utente.getRuolo().equals("admin") ? "adminDashboard.jsp" : "userDashboard.jsp";
    }
%>
    <div class="ordine-confermato-link">
    <a href="<%= dashboardLink %>">← Torna alla tua area personale</a>
</div>
    
</div>

<jsp:include page="footer.jsp" />
