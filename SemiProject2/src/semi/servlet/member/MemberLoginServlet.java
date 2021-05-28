package semi.servlet.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.MemberDao;
import semi.beans.MemberDto;

@WebServlet(urlPatterns = "/member/login.kh")
public class MemberLoginServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			MemberDto memberDto = new MemberDto();
			memberDto.setMemberId(req.getParameter("memberId"));
			memberDto.setMemberPw(req.getParameter("memberPw"));
			MemberDao memberDao = new MemberDao();
			Integer memberNo = memberDao.login(memberDto);
			
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter writer = resp.getWriter();
						
			if(memberNo != null) {
				req.getSession().setAttribute("member", memberNo);
				resp.sendRedirect(req.getContextPath());
			}else {
				writer.println("<script>alert('비밀번호가 맞지 않습니다.'); location.href='"+"login.jsp"+"';</script>");
			}
			
			writer.close();
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}
}
