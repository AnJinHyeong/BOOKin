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

@WebServlet(urlPatterns = "/member/memberEdit.kh")
public class MemberEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			MemberDto memberDto = new MemberDto();
			memberDto.setMemberNo(Integer.parseInt(req.getParameter("memberNo")));
			memberDto.setMemberId(req.getParameter("memberId"));			
			memberDto.setMemberPw(req.getParameter("memberPw"));
			memberDto.setMemberPhone(req.getParameter("memberPhone"));
			memberDto.setMemberBirth(Date.valueOf(req.getParameter("memberBirth")));
			memberDto.setMemberEmail(req.getParameter("memberEmail"));
			memberDto.setMemberAddress(req.getParameter("memberAddress"));
			MemberDao memberDao = new MemberDao();
			boolean result = memberDao.changeInformation(memberDto, req.getParameter("newMemberPw"));
			
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter writer = resp.getWriter();
			
			if(!result) {				 
				writer.println("<script>alert('비밀번호가 맞지 않습니다.'); location.href='"+"myInfo.jsp"+"';</script>");				
			}
			else {
				writer.println("<script>alert('회원정보가 수정 되었습니다.'); location.href='"+"myInfo.jsp"+"';</script>");
			}
			writer.close();
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}
}
