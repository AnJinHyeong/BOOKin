<%@page import="semi.beans.BookDto"%>
<%@page import="semi.beans.BookDao"%>
<%@page import="java.util.List"%>
<%@page import="semi.beans.GenreDto"%>
<%@page import="semi.beans.GenreDao"%>
<%@page import="semi.beans.MemberDto"%>
<%@page import="semi.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String root = request.getContextPath();
	Integer memberNo = (Integer) session.getAttribute("member");
	MemberDao memberDao = new MemberDao();
	boolean isLogin = false;
	boolean isAdmin = false;
	MemberDto memberDto = null;
	if(memberNo!=null){
		isLogin=true;
		memberDto = memberDao.getMember(memberNo);
		if(memberDto.getMemberAdmin().equals("Y")){
			isAdmin=true;
		}
	}
	String keyword = request.getParameter("keyword");
	
	//조회수 Top 10 
		int startRow = 1;
		int endRow = 10;
		BookDao bookDao = new BookDao();
		List<BookDto> bookList = bookDao.bookViewTop(startRow, endRow);
		
		int barCount =1;
		int topCount =1;
%>

<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>알라딘</title>
    <link rel="stylesheet" type="text/css" href="<%= root%>/css/common.css">
    <link rel="stylesheet" type="text/css" href="<%= root%>/css/template.css">
    <link rel="stylesheet" type="text/css" href="<%= root%>/css/signup.css">
    <link rel="stylesheet" type="text/css" href="<%= root%>/css/detail.css">
    <link rel="stylesheet" type="text/css" href="<%= root%>/css/bookRankLolling.css">
   <style>
		
   </style>
   <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script>
		// 인기 도서 lolling 기능
		$(document).ready(function() {
			var height = $(".bookrank").height();
			var num = $(".rolling li").length;
			var max = height * num;
			var move = 0;
			function noticeRolling() {
				move += height;
				$(".rolling").animate({
					"top" : -move
				}, 600, function() {
					if (move >= max) {
						$(this).css("top", 0);
						move = 0;
					}
					;
				});
			}
			;
			noticeRollingOff = setInterval(noticeRolling, 2000);
			$(".rolling").append($(".rolling li").first().clone());
			
			$(".rolling").hover(function() {
				clearInterval(noticeRollingOff);
			}, function(){
				noticeRollingOff = setInterval(noticeRolling, 2000);
			});
		});
	</script>
</head>
<body class="align-column">
<div class="member-area container-1200">

	<% if(isLogin){ %>
	<ul class="ul-row member-menu ">
		<% if(isAdmin){ %>
		<li><a class="change-a" href="<%=root %>/admin/adminHome.jsp">관리자페이지</a></li>
		<%}else{ %>
		<li><a class="change-a" href="<%=root %>/member/myInfo_check.jsp">마이페이지</a></li>
		<%} %>
		<li><a class="change-a" href="#">QnA</a></li>
		<li><a class="change-a" href="<%=root%>/member/logout.kh">로그아웃</a></li>
	</ul>
	<%}else{ %>
	<ul class="ul-row member-menu ">
		<li><a class="change-a" href="<%=root%>/member/signup.jsp">회원가입</a></li>
		<li><a class="change-a" href="#">QnA</a></li>
		<li><a class="change-a" href="<%=root%>/member/login.jsp">로그인</a></li>
	</ul>
	<%} %>	
	
</div>
<div class="line"></div>
<header class="container-1200 align-column ">
<div class="container-1200 align-row space-around">
	<div class="logo-area ">
		<div><a href="<%=root%>"><span style="font-size: 40px">BOOKin</span></a></div>
	</div>
	<div style="width: 45%;margin-right: 200px;" class="search-form-area">
		<form  class="search-form" action="<%=root%>/book/bookSearch.jsp">
			<input style="width: 100%" type="search" name="keyword" class="search-input" value="<%=keyword%>">
			
			<button type="submit" class="search-btn"></button>
		</form>
	</div>

	<div class="searchrank-area">
		<div class="searchrank-item border-bottom">
			<div class="bookrank">
				<ul class="rolling">
					<%for(BookDto bookDto : bookList){ %>
						<li><a href="<%=root%>/book/bookDetail.jsp?no=<%=bookDto.getBookNo()%>"><strong><%=barCount++%>.</strong><span class="searchrank-item-text overflow" style="left:20px;"><%=bookDto.getBookTitle() %></span></a></li>
					<%} %>
				</ul>
			</div>
			<span class="site-color">▼</span>
		</div>
		<div class="searchrank-list" style="background-color: white;">
			<div class="line text-center keyword"><span>인기도서</span></div>
			<%for(BookDto bookDto : bookList){ %>
			<div class="searchrank-item">
				<div>
					<strong class="site-color"><%=topCount++%>.</strong>
					<a href="<%=root%>/book/bookDetail.jsp?no=<%=bookDto.getBookNo()%>"><span class="searchrank-item-text overflow"><%=bookDto.getBookTitle() %></span></a>
				</div>
				<span class="site-color">NEW</span>
			</div>
			<%} %>
		</div>
		
	</div>
</div>

</header>
<div class="line" style=" margin-top: 20px;"></div>
<section style="min-height: 800px" class="container-1200">
