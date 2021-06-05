<%@page import="semi.beans.BookReviewDto"%>
<%@page import="semi.beans.ReviewDto"%>
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
	
	//페이지 네이셔 구현 코드
	int pageNo;//현재 페이지 번호
	try{
		pageNo = Integer.parseInt(request.getParameter("pageNo"));
		if(pageNo < 1) {
			throw new Exception();
		}
	}
	catch(Exception e){
		pageNo = 1;//기본값 1페이지
	}
	
	int pageSize;
	try{
		pageSize = Integer.parseInt(request.getParameter("pageSize"));
		if(pageSize < 10){
			throw new Exception();
		}
	}
	catch(Exception e){
		pageSize = 5;//기본값 10개
	}
	
	ReviewDao reviewDao = new ReviewDao();
	//rownum의 시작번호(startRow)와 종료번호(endRow)를 계산
	int startRow = pageNo * pageSize - (pageSize-1);
	int endRow = pageNo * pageSize;
		
	int count = reviewDao.getCountMyList(memberNo);	
		
	int blockSize = 10;
	int lastBlock = (count + pageSize - 1) / pageSize;
	//	int lastBlock = (count - 1) / pageSize + 1;
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
	if(endBlock > lastBlock){//범위를 벗어나면
		endBlock = lastBlock;//범위를 수정
	}
		
	List<BookDto> noReviewBookList = reviewDao.isPurchaseNoReviewList(memberNo);
	List<BookReviewDto> myReviewList = reviewDao.memberNoList(memberNo, startRow, endRow);
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
		
		$(".review-rolling-content .review-book-img").mouseenter(function(){
			$(this).animate({top: -50}, 200, function(){
				$(this).animate({top: 0}, 200)
			}); 
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
		
		$(".move-book-detail-btn").click(function(){	
			var bookNo = $(this).attr("id");
			location.href ="<%=root%>/book/bookDetail.jsp?no="+bookNo;
		});
	});
	
	//페이지 네이션 
	$(function(){
		$(".pagination > a").click(function(){
			//주인공 == a태그
			var pageNo = $(this).text();
			if(pageNo == "이전"){//이전 링크 : 현재 링크 중 첫 번째 항목 값 - 1
				pageNo = parseInt($(".pagination > a:not(.move-link)").first().text()) - 1;
				$("input[name=pageNo]").val(pageNo);
				$(".page-form").submit();//강제 submit 발생
			}	
			else if(pageNo == "다음"){//다음 링크 : 현재 링크 중 마지막 항목 값 + 1
				pageNo = parseInt($(".pagination > a:not(.move-link)").last().text()) + 1;
				$("input[name=pageNo]").val(pageNo);
				$(".page-form").submit();//강제 submit 발생
			}
			else{//숫자 링크
				$("input[name=pageNo]").val(pageNo);
				$(".page-form").submit();//강제 submit 발생
			}
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
						<%if(noReviewBookList.size()>0) {%>	
							<%for(BookDto bookDto : noReviewBookList){ %>	
								<a href="<%=root%>/book/bookDetail.jsp?no=<%=bookDto.getBookNo() %>" class="review-book-img">	
									<%if(bookDto.getBookImage().startsWith("https")){ %>
						            	<img title="<%=bookDto.getBookTitle() %>" src="<%=bookDto.getBookImage()%>">
						            <%}else{ %>
						            	<img title="<%=bookDto.getBookTitle() %>" src="<%=root%>/book/bookImage.kh?bookNo=<%=bookDto.getBookNo()%>">
						            <%} %>
								</a>										
							<%} %>
						<%} else{%>
							<p style=" margin-top: 80px;font-size:35px; color:#dcdcdc;">리뷰를 남길 책이 없습니다</p>
						<%} %>
					</div>
					<div class="review-right-arrow-div"><img class="review-right-img" src="<%=root%>/image/right-arrow.png"></div>
				</div>
				
				<!--작성한 리뷰 목록 -->
				<div class="row text-center">
					<div style="margin-top: 40px; width:86%; margin-left:7%;">
						<p style="font-size:35px; color:#FFBE0A; margin-bottom: 20px;" class="site-color">내가 작성한 리뷰</p>
						<div style="border-top:2px solid #39373a;"></div>					
							<%for (BookReviewDto bookReviewDto : myReviewList) {%>
								<!-- 처음에 보여줘야 할 부분  -->
								<div style="display: inline-block; width:20%; padding-top:7px; padding-bottom:5px;">
									<img src="<%=bookReviewDto.getReviewBookUrl() %>">
									<p style="font-size:13px; color:#39373a; margin-bottom: 3px; min-height: 35px;" ><%=bookReviewDto.getReviewBookTitle() %></p>
								</div>
								<div style="display: inline-block; width:78%; vertical-align: top; text-align: left;">
									<div style="width:100%;display: inline-block; vertical-align: top; margin-top: 3px; margin-right: 15px; height: 50px;">
										<div style="display:inline-block; width:49%; margin-top: 10px;">
											<%int reviewRate = bookReviewDto.getReviewRate();%>
											<%for (int i = 0; i < reviewRate; i++) {%>
												<img src="<%=root%>/image/star_on.png">
											<%}%>
											<%for (int i = 0; i < 5 - reviewRate; i++) {%>
												<img src="<%=root%>/image/star_off.png">
											<%}%>
										</div>										
										<div style="font-size: 14px; display:inline-block; width:49%; text-align: right; vertical-align: top; margin-top: 5px;"><%=bookReviewDto.getReviewTime()%></div>
									</div>
									<div style="min-height: 60px; text-align: left; overflow: hidden;">
										<%=bookReviewDto.getReviewContent()%>
									</div>
									<div style="text-align: right; width:100%;">
										<input type="button" class="form-btn form-btn-positive btn move-book-detail-btn" id="<%=bookReviewDto.getReviewBook() %>" value="리뷰 보러가기" 
											style="width:100px; margin-right: 20px; margin-bottom: 10px;">
									</div>
								</div>									
								<div style="border-bottom:1px solid gray;"></div>	
							<%}%>
						<div style="border-bottom:2px solid #39373a;"></div>
					</div>
				</div>
				
				<!-- 페이지 네비게이션 자리 -->
				<div class="pagination">				
					<%if(startBlock > 1){ %>
					<a class="move-link">이전</a>
					<%} %>
					
					<%for(int i = startBlock; i <= endBlock; i++){ %>
						<%if(i == pageNo){ %>
							<a class="on"><%=i%></a>
						<%}else{ %>
							<a><%=i%></a>
						<%} %>
					<%} %>
					
					<%if(endBlock < lastBlock){ %>
					<a class="move-link">다음</a>
					<%} %>
					
				</div>
				
				<form class="page-form" action="review.jsp" method="post">
					<input type="hidden" name="pageNo">
				</form>				
			</article>
		</section>
		
	</main>
<jsp:include page="/template/footer.jsp"></jsp:include>