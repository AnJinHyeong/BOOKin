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

@WebServlet(urlPatterns = "/member/signup.kh")
public class MemberSignUpServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		try {
			req.setCharacterEncoding("UTF-8");
			MemberDto memberDto = new MemberDto();
			memberDto.setMemberAddress(req.getParameter("memberAddress"));
			memberDto.setMemberBirth(Date.valueOf(req.getParameter("memberBirth")));
			memberDto.setMemberEmail(req.getParameter("memberEmail"));
			memberDto.setMemberGender(req.getParameter("memberGender"));
			memberDto.setMemberId(req.getParameter("memberId"));
			memberDto.setMemberName(req.getParameter("memberName"));
			memberDto.setMemberPhone(req.getParameter("memberPhone"));
			memberDto.setMemberPw(req.getParameter("memberPw"));
			System.out.println(memberDto);
			MemberDao memberDao = new MemberDao();
			memberDao.signUp(memberDto);
			resp.sendRedirect("thxSignup.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
		
	}
}
