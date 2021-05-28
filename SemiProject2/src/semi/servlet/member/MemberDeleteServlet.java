package semi.servlet.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.MemberDao;

@WebServlet(urlPatterns = "/member/memberDelete.kh")
public class MemberDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int memberNo = Integer.parseInt((req.getParameter("memberNo")));
			MemberDao memberDao = new MemberDao();
			boolean result = memberDao.delete(memberNo);
			
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter writer = resp.getWriter();
						
			if(result) {
				writer.println("<script>alert('회원탈퇴가 정상적으로 처리되었습니다.'); location.href='"+"logout.kh"+"';</script>");				
			}else {
				writer.println("<script>alert('회원탈퇴가 정상적으로 처리되지 않았습니다.'); location.href='"+"myInfo_check.jsp"+"';</script>");	
			}
			writer.close();
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
