package semi.servlet.qnaboard;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.QnaReplyDao;
import semi.beans.QnaReplyDto;

@WebServlet(urlPatterns = "/qna/deleteQnaReply.kh")
public class QnaBoardDeleteReplyServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			QnaReplyDto qnaReplyDto = new QnaReplyDto();
			qnaReplyDto.setQnaReplyNo(Integer.parseInt(req.getParameter("qnaReplyNo")));
			qnaReplyDto.setQnaReplyWriter(Integer.parseInt(req.getParameter("qnaReplyWriter")));
			qnaReplyDto.setQnaReplyOrigin(Integer.parseInt(req.getParameter("qnaReplyOrigin")));
			
			QnaReplyDao qnaReplyDao = new QnaReplyDao();
			boolean result = qnaReplyDao.delete(qnaReplyDto);
			
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter writer = resp.getWriter();
			
			if(!result) {				 
				writer.println("<script>alert('댓글 삭제가 실패했습니다.'); location.href='"+"qnaBoardDetail.jsp?qnaBoardNo="+qnaReplyDto.getQnaReplyOrigin()+"';</script>");				
			}
			else {
				writer.println("<script>alert('댓글이 삭제되었습니다.'); location.href='"+"qnaBoardDetail.jsp?qnaBoardNo="+qnaReplyDto.getQnaReplyOrigin()+"';</script>");
			}
			writer.close();
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
