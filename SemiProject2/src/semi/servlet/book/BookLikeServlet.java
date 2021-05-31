package semi.servlet.book;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.BookLikeDao;
import semi.beans.BookLikeDto;

@WebServlet(urlPatterns = "/book/bookLike.kh")
public class BookLikeServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			BookLikeDto bookLikeDto = new BookLikeDto();
			bookLikeDto.setMemberNo(Integer.parseInt(req.getParameter("memberNo")) );
			String bookOrigin = req.getParameter("bookOrigin");
			bookOrigin = bookOrigin.replace("like", "");
			bookLikeDto.setBookOrigin(Integer.parseInt(bookOrigin) );
			
			BookLikeDao bookLikeDao = new BookLikeDao();
			String type = req.getParameter("type");
			
			if(type.equals("insert"))
				bookLikeDao.insert(bookLikeDto);
			else if(type.equals("delete"))
				bookLikeDao.delete(bookLikeDto);
			else
				System.out.println("BookLike DB 입력 에러");
		}
		catch(Exception e){
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
