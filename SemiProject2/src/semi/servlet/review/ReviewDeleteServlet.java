package semi.servlet.review;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.ReviewDao;



@WebServlet(urlPatterns = "/review/reviewDelete.kh")
public class ReviewDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비
			int reviewNo = Integer.parseInt(req.getParameter("no"));
			
			//계산
			ReviewDao reviewDao = new ReviewDao();
			reviewDao.delete(reviewNo);
			
			//출력
			resp.sendRedirect("reviewList.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}