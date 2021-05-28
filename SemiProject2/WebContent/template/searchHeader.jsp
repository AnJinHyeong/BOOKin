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
	String keyword = request.getParameter("keyword");
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
   <style>
		
   </style>
</head>
<body class="align-column">
<div class="member-area container-1200">

	<% if(isLogin){ %>
	<ul class="ul-row member-menu ">
		<li><a class="change-a" href="<%=root %>/member/myInfo_check.jsp">마이페이지</a></li>
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

</header>
<div class="line" style=" margin-top: 20px;"></div>
<section style="min-height: 800px" class="container-1200">
