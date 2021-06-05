package semi.servlet.review;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.ReviewDao;
import semi.beans.ReviewDto;



@WebServlet(urlPatterns = "/review/reviewDelete.kh")
public class ReviewDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			String root = req.getContextPath();
			//준비
			int reviewNo = Integer.parseInt(req.getParameter("review_no"));
			int reviewBookNo =Integer.parseInt(req.getParameter("book_no"));
			//계산
			
			ReviewDao reviewDao = new ReviewDao();
			reviewDao.delete(reviewNo);
			
			//출력
			resp.sendRedirect(root+"/book/bookDetail.jsp?no="+reviewBookNo);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}