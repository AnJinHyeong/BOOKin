<%@page import="java.util.ArrayList"%>
<%@page import="semi.beans.GenreDto"%>
<%@page import="java.util.List"%>
<%@page import="semi.beans.GenreDao"%>
<%@page import="semi.beans.BookDto"%>
<%@page import="semi.beans.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	long no = Long.parseLong(request.getParameter("no"));
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

%>
<%
	int price=bookDto.getBookPrice();
	int discount=bookDto.getBookDiscount();
	int priceDif=price-discount;
	int discountPercent=price/priceDif;
%>
<jsp:include page="/template/header.jsp"></jsp:include>

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
		<div class="book-image-box"><img title="<%=bookDto.getBookTitle()%>" src="<%=bookDto.getBookImage()%>" class="book-image"></div>
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
					<div>
						<span>인문학 주간 2위, 종합 top100</span><span class="detail-etc-text-highlight">  2주</span>
						<span>&emsp;|&emsp;Sales Point : </span><span class="detail-etc-text-highlight">29,900</span>
					</div>
					<span class="star-image-box">
						<span><img src="<%=root %>/image/star-solid.svg" class="star-image"></span>
						<span><img src="<%=root %>/image/star-solid.svg" class="star-image"></span>
						<span><img src="<%=root %>/image/star-solid.svg" class="star-image"></span>
						<span><img src="<%=root %>/image/star-solid.svg" class="star-image"></span>
						<span><img src="<%=root %>/image/star-half-solid.svg" class="star-image"></span>
						<span class="site-color-red detail-etc-text-highlight">8.8</span>
					</span>
	
					<span>
						&emsp;100자평(5)
					</span>
					<span>
						&emsp;리뷰(0)&emsp;
					</span>
					<span class="blue-box">
						이 책 어때요?
					</span>
				</div>
				<div class="payment-text-box">
					<div class="payment-text">카드/간편결제 할인 &gt;</div>
					<div class="payment-text">무이자 할부 &gt;</div>
					<div class="payment-text">소득공제 690원</div>
				</div><br><br><br>
				<div>
					<span>수량&emsp;&emsp;&emsp;</span>
					<span>
						 <span><button type="button" name="button"onclick="minus()"><img src="<%=root %>/image/minus-solid.svg" alt="minus" class="amount-image"/></button></span>
                <span><input type="text" name="name" value="0" size="10" id="count" class="text-center"></span>
                <span><button type="button" name="button"onclick="plus()"><img src="<%=root %>/image/plus-solid.svg" alt="plus" class="amount-image"/></button></span>
					</span>
				</div>
				<div class="payment-button-box">
					<div class="payment-button"><a href="#" class="payment-button-text">장바구니 담기</a></div>
					<div class="payment-button"><a href="#" class="payment-button-text">바로구매</a></div>
					<div class="payment-button"><a href="#" class="payment-button-text-red">보관함+</a></div>
					<div class="payment-button"><a href="#" class="payment-button-text-red">선물하기</a></div>
					
				</div><br><br><br>
				<div class="secondHand-text-box">
					<div class="secondHand-text">전자책 출간알림 신청 &gt;</div>
					<div class="secondHand-text">중고 등록알림 신청 &gt;</div>
					<div class="secondHand-text">중고로 팔기 &gt;</div>
				</div><br><br><br>
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
	<%-- <div class="row text-left book-detail-semi-box">
		<div class="book-detail-semi-title"><span>이벤트</span></div>
		<div class="book-detail-semi-subtitle">
			<div class="event-image"><img src="<%=root%>/image/event1.PNG"></div>
			<div class="event-image"><img src="<%=root%>/image/event2.PNG"></div>
			<div class="event-image"><img src="<%=root%>/image/event3.PNG"></div>
		</div>
	</div> --%>
	<div class="row text-left book-detail-semi-box2">
		<div class="book-detail-semi-title2">
		<span ><%=bookDto.getBookAuthor() %></span>
		<span class="book-detail-semi-title2-highlight"> 작가의 다른 책</span> 
		
		</div>
		<div class="book-detail-semi-image-box">
			<%if(bookList.size()<5){ %>
				<%for(int i=0;i<bookList.size();i++){ %>
					<%if(bookDto.getBookNo()==bookList.get(i).getBookNo()){ continue;}%>
					
					 
				<a href="#"><img title="<%=bookList.get(i).getBookTitle() %>" src="<%=bookList.get(i).getBookImage() %>" class="same-author-book-img"></a>
				<%} %> 
				
			<%}else{ %>
				<%for(int i=0;i<4;i++){ %>
				<%if(bookDto.getBookNo()==bookList.get(i).getBookNo()){ continue;}%>
				<a href="#"><img title="<%=bookList.get(i).getBookTitle() %>" src="<%=bookList.get(i).getBookImage() %>" class="same-author-book-img"></a>
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
					
					 
				<a href="#"><img title="<%=bookList2.get(i).getBookTitle() %>" src="<%=bookList2.get(i).getBookImage() %>" class="same-author-book-img"></a>
				<%} %> 
				
			<%}else{ %>
				<%for(int i=0;i<4;i++){ %>
				<%if(bookDto.getBookNo()==bookList2.get(i).getBookNo()){ continue;}%>
				<a href="#"><img title="<%=bookList2.get(i).getBookTitle() %>" src="<%=bookList2.get(i).getBookImage() %>" class="same-author-book-img"></a>
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
					
					 
				<a href="#"><img title="<%=bookList3.get(i).getBookTitle() %>" src="<%=bookList3.get(i).getBookImage() %>" class="same-author-book-img "></a>
				<%} %> 
				
			<%}else{ %>
				<%for(int i=0;i<4;i++){ %>
				<%if(bookDto.getBookNo()==bookList3.get(i).getBookNo()){ continue;}%>
				<a href="#"><img title="<%=bookList3.get(i).getBookTitle() %>" src="<%=bookList3.get(i).getBookImage() %>" class="same-author-book-img "></a>
				<%} %>
			<%} %>
		</div>
		<hr>
	</div>
	
	
</div>

<script>
var count = 1;
var countEl = document.getElementById("count");
function plus(){
    count++;
    countEl.value = count;
}
function minus(){
    if (count > 1) {
        count--;
        countEl.value = count;
    }
}
</script>

<jsp:include page="/template/footer.jsp"></jsp:include>
