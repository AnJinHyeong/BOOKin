<%@page import="semi.beans.ReviewDao"%>
<%@page import="java.util.Map"%>
<%@page import="semi.beans.PurchaseDao"%>
<%@page import="semi.beans.MemberDto"%>
<%@page import="semi.beans.MemberDao"%>
<%@page import="semi.beans.BookDao"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="semi.beans.BookDto"%>
<%@page import="semi.beans.BookLikeDao"%>
<%@page import="semi.beans.BookLikeDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String root = request.getContextPath();

	boolean isLogin = session.getAttribute("member") != null;
	
	if(!isLogin){	
		response.sendRedirect("login.jsp");
		return;
	}	
		
	int memberNo = (int)session.getAttribute("member");
	
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
	
	ReviewDao reviewDao = new ReviewDao();
	List<BookDto> noReviewBookList = reviewDao.isPurchaseNoReviewList(memberNo);
%>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	var banner_left =0;
	var img_cnt = 0;
	var first = 1;
	var last;
	var interval;
	
	$(function(){
		$(".review-rolling-content .review-book-img").each(function(){
			$(this).css("left", banner_left);
			banner_left += $(this).width() + 8;
			$(this).attr("id", "content"+(++img_cnt));
		});
		
		last = img_cnt;
		
		$(".review-right-img").click(function(){
			var last_content = $("#content"+last);
			var pos = last_content.position().left + last_content.width() + 8;
			if(pos < $(".review-rolling-content").width())
				return;
			
			$(".review-rolling-content .review-book-img").each(function(){
				$(this).animate({
					left: $(this).position().left - ($(this).width() * 2)
				}, 500); 			
			})
		});
		
		$(".review-left-img").click(function(){	
			var first_content = $("#content"+first);
			var pos = first_content.position().left;
			if(pos > -5)
				return;
			
			$(".review-rolling-content .review-book-img").each(function(){
				 $(this).animate({
					 left: $(this).position().left + ($(this).width() * 2)
				}, 500);	
			})
		});
	});
	
</script>

<jsp:include page="/template/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=root%>/css/myInfoLayout.css">
<link rel="stylesheet" type="text/css" href="<%=root%>/css/template.css">
<link rel="stylesheet" type="text/css" href="<%= root%>/css/list.css">
<link rel="stylesheet" type="text/css" href="<%= root%>/css/reviewPage.css">
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
			<div class="txt">거래완료</div>
		</dd>
	</dl>
	</div>
	<main class="myInfo-main">		
		<!-- 사이드영역 -->
		<aside class="myInfo-aside">
			<h2 class="tit">MYPAGE</h2>
			<ul class="menu" >
				<li ><a href="myInfo_check.jsp" id="edit-info">회원정보 수정 / 탈퇴</a></li>
				<li><a href="deliveryList.jsp">주문목록 / 배송조회</a></li>
				<li class="on"><a href="review.jsp">리뷰관리</a></li>				
				<li><a href="<%=root%>/qna/qnaNotice.jsp">고객센터</a></li>
				<li><a href="cart.jsp">장바구니</a></li>
				<li><a href="bookLike.jsp">좋아요</a></li>
			</ul>
		</aside>
		
		<!-- 컨텐츠영역 -->
		<section class="myInfo-section">
			<header class="text-center"> <h3 style=" margin-bottom: 40px;font-size:40px;" class="site-color">리뷰를 남겨주세요</h3> </header>
			<article class="myInfo-article text-center">
				<div class="review-rolling-div">
					<div class="review-left-arrow-div"><img class="review-left-img" src="<%=root%>/image/left-arrow.png"></div>
					<div class="review-rolling-content">	
						<%for(BookDto bookDto : noReviewBookList){ %>	
							<a href="<%=root%>/book/bookDetail.jsp?no=<%=bookDto.getBookNo() %>" class="review-book-img">	
								<%if(bookDto.getBookImage().startsWith("https")){ %>
					            	<img title="<%=bookDto.getBookTitle() %>" src="<%=bookDto.getBookImage()%>">
					            <%}else{ %>
					            	<img title="<%=bookDto.getBookTitle() %>" src="<%=root%>/book/bookImage.kh?bookNo=<%=bookDto.getBookNo()%>">
					            <%} %>
							</a>										
						<%} %>
					</div>
					<div class="review-right-arrow-div"><img class="review-right-img" src="<%=root%>/image/right-arrow.png"></div>
				</div>				
			</article>
		</section>
		
	</main>
<jsp:include page="/template/footer.jsp"></jsp:include>