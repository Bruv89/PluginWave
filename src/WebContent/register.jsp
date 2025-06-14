<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="header.jsp" />

<main>
    <div class="form-checkout">
        <h2 style="text-align:center; color: #023059;">📝 Registrazione</h2>

        <form action="register" method="post" id="registerForm">
            <label for="nome">Nome</label>
            <input type="text" name="nome" id="nome" required minlength="6" required maxlength="50">

            <label for="email">Email</label>
            <input type="email" name="email" id="email" required maxlength="100">

            <label for="password">Password</label>
            <input type="password" name="password" id="password" required minlength="6" maxlength="50">

            <button type="submit" class="btn">Registrati</button>
        </form>

        <% if (request.getAttribute("errore") != null) { %>
            <p class="error" style="text-align:center;"><%= request.getAttribute("errore") %></p>
        <% } %>

        <p style="text-align:center; margin-top: 15px;">
            Hai già un account? <a href="login.jsp" style="color:#025373; font-weight:bold;">Accedi</a>
        </p>
    </div>
</main>

<jsp:include page="footer.jsp" />
