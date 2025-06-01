<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Carrello" %>
<%@ page import="model.ElementoCarrello" %>
<%@ page import="java.util.*" %>
<jsp:include page="header.jsp" />

<h2 style="padding: 20px;">Checkout</h2>

<%
    Carrello carrello = (Carrello) session.getAttribute("carrello");

    if (carrello == null || carrello.isVuoto()) {
%>
    <p style="padding: 20px;">Il carrello è vuoto. <a href="home">Torna al catalogo</a></p>
<%
    } else {
%>
    <form action="confermaOrdine" method="post" style="margin: 20px;">
        <h3>Dati di spedizione</h3>
        <label>Indirizzo: <input type="text" name="indirizzo" required></label><br><br>
        <label>Città: <input type="text" name="citta" required></label><br><br>
        <label>CAP: <input type="text" name="cap" required pattern="\d{5}"></label><br><br>

        <h3>Dati di pagamento</h3>
        <label>Numero carta: <input type="text" name="carta" required pattern="\d{16}"></label><br><br>
        <label>Intestatario: <input type="text" name="intestatario" required></label><br><br>

        <p>Totale ordine: <strong>€ <%= carrello.getTotale() %></strong></p>

        <button type="submit">Conferma ordine</button>
    </form>
<%
    }
%>

<jsp:include page="footer.jsp" />
