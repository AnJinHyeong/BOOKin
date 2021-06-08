package semi.servlet.book;

import java.io.IOException;
import java.io.PrintWriter;
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
import semi.beans.GenreDao;

@WebServlet(urlPatterns = "/book/bookInsert.kh")
public class BookInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {			
			String path="D:/upload";
//			String path= "/Users/anjinhyeong/git/upload";	
//			String path= "C:/Users/Jeon/upload";	
			int maximumSize = 10*1024*1024;
			String encoding="UTF-8";
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
		
			MultipartRequest mRequest = new MultipartRequest(req,path,maximumSize,encoding,policy);
			
			GenreDao genreDao = new GenreDao();
			//준비 : 데이터 5개(번호 제외)
		
			BookDto bookDto = new BookDto();
			BookDao bookDao = new BookDao();
			
			

			bookDto.setBookTitle(mRequest.getParameter("bookTitle"));
			bookDto.setBookAuthor(mRequest.getParameter("bookAuthor"));
			bookDto.setBookPrice(Integer.parseInt(mRequest.getParameter("bookPrice")));
			bookDto.setBookDiscount(Integer.parseInt(mRequest.getParameter("bookDiscount")));
			bookDto.setBookPublisher(mRequest.getParameter("bookPublisher"));
			bookDto.setBookDescription(mRequest.getParameter("bookDescription"));
			bookDto.setBookPubDate(Date.valueOf(mRequest.getParameter("bookPubDate")));
			bookDto.setBookGenreNo(genreDao.getGenreNoByName(mRequest.getParameter("bookGenre")));
			bookDto.setBookImage(mRequest.getFilesystemName("bookImage"));

			
		
			
			bookDao.registBook(bookDto);
			
			//출력
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter writer = resp.getWriter();
			writer.println("<script>alert('등록되었습니다'); location.href='"+req.getContextPath()+"/admin/adminHome.jsp'"+"</script>"); 
			writer.close();
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}