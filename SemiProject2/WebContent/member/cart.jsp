<%@page import="semi.beans.BookDto"%>
<%@page import="java.util.List"%>
<%@page import="semi.beans.BookDao"%>
<%@page import="semi.beans.MemberDto"%>
<%@page import="semi.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
   String root = request.getContextPath();
   BookDao bookdao = new BookDao();
   List<BookDto> bookList =bookdao.list(1);
   
%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
   
</script>
<jsp:include page="/template/header.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="<%=root%>/css/myInfoLayout.css">
<link rel="stylesheet" type="text/css" href="<%=root%>/css/template.css">

<style>
section{
	display: inline-block;
	width: 80%;	
}

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
   width: 60%;
   min-height: 535px;
   display: inline-block;
   padding-left: 20px;
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
   width: auto;
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
   height: 20px;
   font-size: 14px;
   color: #010101;
   line-height: 1.4;
   border-bottom: solid 1px #e8e8e8;
   padding: 5px 5px;
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
   background: url(/SemiProject/image/pc_good_on.png);   
   width: 92px;
   height: 100px;
   background-repeat: no-repeat;
   background-size: 100px;
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
   text-align: left;
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
	vertical-align: top;
   display:inline-block;
   right: 0;
   top: 0;
   width: 346px;
   
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
   width: 37px;
   height: 33px;
   font-size: 12px;
   color: #000;
   text-align: center;
   border: solid 1px #acacac;
   border-radius: 2px;
}
.cart-checkbox{
	height: 17px;
}
.btn-s-black{
	color: #fff;
    background: #39373a;
    min-width: 85px;
    height: 28px;
    line-height: 26px;
    font-family: 'Noto-M';
    font-size: 12px;
    text-align: center;
    border-radius: 6px;
}
</style>
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
         <div class="txt">상품준비중</div>
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
            <li><a href="<%=root%>/qna/qnaNotice.jsp">고객센터</a></li>
            <li class="on"><a href="cart.jsp">장바구니</a></li>
            <li><a href="bookLike.jsp">좋아요</a></li>
         </ul>
      </aside>
      <section>
      	<header>
      		<h2 class="cart-t">장바구니</h2>
      	</header>
      	<article>
      		<div class="cart cart-table">
      			<table style="margin-left: -11px;">
				<colgroup>
					<col style="width: 7%">
					<col style="width: 50%">
					<col style="width: 21%">
					<col style="width: 20%">
					<col style="width: 12%">   
				</colgroup>
				   <thead> 
					   	<tr> 
					   		<th scope="col" > 
					   			<span class='cs-form round'> <!-- 누르면 차트에 있는 상품 모두 클릭 --> 
					   				<input id="allCheck"  class="cart-checkbox" type="checkbox" checked=""> 
					   				<label for="allCheck"></label> 
					   			</span> 
				   			</th> 
			   				<th scope="col">주문상품정보</th> 
			   				<th scope="col">수량</th> 
			   				<th scope="col">가격</th> 
			   				<th scope="col"></th> 
		   				</tr> 
	   				</thead> 
	   				<tbody> 
	   					<tr class="goods-form"> 
	   						<td rowspan="2" class="text-center"> 
	   							<span class="cs-form round "> 
	   								<input type="checkbox" checked="" class="cart-checkbox" > 
   								</span> 
							</td> 
							<td class="text-center" style="border-bottom:none;"> 
								<div class="bookimg "> 
									<a href="/bookDetail.jsp?" class="book-img-a"></a> 
								</div> 								
							</td>  
							<!-- 수량체크부분  -->
							<td rowspan="2"> 
								<div class="cart-count" style="display:inline-block; width:45%; height:50px;"> 
									<input type="text" title="수량" name="cart-count" value="1"> 									 
								</div> 
								<div style="display:inline-block; width:45%; height:50px;">
									<button class="cart-plus" type="button" style="display:block;">+</button>
									<button class="cart-minus" type="button" style="display:block;">-</button>
								</div>
							</td>  
							<!-- 가격부분 --> 
							<td rowspan="2"> 
								<span class="c1">원래가격</span> 
								<span class="c2">할인가격</span> 
							</td>  
							<!-- 삭제버튼 --> 
							<td rowspan="2" class="text-center"> 
								<button class="btn-del" type="button">삭제</button> 
							</td> 
						</tr> 
						<tr >
							<td class="text-center" >
								<span class="c1">책제목</span>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="text-right" style="margin-top: 20px; margin-right:15px;">
					<input class="btn-s-black" type="button" value="선택상품 삭제"> 
					<input class="btn-s-black" type="button" value="전체상품 삭제">					
				</div>
      		</div>
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
			
      	</article>
      </section>
      <!-- 장바구니 -->
      <!-- <section >
         <article>
         <div class="cart-contents">
            <h2 class="cart-t">장바구니</h2>
            <div class="cart">            
               <div class="cart-con">
                  <div class="cart-left">
                     <div class="order-list">
                        <form class="goods-form"></form>
                        삭제 금지
                        <input type="hidden" name="promotion-state" value="">
                        <div class="cart-table">
                           <table style="margin-left: 10px;">
                              <caption>장바구니</caption>
                              <colgroup>
                                 <col style="width: 11%">
                                 <col style="width: 56%">
                                 <col style="width: 14%">
                                 <col style="width: 16%">
                                 <col style="width: 12%">   
                              </colgroup>
                              <thead>
                                 <tr>
                                    <th scope="col">
                                       <span class='cs-form round'>
                                          누르면 차트에 있는 상품 모두 클릭
                                          <input id="allCheck" type="checkbox" checked="">
                                          <label for="allCheck">선택</label>
                                       </span>
                                    </th>
                                    <th scope="col">주문상품정보</th>
                                    <th scope="col">수량</th>
                                    <th scope="col">가격</th>
                                    <th scope="col">공백</th>
                                 </tr>
                              </thead>
                              <tbody>
                                 <tr class="goods-form">
                                    <td>
                                       <span class="cs-form round">
                                          <input type="checkbox" checked="">
                                          <label>선택</label>
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
                                                
                                             </div>
                                             작품설명
                                          </div>
                                       </div>
                                       
                                    </td>
                                    
                                    수량체크부분
                                    <td>
                                       <div class="cart-count">
                                          <input type="text" title="수량" name="cart-count" value="1">
                                          +누르면 +1 -면 -1
                                          <button class="cart-plus" type="button">+</button>
                                          <button class="cart-minus" type="button">-</button>
                                       </div>
                                    </td>
                                    
                                    가격부분
                                    <td>
                                       <span class="c1">원래가격</span>
                                       <span class="c2">할인가격</span>
                                    </td>
                                    
                                    삭제버튼
                                    <td>
                                       <button class="btn-del" type="button">삭제</button>
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
                  //left
                  
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
               //cart-con
            </div>
            //cart
         </div>
         //contanier-800
         </article>
      </section>  -->     
   </main>
<jsp:include page="/template/footer.jsp"></jsp:include>