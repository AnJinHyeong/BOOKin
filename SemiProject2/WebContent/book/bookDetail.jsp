<%@page import="semi.beans.ReviewDao"%>
<%@page import="semi.beans.MemberDto"%>
<%@page import="semi.beans.MemberDao"%>
<%@page import="semi.beans.BookReviewDto"%>
<%@page import="semi.beans.BookReviewDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="semi.beans.GenreDto"%>
<%@page import="java.util.List"%>
<%@page import="semi.beans.GenreDao"%>
<%@page import="semi.beans.BookDto"%>
<%@page import="semi.beans.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	int no = Integer.parseInt(request.getParameter("no"));
	String root = request.getContextPath();
	
	BookDao bookDao = new BookDao();
	BookDto bookDto = bookDao.get(no);
	if (bookDto.getBookImage() == null) {
		bookDto.setBookImage(root + "/image/nullbook.png");
	}
	
	GenreDao genreDao = new GenreDao();
	GenreDto genreDto = genreDao.get(bookDto.getBookGenreNo());
	GenreDto genreDto2;
	GenreDto genreDto1 = genreDao.get(genreDao.get(genreDto.getGenreParents()).getGenreNo());
	if (genreDao.get(genreDto1.getGenreParents()) != null) {
		genreDto2 = genreDao.get(genreDao.get(genreDto1.getGenreParents()).getGenreNo());
	} else {
		genreDto2 = null;
	}
	List<BookDto> bookList = bookDao.authorSearch(bookDto.getBookAuthor(), 1, 10);
	List<BookDto> bookList2 = bookDao.publisherSearch(bookDto.getBookPublisher(), 1, 10);
	List<BookDto> bookList3 = bookDao.genreSearch(bookDto.getBookGenreNo());
	List<GenreDto> genreList = genreDao.sameGenreList(bookDto.getBookGenreNo());
	
	bookDao.bookView((int) no);
%>
<%
	int price = bookDto.getBookPrice();
	int discount = bookDto.getBookDiscount();
	int priceDif = price - discount;
	int discountPercent = (int) (((double) priceDif / (double) price) * (100.0));
%>
<%
	//페이지 네이셔 구현 코드
	int pageNo;//현재 페이지 번호
	try {
		pageNo = Integer.parseInt(request.getParameter("pageNo"));
		if (pageNo < 1) {
			throw new Exception();
		}
	} catch (Exception e) {
		pageNo = 1;//기본값 1페이지
	}
	
	int pageSize;
	try {
		pageSize = Integer.parseInt(request.getParameter("pageSize"));
		if (pageSize < 10) {
			throw new Exception();
		}
	} catch (Exception e) {
		pageSize = 5;//기본값 15개
	}
	
	//rownum의 시작번호(startRow)와 종료번호(endRow)를 계산
	int startRow = pageNo * pageSize - (pageSize - 1);
	int endRow = pageNo * pageSize;
	
	//해당 책 리뷰
	BookReviewDao bookReviewDao = new BookReviewDao();
	List<BookReviewDto> reviewList = bookReviewDao.list(no, startRow, endRow);
	
	//해당 책 리뷰 개수
	int reviewCount = bookReviewDao.count(no);
	//해당 책 리뷰 평점
	int reviewAvg = bookReviewDao.avg(no);
	
	int count = bookReviewDao.count(no);
	
	int blockSize = 10;
	int lastBlock = (count + pageSize - 1) / pageSize;
	//	int lastBlock = (count - 1) / pageSize + 1;
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
	if (endBlock > lastBlock) {//범위를 벗어나면
		endBlock = lastBlock;//범위를 수정
}
%>
<%
	int bookNo = (int) Long.parseLong(request.getParameter("no"));
	
	int member;
	try {
		member = (int) session.getAttribute("member");
	} catch (Exception e) {
		member = 0;
	}
	
	ReviewDao reviewDao = new ReviewDao();
	boolean isPurchase = reviewDao.isPurchase(bookNo, member);
	
	boolean isReview = reviewDao.isReview(bookNo, member);
%>

<link rel="stylesheet" type="text/css" href="<%=root%>/css/review.css">
<jsp:include page="/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<style>
.hidden {
	display: none;
}

.non-hidden {
	display: block;
}

.star {
	width: 30px;
}
</style>
<script>
	//페이지 네이션 
	$(function() {
		$(".pagination > a").click(
				function() {
					//주인공 == a태그
					var pageNo = $(this).text();
					if (pageNo == "이전") {//이전 링크 : 현재 링크 중 첫 번째 항목 값 - 1
						pageNo = parseInt($(".pagination > a:not(.move-link)")
								.first().text()) - 1;
						$("input[name=pageNo]").val(pageNo);
						$(".page-form").submit();//강제 submit 발생
					} else if (pageNo == "다음") {//다음 링크 : 현재 링크 중 마지막 항목 값 + 1
						pageNo = parseInt($(".pagination > a:not(.move-link)").last().text()) + 1;
						$("input[name=pageNo]").val(pageNo);
						$(".page-form").submit();//강제 submit 발생
					} else {//숫자 링크
						$("input[name=pageNo]").val(pageNo);
						$(".page-form").submit();//강제 submit 발생
					}
				});
	});
</script>
<script>
	$(function() {
		$(".edit_button").click(function() {
			var beforeEditId = "#beforeEdit" + $(this).attr("data-reviewno");

			$(beforeEditId).removeClass("hidden");
			$(beforeEditId).removeClass("non-hidden");

			$(beforeEditId).addClass("hidden");

			var afterEditId = "#afterEdit" + $(this).attr("data-reviewno");

			$(afterEditId).removeClass("hidden");
			$(afterEditId).removeClass("non-hidden");

			$(afterEditId).addClass("non-hidden");

		});

		$(".cancle_button").click(function() {

			var beforeEditId = "#beforeEdit" + $(this).attr("data-reviewno");

			$(beforeEditId).removeClass("hidden");
			$(beforeEditId).removeClass("non-hidden");

			$(beforeEditId).addClass("non-hidden");

			var afterEditId = "#afterEdit" + $(this).attr("data-reviewno");

			$(afterEditId).removeClass("hidden");
			$(afterEditId).removeClass("non-hidden");

			$(afterEditId).addClass("hidden");

		});
		
		//별점 인풋 스크립트				
		$(".star").click(function(){
			var id = $(this).attr("id");
			var starNumber=id.substring(4,5);
			
			for(var i=1;i<=5;i++){ 
				var temp = "#star" + i;
				$(temp).attr("src","<%=root%>/image/star_off.png");
			}
			for(var i=1;i<=starNumber;i++){
				var temp = "#star" + i;
				$(temp).attr("src","<%=root%>/image/star_on.png");
			}
				$("#review_rate").val(starNumber);
		});
		
		
		$("#review_insert_button").click(function(){
			if($(".review_inbox_text.insert").val()){
			$(".review_input_form").submit()
			}
		});
	
		$("#review_edit_button").click(function(){
			if($(".review_inbox_text.edit").val()){
			$(".review_edit_form").submit()
			}
		});
	});
</script>

<div class="container-700">

	<div class="row text-left">
      <h1><%=bookDto.getBookTitle() %></h1><br>
      <div>
         <span><%=bookDto.getBookAuthor() %> (지은이)&nbsp;&nbsp;</span>
         <span><%=bookDto.getBookPublisher()%>&nbsp;&nbsp;</span>
         <span><%=bookDto.getBookPubDate()%></span>
         
      </div>
   </div>
   <hr>
   
   <div class="main-detail">
      <div class="book-image-box">
         <%if(bookDto.getBookImage().startsWith("https")){ %>
         <img title="<%=bookDto.getBookTitle()%>" src="<%=bookDto.getBookImage()%>" class="book-image" style="height: 50%;">
         <%}else{ %>
         <img title="<%=bookDto.getBookTitle() %>" class="book-image" src="<%=root%>/book/bookImage.kh?bookNo=<%=bookDto.getBookNo()%>" style="height: 50%;">
         <%} %>
      </div>
      <div class="book-table-box">
         <div class="site-color-red">신구간의 매력적인 조합, 인문ON! 와이드 데스크 매트</div><br><br>
         
         <div>
            <span>정가</span>
            <span>&emsp;&emsp;&emsp;<%=bookDto.getBookPrice()%>원</span>
         </div><br>
         <div>
            <span>판매가&emsp;&emsp;</span>
            <span class="price-text"><%=bookDto.getBookDiscount()%></span>
            <span>원&nbsp;(<%=discountPercent %>%, <%=priceDif %>원 할인)</span>         
         </div><br><br>
         <div>
            <span>배송료</span>
            <span>&emsp;&emsp;신간도서 단 1권도 무료</span>
         </div>
         <div class="detail-info-box">
            <div class="detail-info-clock-box">
               <img src="<%=root %>/image/clock-regular.svg" class="clock-image">
            </div>
            <div class="detail-info-text-box">
               <div class="carpet-delivery-text">양탄자배송</div>
               <span>밤 10시까지 주문하면 내일 아침 7시 </span><span class="site-color-red">출근전 배송</span><br>
               <span>(중구 중림동 기준) 지역변경</span>
            </div>
         </div><br><br>
         <div class="detail-etc-text-box">

               <span class="star-image-box">
                  <%if(reviewAvg == 0){ %>
                     <span class="site-color-red detail-etc-text-highlight">리뷰가 없습니다.</span>
                  <%} else{%>
                     <%for(int i=0; i<reviewAvg;i++){ %>
                        <span><img src="<%=root %>/image/star_on.png" class="star-image"></span>
                     <%} %>
                     <%for(int i=0; i<5-reviewAvg; i++){ %>
                        <span><img src="<%=root %>/image/star_off.png" class="star-image"></span>
                     <%} %>
                     <span class="site-color-red detail-etc-text-highlight"><%=reviewAvg %></span>
                  <%} %>
               </span>
   
               <span>
                  &emsp;리뷰(<%=reviewCount %>)&emsp;
               </span>
               <span class="blue-box">
                  이 책 어때요?
               </span>
            </div><br>
            
            
            <div class="payment-button-box">
            	<%if(session.getAttribute("member")!=null){ 
            		System.out.println(session.getAttribute("member"));
            	%>
               	<form action="<%=root %>/member/cartInsert.kh" method="post" onsubmit="foo();" class="cartInsertForm">
               <%}else{ %>
               	<form action="<%=root %>/member/login.jsp" method="post" onsubmit="foo2();" class="cartInsertForm">

               <%} %>
                  <div class="row">
                     <span style="width: 50px; text-align: left;">수량</span>
                     <input type="number" name="cartAmount" value="1" min="1" style="margin: 0 0 0 40px; height: 30px; width: 150px;" id="cartAmount">
                     <span class="book-price"></span>                     
                  </div><br>
                  <input type="hidden" name="memberNo" value="<%=member %>">
                  <input type="hidden" name="bookNo" value="<%=no %>">
                  <div style="margin-top:30px;">
                     
                     <ul style="display:flex;" class="payment-button-ul">
                     
                     <%if(session.getAttribute("member")!=null){%>
                     	<li class="cart-btn" style="background-color:rgb(223,48,127);"><a href="<%=root %>/purchase/purchase.jsp?no=<%=bookDto.getBookNo()%>" class="payment-button-text js_purchase_btn">바로구매</a></li>
		               <%}else{ %>
                     	<li class="cart-btn" style="background-color:rgb(223,48,127);"><a href="<%=root %>/member/login.jsp" class="payment-button-text js_purchase_btn">바로구매</a>
		               <%} %>
                    
                    	<%if(session.getAttribute("member")!=null){%>
                     	<li class="cart-btn" style="background-color:rgb(226,68,87);"onClick="gotoCart()"><a href="#" class="payment-button-text">장바구니 담기</a>
		               <%}else{ %>
                     	<li class="cart-btn" style="background-color:rgb(226,68,87);"onClick="foo2()"><a href="<%=root %>/member/login.jsp" class="payment-button-text">장바구니 담기</a>
		               <%} %>
                     </ul>
                  </div>

               </form>
            
            </div><br><br>
            
      </div>
      
   </div>
   <hr>

	<div class="row text-left book-detail-semi-box">
		<div class="book-detail-semi-title">
			<span>기본정보</span>
		</div>
		<div class="book-detail-semi-subtitle">
			<div class="book-detail-semi-subtitle-text">주제분류</div>
			<br>
			<div>
				<%if (genreDto2 == null) {%>
				<%=genreDto1.getGenreName()%>
				&gt;<%=genreDto.getGenreName()%>
				<%} else {%>
				<%=genreDto2.getGenreName()%>
				&gt;
				<%=genreDto1.getGenreName()%>
				&gt;
				<%=genreDto.getGenreName()%>
				<% } %>
			</div>
		</div>
	</div>
	
	<hr>

	<div class="row text-left book-detail-semi-box">
		<div class="book-detail-semi-title">
			<span>책소개</span>
		</div>
		<div class="book-detail-semi-subtitle"><%=bookDto.getBookDescription()%></div>
	</div>
	
	<hr>

	<div class="row text-left book-detail-semi-box2">
		<div class="book-detail-semi-title2">
			<span><%=bookDto.getBookAuthor()%></span> <span
				class="book-detail-semi-title2-highlight"> 작가의 다른 책</span>
		</div>
		<div class="book-detail-semi-image-box">
			<%if (bookList.size() < 5) { %>
				<%for (int i = 0; i < bookList.size(); i++) { %>
					<%
						if (bookDto.getBookNo() == bookList.get(i).getBookNo()) {
							continue;
						}
					%>
					<a href="<%=root%>/book/bookDetail.jsp?no=<%=bookList.get(i).getBookNo()%>">
						<%
							if (bookList.get(i).getBookImage().startsWith("https")) {
						%> 
							<img title="<%=bookList.get(i).getBookTitle()%>"
							src="<%=bookList.get(i).getBookImage()%>"
							class="same-author-book-img"> 
						<%} else {%> 
						 <img title="<%=bookList.get(i).getBookTitle()%>"
						class="same-author-book-img"
						src="<%=root%>/book/bookImage.kh?bookNo=<%=bookList.get(i).getBookNo()%>">
						<% } %>
					</a>
				<% } %>
			<%} else {%>
				<%for (int i = 0; i < 4; i++) { %>
					<%
						if (bookDto.getBookNo() == bookList.get(i).getBookNo()) {
							continue;
						}
					%>
					<a href="<%=root%>/book/bookDetail.jsp?no=<%=bookList.get(i).getBookNo()%>">
						<%if (bookList.get(i).getBookImage().startsWith("https")) {%> 
							<img title="<%=bookList.get(i).getBookTitle()%>"
							src="<%=bookList.get(i).getBookImage()%>"
							class="same-author-book-img"> 
						<%} else {%> 
							<img title="<%=bookList.get(i).getBookTitle()%>"
							class="same-author-book-img"
							src="<%=root%>/book/bookImage.kh?bookNo=<%=bookList.get(i).getBookNo()%>">
						<% } %>
					</a>
				<% } %>
			<% } %>
		</div>
	</div>
	
	<hr>
	
	<div class="row text-left book-detail-semi-box2">
		<div class="book-detail-semi-title2">
			<span><%=bookDto.getBookPublisher()%></span> <span
				class="book-detail-semi-title2-highlight"> 출판사의 다른 책</span>
		</div>
		<div class="book-detail-semi-image-box">

			<%if (bookList2.size() < 5) {%>
				<%for (int i = 0; i < bookList2.size(); i++) {%>
					<%
						if (bookDto.getBookNo() == bookList2.get(i).getBookNo()) {
							continue;
						}
					%>
					<a href="<%=root%>/book/bookDetail.jsp?no=<%=bookList2.get(i).getBookNo()%>">
						<%if (bookList2.get(i).getBookImage().startsWith("https")) {%> 
							<img title="<%=bookList2.get(i).getBookTitle()%>"
							src="<%=bookList2.get(i).getBookImage()%>"
							class="same-author-book-img">
						<%} else {%> 
							<img title="<%=bookList2.get(i).getBookTitle()%>"
							class="same-author-book-img"
							src="<%=root%>/book/bookImage.kh?bookNo=<%=bookList2.get(i).getBookNo()%>">
						<% } %>
					</a>
				<% } %>
			<%} else { %>
			<%for (int i = 0; i < 4; i++) { %>
			<%
				if (bookDto.getBookNo() == bookList2.get(i).getBookNo()) {
					continue;
				}
				%>
				<a href="<%=root%>/book/bookDetail.jsp?no=<%=bookList2.get(i).getBookNo()%>">
					<%if (bookList2.get(i).getBookImage().startsWith("https")) {%> 
						<img title="<%=bookList2.get(i).getBookTitle()%>"
						src="<%=bookList2.get(i).getBookImage()%>"
						class="same-author-book-img"> 
					<%} else { %> 
						<img title="<%=bookList2.get(i).getBookTitle()%>"
						class="same-author-book-img"
						src="<%=root%>/book/bookImage.kh?bookNo=<%=bookList2.get(i).getBookNo()%>">
					<% } %>
				</a>
				<% } %>
			<% } %>
		</div>
	</div>
	
	<hr>
	
	<div class="row text-left book-detail-semi-box2">
		<div class="book-detail-semi-title2">
			<span><%=genreDto.getGenreName()%></span> <span
				class="book-detail-semi-title2-highlight"> 장르의 다른 책</span>
		</div>
		<div class="book-detail-semi-image-box">
			<%if (bookList3.size() < 5) {%>
				<%for (int i = 0; i < bookList3.size(); i++) {%>
					<%
					if (bookDto.getBookNo() == bookList3.get(i).getBookNo()) {
						continue;
					}
					%>
					<a href="<%=root%>/book/bookDetail.jsp?no=<%=bookList3.get(i).getBookNo()%>">
						<%if (bookList3.get(i).getBookImage().startsWith("https")) {%> 
							<img title="<%=bookList3.get(i).getBookTitle()%>"
							src="<%=bookList3.get(i).getBookImage()%>"
							class="same-author-book-img"> 
						<%} else { %>
							<img title="<%=bookList3.get(i).getBookTitle()%>"
							class="same-author-book-img"
							src="<%=root%>/book/bookImage.kh?bookNo=<%=bookList3.get(i).getBookNo()%>">
						<% } %>
					</a>
				<% } %>
			<%} else {%>
				<%for (int i = 0; i < 4; i++) {%>
					<%
					if (bookDto.getBookNo() == bookList3.get(i).getBookNo()) {
						continue;
					}
					%>
					<a href="<%=root%>/book/bookDetail.jsp?no=<%=bookList3.get(i).getBookNo()%>">
						<%if (bookList3.get(i).getBookImage().startsWith("https")) { %>
							<img title="<%=bookList3.get(i).getBookTitle()%>"src="<%=bookList3.get(i).getBookImage()%>" class="same-author-book-img"> 
						<%} else { %> 
							<img title="<%=bookList3.get(i).getBookTitle()%>"
							class="same-author-book-img"
							src="<%=root%>/book/bookImage.kh?bookNo=<%=bookList3.get(i).getBookNo()%>">
						<% } %>
					</a>
				<% } %>
			<% } %>
		</div>
		<hr>
	</div>
	
	<div class="row text-left book-detail-semi-box2">
		<div class="book-detail-semi-title2">
			<span>BOOK 리뷰</span>
		</div>
		<!-- 리뷰 -->
		<!-- 		어떤책에 누가 리뷰번호,리뷰내용,평점,작성시간 넣을 수 있음 -->
		<%if (isPurchase && (isReview == false)) {%>
		<div class="review-regit-reply" >
			<!-- 			보내야할 정보 책,작성자번호,리뷰내용,평점 -->
			<div class="review-row">
				<div style="display:inline-block; width:75%;">
					<form action="<%=root%>/review/reviewInsert.kh" class="review_input_form" method="post">
						<div class="row">
							<img id="star1" class="star" src="<%=root%>/image/star_on.png">
							<img id="star2" class="star" src="<%=root%>/image/star_off.png">
							<img id="star3" class="star" src="<%=root%>/image/star_off.png">
							<img id="star4" class="star" src="<%=root%>/image/star_off.png">
							<img id="star5" class="star" src="<%=root%>/image/star_off.png">
						</div>
						<textarea required name="review_content" placeholder="리뷰를 남겨보세요" rows="3" class="review_inbox_text insert" style="overflow: hidden; overflow-wrap: break-word; height: 20px;" required></textarea>
						<!--  <label>평점</label>   -->
						<input type="hidden" name="review_rate" value="1" id="review_rate">
						<input type="hidden" name="review_book" value="<%=no%>"> 
						<input type="hidden" name="review_member" value="<%=member%>"> 
						
					</form>
				</div>
				<div class="text-center" style="display:inline-block; width:20%; vertical-align: top; margin-top: 54px;">
					<input id="review_insert_button" class="form-btn form-btn-positive btn" style="width:56%; height:50px; font-size:16px;" type="button" value="등록">
				</div>				
			</div>
		</div>
		<% } %>
		
		<%MemberDao memberDao = new MemberDao();%>
		<%if (reviewCount > 0) {%>
			<%for (BookReviewDto bookReviewDto : reviewList) {%>
				<!-- 처음에 보여줘야 할 부분  -->
				<div class="row" class="non-hidden"	id="beforeEdit<%=bookReviewDto.getReviewNo()%>"	style="padding-bottom: 15px;">
					<div style="display: inline-block; width:20%; vertical-align: top; margin-top: 3px; margin-right: 15px;">
						<%int reviewRate = bookReviewDto.getReviewRate();%>
						<%for (int i = 0; i < reviewRate; i++) {%>
							<img src="<%=root%>/image/star_on.png">
						<%}%>
						<%for (int i = 0; i < 5 - reviewRate; i++) {%>
							<img src="<%=root%>/image/star_off.png">
						<%}%>
					</div>
					<div style="display: inline-block; width:75%;">
						<div style="min-height: 60px;">
							<%=bookReviewDto.getReviewContent()%>
						</div>
						<div style="display: inline-block; width: 45%;">
							<%MemberDto memberDto = memberDao.getMember(bookReviewDto.getReviewMember());%>
							<span style="font-size: 14px; margin-right:10px;"><%=memberDto.getMemberId()%></span>	
							<span style="font-size: 14px; margin-right:10px;"><%=bookReviewDto.getReviewTime()%></span>							
						</div>						
						<%if (bookReviewDto.getReviewMember() == member) {%>
							<div style="display: inline-block; width: 45%;" class="text-right">
								<input class="edit_button form-btn form-btn-normal btn" style="width:45px;" type="button" data-reviewno="<%=bookReviewDto.getReviewNo()%>" value="수정">
																
								<form action="<%=root %>/review/reviewDelete.kh" style="display:inline;"> 
									<input type="hidden" name="book_no"	value="<%=bookReviewDto.getReviewBook()%>">
									<input type="hidden" name="review_no" value="<%=bookReviewDto.getReviewNo()%>">
									<input type="submit" class="form-btn form-btn-negative btn" id="delete-review-btn" value="삭제" style="width:45px;">
								</form>	
							</div>							
						<%}%>						
					</div>
				</div>
		
				<img class="img-1" src="">
				<%if (bookReviewDto.getReviewMember() == member) {%>
					<!-- 숨겨놨다가 수정 버튼을 누르면 보여줘야 할 부분   -->
					<div class="review-regit-reply afterEdit hidden" id="afterEdit<%=bookReviewDto.getReviewNo()%>" >
						<div class="review-row">
							<div style="display:inline-block; width:75%;">
								<form action="<%=root%>/review/reviewEdit.kh" class="review_edit_form" method="post">
									<input type="hidden" name="review_no" value="<%=bookReviewDto.getReviewNo()%>">
									<div class="row">
										<%int editRate = bookReviewDto.getReviewRate();%>
										<%int starCnt = 1; %>
										<%for (int i = 0; i < editRate; i++) {%>
											<img id="star<%=starCnt %>" class="star" src="<%=root%>/image/star_on.png">
											<%starCnt++; %>
										<%}%>
										<%for (int i = 0; i < 5 - editRate; i++) {%>
											<img id="star<%=starCnt %>" class="star" src="<%=root%>/image/star_off.png">
											<%starCnt++; %>
										<%}%>
									</div>
									<textarea required name="review_content" placeholder="<%=bookReviewDto.getReviewContent()%>" rows="3" class="review_inbox_text edit" style="overflow: hidden; overflow-wrap: break-word; height: 20px;" required></textarea>
									<input type="hidden" name="review_rate" value="<%=bookReviewDto.getReviewRate()%>" id="review_rate">
									<input type="hidden" name="review_book"	value="<%=bookReviewDto.getReviewBook()%>">									
									<input type="hidden" name="review_member"	value="<%=bookReviewDto.getReviewMember()%>">
								</form>
							</div>
							<div class="text-center" style="display:inline-block; width:20%; vertical-align: top; margin-top: 49px;">
								<input type="button" class="form-btn form-btn-normal btn" id="review_edit_button" value="수정" style="width:45px; height:35px;">
								<input class="cancle_button form-btn form-btn-negative btn" type="button" data-reviewno="<%=bookReviewDto.getReviewNo()%>" value="취소" style="width:45px; height:35px; margin-right: 20px;"> 			
							</div>				
						</div>
					</div>
				<%}%>
			<%}%>
		<%} else {%>
			<div class="row text-center">
				<div class="row" style="height: 100px;">
					<span style="color: lightgray;">작성된 리뷰가 없습니다.</span>
				</div>
			</div>
		<%}%>


		<!-- 페이지 네이션 -->
		<div class="pagination text-center">

			<%if (startBlock > 1) {%>
			<a class="move-link">이전</a>
			<%}%>
			<%for (int i = startBlock; i <= endBlock; i++) {%>
				<%if (i == pageNo) {%>
					<a class="on"><%=i%></a>
				<%} else {%>
					<a><%=i%></a>
				<%}%>
			<%}%>
			<%if (endBlock < lastBlock) {%>
				<a class="move-link">다음</a>
			<%}%>
		</div>

		<form class="page-form" action="bookDetail.jsp?no=<%=no%>"
			method="post">
			<input type="hidden" name="pageNo">
		</form>

	</div>
</div>

<script>
	function foo() {
		alert("장바구니에 담겼습니다.");
	};
	function foo2() {
		alert("로그인 후 이용 가능합니다.");
	};
	
	window.addEventListener("load",function(){
		js_purchase_btn = document.querySelector(".js_purchase_btn")
		
		js_purchase_btn.addEventListener("click",function(e){
			console.dir(this)
			<%if(session.getAttribute("member")!=null){%>
				this.href+="&amount="+document.getElementById("cartAmount").value;
			<%}else{ %>
			alert("로그인 후 이용 가능합니다.");
			
			<%}%>
		})
	})
	function gotoCart(){
		document.querySelector(".cartInsertForm").submit();
		alert("장바구니에 담겼습니다.");
	}
</script>

<jsp:include page="/template/footer.jsp"></jsp:include>
