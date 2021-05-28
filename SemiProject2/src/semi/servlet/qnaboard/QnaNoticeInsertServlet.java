package semi.servlet.qnaboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.NoticeBoardDao;
import semi.beans.NoticeBoardDto;

@WebServlet(urlPatterns = "/qna/qnaNoticeInsert.kh")
public class QnaNoticeInsertServlet extends HttpServlet {
   @Override
   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      try {
         req.setCharacterEncoding("UTF-8");
         NoticeBoardDto noticeBoardDto = new NoticeBoardDto();
         noticeBoardDto.setNoticeBoardHeader(req.getParameter("noticeBoardHeader"));
         noticeBoardDto.setNoticeBoardTitle(req.getParameter("noticeBoardTitle"));
         noticeBoardDto.setNoticeBoardContent(req.getParameter("noticeBoardContent"));
         
         int member = (int)req.getSession().getAttribute("member");  
         noticeBoardDto.setNoticeBoardWriter(member);
         
         NoticeBoardDao noticeBoardDao = new NoticeBoardDao();
         int noticeBoardNo = noticeBoardDao.getSequence(); //게시글 번호
         noticeBoardDto.setNoticeBoardNo(noticeBoardNo);
         
         noticeBoardDao.insert(noticeBoardDto);
         
         resp.sendRedirect("qnaNoticeDetail.jsp?noticeBoardNo=" + noticeBoardNo);
      } 
      catch (Exception e) {
         e.printStackTrace();
         resp.sendError(500);
      }
   }
}