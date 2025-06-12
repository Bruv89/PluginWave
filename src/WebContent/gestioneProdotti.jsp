<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
<jsp:include page="header.jsp" />

<main>
<div class="gestione-prodotti-container">
    <h2 class="gestione-titolo">🛠️ Gestione Prodotti</h2>

    <% if ("ok".equals(request.getParameter("modifica"))) { %>
        <div class="success-message">✔️ Modifica salvata con successo.</div>
    <% } %>

    <%
        List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
        if (prodotti == null || prodotti.isEmpty()) {
    %>
        <p class="empty-cart">Nessun prodotto presente nel catalogo.</p>
    <%
        } else {
    %>
    <div class="tabella-container">
        <table class="tabella-prodotti">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Prezzo</th>
                    <th>Categoria</th>
                    <th>Azioni</th>
                </tr>
            </thead>
            <tbody>
            <% for (Prodotto p : prodotti) { %>
                <tr>
                    <td><%= p.getId() %></td>
                    <td><%= p.getNome() %></td>
                    <td>€ <%= p.getPrezzo() %></td>
                    <td><%= p.getCategoria() %></td>
                    <td class="azioni">
                        <form action="modificaProdotto.jsp" method="get">
                            <input type="hidden" name="id" value="<%= p.getId() %>">
                            <button class="btn secondary" type="submit">Modifica</button>
                        </form>
                        <form action="eliminaProdotto" method="post" onsubmit="return confirm('Sei sicuro di voler eliminare questo prodotto?');">
                            <input type="hidden" name="id" value="<%= p.getId() %>">
                            <button class="btn danger" type="submit">Elimina</button>
                        </form>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>
    <% } %>

    <div class="cart-back" style="margin-top: 40px;">
        <a href="adminDashboard.jsp">← Torna alla Dashboard</a>
    </div>
</div>
</main>


<jsp:include page="footer.jsp" />
