<%@page import="java.util.ArrayList"%>
<%@page import="semi.beans.CartListDto"%>
<%@page import="semi.beans.CartListDao"%>
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

<%
	String bookTitle = request.getParameter("bookTitle");

	boolean isTitle = bookTitle!= null;

	int pageNo; //현재 페이지 번호
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
		if(pageSize < 4){
			throw new Exception();
		}
	}
	catch(Exception e){
		pageSize = 4;//기본값 10개
	}
	
	// rownum의 시작번호(startRow)와 종료번호(endRow)를 계산
	int startRow = pageNo * pageSize - (pageSize-1);
	int endRow = pageNo * pageSize;
	
	CartListDao cartListDao = new CartListDao();
	List<CartListDto> cartList;
		if(isTitle){
			cartList = cartListDao.titleList(bookTitle, startRow, endRow);	
		}
		else{
			cartList = cartListDao.list(startRow, endRow);
		}

		int count;
		if(isTitle){
			count = cartListDao.getCountTitle(bookTitle);
		}
		else{
			count = cartListDao.getCount();
		}
		
		int blockSize = 10;
		int lastBlock = (count + pageSize - 1) / pageSize;
		int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
		int endBlock = startBlock + blockSize - 1;
		
		if(endBlock > lastBlock){//범위를 벗어나면
			endBlock = lastBlock;//범위를 수정
		}
		
		
		int totalPrice = 0;		
		List<CartListDto> priceList = cartListDao.priceList(member);
		int a = 2500; //배송비
		
		for(CartListDto cartListDto : priceList){
			if(cartListDto.getBookDiscount() > 0){
				totalPrice += cartListDto.getBookDiscount() * cartListDto.getCartAmount() ;
			} 
			else{
				totalPrice += cartListDto.getBookPrice() * cartListDto.getCartAmount() ;
			}			
		}
		
		int cartTotalPrice = 0;
		if(priceList.size() == 0)
			cartTotalPrice = totalPrice;
		else
			cartTotalPrice = totalPrice + a;
		
%>


<jsp:include page="/template/header.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="<%=root%>/css/myInfoLayout.css">
<link rel="stylesheet" type="text/css" href="<%=root%>/css/template.css">

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
	$(window).on("scroll", function(){
		console.log("scroll moved");
	});
</script>

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

<script>

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
            <li class="on"><a href="deliveryList.jsp">주문목록 / 배송조회</a></li>
            <li><a href="review.jsp">리뷰관리</a></li>            
            <li><a href="<%=root%>/qna/qnaList.jsp">고객센터</a></li>
            <li><a href="cart.jsp">장바구니</a></li>
            <li><a href="bookLike.jsp">좋아요</a></li>
         </ul>
      </aside>
      <!-- 장바구니 -->
      <section class="myInfo-section">
      
      	<article class="myInfo-article text-center">
			<div class="row ">
				<h3 style=" margin-bottom: 40px;font-size:40px;" class="site-color">주문목록 / 배송조회</h3>
			</div>
			
			<div class="row">
				<table class="">
					<tr>
						<th>번호</th>
						<th>상품</th>
						<th>수량</th>
						<th>가격</th>
						<th>상태</th>
					</tr>
				</table>
			</div>
			
   			
			</article>
      </section>      
   </main>
<jsp:include page="/template/footer.jsp"></jsp:include>