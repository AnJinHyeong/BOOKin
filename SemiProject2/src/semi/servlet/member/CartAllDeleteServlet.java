package semi.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

import semi.beans.CartDao;
import semi.beans.CartDto;

@WebServlet(urlPatterns = "/member/cartDeleteAll.kh")
public class CartAllDeleteServlet extends HttpServlet {
   @Override
   protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      try {
         req.setCharacterEncoding("UTF-8");
         int memberNo = Integer.parseInt(req.getParameter("memberNo"));
                  
         CartDao cartDao = new CartDao();
         cartDao.deleteAll(memberNo);
         
         resp.sendRedirect(req.getContextPath() + "/member/cart.jsp");
      } 
      catch (Exception e) {
         e.printStackTrace();
         resp.sendError(500);
      }
   }
}