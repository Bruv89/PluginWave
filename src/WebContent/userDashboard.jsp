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

<main>
    <div class="admin-dashboard">
        <h2>🎉 Benvenuto, <span class="highlight"><%= u.getNome() %></span>!</h2>
        <p class="subtitle">Questa è la tua area personale su PluginWave.</p>

        <div class="admin-actions">
            <a class="admin-card" href="home">🎧 Vai al catalogo prodotti</a>
            <a class="admin-card" href="carrello.jsp">🛒 Visualizza carrello</a>
            <a class="admin-card" href="ordini">📦 I miei ordini</a>
            <a class="admin-card" href="logout">🔓 Logout</a>
        </div>
    </div>
</main>

<jsp:include page="footer.jsp" />
