<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Utente" %>
<jsp:include page="header.jsp" />
<main>

<%
    Utente utente = (Utente) session.getAttribute("utente");
%>

<div class="hero">
    <div class="hero-content">
        <h1>Benvenuto su <span class="brand">SoundWave</span></h1>
        <p>Il marketplace dove puoi acquistare plugin audio professionali di alta qualità, per produttori, musicisti e sound designer.</p>

        <div class="cta-buttons">
            <% if (utente == null) { %>
                <a href="login.jsp" class="btn">🎤 Accedi</a>
                <a href="register.jsp" class="btn secondary">📝 Registrati</a>
            <% } else { %>
                <a href="home" class="btn">🎧 Vai al catalogo</a>
                <a href="<%= utente.getRuolo().equals("admin") ? "adminDashboard.jsp" : "userDashboard.jsp" %>" class="btn secondary">
                    👤 Area personale
                </a>
            <% } %>
        </div>

        <% if (utente == null) { %>
        <div class="explore">
            <a href="home" class="btn explore-btn">🎧 Esplora il Catalogo</a>
        </div>
        <% } %>
    </div>
</div>

</main>
<jsp:include page="footer.jsp" />
