<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Carrello" %>
<%@ page import="model.ElementoCarrello" %>
<%@ page import="java.util.*" %>
<jsp:include page="header.jsp" />

<link rel="stylesheet" href="styles/style.css">

<div class="cart-container">
    <h2>🛒 Il tuo carrello</h2>

    <%
        Carrello carrello = (Carrello) session.getAttribute("carrello");

        if (carrello == null || carrello.isVuoto()) {
    %>
        <p class="empty-cart">Il carrello è vuoto.</p>
    <%
        } else {
    %>
        <div class="cart-grid">
            <div class="cart-header">Prodotto</div>
            <div class="cart-header">Quantità</div>
            <div class="cart-header">Prezzo</div>
            <div class="cart-header">Totale</div>
            <div class="cart-header">Rimuovi</div>

            <%
                for (ElementoCarrello ec : carrello.getElementi()) {
                    int id = ec.getProdotto().getId();
            %>
            <div class="cart-cell"><%= ec.getProdotto().getNome() %></div>
            <div class="cart-cell">
                <input type="number" class="quantita" data-id="<%= id %>" value="<%= ec.getQuantita() %>" min="0">
            </div>
            <div class="cart-cell prezzo">€ <%= ec.getProdotto().getPrezzo() %></div>
            <div class="cart-cell subtotale">€ <%= ec.getTotale() %></div>
            <div class="cart-cell">
                <form action="aggiornaCarrello" method="post">
                    <input type="hidden" name="rimuovi" value="<%= id %>">
                    <button class="remove-btn" type="submit">❌</button>
                </form>
            </div>
            <% } %>
        </div>

        <div class="cart-summary">
            <strong id="totale">Totale: € <%= carrello.getTotale() %></strong>
        </div>

        <div class="cart-actions">
            <a href="checkout.jsp" class="btn">Procedi al checkout</a>
        </div>
    <%
        }
    %>

    <div class="cart-back">
        <a href="home">← Torna al catalogo prodotti</a>
    </div>
</div>

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
            const riga = document.querySelector('div.cart-cell input[data-id="' + id + '"]')?.closest('.cart-grid');
            const inputElem = document.querySelector('input[data-id="' + id + '"]');
            const container = inputElem?.closest('.cart-grid');

            if (quantita == 0 && container) {
                inputElem.closest('.cart-cell').parentElement.remove();
            } else {
                inputElem.parentElement.nextElementSibling.textContent = "€ " + Number(data.prezzo).toFixed(2);
                inputElem.parentElement.nextElementSibling.nextElementSibling.textContent = "€ " + Number(data.subtotale).toFixed(2);
            }

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
