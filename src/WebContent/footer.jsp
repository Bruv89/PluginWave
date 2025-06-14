<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String path = request.getServletPath();
    if (path != null && path.endsWith("footer.jsp")) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<footer class="site-footer">
    <div class="footer-content">
        <p>&copy; 2025 SoundWave - Tutti i diritti riservati</p>
        <p>
            <a href="index.jsp">Home</a> |
            <a href="contatti.jsp">Contatti</a> |
            <a href="privacy.jsp">Privacy</a>
        </p>
    </div>
</footer>
