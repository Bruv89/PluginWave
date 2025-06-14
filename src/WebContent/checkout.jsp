<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Carrello" %>
<%@ page import="model.ElementoCarrello" %>
<%@ page import="model.Utente" %>
<%@ page import="java.util.*" %>

<jsp:include page="header.jsp" />
<main>
<%
    Utente utente = (Utente) session.getAttribute("utente");
model.OrdineDTO ultimoOrdine = null;
if (utente != null) {
    try {
        ultimoOrdine = model.OrdineDAO.getUltimoOrdineByUtente(utente.getId());
    } catch (Exception e) {
        e.printStackTrace();
    }
}

    Carrello carrello = (Carrello) session.getAttribute("carrello");

    if (utente == null) {
        session.setAttribute("redirectAfterLogin", "checkout.jsp");
%>
    <div class="cart-container">
        <p class="empty-cart">
            🔒 Per completare l'ordine devi <a href="login.jsp">accedere</a> o <a href="register.jsp">registrarti</a>.
        </p>
    </div>
<%
    } else if (carrello == null || carrello.isVuoto()) {
%>
    <div class="cart-container">
        <p class="empty-cart">Il carrello è vuoto. <a href="home">Torna al catalogo</a></p>
    </div>
<%
    } else {
%>

<div class="cart-container">
    <h2 style="text-align:center;">🧾 Checkout</h2>

    <form action="confermaOrdine" method="post" id="checkoutForm" class="form-checkout">
        <h3>📦 Dati di spedizione</h3>

        <label for="indirizzo">Indirizzo</label>
        <input type="text" name="indirizzo" id="indirizzo" required
       value="<%= ultimoOrdine != null ? ultimoOrdine.indirizzo : "" %>">

        <label for="citta">Città</label>
        <input type="text" name="citta" id="citta" required
       value="<%= ultimoOrdine != null ? ultimoOrdine.citta : "" %>">

        <label for="cap">CAP</label>
        <input type="text" name="cap" id="cap" required
       value="<%= ultimoOrdine != null ? ultimoOrdine.cap : "" %>">

        <h3>💳 Dati di pagamento</h3>

        <label for="carta">Numero carta</label>
        <input type="text" name="carta" id="carta" required>

        <label for="intestatario">Intestatario</label>
        <input type="text" name="intestatario" id="intestatario" required>

        <p class="cart-summary">Totale ordine: <strong>€ <%= carrello.getTotale() %></strong></p>

        <div class="cart-actions">
            <button type="submit" class="btn">Conferma ordine</button>
        </div>
    </form>
</div>

<%
    }
%>
</main>
<script src="scripts/checkout.js" defer></script>
<jsp:include page="footer.jsp" />
