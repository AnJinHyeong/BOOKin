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
	if(bookDto.getBookImage()==null){
		bookDto.setBookImage(root+"/image/nullbook.png");
	}
	
	GenreDao genreDao=new GenreDao();
	GenreDto genreDto=genreDao.get(bookDto.getBookGenreNo());
	GenreDto genreDto2;
	GenreDto genreDto1=genreDao.get(genreDao.get(genreDto.getGenreParents()).getGenreNo());
	if(genreDao.get(genreDto1.getGenreParents())!=null){
	genreDto2=genreDao.get(genreDao.get(genreDto1.getGenreParents()).getGenreNo());
	}else{
		genreDto2=null;
	}
	List<BookDto> bookList=bookDao.authorSearch(bookDto.getBookAuthor(),1,10);
	List<BookDto> bookList2=bookDao.publisherSearch(bookDto.getBookPublisher(),1,10);
	List<BookDto> bookList3=bookDao.genreSearch(bookDto.getBookGenreNo());
	List<GenreDto> genreList=genreDao.sameGenreList(bookDto.getBookGenreNo());
	
	bookDao.bookView((int)no);
	
	
%>
<%
	int price=bookDto.getBookPrice();
	int discount=bookDto.getBookDiscount();
	int priceDif=price-discount;
	int discountPercent=(int)(((double)priceDif/(double)price)*(100.0));
%>
<%
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
		pageSize = 5;//기본값 15개
	}
	
	//rownum의 시작번호(startRow)와 종료번호(endRow)를 계산
	int startRow = pageNo * pageSize - (pageSize-1);
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
	
	if(endBlock > lastBlock){//범위를 벗어나면
		endBlock = lastBlock;//범위를 수정
	}
	
%>
<%
	int bookNo = (int)Long.parseLong(request.getParameter("no"));

	int member;
	try{
		member = (int)session.getAttribute("member");
	}
	catch(Exception e){
		member = 0;
	}
	
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
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
			<img title="<%=bookDto.getBookTitle()%>" src="<%=bookDto.getBookImage()%>" class="book-image">
			<%}else{ %>
			<img title="<%=bookDto.getBookTitle() %>" class="book-image" src="<%=root%>/book/bookImage.kh?bookNo=<%=bookDto.getBookNo()%>">
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
					
					
					<form action="<%=root %>/member/cartInsert.kh" method="post" onsubmit="foo();">
						<div class="row">
							<span style="width: 50px; text-align: left;">수량</span>
							<input type="number" name="cartAmount" value="1" min="1" style="margin: 0 0 0 40px; height: 30px; width: 150px;" id="cartAmount">
							<span class="book-price"></span>							
						</div><br>
						<input type="hidden" name="memberNo" value="<%=member %>">
						<input type="hidden" name="bookNo" value="<%=no %>">
						<div style="display:flex; margin-top:30px;">
							<div style="float: left; padding-left: 15px; ">
								<span class="payment-button" style="background-color:rgb(223,48,127); padding: 1rem 3rem;">
								<a href="<%=root %>/purchase/purchase.jsp?no=<%=bookDto.getBookNo()%>" class="payment-button-text js_purchase_btn">바로구매</a>
								</span> 
							</div>
							<div style="float: right; padding-right: 15px;">
		                		<span class="payment-button" style="background-color:rgb(226,68,87); padding: 1rem 3rem;"><input type="submit" value="장바구니 담기" class="cart-btn"></span>
							</div>
						</div>

					</form>
				
				</div><br><br>
				
		</div>
		
	</div>
	<hr>
	
	<div class="row text-left book-detail-semi-box">
		<div class="book-detail-semi-title" ><span>기본정보</span></div>
		<div class="book-detail-semi-subtitle">
			<div class="book-detail-semi-subtitle-text">주제분류</div><br>
			<div>
				<% if (genreDto2==null){ %>
					<%=genreDto1.getGenreName() %> &gt;<%= genreDto.getGenreName()%>
				<%}else{ %>
				
	    		 <%=genreDto2.getGenreName() %> &gt;
				<%=genreDto1.getGenreName() %> &gt;
				<%=genreDto.getGenreName() %>
				<% }%>
			</div>
		</div>
	</div>
	<hr> 
	
	<div class="row text-left book-detail-semi-box"> 
		<div class="book-detail-semi-title"><span>책소개</span></div>
		<div class="book-detail-semi-subtitle"><%=bookDto.getBookDescription()%></div>
	</div>
	<hr>
	
	<div class="row text-left book-detail-semi-box2">
		<div class="book-detail-semi-title2">
		<span ><%=bookDto.getBookAuthor() %></span>
		<span class="book-detail-semi-title2-highlight"> 작가의 다른 책</span> 
		
		</div>
		<div class="book-detail-semi-image-box">
			<%if(bookList.size()<5){ %>
				<%for(int i=0;i<bookList.size();i++){ %>
					<%if(bookDto.getBookNo()==bookList.get(i).getBookNo()){ continue;}%>
					
					 
				<a href="<%=root %>/book/bookDetail.jsp?no=<%=bookList.get(i).getBookNo()%>">
				<%if(bookList.get(i).getBookImage().startsWith("https")){ %>
				<img title="<%=bookList.get(i).getBookTitle() %>" src="<%=bookList.get(i).getBookImage() %>" class="same-author-book-img">
				<%}else{ %>
				<img title="<%=bookList.get(i).getBookTitle() %>" class="same-author-book-img" src="<%=root%>/book/bookImage.kh?bookNo=<%=bookList.get(i).getBookNo()%>">
				<%} %>
				
				
				</a>
				<%} %> 
				
			<%}else{ %>
				<%for(int i=0;i<4;i++){ %>
				<%if(bookDto.getBookNo()==bookList.get(i).getBookNo()){ continue;}%>
				<a href="<%=root %>/book/bookDetail.jsp?no=<%=bookList.get(i).getBookNo()%>">
				
				<%if(bookList.get(i).getBookImage().startsWith("https")){ %>
				<img title="<%=bookList.get(i).getBookTitle() %>" src="<%=bookList.get(i).getBookImage() %>" class="same-author-book-img">
				<%}else{ %>
				<img title="<%=bookList.get(i).getBookTitle() %>" class="same-author-book-img" src="<%=root%>/book/bookImage.kh?bookNo=<%=bookList.get(i).getBookNo()%>">
				<%} %>
				
				</a>
				<%} %>
			<%} %>
			
		 
		</div>
	</div>
	<hr>
	<div class="row text-left book-detail-semi-box2">
		<div class="book-detail-semi-title2">
		<span><%=bookDto.getBookPublisher() %></span>
		<span class="book-detail-semi-title2-highlight"> 출판사의 다른 책</span> 
		
		</div>
		<div class="book-detail-semi-image-box">
		
			 <%if(bookList2.size()<5){ %>
				<%for(int i=0;i<bookList2.size();i++){ %>
					<%if(bookDto.getBookNo()==bookList2.get(i).getBookNo()){ continue;}%>
					
					 
				<a href="<%=root %>/book/bookDetail.jsp?no=<%=bookList2.get(i).getBookNo()%>">
				
				<%if(bookList2.get(i).getBookImage().startsWith("https")){ %>
				<img title="<%=bookList2.get(i).getBookTitle() %>" src="<%=bookList2.get(i).getBookImage() %>" class="same-author-book-img">
				<%}else{ %>
				<img title="<%=bookList2.get(i).getBookTitle() %>" class="same-author-book-img" src="<%=root%>/book/bookImage.kh?bookNo=<%=bookList2.get(i).getBookNo()%>">
				<%} %>
				
				</a>
				<%} %> 
				
			<%}else{ %>
				<%for(int i=0;i<4;i++){ %>
				<%if(bookDto.getBookNo()==bookList2.get(i).getBookNo()){ continue;}%>
				<a href="<%=root %>/book/bookDetail.jsp?no=<%=bookList2.get(i).getBookNo()%>">
				
				<%if(bookList2.get(i).getBookImage().startsWith("https")){ %>
				<img title="<%=bookList2.get(i).getBookTitle() %>" src="<%=bookList2.get(i).getBookImage() %>" class="same-author-book-img">
				<%}else{ %>
				<img title="<%=bookList2.get(i).getBookTitle() %>" class="same-author-book-img" src="<%=root%>/book/bookImage.kh?bookNo=<%=bookList2.get(i).getBookNo()%>">
				<%} %>
				
				</a>
				<%} %>
			<%} %>
		</div>
	</div>
	<hr>
	<div class="row text-left book-detail-semi-box2">
		<div class="book-detail-semi-title2">
		<span><%=genreDto.getGenreName() %></span>
		<span class="book-detail-semi-title2-highlight"> 장르의 다른 책</span> 
		
		</div>
		<div class="book-detail-semi-image-box">
			<%if(bookList3.size()<5){ %>
				<%for(int i=0;i<bookList3.size();i++){ %>
					<%if(bookDto.getBookNo()==bookList3.get(i).getBookNo()){ continue;}%>
					
					 
				<a href="<%=root %>/book/bookDetail.jsp?no=<%=bookList3.get(i).getBookNo()%>">
				
				<%if(bookList3.get(i).getBookImage().startsWith("https")){ %>
				<img title="<%=bookList3.get(i).getBookTitle() %>" src="<%=bookList3.get(i).getBookImage() %>" class="same-author-book-img">
				<%}else{ %>
				<img title="<%=bookList3.get(i).getBookTitle() %>" class="same-author-book-img" src="<%=root%>/book/bookImage.kh?bookNo=<%=bookList3.get(i).getBookNo()%>">
				<%} %>
				
				</a>
				<%} %> 
				
			<%}else{ %>
				<%for(int i=0;i<4;i++){ %>
				<%if(bookDto.getBookNo()==bookList3.get(i).getBookNo()){ continue;}%>
				<a href="<%=root %>/book/bookDetail.jsp?no=<%=bookList3.get(i).getBookNo()%>">
				
				<%if(bookList3.get(i).getBookImage().startsWith("https")){ %>
				<img title="<%=bookList3.get(i).getBookTitle() %>" src="<%=bookList3.get(i).getBookImage() %>" class="same-author-book-img">
				<%}else{ %>
				<img title="<%=bookList3.get(i).getBookTitle() %>" class="same-author-book-img" src="<%=root%>/book/bookImage.kh?bookNo=<%=bookList3.get(i).getBookNo()%>">
				<%} %>
				
				</a>
				<%} %>
			<%} %>
		</div>
		<hr>
	</div>
	<div class="row text-left book-detail-semi-box2">
		<!-- 리뷰 -->
		<div class="book-detail-semi-title2">
			<span>BOOK 리뷰</span> 
		</div>
		<%if(reviewCount > 0){ %>
			<%for(BookReviewDto bookReviewDto : reviewList){ %>
				<div class="row" style="padding-bottom: 15px;">
					<div class="row">
						<span style="display: none;"><%=bookReviewDto.getReviewRate() %></span>
						<%int reviewRate = bookReviewDto.getReviewRate() ; %>
						<%for(int i=0; i<reviewRate; i++){ %>
							<img src="<%=root%>/image/star_on.png">
						<%} %>
						<%for(int i=0; i<5-reviewRate; i++){ %>
							<img src="<%=root%>/image/star_off.png">
						<%} %>
					</div>
					
					<div class="row text-left">
						<p style="min-height: 40px;"><%=bookReviewDto.getReviewContent() %></p>
					</div>
					
					<div class="row text-left">
						<span style="font-size: 12px;"><%=bookReviewDto.getMemberId() %></span>
						<span style="font-size: 12px;"><%=bookReviewDto.getReviewTime() %></span>
					</div>
				</div>
				
			<%} %>
		<%} else{%>
			<div class="row text-center">
				<div class="row" style="height: 100px; ">
					<span style="color: lightgray;">작성된 리뷰가 없습니다.</span>
				</div>
			</div>
		<%} %>
		
		<!-- 페이지 네이션 -->
		<div class="pagination text-center">
		
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
		
		<form class="page-form" action="bookDetail.jsp?no=<%=no %>" method="post">
			<input type="hidden" name="pageNo">
		</form>
		
	</div>
	
	
</div>



<script>
	function foo(){
		alert("장바구니에 담겼습니다.");
	};
	
	window.addEventListener("load",function(){
		js_purchase_btn = document.querySelector(".js_purchase_btn")
		
		js_purchase_btn.addEventListener("click",function(e){
			console.dir(this)
			this.href+="&amount="+document.getElementById("cartAmount").value;
			
		})
	})
</script>

<jsp:include page="/template/footer.jsp"></jsp:include>
