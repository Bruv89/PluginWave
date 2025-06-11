<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Utente" %>
<jsp:include page="header.jsp" />

<link rel="stylesheet" href="styles/style.css">

<%
    Utente u = (Utente) session.getAttribute("utente");
    if (u == null || !"admin".equals(u.getRuolo())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<div class="admin-dashboard">
    <h2>Benvenuto, <span class="highlight">Amministratore</span></h2>
    <p class="subtitle">Gestisci il catalogo e gli ordini tramite le opzioni sottostanti.</p>

    <%
        if ("ok".equals(request.getParameter("inserito"))) {
    %>
        <div class="success-message">✅ Prodotto aggiunto con successo!</div>
    <%
        }
    %>

    <div class="admin-actions">
        <a href="inserisciProdotto.jsp" class="admin-card">➕ Inserisci nuovo prodotto</a>
        <a href="gestioneProdotti" class="admin-card">✏️ Modifica / Elimina prodotti</a>
        <a href="ordiniAdmin.jsp" class="admin-card">📦 Visualizza ordini</a>
        <a href="logout" class="admin-card danger">🔓 Logout</a>
    </div>
</div>

<jsp:include page="footer.jsp" />
