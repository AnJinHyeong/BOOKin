package semi.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.CartDao;
import semi.beans.CartDto;

public class CartDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			CartDto cartDto = new CartDto();
			cartDto.setMemberNo(Integer.parseInt(req.getParameter("memberNo")));
			cartDto.setBookNo(Integer.parseInt(req.getParameter("bookNo")));
			cartDto.setCartAmount(Integer.parseInt(req.getParameter("cartAmount")));
			
			CartDao cartDao = new CartDao();
			cartDao.delete(cartDto);
			
			resp.sendRedirect("bookList.jsp");
		} 
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
