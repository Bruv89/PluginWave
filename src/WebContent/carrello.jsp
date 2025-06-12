<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Carrello" %>
<%@ page import="model.ElementoCarrello" %>
<%@ page import="java.util.*" %>
<jsp:include page="header.jsp" />

<main>

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
        <div class="cart-grid" id="cartGrid">
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
            <input type="number" class="quantita" data-id="<%= id %>" value="<%= ec.getQuantita() %>" min="1" max="1000">
            
        </div>
        <div class="cart-cell prezzo" data-id="<%= id %>">€ <%= ec.getProdotto().getPrezzo() %></div>
        <div class="cart-cell subtotale" data-id="<%= id %>">€ <%= ec.getTotale() %></div>
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
</main>

<jsp:include page="footer.jsp" />

<script>
document.querySelectorAll('.quantita').forEach(input => {
    input.addEventListener('input', function () {
        const id = this.dataset.id;
        let quantita = parseInt(this.value);

        if (quantita > 1000) {
            quantita = 1000;
            this.value = 1000;
        } else if (quantita < 1 || isNaN(quantita)) {
            quantita = 1;
            this.value = 1;
        }

        const params = "idProdotto=" + encodeURIComponent(id) + "&quantita=" + encodeURIComponent(quantita);

        fetch('aggiornaCarrelloAjax', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: params
        })
        .then(res => res.json())
        .then(data => {
            const inputElem = document.querySelector('input[data-id="' + id + '"]');

            if (quantita === 0) {
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