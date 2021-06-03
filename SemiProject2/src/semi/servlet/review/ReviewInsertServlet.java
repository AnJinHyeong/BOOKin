//package semi.servlet.review;
//
//import java.io.IOException;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import semi.beans.PurchaseDao;
//import semi.beans.PurchaseDto;
//import semi.beans.ReviewDao;
//import semi.beans.ReviewDto;
//
//
//
//
//@WebServlet(urlPatterns = "/review/reviewInsert.kh")
//public class ReviewInsertServlet extends HttpServlet{
//	@Override
//	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		try {
//			
//			
//			req.setCharacterEncoding("UTF-8");
//			ReviewDto reviewDto = new ReviewDto();
//			reviewDto.setReviewContent(req.getParameter("reviewContent"));
//			reviewDto.setReviewRate(Long.parseLong(req.getParameter("reviewRate")));
//			
//			
////			int memberNo = (int)req.getSession().getAttribute("member");
//			int memberNo = 1;
//			
//			reviewDto.setReviewMember(memberNo);
//			
//			
//			ReviewDao reviewDao = new ReviewDao();
//			PurchaseDao purchaseDao = new PurchaseDao();
//			int bookNo = purchaseDao.getSequence();
//			reviewDto.setReviewBook(bookNo);
//			
//			//계산
//			
//			reviewDao.registReview(reviewDto);
//			
//			//출력
//			resp.sendRedirect("reviewList.jsp");
//		}
//		catch(Exception e) {
//			e.printStackTrace();
//			resp.sendError(500);
//		}
//	}
//}