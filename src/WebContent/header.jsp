<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    model.Utente utente = (model.Utente) session.getAttribute("utente");
    if (utente != null) {
%>
    <div style="text-align: right; padding: 10px; background-color: #f2f2f2;">
        <span>Ciao, <%= utente.getNome() %>!</span>
        <a href="#" onclick="confirmLogout()" style="margin-left: 10px;">Logout</a>
    </div>
<%
    }
%>
<script>
function confirmLogout() {
    if (confirm("Sei sicuro di voler effettuare il logout?")) {
        window.location.href = "logout";
    }
}
</script>


</body>
</html>