package semi.servlet.qnaboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.NoticeBoardDao;

@WebServlet(urlPatterns = "/qna/qnaNoticeDelete.kh")
public class QnaNoticeDeleteServlet extends HttpServlet{
   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      try {
         // 게시글번호
         int noticeBoardNo = Integer.parseInt(req.getParameter("noticeBoardNo"));
         
         NoticeBoardDao noticeBoardDao = new NoticeBoardDao();
         noticeBoardDao.delete(noticeBoardNo);
         
         resp.sendRedirect("qnaNotice.jsp");
      } 
      catch (Exception e) {
         e.printStackTrace();
         resp.sendError(500);
      }
   }
}