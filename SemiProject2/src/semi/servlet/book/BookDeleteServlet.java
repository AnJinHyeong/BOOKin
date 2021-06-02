package semi.servlet.book;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.BookDao;

@WebServlet(urlPatterns="/book/bookDelete.kh")
public class BookDeleteServlet extends HttpServlet{
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
   try {
      long bookNo=Long.parseLong(req.getParameter("bookNo"));
      
      BookDao bookDao=new BookDao();
      bookDao.delete(bookNo);
     
      
      
		
      resp.sendRedirect(req.getContextPath());
      
   }catch(Exception e) {
      e.printStackTrace();
      resp.sendError(500);
   }
}
}