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
	MemberDto memberDto = null;
	if(memberNo!=null){
		isLogin=true;
		memberDto = memberDao.getMember(memberNo);
	}
	GenreDao genreDao=new GenreDao();
	List<GenreDto> genreList=genreDao.topGenreList();
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
    <link rel="stylesheet" type="text/css" href="<%= root%>/css/purchase.css">
   <style>
		
   </style>
</head>
<body class="align-column">
<div class="member-area container-1200">

	<% if(isLogin){ %>
	<ul class="ul-row member-menu ">
		<li><a class="change-a" href="<%=root %>/member/myInfo_check.jsp">마이페이지</a></li>
		<li><a class="change-a" href="<%=root%>/qna/qnaList.jsp">QnA</a></li>
		<li><a class="change-a" href="<%=root%>/member/logout.kh">로그아웃</a></li>
	</ul>
	<%}else{ %>
	<ul class="ul-row member-menu ">
		<li><a class="change-a" href="<%=root%>/member/signup.jsp">회원가입</a></li>
		<li><a class="change-a" href="<%=root%>/qna/qnaList.jsp">QnA</a></li>
		<li><a class="change-a" href="<%=root%>/member/login.jsp">로그인</a></li>
	</ul>
	<%} %>	
	
</div>
<div class="line"></div>
<header class="container-1200 align-column ">
<div class="container-1200 align-row space-around">
	<div class="logo-area ">
		<div><a href="<%=root%>"><span>BOOKin</span></a></div>
	</div>
	<div class="search-form-area">
		<form class="search-form" action="<%=root%>/book/bookSearch.jsp">
			<input type="search" name="keyword" class="search-input">
			
			<button type="submit" class="search-btn"></button>
		</form>
	</div>
	<div class="icon-area align-row">
		<a class="icon-item align-column" href="#">
			<img class ="icon" src="<%=root%>/image/like.svg">
			<span>좋아요</span>
		</a>
		<a class="icon-item align-column" href="#">
			<img class ="icon" src="<%=root%>/image/bag.svg">
			<span>장바구니</span>
		</a>
		<a class="icon-item align-column" href="#">
			<img class ="icon" src="<%=root%>/image/writing.svg">
			<span>리뷰</span>
		</a>
		<a  class="icon-item align-column" href="<%=root%>/qna/qnaNotice.jsp">
			<img class ="icon" src="<%=root%>/image/gift.svg">
			<span>이벤트</span>
		</a>
	</div>
	<div class="searchrank-area">
		<div class="searchrank-item border-bottom">
			<div>
				<span class="site-color">1.</span>
				<a href="#"><span class="searchrank-item-text">명탐정코난</span></a>
			</div>
			<span class="site-color">▼</span>
		</div>
		<div class="searchrank-list" style="background-color: white;">
			<div class="line text-center keyword"><span>인기검색어</span></div>
			<% for(int i =1;i<11;i++){ %>
			<div class="searchrank-item">
				<div>
					<span class="site-color"><%=i %>.</span>
					<a href="#"><span class="searchrank-item-text overflow">명탐정코난asdasdasdasdasd</span></a>
				</div>
				<span class="site-color">NEW</span>
			</div>
			<%} %>
		</div>
	</div>
</div>
<div class="container-1200 align-row space-between">
	<ul class="font-weight-900 ul-row main-menu">
		<li><a class="site-color change-a" href="#">베스트</a></li>
		<li><a class="site-color-red change-a"  href="#" >NEW</a></li>
	<% for(int i=0;i<genreList.size();i++){ %>
		<li>
			<a class="change-a" href="?genre=<%=genreList.get(i).getGenreNo()%>"> <%=genreList.get(i).getGenreName() %></a>
			<ul class="sub-menu">
			<% 
			List<GenreDto> sublist=	genreDao.childGenreList(genreList.get(i).getGenreNo());
			for(int j =0;j<sublist.size();j++){ %>
				<li>
					<a href="?genre=<%=sublist.get(j).getGenreNo()%>" class="change-a_noani overflow"><%=sublist.get(j).getGenreName() %></a>
					<ul class="sub-sub-menu">
						<%
						List<GenreDto> sublist2=genreDao.childGenreList(sublist.get(j).getGenreNo());
						for(int k =0;k<sublist2.size();k++){ %>
							<li><a href="?genre=<%=sublist2.get(k).getGenreNo()%>" class="change-a_noani overflow"><%=sublist2.get(k).getGenreName() %></a></li>
						
						<%} %>
					</ul>
				</li>
			<%} %>
			</ul>
		</li>
	<%} %>
	</ul>
</div>
</header>
<script>
	window.addEventListener("load",function(){
		var sub_menu = document.querySelectorAll(".sub-menu>li");
		for(var i=0;i<sub_menu.length;i++){
			sub_menu[i].addEventListener("mouseover",function(){
				var wid = -this.children[1].firstElementChild.offsetWidth;
				this.children[1].style.right=String(wid+1)+'px';
			})
		}
	})
</script>
<section style="min-height: 800px" class="container-1200">

