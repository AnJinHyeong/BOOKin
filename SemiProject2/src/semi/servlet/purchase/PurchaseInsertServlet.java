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
			 PurchaseDao purchaseDao=new PurchaseDao();
			 int no= purchaseDao.getNumber();
			 String[] bookNoList = req.getParameterValues("purchaseBook");
			 String[] amountList = req.getParameterValues("purchaseAmount");
			 int count= -1;
			 int bookNo=0;
			 for(int i = 0;i<bookNoList.length;i++) {				 
				 PurchaseDto purchaseDto= new PurchaseDto();
				 purchaseDto.setPurchaseNo(no);
				 purchaseDto.setPurchaseMember(Integer.parseInt(req.getParameter("purchaseMember")));
				 purchaseDto.setPurchaseBook(Integer.parseInt(bookNoList[i]));
				 purchaseDto.setPurchaseRecipient(req.getParameter("purchaseRecipient"));
				 purchaseDto.setPurchasePhone(req.getParameter("purchasePhone"));
				 purchaseDto.setPurchaseAddress(req.getParameter("purchaseAddress"));
				 purchaseDto.setPurchaseAmount(Integer.parseInt(amountList[i]));
				 count++;
				 purchaseDao.insert(purchaseDto);
				 bookNo=purchaseDto.getPurchaseBook();
			 }
			 resp.sendRedirect("purchaseSuccess.jsp?purchaseNo="+no+"&no="+bookNo+"&amount="+count);
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}

