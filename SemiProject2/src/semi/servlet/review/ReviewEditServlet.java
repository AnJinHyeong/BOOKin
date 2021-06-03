package semi.servlet.review;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.ReviewDao;
import semi.beans.ReviewDto;

@WebServlet(urlPatterns = "/review/reviewEdit.kh")
public class ReviewEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비
			req.setCharacterEncoding("UTF-8");
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setReviewNo(Integer.parseInt(req.getParameter("review_no")));
			reviewDto.setReviewContent(req.getParameter("review_content"));
			reviewDto.setReviewRate(Long.parseLong(req.getParameter("review_rate")));
			
			//계산
			ReviewDao reviewDao = new ReviewDao();
			reviewDao.edit(reviewDto);
			
			//출력
			resp.sendRedirect("reviewDetail.jsp?no="+reviewDto.getReviewNo());
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}