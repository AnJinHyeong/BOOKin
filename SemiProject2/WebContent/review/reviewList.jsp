<%@page import="semi.beans.ReviewBookDto"%>
<%@page import="semi.beans.ReviewDao"%>
<%@page import="java.util.List"%>
<%@page import="semi.beans.ReviewDto"%>
<%@page import="semi.beans.BookDto"%>
<%@page import="semi.beans.BookDao"%>
<%@page import="semi.beans.PurchaseDao"%>
<%@page import="semi.beans.PurchaseDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%


ReviewDao reviewDao = new ReviewDao();

int memberno=(Integer)session.getAttribute("member");
// int memberno=1;
List<ReviewBookDto> reviewList = reviewDao.memberList(memberno);

%>
<jsp:include page="/template/header.jsp"></jsp:include>

<style>


tbody>tr,
tbody>td,
tbody>th{
border: solid 1px #ff7d9e;
}

thead{ 

margin: 50px 0px;
font-family: 'Noto-B';
font-size: 40px;
color: #FF8E99;
text-align: center;
   
   }
 .title{
 margin: 50px 0px;
	font-family: 'Noto-B';
	font-size: 40px;
	color: #FF8E99;
	text-align: center;
 }  
 .review-contentTitle{
 padding-left:500px;
 padding-right:500px;
 text-align: center;
 }
 .review-content{
 margin-top: auto;
 margin-bottom:auto;
 font:bold;
 font-size:20px;
 }
 .riview-book{
 font:bold;
 }
 
</style>

<div class="container-1200">

<div class="row">
		<h2 class=title>작성한리뷰</h2>
</div>
	
	<div class="row">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th>책제목</th>
					<th>책이미지</th>
					
					<th>리뷰번호</th>
					<th>내용</th>
					<th>평점</th>
					
			
				</tr>
			</thead>
			<tbody>
			
			
			
			<%for(ReviewBookDto reviewBookDto : reviewList){ %>			
				<tr>
					<th><%=reviewBookDto.getBookTitle() %></th>
					<th><img src="<%=reviewBookDto.getBookImage()%>"></th>
					
					<th><%=reviewBookDto.getReviewNo()%></th>
					<th><%=reviewBookDto.getReviewContent() %></th>
					<th><%=reviewBookDto.getReviewRate() %></th>
					
				
			
		</tr>
			<%} %>
			
	</div>
	</div>
	
	


