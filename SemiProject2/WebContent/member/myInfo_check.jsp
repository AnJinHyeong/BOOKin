<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="semi.beans.PurchaseDao"%>
<%@page import="semi.beans.MemberDto"%>
<%@page import="semi.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String root = request.getContextPath();

	boolean isLogin = session.getAttribute("member") != null;
	
	if(!isLogin){		
		response.sendRedirect("login.jsp");
	}
	
	int memberNo = (int)session.getAttribute("member");
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.getMember(memberNo);
	PurchaseDao purchaseDao = new PurchaseDao();
	Map<String,List<Integer>> map = purchaseDao.getMemberPurchaseStateCount(memberNo);
	
	int orderConfirm=0;
	int delieverying=0;
	int delieverySucces=0;
	int pay=0;
	
	if(map.containsKey("주문확인")){
		
		orderConfirm=map.get("주문확인").size();
		
	}
	if(map.containsKey("결제완료")){
		
		pay=map.get("결제완료").size();
		
	}
	if(map.containsKey("배송중")){
		
		delieverying=map.get("배송중").size();
		
	}
	if(map.containsKey("배송완료")){
		
		delieverySucces=map.get("배송완료").size();
		
	}
%>

<jsp:include page="/template/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=root%>/css/myInfoLayout.css">
<link rel="stylesheet" type="text/css" href="<%=root%>/css/template.css">

	<!-- 주문 현황 영역 -->
	<div class="container-1200 myInfo-header">
		<dl class="bottom" style="padding-bottom:55px;">
		<dt>주문현황</dt>
		<dd>
			<div class="tit"><a><%=pay %></a></div>
			<div class="txt">결제완료</div>
		</dd>
		<dd class="bottom-next">
			<img src="<%=root %>/image/myInfo_next.png" width="30px" height="30px">
		</dd>
		<dd>
			<div class="tit"><a><%=orderConfirm %></a></div>
			<div class="txt">주문확인</div>
		</dd>
		<dd class="bottom-next">
			<img src="<%=root %>/image/myInfo_next.png" width="30px" height="30px">
		</dd>
		<dd>
			<div class="tit"><a><%=delieverying %></a></div>
			<div class="txt">배송중</div>
		</dd>
		<dd class="bottom-next">
			<img src="<%=root %>/image/myInfo_next.png" width="30px" height="30px">
		</dd>
		<dd>
			<div class="tit"><a><%=delieverySucces %></a></div>
			<div class="txt">배송완료</div>
		</dd>
	</dl>
	</div>
	<main class="myInfo-main">		
		<!-- 사이드영역 -->
		<aside class="myInfo-aside">
			<h2 class="tit">MYPAGE</h2>
			<ul class="menu" >
				<li class="on"><a href="myInfo_check.jsp" id="edit-info">회원정보 수정 / 탈퇴</a></li>
				<li><a href="deliveryList.jsp">주문목록 / 배송조회</a></li>
				<li><a href="review.jsp">리뷰관리</a></li>				
				<li><a href="<%=root%>/qna/qnaList.jsp">고객센터</a></li>
				<li><a href="cart.jsp">장바구니</a></li>
				<li ><a href="bookLike.jsp">좋아요</a></li>
			</ul>
		</aside>
		
		<!-- 컨텐츠영역 -->
		<section class="myInfo-section">
			<article class="myInfo-article">
				<div class="align-column">
					<h3 style="margin-bottom: 40px;font-size:40px;" class="site-color">회원정보 수정</h3>
					<form class="container-500 align-column singup-form" action="memberEditCheck.kh" method="post">
						<input type="hidden" name="memberNo" value="<%=memberNo %>">
						<div><span>아이디</span><span style="width: 70%; text-align: left;"><%=memberDto.getMemberId() %></span></div>
						<input type="hidden" name="memberId" value="<%=memberDto.getMemberId() %>">						
						<div><span>비밀번호</span><input type="password" name="memberPw" required></div>	
						
						<div style="width: 100% ;border-bottom:1px solid rgba(0,0,0,0.4);margin-top:30px;margin-bottom:30px"></div> 
						
						<div class="signup-button-area">
							<button type="submit" class="form-btn form-btn-positive btn">확인</button>
							<button type="reset" class="form-btn form-btn-normal btn js_cancel_signup">취소</button>
						</div>					
					</form>
				</div>
			</article>
		</section>
		
	</main>
<jsp:include page="/template/footer.jsp"></jsp:include>