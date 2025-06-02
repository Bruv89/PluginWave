<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - PluginWave</title>
    <link rel="stylesheet" href="styles/style.css">
    <script src="scripts/login.js" defer></script>
</head>
<body>
<jsp:include page="header.jsp" />

<%
    String regSuccess = request.getParameter("registrazione");
    if ("ok".equals(regSuccess)) {
%>
    <p style="color: green; padding: 10px; text-align: center;">
        ✅ Il tuo profilo è stato creato correttamente. Effettua il login.
    </p>
<%
    }
%>

<h2>Login</h2>

<form action="login" method="post" id="loginForm">
    <label>Email:</label>
    <input type="email" name="email" required><br>
    
    <label>Password:</label>
    <input type="password" name="password" required><br>
    
    <button type="submit">Accedi</button>
</form>

<p style="color:red;">
    <%= request.getAttribute("errore") != null ? request.getAttribute("errore") : "" %>
</p>

<jsp:include page="footer.jsp" />
</body>
</html>
