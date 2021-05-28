package semi.servlet.qnaboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.NoticeBoardDao;
import semi.beans.NoticeBoardDto;

@WebServlet(urlPatterns = "/qna/qnaNoticeEdit.kh")
public class QnaNoticeEditServlet extends HttpServlet{
   @Override
   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      try {
         req.setCharacterEncoding("UTF-8");
         NoticeBoardDto noticeBoardDto = new NoticeBoardDto();
         noticeBoardDto.setNoticeBoardNo(Integer.parseInt(req.getParameter("noticeBoardNo")));
         noticeBoardDto.setNoticeBoardHeader(req.getParameter("noticeBoardHeader"));
         noticeBoardDto.setNoticeBoardTitle(req.getParameter("noticeBoardTitle"));
         noticeBoardDto.setNoticeBoardContent(req.getParameter("noticeBoardContent"));
         
         NoticeBoardDao noticeBoardDao = new NoticeBoardDao();
         noticeBoardDao.edit(noticeBoardDto);
         
         resp.sendRedirect("qnaNoticeDetail.jsp?noticeBoardNo=" + noticeBoardDto.getNoticeBoardNo());

      } 
      catch (Exception e) {
         e.printStackTrace();
         resp.sendError(500);
      }
   }
}