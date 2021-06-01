<%@page import="semi.beans.ReviewDto"%>
<%@page import="semi.beans.BookDto"%>
<%@page import="semi.beans.BookDao"%>
<%@page import="semi.beans.PurchaseDao"%>
<%@page import="semi.beans.PurchaseDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%

ReviewDto reviewDto = new ReviewDto();
PurchaseDto purchaseDto = new PurchaseDto();
PurchaseDao purchaseDao = new PurchaseDao();

BookDao bookDao = new BookDao();
// int no =purchaseDto.getPurchaseBook();
int no = 5;
BookDto bookDto=bookDao.get(no);

%>
<table>
<thead>
	
</thead>


<tr>
<td><img src="<%=bookDto.getBookImage()%>"></td>
<td rowspan="2">리뷰내용</td>
<td><a href="#">수정</a></td>
</tr>
<tr>
<td><%=bookDto.getBookTitle()%></td>
<td><%=reviewDto.getReviewContent() %></td>
<td><a href="#">삭제</a></td>

</tr>
</table>
</div>



</div>
