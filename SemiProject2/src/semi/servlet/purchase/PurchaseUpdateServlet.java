package semi.servlet.purchase;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.PurchaseDao;

@WebServlet(urlPatterns = "/purchase/purchaseUpdate.kh")
public class PurchaseUpdateServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			Set<Integer> noSet = new HashSet<>();
			String[] noList = req.getParameterValues("purchaseNo");
			PurchaseDao purchaseDao = new PurchaseDao();
			for(int i = 0 ; i<noList.length;i++) {
				noSet.add(Integer.parseInt(noList[i]));
			}
			for(int no : noSet) {
				if(req.getParameter("confirmOrder")!=null) {
					purchaseDao.editState(no,"주문확인");
					resp.setContentType("text/html; charset=UTF-8");
					PrintWriter writer = resp.getWriter();
					writer.println("<script>alert('주문확인 되었습니다');history.go(-2);</script>"); 
					writer.close();
				}else {
					purchaseDao.editState(no,"배송중");
					resp.setContentType("text/html; charset=UTF-8");
					PrintWriter writer = resp.getWriter();
					writer.println("<script>alert('수정되었습니다');history.go(-2);</script>"); 
					writer.close();
				}
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
