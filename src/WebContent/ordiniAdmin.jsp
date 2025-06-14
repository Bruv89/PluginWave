<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.OrdineDTO, model.RigaOrdineDTO" %>


<%
    model.Utente utente = (model.Utente) session.getAttribute("utente");
    if (utente == null || !"admin".equals(utente.getRuolo())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<jsp:include page="header.jsp" />

<div class="admin-dashboard">
    <h2 class="gestione-titolo">📋 Visualizza Ordini</h2>

    <form action="ordiniAdmin" method="get" class="admin-search-form">
        <label>Data inizio:
            <input type="date" name="startDate">
        </label>

        <label>Data fine:
            <input type="date" name="endDate">
        </label>

        <label>Email cliente:
            <input type="email" name="email" list="emailSuggerite" id="emailInput">
            <datalist id="emailSuggerite"></datalist>
        </label>

        <button type="submit" class="btn">Cerca</button>
    </form>

    <%
        Collection<OrdineDTO> ordini = (Collection<OrdineDTO>) request.getAttribute("ordini");

        if (ordini != null) {
            if (ordini.isEmpty()) {
    %>
        <p class="ordine-confermato-testo">❌ Nessun ordine trovato.</p>
    <%
            } else {
                for (OrdineDTO ordine : ordini) {
    %>
        <div class="ordine-box">
            <h3>🧾 Ordine #<%= ordine.id %> – <%= ordine.data %> – <%= ordine.emailUtente %></h3>
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
        }
    %>

    <div class="ordine-confermato-link">
        <a href="adminDashboard.jsp">← Torna alla Dashboard</a>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script>
document.addEventListener("DOMContentLoaded", () => {
    fetch("email-utenti")
        .then(response => response.json())
        .then(data => {
            const datalist = document.getElementById("emailSuggerite");
            data.forEach(email => {
                const option = document.createElement("option");
                option.value = email;
                datalist.appendChild(option);
            });
        })
        .catch(error => console.error("Errore nel caricamento email:", error));
});
</script>
