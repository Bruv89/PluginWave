<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Carrello" %>
<%@ page import="model.ElementoCarrello" %>
<%@ page import="model.Utente" %>
<%@ page import="java.util.*" %>

<jsp:include page="header.jsp" />

<%
    Utente utente = (Utente) session.getAttribute("utente");
    Carrello carrello = (Carrello) session.getAttribute("carrello");

    if (utente == null) {
        session.setAttribute("redirectAfterLogin", "checkout.jsp");
%>
    <p style="color: red; padding: 20px;">
        🔒 Per completare l'ordine devi <a href="login.jsp">accedere</a> o <a href="register.jsp">registrarti</a>.
    </p>
<%
    } else if (carrello == null || carrello.isVuoto()) {
%>
    <p style="padding: 20px;">Il carrello è vuoto. <a href="home">Torna al catalogo</a></p>
<%
    } else {
%>

<h2 style="padding: 20px;">Checkout</h2>

<form action="confermaOrdine" method="post" id="checkoutForm" style="margin: 20px;">
    <h3>Dati di spedizione</h3>
    <label>Indirizzo: <input type="text" name="indirizzo"></label><br><br>
    <label>Città: <input type="text" name="citta"></label><br><br>
    <label>CAP: <input type="text" name="cap"></label><br><br>

    <h3>Dati di pagamento</h3>
    <label>Numero carta: <input type="text" name="carta"></label><br><br>
    <label>Intestatario: <input type="text" name="intestatario"></label><br><br>

    <p>Totale ordine: <strong>€ <%= carrello.getTotale() %></strong></p>

    <button type="submit">Conferma ordine</button>
</form>

<%
    }
%>

<script src="scripts/checkout.js" defer></script>
<jsp:include page="footer.jsp" />
