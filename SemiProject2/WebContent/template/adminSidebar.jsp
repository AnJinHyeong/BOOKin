<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	String root = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" type="text/css" href="<%= root%>/css/template.css">
    <link rel="stylesheet" type="text/css" href="<%= root%>/css/adminPage.css">
    
</head>
<body>
	<aside>
		<div class="admin-logo"><a href="<%=root%>/admin/adminHome.jsp">BOOKin</a></div>
		<ul>
			<li class="admin-aside-top_menu"><span class="admin-aside-top_text">상품</span>
				<ul class="admin-aside-side_menus">
					<li><a href="<%=root%>/admin/bookInsert.jsp">상품 등록</a></li>
					<li><a href="<%=root%>/admin/bookSearch.jsp">상품 조회/수정</a></li>
				</ul>
			</li>
			<li class="admin-aside-top_menu"><span class="admin-aside-top_text">판매</span>
				<ul class="admin-aside-side_menus">
					<li><a href="<%=root%>/admin/purchaseSearch.jsp">주문확인/발송관리</a></li>
					<li><a>취소 관리</a></li>
				</ul>
			</li>
			<li class="admin-aside-top_menu"><span class="admin-aside-top_text">문의/리뷰</span>
				<ul class="admin-aside-side_menus">
					<li><a href="<%=root%>/admin/qnaReply.jsp">문의 관리</a></li>
					<li><a>리뷰 관리</a></li>
				</ul>
			</li>
			<li class="admin-aside-top_menu"><span class="admin-aside-top_text">공지/이벤트</span>
				<ul class="admin-aside-side_menus">
					<li><a href="<%=root%>/admin/noticeInsert.jsp">공지/이벤트 등록</a></li>
					<li><a href="<%=root%>/admin/notice.jsp">공지/이벤트 관리</a></li>
				</ul>
			</li>
			<li class="admin-aside-top_menu"><span class="admin-aside-top_text">정산</span>
				<ul class="admin-aside-side_menus">
					<li><a>정산 내역</a></li>
				</ul>
			</li>
			<li class="admin-aside-top_menu" style="padding-top: 250px;"><span class="admin-aside-top_text"></span>
				<ul class="admin-aside-side_menus">
					<li><a href="<%=root%>">메인 페이지</a></li>
				</ul>
			</li>
		</ul>
	</aside>
	