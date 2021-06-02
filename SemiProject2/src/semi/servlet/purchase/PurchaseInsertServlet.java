package semi.servlet.purchase;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.beans.BookDao;
import semi.beans.BookDto;
import semi.beans.PurchaseDao;
import semi.beans.PurchaseDto;

@WebServlet(urlPatterns = "/purchase/purchaseInsert.kh")
public class PurchaseInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			
			 req.setCharacterEncoding("UTF-8"); 
			 PurchaseDto purchaseDto= new PurchaseDto();
			 
			 PurchaseDao purchaseDao=new PurchaseDao();
			 int no= purchaseDao.getNumber();
			 purchaseDto.setPurchaseNo(no);
			 purchaseDto.setPurchaseMember(Integer.parseInt(req.getParameter("purchaseMember")));
			 purchaseDto.setPurchaseBook(Integer.parseInt(req.getParameter("purchaseBook")));
			 purchaseDto.setPurchaseRecipient(req.getParameter("purchaseRecipient"));
			 purchaseDto.setPurchasePhone(req.getParameter("purchasePhone"));
			 purchaseDto.setPurchaseAddress(req.getParameter("purchaseAddress"));
	
			
			 purchaseDao.insert(purchaseDto);
		
			 resp.sendRedirect("purchaseSuccess.jsp?purchaseNo="+no+"&no="+purchaseDto.getPurchaseBook());
			 
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}

