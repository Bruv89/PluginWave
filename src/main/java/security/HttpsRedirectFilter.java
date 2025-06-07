package security;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class HttpsRedirectFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        if (!req.isSecure()) {
            String httpsURL = "https://" + req.getServerName() + req.getRequestURI();
            String query = req.getQueryString();
            if (query != null) {
                httpsURL += "?" + query;
            }
            res.sendRedirect(httpsURL);
            return;
        }

        chain.doFilter(request, response);
    }

    public void init(FilterConfig filterConfig) {}
    public void destroy() {}
}
