<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registrazione - PluginWave</title>
    <link rel="stylesheet" href="styles/style.css">
    <script src="scripts/register.js" defer></script>
</head>
<body>
<jsp:include page="header.jsp" />

<h2>Registrazione</h2>

<form action="register" method="post" id="registerForm">
    <label>Nome:</label>
    <input type="text" name="nome" required><br>

    <label>Email:</label>
    <input type="email" name="email" required><br>

    <label>Password:</label>
    <input type="password" name="password" required><br>

    <button type="submit">Registrati</button>
</form>

<p style="color:red;">
    <%= request.getAttribute("errore") != null ? request.getAttribute("errore") : "" %>
</p>

<jsp:include page="footer.jsp" />
</body>
</html>
