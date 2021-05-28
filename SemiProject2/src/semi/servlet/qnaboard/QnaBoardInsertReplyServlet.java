package semi.servlet.qnaboard;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.QnaBoardDao;
import semi.beans.QnaReplyDao;
import semi.beans.QnaReplyDto;

@WebServlet(urlPatterns = "/qna/insertQnaReply.kh")
public class QnaBoardInsertReplyServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			QnaReplyDto qnaReplyDto = new QnaReplyDto();
			qnaReplyDto.setQnaReplyContent(req.getParameter("qnaReplyContent"));
			qnaReplyDto.setQnaReplyWriter(Integer.parseInt(req.getParameter("qnaReplyWriter")));
			qnaReplyDto.setQnaReplyOrigin(Integer.parseInt(req.getParameter("qnaReplyOrigin")));
			
			QnaReplyDao qnaReplyDao = new QnaReplyDao();
			qnaReplyDao.insert(qnaReplyDto);
			
			QnaBoardDao qnaBoardDao = new QnaBoardDao();
			qnaBoardDao.refreshBoardReply(qnaReplyDto.getQnaReplyOrigin());
			
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter writer = resp.getWriter();	
			
			writer.println("<script>alert('댓글이 등록되었습니다.'); location.href='"+"qnaBoardDetail.jsp?qnaBoardNo="+qnaReplyDto.getQnaReplyOrigin() +"';</script>");					
			writer.close();
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
