package semi.servlet.review;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.BookReviewDto;
import semi.beans.ReviewDao;
import semi.beans.ReviewDto;

@WebServlet(urlPatterns = "/review/reviewEdit.kh")
public class ReviewEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비
			int reviewBookNo = Integer.parseInt(req.getParameter("review_book"));
			req.setCharacterEncoding("UTF-8");
			String root = req.getContextPath();
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setReviewNo(Integer.parseInt(req.getParameter("review_no")));
			reviewDto.setReviewContent(req.getParameter("review_content"));
			reviewDto.setReviewRate(Long.parseLong(req.getParameter("review_rate")));
			reviewDto.setReviewMember(Integer.parseInt(req.getParameter("review_member")));
			reviewDto.setReviewBook(Integer.parseInt(req.getParameter("review_book")));
			//계산
			ReviewDao reviewDao = new ReviewDao();
			reviewDao.edit(reviewDto);
			
			//출력
			resp.sendRedirect(root+"/book/bookDetail.jsp?no="+reviewBookNo);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}

