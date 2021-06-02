<%@page import="semi.beans.BookDto"%>
<%@page import="semi.beans.BookDao"%>
<%@page import="semi.beans.PurchaseDto"%>
<%@page import="semi.beans.PurchaseDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String root=request.getContextPath();
	PurchaseDao purchaseDao=new PurchaseDao();
	//int no=purchaseDao.getNumber();
	int no=13;
	PurchaseDto purchaseDto=purchaseDao.get(no);
	
	BookDao bookDao=new BookDao();
	//BookDto bookDto=bookDao.get(Integer.parseInt(request.getParameter("no")));
	BookDto bookDto=bookDao.get(5603);
%>
    <jsp:include page="/template/header.jsp"></jsp:include>
    
    <div class="purchase-success-box container-500 text-center">
	    <div style="font-size:30px; font-weight:bold;">주문이 완료되었습니다.</div>
	    <br>
	    <div style="font-size:20px;">주분번호 : <%=purchaseDto.getPurchaseNo() %></div>
	    <div style="font-size:20px;">주문 목록: <%=bookDto.getBookTitle() %></div>
    </div>
    <div class="purchase-success-box container-500 text-center">
    	<span><a href="<%=root%>/index.jsp" class="success-main-btn">메인페이지로</a></span>
    	<span><a href="#">내 주문목록</a></span>
    </div>
    <jsp:include page="/template/footer.jsp"></jsp:include>