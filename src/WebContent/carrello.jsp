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
        <tr data-id="<%= id %>">
            <td><%= ec.getProdotto().getNome() %></td>
            <td>
                <input type="number" class="quantita" data-id="<%= id %>" value="<%= ec.getQuantita() %>" min="0">
            </td>
            <td class="prezzo">€ <%= ec.getProdotto().getPrezzo() %></td>
            <td class="subtotale">€ <%= ec.getTotale() %></td>
            <td>
                <form action="aggiornaCarrello" method="post">
                    <input type="hidden" name="rimuovi" value="<%= id %>">
                    <button type="submit">❌</button>
                </form>
            </td>
        </tr>
        <% } %>
    </table>

    <p style="margin: 20px;">
  <strong id="totale">Totale: € <%= carrello.getTotale() %></strong>
</p>
    

    <div style="margin: 20px;">
        <a href="checkout.jsp"><button>Procedi al checkout</button></a>
    </div>
<%
    }
%>

<p style="margin: 20px;">
    <a href="home">← Torna al catalogo prodotti</a>
</p>

<jsp:include page="footer.jsp" />

<script>
document.querySelectorAll('.quantita').forEach(input => {
    input.addEventListener('input', function () {
        const id = this.dataset.id;
        const quantita = this.value;

        const params = "idProdotto=" + encodeURIComponent(id) + "&quantita=" + encodeURIComponent(quantita);

        fetch('aggiornaCarrelloAjax', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: params
        })
        .then(res => res.json())
        .then(data => {
            const riga = document.querySelector('tr[data-id="' + id + '"]');
            if (riga) {
                if (quantita == 0) {
                    // Se la quantità è zero, rimuovi la riga
                    riga.remove();
                } else {
                    const subtotaleCell = riga.querySelector('.subtotale');
                    if (subtotaleCell) {
                        subtotaleCell.textContent = "€ " + Number(data.subtotale).toFixed(2);
                    }

                    const prezzoCell = riga.querySelector('.prezzo');
                    if (prezzoCell) {
                        prezzoCell.textContent = "€ " + Number(data.prezzo).toFixed(2);
                    }
                }
            }

            // Aggiorna sempre il totale finale
            const totaleEl = document.getElementById('totale');
            if (totaleEl) {
                totaleEl.textContent = "Totale: € " + Number(data.totale).toFixed(2);
            }
        })
        .catch(error => {
            console.error('Errore nella risposta AJAX:', error);
        });
    });
});
</script>

