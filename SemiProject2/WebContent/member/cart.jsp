<%@page import="semi.beans.GenreDto"%>
<%@page import="semi.beans.GenreDao"%>
<%@page import="semi.beans.CartDto"%>
<%@page import="semi.beans.BookDto"%>
<%@page import="java.util.List"%>
<%@page import="semi.beans.BookDao"%>
<%@page import="semi.beans.MemberDto"%>
<%@page import="semi.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String root = request.getContextPath();
	
%>
<%	

	int member;
	try{
		member = (int)session.getAttribute("member");
	}
	catch(Exception e){
		member = 0;
	}

	CartDto cartDto = new CartDto();
	
%>


<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	
</script>
<jsp:include page="/template/header.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="<%=root%>/css/myInfoLayout.css">
<link rel="stylesheet" type="text/css" href="<%=root%>/css/template.css">

<style>
.container-1000 { width:1000px; }
.cart-t {
	padding: 0 0 45px 0;
	font-size: 40px;
	color: #ff7d9e;
	text-align: center;
}
margin-left: 10px;}
.cart-contents {
	margin: 0 auto;
	width: 1400px;
}
.cart {
	width: 1200px;
	min-height: 535px;
}	
.step {
	margin: -12px 0 72px 0;
	text-align: center;
}
ol, ul {
	list-style: none;
}
.step > li {
	display: inline-block;
	width: 114px;
	height: 114px;
	text-align: left;
	text-indent: -9999px;
	background: url('../image/cart-step.png') no-repeat 0 100%;
}
.cart-con {
	margin: 0 auto;
	position: relative;
	width: 1150px;
}
.cart-left {
	width: 820px;
}
.cart-table {
	margin: 0 0 22px 0;
}
.cs-form {
	display: inline-block;
	position: relative;
	vertical-align: middle;
}
.cart-table table td {
	height: 36px;
	font-size: 14px;
	color: #010101;
	line-height: 1.4;
	border-bottom: solid 1px #e8e8e8;
	padding: 16px 5px;
}
.cart-table table thead th {
	height: 42px;
	font-size: 16px;
	color: #010101;
	text-align: center;
	border-top: solid 2px #000;
	border-bottom: solid 1px #9d9d9d;
	
}
.tleft {
	text-align: left;
}
table {
	border-collapse: collapse;
	border-spacing: 0;
}
.bookimg {
	
	width: 120px;
}
.product-info > *{
	display: inline-block;
	vertical-align: middle;
}
.info {
	width: 280px;
	font-size: 14px;
}
.tit {
	margin: 0 0 6px 0;
	font-size: 16px;
}
.txt {
	margin: 0 0 18px 0;
	color: #484848;
}
.cart-count {
	display: inline-blockblock;
	position: relative;
	width: 71px;
	text-align: center;
	margin-left: 9px;
}
.c1 {
	margin: 0 0 12px 0;
	display: block;
	color: #848484;
	
}
.c2 {
	margin: 0;
	display: block;
	color: #000;
}
.btnbox {
	margin: 0 0 33px 0;
}
.btnbox.right {
	text-align: right;
}
.dash-list {
	padding: 10px 0 18px 34px;
	background: #fff5f6;
	text-align: left;
	
}
.cart-right {
	position: absolute;
	right: 0;
	top: 0;
	width: 300px;
	
}
.paybox {
	top: 0;
	width: 346px;
	position: relative;
	margin-left: 0px;
}
.cart-top {
	margin: 0 0 22px 0;
	padding: 40px 44px 48px 44px;
	background: #f6f6f6;
}
.cart-price {
	margin: 0 0 36px 0;
	font-size: 17px;
	color: #ff7d9e;
}
#cart-total-price,
#del-price,
#cart-total-discount {
	color: #7e7e7e;
	text-align: right;
}
.btn-m-red,
.btn-m-line {
	width: 100%;
	height: 60px;
	
}

.btn-m-red span,
.btn-m-line span {
	width: 100%;
	height: 60px;
	font-size: 18px;
	line-height: 60px;
	min-width: 150px;
	display: block;
	box-sizing: border-box;
}
.btn-m-red span {
	color: #fff;
	background: #ff7d9e;
}
.btn-m-line span {
	color: #ff7d9e;
	border-color: #ff7d9e;
	border: solid 1px #bebebe;
	background: #fff;
	padding: 0 10px;
}
[class^="btn0m"] span {
	padding: 0 10px;
	min-width: 150px;
	text-align: center;
	border-radius: 10px;
	cursor: pointer;
	
}

.cart-count input {
	padding: 0;
	width: 25px;
	height: 33px;
	font-size: 12px;
	color: #000;
	text-align: center;
	border: solid 1px #acacac;
	border-radius: 2px;
}
.cart-count {
	
}

</style>

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
	<!-- 주문 현황 영역 -->
	<div class="container-1200 myInfo-header">
		<dl class="bottom" style="padding-bottom:55px;">
		<dt>주문현황</dt>
		<dd>
			<div class="tit">0</div>
			<div class="txt">주문접수</div>
		</dd>
		<dd class="bottom-next">
			<img src="<%=root %>/image/myInfo_next.png" width="30px" height="30px">
		</dd>
		<dd>
			<div class="tit">0</div>
			<div class="txt">결제완료</div>
		</dd>
		<dd class="bottom-next">
			<img src="<%=root %>/image/myInfo_next.png" width="30px" height="30px">
		</dd>
		<dd>
			<div class="tit">0</div>
			<div class="txt">상품준비중</div>
		</dd>
		<dd class="bottom-next">
			<img src="<%=root %>/image/myInfo_next.png" width="30px" height="30px">
		</dd>
		<dd>
			<div class="tit">0</div>
			<div class="txt">출고시작</div>
		</dd>
		<dd class="bottom-next">
			<img src="<%=root %>/image/myInfo_next.png" width="30px" height="30px">
		</dd>
		<dd> 
			<div class="tit">0</div>
			<div class="txt">배송중</div>
		</dd>
		<dd class="bottom-next">
			<img src="<%=root %>/image/myInfo_next.png" width="30px" height="30px">
		</dd>
		<dd>
			<div class="tit">0</div>
			<div class="txt">거래완료</div>
		</dd>
	</dl>
	</div>
	<main class="myInfo-main">		
		<!-- 사이드영역 -->
		<aside class="myInfo-aside">
			<h2 class="tit">MYPAGE</h2>
			<ul class="menu" >
				<li><a href="myInfo_check.jsp" id="edit-info">회원정보 수정 / 탈퇴</a></li>
				<li><a href="#">주문목록 / 배송조회</a></li>
				<li><a href="#">리뷰관리</a></li>				
				<li><a href="#">배송지 / 환불계좌 관리</a></li>
				<li><a href="#">고객센터</a></li>
				<li class="on"><a href="#">장바구니</a></li>
				<li><a href="#">좋아요</a></li>
			</ul>
		</aside>
		<!-- 장바구니 -->
		<section class="container-1000">
			<article>
			<div class="cart-contents">
				<h2 class="cart-t">장바구니</h2>
				<div class="cart">
				
					<div class="cart-con">
						<div class="cart-left">
							<div class="order-list">
								<form class="goods-form"></form>
								<!-- 삭제 금지 -->
								<input type="hidden" name="promotion-state"value="">
								<div class="cart-table">
									<table style="margin-left: 10px;">
										<caption>장바구니</caption>
										<colgroup>
											<col style="width: 11%">
											<col style="width: 56%">
											<col style="width: 14%">
											<col style="width: 20%">
											<col style="width: 12%">	
										</colgroup>
										<thead>
											<tr>
												<th scope="col">
													<span class='cs-form round'>
														<!-- 누르면 차트에 있는 상품 모두 클릭 -->
														<input id="allCheck" type="checkbox" checked="">
														<!-- <label for="allCheck">선택</label> -->
													</span>
												</th>
												<th scope="col">주문상품정보</th>
												<th scope="col">수량</th>
												<th scope="col">가격</th>
												<th scope="col"><!-- 공백 --></th>
											</tr>
										</thead>
										<tbody>
											
											<tr class="goods-form">
												<td>
													<span class="cs-form round">
														<input type="checkbox" checked="">
														<!-- <label>선택</label> -->
													</span>
												</td>												
												<td class="tleft">		
													<div class="product-info">
														<div class="bookimg">
															<a href="/bookDetail.jsp?" class="book-img-a">
																책이미지
															</a>
														</div>
														<div class="info">
															
															<div class="tit">
																<%=cartDto.getBookNo() %>
																
															</div>
															
														</div>
													</div>
													
												</td>
												
												<!-- 수량체크부분 -->
												<td>
													<div class="cart-count">
														<span><button type="button" name="button"onclick="minus()"><img src="<%=root %>/image/minus-solid.svg" alt="minus" class="amount-image"/></button></span>
										               	 <span><input type="text" name="cartAmount" value="1" size="1" id="count" class="text-center"></span>
										                <span><button type="button" name="button"onclick="plus()"><img src="<%=root %>/image/plus-solid.svg" alt="plus" class="amount-image"/></button></span>
													</div>
												</td>
												
												<!-- 가격부분 -->
												<td>
													<span class="c1">
														원래가격
													</span>
													<span class="c2">
														할인가격
													</span>
												</td>
											
												<!-- 삭제버튼 -->
												<td>
													<button class="btn-del" type="button">X</button>
												</td>												
											</tr>
										</tbody>
									</table>
								</div>
								<ul class="btnbox right">
									<li>
										<button class="btn-s-black" type="button">
											<span>선택상품 삭제</span>
										</button>
									</li>
									<li>
										<button class="btn-s-black" type="button">
											<span>전체상품 삭제</span>
										</button>
									</li>
								</ul>
								
							</div>
						</div>
						<!-- //left -->
						
						<div class="cart-right">
							<div id="paybox" class="paybox" style="position: relative; margin-left: 0px;">
								<div class="cart-top">
									<div class="tit">결제금액</div>
									<div class="cart-price">
										<strong>13,000</strong>원
									</div>
									
									<ul class="info">
										<li>
											<span class="c1">총 상품금액</span>
											<span class="c2">
												<span id="cart-total-price" >10,500</span>원
											</span>
										</li>
										<li>
											<span class="c1">배송비</span>
											<span class="c2">
												<span id="del-price" >2,500</span>원
											</span>
										</li>
										<li>
											<span class="c1">할인금액</span>
											<span class="c2">
												<span id="cart-total-discount">0</span>원
											</span>
										</li>
									</ul>
								</div>
								
								<ul class="btnbox">
									<li>
										<button class="btn-m-red" type="button">
											<span>전체상품 주문하기</span>
										</button>
									</li>
									<li>
										<button class="btn-m-line" type="button" >
											<span>선택상품 주문하기</span>
										</button>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<!-- //cart-con -->
				</div>
				<!-- //cart -->
			</div>
			<!-- //contanier-800 -->
			</article>
		</section>		
	</main>
<jsp:include page="/template/footer.jsp"></jsp:include>