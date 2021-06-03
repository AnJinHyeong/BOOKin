<%@page import="semi.beans.BookDto"%>
<%@page import="semi.beans.BookDao"%>
<%@page import="semi.beans.PurchaseDto"%>
<%@page import="semi.beans.PurchaseDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
PurchaseDto purchaseDto = new PurchaseDto();
PurchaseDao purchaseDao = new PurchaseDao();

int no =purchaseDto.getPurchaseBook();
BookDao bookDao = new BookDao();

BookDto bookDto=bookDao.get(no);

%>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>



<form action="reviewInsert.kh" method="post">
	<div class="row text-left">
	<span><%=bookDto.getBookTitle()%></span>
	</div>
	
	<div class="row text-left">
		
			<label>리뷰내용</label>	
			<textarea name="reviewContent"></textarea>
	</div>
	
		<div class="row text-left">
		<label>리뷰 평점</label>
		<input name="reviewRate" type="text">
		
		<input type="submit" >
	</div>



</form>





</body>
</html>