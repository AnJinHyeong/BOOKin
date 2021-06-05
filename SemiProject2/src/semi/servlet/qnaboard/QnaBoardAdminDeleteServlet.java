package semi.servlet.qnaboard;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.QnaBoardDao;

@WebServlet(urlPatterns = "/admin/qnaboardAdminDelete.kh")
public class QnaBoardAdminDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 준비 : 게시글 번호
			int qnaBoardNo = Integer.parseInt(req.getParameter("qnaBoardNo"));

			// 처리
			QnaBoardDao qnaBoardDao = new QnaBoardDao();
			qnaBoardDao.delete(qnaBoardNo);

			// 출력 : 목록으로 리다이렉트
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter writer = resp.getWriter();

			writer.println("<script>alert('문의글이 삭제되었습니다.'); location.href='" + req.getContextPath()+ "/admin/qnaReply.jsp';</script>");

			writer.close();
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}