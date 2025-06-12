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

<main>
<div class="gestione-prodotti-container">
    <h2 class="gestione-titolo">➕ Inserisci nuovo prodotto</h2>

    <form action="inserisciProdotto" method="post" class="form-checkout">
        <label for="nome">Nome</label>
        <input type="text" name="nome" id="nome" required minlength="3" maxlength="100">

        <label for="descrizione">Descrizione</label>
        <textarea name="descrizione" id="descrizione" rows="4" required minlength="10" maxlength="500"></textarea>

        <label for="prezzo">Prezzo</label>
        <input type="number" name="prezzo" id="prezzo" required min="0.01" max="9999.99" step="0.01">

        <label for="immagine">Immagine (URL)</label>
        <input type="text" name="immagine" id="immagine" required>

        <label for="categoria">Categoria</label>
        <input type="text" name="categoria" id="categoria" required maxlength="50">

        <button type="submit" class="btn">Aggiungi prodotto</button>
    </form>

    <div class="cart-back" style="margin-top: 30px;">
        <a href="adminDashboard.jsp">← Torna alla dashboard</a>
    </div>
</div>
</main>

<jsp:include page="footer.jsp" />

<script>
document.addEventListener("DOMContentLoaded", function () {
    const categoriaInput = document.getElementById("categoria");
    const dataList = document.createElement("datalist");
    dataList.id = "categorie-suggerite";
    categoriaInput.setAttribute("list", "categorie-suggerite");
    document.body.appendChild(dataList);

    fetch("categorie")
        .then(response => response.json())
        .then(data => {
            data.forEach(cat => {
                const option = document.createElement("option");
                option.value = cat;
                dataList.appendChild(option);
            });
        })
        .catch(err => console.error("Errore nel recupero categorie:", err));
});
</script>
