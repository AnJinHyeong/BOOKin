//package semi.servlet.book;
//
//import java.io.IOException;
//import java.util.List;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import semi.beans.BookDao;
//import semi.beans.BookDto;
//@WebServlet(urlPatterns = "/book/search.kh")
//public class BookSearchServlet extends HttpServlet{
//@Override
//protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//try {
////	준비물 : type(검색분류) keyword(검색어)
//	
//	String keyword = req.getParameter("");
//	
//	//계산
//	BookDao bookDao = new BookDao();
////	List<BookDto>bookList = bookDao.search(keyword);
//	
//	//출력 : 검색결과
//	resp.setCharacterEncoding("MS949");
//	for(BookDto bookDto : bookList) {
//			resp.getWriter().println(bookDto);
//		}
//}
//catch(Exception e) {
//	e.printStackTrace();
//	resp.sendError(500);
//}
//
//}
//}
