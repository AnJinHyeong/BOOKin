package semi.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.MemberDao;

@WebFilter(urlPatterns = {"/admin/*",})
public class AdminFilter implements Filter {
	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		try {
			MemberDao memberDao = new MemberDao();

			boolean isAdmin = memberDao
					.getMember(
							(Integer) req.getSession().getAttribute("member"))
					.getMemberAdmin().equals("Y");

			if (isAdmin) {
				chain.doFilter(request, response);
			} else {
				resp.sendRedirect(req.getContextPath() + "/index.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}

	}
}