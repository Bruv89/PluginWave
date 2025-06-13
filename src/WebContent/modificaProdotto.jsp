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
        out.println("<div class='error' style='text-align:center;'>❌ Errore nel recupero del prodotto.</div>");
    }

    if (prodotto == null) {
%>
    <div class="error" style="text-align:center;">❌ Prodotto non trovato.</div>
<%
    } else {
%>

<main>
    <h2 style="text-align:center; color:#023059;">✏️ Modifica Prodotto</h2>

    <form action="modificaProdotto" method="post">
        <input type="hidden" name="id" value="<%= prodotto.getId() %>">

        <label>Nome:</label>
        <input type="text" name="nome" value="<%= prodotto.getNome() %>" maxlength="100" required>

        <label>Descrizione:</label>
        <input type="text" name="descrizione" value="<%= prodotto.getDescrizione() %>" maxlength="255" required>

        <label>Prezzo:</label>
        <input type="number" name="prezzo" value="<%= prodotto.getPrezzo() %>" step="0.01" min="0" required>

        <label>Categoria:</label>
        <input type="text" name="categoria" value="<%= prodotto.getCategoria() %>" maxlength="50" required>

        <label>Immagine (URL):</label>
        <input type="text" name="immagine" value="<%= prodotto.getImmagine() %>" required>

        <button type="submit">💾 Salva modifiche</button>
    </form>

    <div class="cart-back" style="margin-top: 30px;">
        <a href="gestioneProdotti">← Torna alla lista prodotti</a>
    </div>
</main>

<%
    }
%>

<jsp:include page="footer.jsp" />
