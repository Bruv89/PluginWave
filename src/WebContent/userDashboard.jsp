<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Utente" %>
<jsp:include page="header.jsp" />

<%
    Utente u = (Utente) session.getAttribute("utente");
    if (u == null || !"user".equals(u.getRuolo())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<div style="padding: 40px;">
    <h2>Benvenuto, <%= u.getNome() %>!</h2>
    <p>Questa è la tua area personale su SoundWave.</p>

    <ul style="margin-top: 20px;">
        <li><a href="home">🎧 Vai al catalogo prodotti</a></li>
        <li><a href="carrello.jsp">🛒 Visualizza carrello</a></li>
        <li><a href="ordiniUtente.jsp">📦 I miei ordini</a> (in arrivo)</li>
        <li><a href="logout">🔓 Logout</a></li>
    </ul>
</div>

<jsp:include page="footer.jsp" />
