package semi.servlet.qnaboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.QnaBoardDao;

@WebServlet(urlPatterns = "/qna/qnaboardDelete.kh")
public class QnaBoardDeleteServlet extends HttpServlet{
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
   try {
      //준비 : 게시글 번호
      int qnaBoardNo = Integer.parseInt(req.getParameter("qnaBoardNo"));
      
      //처리
      QnaBoardDao qnaBoardDao = new QnaBoardDao();
      qnaBoardDao.delete(qnaBoardNo);
      
      //출력 : 목록으로 리다이렉트
      resp.sendRedirect("qnaMyList.jsp");
   } 
   catch (Exception e) {
      e.printStackTrace();
      resp.sendError(500);
   }
}
}