package semi.servlet.qnaboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.QnaBoardDao;
import semi.beans.QnaBoardDto;


@WebServlet(urlPatterns = "/qna/qnaboardEdit.kh")
public class QnaBoardEditServlet extends HttpServlet {
   @Override
   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      try {
         //준비 : 파라미터(4개 : 번호, 말머리, 제목, 내용) + 세션(회원번호, 본인글 여부 확인용) --> qnaBoardDto
         req.setCharacterEncoding("UTF-8");
         QnaBoardDto qnaBoardDto = new QnaBoardDto();
         qnaBoardDto.setQnaBoardNo(Integer.parseInt(req.getParameter("qnaBoardNo")));
         qnaBoardDto.setQnaBoardHeader(req.getParameter("qnaBoardHeader"));
         qnaBoardDto.setQnaBoardTitle(req.getParameter("qnaBoardTitle"));
         qnaBoardDto.setQnaBoardContent(req.getParameter("qnaBoardContent"));
         
         
         //처리
         QnaBoardDao qnaBoardDao = new QnaBoardDao();
         qnaBoardDao.edit(qnaBoardDto);
         
         //출력 : 번호를 첨부하여 상세페이지로 리다이렉트
         resp.sendRedirect("qnaBoardDetail.jsp?qnaBoardNo=" + qnaBoardDto.getQnaBoardNo());
      } 
      catch (Exception e) {
         e.printStackTrace();
         resp.sendError(500);
      }
   }
}