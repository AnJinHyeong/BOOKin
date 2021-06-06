package semi.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.CartDao;
import semi.beans.CartDto;

@WebServlet(urlPatterns = "/member/searchToCartInsert.kh")
public class SearchtoCartInsertServlet extends HttpServlet{
   @Override
   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      try {
         req.setCharacterEncoding("UTF-8");
         CartDto cartDto = new CartDto();
         cartDto.setMemberNo(Integer.parseInt(req.getParameter("memberNo")));
         cartDto.setBookNo(Integer.parseInt(req.getParameter("bookNo")));
         cartDto.setCartAmount(Integer.parseInt(req.getParameter("cartAmount")));           
                  
         CartDao cartDao = new CartDao();         
         
         boolean result = cartDao.check(cartDto);         
         
         if(result) {
        	 cartDao.edit(cartDto);
         }
         else {
        	 cartDao.insert(cartDto);
         }         
      }
      catch (Exception e) {
         e.printStackTrace();
         resp.sendError(500);
      }
   }
}