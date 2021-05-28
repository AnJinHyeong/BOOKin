package semi.servlet.member;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.MemberDao;
import semi.beans.MemberDto;

@WebServlet(urlPatterns = "/member/logout.kh")
public class MemberLogoutServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			req.getSession().removeAttribute("member");
			resp.sendRedirect(req.getContextPath());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
