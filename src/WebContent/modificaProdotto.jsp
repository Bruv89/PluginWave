<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Prodotto" %>
<%@ page import="model.ProdottoDAO" %>
<%@ page import="model.Utente" %>
<%@ page import="java.sql.*" %>
<jsp:include page="header.jsp" />

<%
    HttpSession sessione = request.getSession(false);
    Utente utente = (sessione != null) ? (Utente) sessione.getAttribute("utente") : null;

    if (utente == null || !"admin".equals(utente.getRuolo())) {
        response.sendRedirect("login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
    Prodotto prodotto = null;
    try {
        prodotto = new ProdottoDAO().doRetrieveById(id);
    } catch (SQLException e) {
        out.println("<p style='color: red;'>Errore nel recupero del prodotto.</p>");
    }

    if (prodotto == null) {
%>
    <p style="padding: 20px; color: red;">Prodotto non trovato.</p>
<%
    } else {
%>

<h2 style="padding: 20px;">Modifica Prodotto</h2>

<form action="modificaProdotto" method="post" style="padding: 20px;">
    <input type="hidden" name="id" value="<%= prodotto.getId() %>">
    <label>Nome: <input type="text" name="nome" value="<%= prodotto.getNome() %>" required></label><br><br>
    <label>Descrizione: <input type="text" name="descrizione" value="<%= prodotto.getDescrizione() %>" required></label><br><br>
    <label>Prezzo: <input type="number" name="prezzo" value="<%= prodotto.getPrezzo() %>" step="0.01" required></label><br><br>
    <label>Categoria: <input type="text" name="categoria" value="<%= prodotto.getCategoria() %>" required></label><br><br>
    <label>Immagine (URL): <input type="text" name="immagine" value="<%= prodotto.getImmagine() %>" required></label><br><br>

    <button type="submit">Salva modifiche</button>
</form>

<p style="padding: 20px;"><a href="gestioneProdotti">← Torna alla lista prodotti</a></p>

<%
    }
%>

<jsp:include page="footer.jsp" />
