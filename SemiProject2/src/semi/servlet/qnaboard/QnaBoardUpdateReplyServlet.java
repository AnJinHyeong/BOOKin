package semi.servlet.qnaboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.QnaBoardDao;
import semi.beans.QnaReplyDao;
import semi.beans.QnaReplyDto;

@WebServlet(urlPatterns = "/qna/updateQnaReply.kh")
public class QnaBoardUpdateReplyServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			QnaReplyDto qnaReplyDto = new QnaReplyDto();
			qnaReplyDto.setQnaReplyNo(Integer.parseInt(req.getParameter("qnaReplyNo")));
			qnaReplyDto.setQnaReplyContent(req.getParameter("qnaReplyContent"));
			qnaReplyDto.setQnaReplyWriter(Integer.parseInt(req.getParameter("qnaReplyWriter")));
			qnaReplyDto.setQnaReplyOrigin(Integer.parseInt(req.getParameter("qnaReplyOrigin")));
			
			QnaReplyDao qnaReplyDao = new QnaReplyDao();
			qnaReplyDao.edit(qnaReplyDto);		
			
			resp.sendRedirect("qnaBoardDetail.jsp?qnaBoardNo="+qnaReplyDto.getQnaReplyOrigin());
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
