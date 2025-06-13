<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.*" %>
<jsp:include page="header.jsp" />

<main>
    <div class="form-checkout">
        <h2 style="text-align:center; color: #023059;">🔐 Login</h2>

        <%
            String regSuccess = request.getParameter("registrazione");
            if ("ok".equals(regSuccess)) {
        %>
            <div class="success-message">✅ Il tuo profilo è stato creato correttamente. Effettua il login.</div>
        <%
            }
        %>

        <form action="login" method="post" id="loginForm">
            <label for="email">Email</label>
            <input type="email" name="email" id="email" required>

            <label for="password">Password</label>
            <input type="password" name="password" id="password" required>

            <button type="submit" class="btn">Accedi</button>
        </form>

        <% if (request.getAttribute("errore") != null) { %>
            <p class="error" style="text-align:center;"><%= request.getAttribute("errore") %></p>
        <% } %>

        <p style="text-align:center; margin-top: 15px;">
            Non hai un account? <a href="register.jsp" style="color:#025373; font-weight:bold;">Registrati</a>
        </p>
    </div>
</main>

<jsp:include page="footer.jsp" />
