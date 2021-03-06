package semi.servlet.purchase;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.PurchaseBookMemberDao;

@WebServlet (urlPatterns = "/purchase/purchaseState.kh")
public class PurchaseStateServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");

			int purchaseNo = Integer.parseInt(req.getParameter("purchaseNo"));
			int member = (int)req.getSession().getAttribute("member");
			
			PurchaseBookMemberDao purchaseBookMemberDao = new PurchaseBookMemberDao();
			purchaseBookMemberDao.stateUpdate(purchaseNo,member);
			
			resp.sendRedirect(req.getContextPath() + "/member/deliveryList.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
