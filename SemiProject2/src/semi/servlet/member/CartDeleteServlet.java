package semi.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.CartDao;
import semi.beans.CartDto;

@WebServlet(urlPatterns = "/member/cartDelete.kh")
public class CartDeleteServlet extends HttpServlet {
   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      try {
         req.setCharacterEncoding("UTF-8");
         CartDto cartDto = new CartDto();
         cartDto.setCartNo(Integer.parseInt(req.getParameter("cartNo")));
         
         CartDao cartDao = new CartDao();
         cartDao.delete(cartDto);
         
         resp.sendRedirect(req.getContextPath() + "/member/cart.jsp");
      } 
      catch (Exception e) {
         e.printStackTrace();
         resp.sendError(500);
      }
   }
}