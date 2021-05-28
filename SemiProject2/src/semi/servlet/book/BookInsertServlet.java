package semi.servlet.book;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.BookDao;
import semi.beans.BookDto;

@WebServlet(urlPatterns = "/book/bookInsert.kh")
public class BookInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : 데이터 5개(번호 제외)
			req.setCharacterEncoding("UTF-8");
			BookDto bookDto = new BookDto();
			bookDto.setBookNo(Integer.parseInt(req.getParameter("book_no")));
			bookDto.setBookTitle(req.getParameter("book_title"));
			bookDto.setBookImage(req.getParameter("book_image"));
			bookDto.setBookAuthor(req.getParameter("book_author"));
			bookDto.setBookPrice(Integer.parseInt(req.getParameter("book_price")));
			bookDto.setBookDiscount(Integer.parseInt(req.getParameter("book_discount")));
			bookDto.setBookPublisher(req.getParameter("book_publisher"));
			bookDto.setBookDescription(req.getParameter("book_description"));
			bookDto.setBookPubDate(Date.valueOf(req.getParameter("book_pubdate")));
			bookDto.setBookGenreNo(Long.parseLong(req.getParameter("book_genre")));
			
			
			
			//계산
			BookDao bookDao = new BookDao();
			bookDao.registBook(bookDto);
			
			//출력
			resp.sendRedirect("bookList.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}