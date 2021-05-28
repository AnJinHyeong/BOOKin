package semi.servlet.qnaboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.QnaBoardDao;
import semi.beans.QnaBoardDto;

@WebServlet(urlPatterns = "/qna/qnaboardInsert.kh")
public class QnaBoardInsertServlet extends HttpServlet{
   @Override
   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      try {
         // 준비 : 파라미터 3개(제목, 내용, 말머리) + 세션1개(회원번호) + DB조회 1개(시퀀스번호) = BoardDto
         req.setCharacterEncoding("UTF-8");
         QnaBoardDto qnaBoardDto = new QnaBoardDto();
         qnaBoardDto.setQnaBoardHeader(req.getParameter("qnaBoardHeader")); //말머리(파라미터)
         qnaBoardDto.setQnaBoardTitle(req.getParameter("qnaBoardTitle")); //글제목(파라미터)
         qnaBoardDto.setQnaBoardContent(req.getParameter("qnaBoardContent")); //글내용(파라미터)
         
         int member = (int)req.getSession().getAttribute("member"); //회원번호(세션)
         qnaBoardDto.setQnaBoardWriter(member);
         
         QnaBoardDao qnaBoardDao = new QnaBoardDao(); //DB조회를 위해
         int qnaBoardNo = qnaBoardDao.getSequence(); //게시글번호(DB시퀀스)
         qnaBoardDto.setQnaBoardNo(qnaBoardNo);
         
         //처리
         qnaBoardDao.write(qnaBoardDto);
         
         //출력 : 상세페이지로 이동
         resp.sendRedirect("qnaBoardDetail.jsp?qnaBoardNo=" + qnaBoardDto.getQnaBoardNo());
      } 
      catch (Exception e) {
         e.printStackTrace();
         resp.sendError(500);
      }
   }
}