<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Utente" %>
<jsp:include page="header.jsp" />

<%
    Utente u = (Utente) session.getAttribute("utente");
    if (u == null || !"admin".equals(u.getRuolo())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<h2 style="padding: 20px;">Inserisci nuovo prodotto</h2>

<form action="inserisciProdotto" method="post" style="padding: 20px;">
    <label>Nome: <input type="text" name="nome" required></label><br><br>
    <label>Descrizione: <textarea name="descrizione" rows="4" cols="50" required></textarea></label><br><br>
    <label>Prezzo: <input type="number" step="0.01" name="prezzo" required></label><br><br>
   	<label>Immagine (URL): <input type="text" name="immagine" required></label><br><br>
   	<label>Categoria: <input type="text" name="categoria" required></label><br><br>
    <button type="submit">Aggiungi prodotto</button>
</form>

<p style="padding: 20px;">
    <a href="adminDashboard.jsp">← Torna alla dashboard</a>
</p>

<jsp:include page="footer.jsp" />
