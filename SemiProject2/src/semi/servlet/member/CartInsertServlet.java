package semi.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.CartDao;
import semi.beans.CartDto;

@WebServlet(urlPatterns = "/member/cartInsert.kh")
public class CartInsertServlet extends HttpServlet{
   @Override
   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      try {
         req.setCharacterEncoding("UTF-8");
         CartDto cartDto = new CartDto();
         cartDto.setMemberNo(Integer.parseInt(req.getParameter("memberNo")));
         cartDto.setBookNo(Integer.parseInt(req.getParameter("bookNo")));
         cartDto.setCartAmount(Integer.parseInt(req.getParameter("cartAmount")));
      
         int bookNo;
         try {
			bookNo = Integer.parseInt(req.getParameter("no"));
		} catch (Exception e) {
			bookNo = 0;
		}
         
         
         CartDao cartDao = new CartDao();
         
         
         boolean result = cartDao.check(cartDto);
         
         
         if(result) {
        	 cartDao.edit(cartDto);
         }
         else {
        	 cartDao.insert(cartDto);
         }
         
         
         resp.sendRedirect(req.getContextPath() + "/book/bookDetail.jsp?no=" + cartDto.getBookNo());   
         
      }
      catch (Exception e) {
         e.printStackTrace();
         resp.sendError(500);
      }
   }
}