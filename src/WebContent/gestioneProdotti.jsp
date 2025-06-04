<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
<jsp:include page="header.jsp" />

<h2 style="padding: 20px;">Gestione Prodotti</h2>

<%
    List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
    if (prodotti == null || prodotti.isEmpty()) {
%>
    <p style="padding: 20px;">Nessun prodotto presente nel catalogo.</p>
<%
    } else {
%>
    <table border="1" cellpadding="10" cellspacing="0" style="margin: 20px; width: 90%;">
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Prezzo</th>
            <th>Categoria</th>
            <th>Azioni</th>
        </tr>
        <%
            for (Prodotto p : prodotti) {
        %>
        <tr>
            <td><%= p.getId() %></td>
            <td><%= p.getNome() %></td>
            <td>€ <%= p.getPrezzo() %></td>
            <td><%= p.getCategoria() %></td>
            <td>
                <form action="modificaProdotto.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="id" value="<%= p.getId() %>">
                    <button type="submit">Modifica</button>
                </form>
                <form action="eliminaProdotto" method="post" style="display:inline;" onsubmit="return confirm('Sei sicuro di voler eliminare questo prodotto?');">
                    <input type="hidden" name="id" value="<%= p.getId() %>">
                    <button type="submit">Elimina</button>
                </form>
            </td>
        </tr>
        <%
            }
        %>
    </table>
<%
    }
%>

<p style="padding: 20px;">
    <a href="adminDashboard.jsp">← Torna alla Dashboard</a>
</p>

<jsp:include page="footer.jsp" />
