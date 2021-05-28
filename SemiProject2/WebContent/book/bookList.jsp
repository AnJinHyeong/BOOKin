<%@page import="java.text.DecimalFormat"%>
<%@page import="semi.beans.GenreDto"%>
<%@page import="semi.beans.GenreDao"%>
<%@page import="semi.beans.BookDto"%>
<%@page import="java.util.List"%>
<%@page import="semi.beans.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String root = request.getContextPath();
	BookDao bookdao = new BookDao();
	List<BookDto> bookList =bookdao.list(1);
	DecimalFormat format = new DecimalFormat("###,###");
%>
    <link rel="stylesheet" type="text/css" href="<%= root%>/css/list.css">
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-1200 book-list">
	<%for(BookDto bookDto : bookList){ %>
	<div class="book-item">
		<a href="/bookDetail.jsp?" class="book-img-a">
			<img title="<%=bookDto.getBookTitle() %>" class="book-img" src="<%=bookDto.getBookImage()%>">
		</a>
		<a class="book-publisher"><span><%=bookDto.getBookPublisher() %></span></a>
		<a class="book-title overflow"  title="<%=bookDto.getBookTitle() %>"><%=bookDto.getBookTitle() %></a>
		<a class="book-author overflow"><%=bookDto.getBookAuthor() %></a>
		<% 
		
		
		%>
		<div style="width: 100%;text-align: right;">
		<a class="book-price"><%=format.format(bookDto.getBookPrice()) %></a><a style="font-weight: 900;color:rgba(0,0,0,0.5);"> 원</a>
		</div>
	</div>   
	<%} %>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>
