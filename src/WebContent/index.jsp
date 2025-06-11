<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="header.jsp" />

<link rel="stylesheet" href="styles/style.css">

<div class="hero">
    <div class="hero-content">
        <h1>Benvenuto su <span class="brand">SoundWave</span></h1>
        <p>Il marketplace dove puoi acquistare plugin audio professionali.</p>

        <div class="cta-buttons">
            <a href="login.jsp" class="btn">Accedi</a>
            <a href="register.jsp" class="btn secondary">Registrati</a>
        </div>

        <div class="explore">
            <a href="home" class="btn explore-btn">🎧 Esplora catalogo</a>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
