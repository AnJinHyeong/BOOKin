package semi.servlet.purchase;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.PurchaseBookMemberDao;

@WebServlet (urlPatterns = "/purchase/delete.kh")
public class PurchaseDeleteServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			req.setCharacterEncoding("UTF-8");
			
			int member = (int)req.getSession().getAttribute("member");
			int purchaseNo = Integer.parseInt(req.getParameter("purchaseNo"));
			
			PurchaseBookMemberDao purchaseBookMemberDao = new PurchaseBookMemberDao();
			purchaseBookMemberDao.delete(purchaseNo, member);
			
			resp.sendRedirect(req.getContextPath() + "/member/deliveryList.jsp");
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
	
}
