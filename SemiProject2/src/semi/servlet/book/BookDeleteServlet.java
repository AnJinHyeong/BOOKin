package semi.servlet.book;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.BookDao;


@WebServlet(urlPatterns = "/book/bookDelete.kh")
public class BookDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			int bookNo = Integer.parseInt((req.getParameter("bookNo")));
			BookDao bookDao = new BookDao();
			boolean result = bookDao.delete(bookNo);
			
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter writer = resp.getWriter();
						
			if(result) {
				writer.println("<script>alert('삭제되었습니다.'); history.back(); </script>");				
			}else {
				writer.println("<script>alert('알수없는 오류로 삭제되지 않았습니다.'); history.back(); </script>");	
			}
			writer.close();
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
