package semi.servlet.book;

import java.io.File;
import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import semi.beans.BookDao;
import semi.beans.BookDto;
import semi.beans.BookimageDao;
import semi.beans.BookimageDto;

@WebServlet(urlPatterns = "/book/bookInsert.kh")
public class BookInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			
			String path="D:/upload";
			int maximumSize = 10*1024*1024;
			String encoding="UTF-8";
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
		
			MultipartRequest mRequest = new MultipartRequest(req,path,maximumSize,encoding,policy);
			
			
			//준비 : 데이터 5개(번호 제외)
		
			BookDto bookDto = new BookDto();
			File file = mRequest.getFile("bookimagefile");
			
			
			bookDto.setBookTitle(mRequest.getParameter("book_title"));
			bookDto.setBookAuthor(mRequest.getParameter("book_author"));
			bookDto.setBookPrice(Integer.parseInt(mRequest.getParameter("book_price")));
			bookDto.setBookDiscount(Integer.parseInt(mRequest.getParameter("book_discount")));
			bookDto.setBookPublisher(mRequest.getParameter("book_publisher"));
			bookDto.setBookDescription(mRequest.getParameter("book_description"));
			bookDto.setBookPubDate(Date.valueOf(mRequest.getParameter("book_pubdate")));
			bookDto.setBookGenreNo(Long.parseLong(mRequest.getParameter("book_genre")));
			
			bookDto.setBookImage(mRequest.getParameter("book_image"));
			
		
			
//			bookDao.registBook(bookDto);
			

			
		
			
			
			
			
			
			
			
			
			//출력
			resp.sendRedirect("bookList.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}