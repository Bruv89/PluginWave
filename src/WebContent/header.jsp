<%@ page import="model.Utente" %>
<%
    String path = request.getServletPath();
    if (path != null && path.endsWith("header.jsp")) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SoundWave</title>
    <link rel="stylesheet" href="styles/style.css">
    <style>
        body { margin: 0; font-family: Arial, sans-serif; }
        .navbar {
            background-color: #002244;
            color: white;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            font-weight: bold;
        }
        .navbar a:hover {
            text-decoration: underline;
        }
        .nav-left, .nav-right {
            display: flex;
            align-items: center;
        }
    </style>
</head>

<%
    Utente utente = (Utente) session.getAttribute("utente");
    String homeLink = "index.jsp";

    if (utente != null) {
        if ("admin".equals(utente.getRuolo())) {
            homeLink = "adminDashboard.jsp";
        } else {
            homeLink = "userDashboard.jsp";
        }
    }
%>

<body>
<div class="navbar">
    <div class="nav-left">
        <a href="<%= homeLink %>">SoundWave</a>
    </div>
    <div class="nav-right">
        <%
            if (utente != null) {
        %>
            <a href="home">Catalogo</a>
            <a href="carrello.jsp">Carrello</a>
            <a href="ordini">I miei ordini</a>
            <a href="#" onclick="confirmLogout()">Logout</a>
        <%
            } else {
        %>
            <a href="login.jsp">Accedi</a>
            <a href="register.jsp">Registrati</a>
        <%
            }
        %>
    </div>
</div>

<script>
    function confirmLogout() {
        if (confirm("Sei sicuro di voler effettuare il logout?")) {
            window.location.href = "logout";
        }
    }
</script>
