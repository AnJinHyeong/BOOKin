package semi.servlet.review;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.ReviewDao;
import semi.beans.ReviewDto;

@WebServlet(urlPatterns = "/review/reviewInsert.kh")
public class ReviewInsertServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			String root = req.getContextPath();

			req.setCharacterEncoding("UTF-8");
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setReviewContent(req.getParameter("review_content"));
			reviewDto.setReviewRate(Long.parseLong(req.getParameter("review_rate")));
			reviewDto.setReviewBook(Integer.parseInt(req.getParameter("review_book")));
			reviewDto.setReviewMember(Integer.parseInt(req.getParameter("review_member")));

			ReviewDao reviewDao = new ReviewDao();
			reviewDao.registReview(reviewDto);

			resp.sendRedirect(root + "/book/bookDetail.jsp?no=" + reviewDto.getReviewBook());
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}