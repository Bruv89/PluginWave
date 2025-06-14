<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    model.Utente utente = (model.Utente) session.getAttribute("utente");
    if (utente == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<jsp:include page="header.jsp" />

<main>
    <div class="ordine-confermato-container">
        <h2 class="ordine-confermato-titolo">🎉 Ordine confermato!</h2>
        <p class="ordine-confermato-testo">
            Grazie per il tuo acquisto! Riceverai a breve una mail con i dettagli della spedizione.
        </p>

        <div class="ordine-confermato-link">
            <a href="home">← Torna al catalogo</a>
        </div>
    </div>
</main>

<jsp:include page="footer.jsp" />
