<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Utente" %>
<jsp:include page="header.jsp" />

<%
    Utente u = (Utente) session.getAttribute("utente");
    if (u == null || !"admin".equals(u.getRuolo())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<div style="padding: 40px;">
    <h2>Benvenuto, Amministratore</h2>
    <p>Gestisci il catalogo e gli ordini.</p>

    <ul style="margin-top: 20px;">
        <li><a href="inserisciProdotto.jsp">➕ Inserisci nuovo prodotto</a></li>
        <li><a href="gestioneProdotti">✏️ Modifica / Elimina prodotti</a></li>
        <li><a href="ordiniAdmin.jsp">📦 Visualizza ordini</a></li>
        <li><a href="logout">🔓 Logout</a></li>
    </ul>
</div>

<jsp:include page="footer.jsp" />

