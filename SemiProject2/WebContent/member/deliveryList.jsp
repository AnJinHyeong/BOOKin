<%@page import="semi.beans.PurchaseBookMemberDto"%>
<%@page import="semi.beans.PurchaseBookMemberDao"%>
<%@page import="semi.beans.PurchaseDto"%>
<%@page import="java.util.Map"%>
<%@page import="semi.beans.PurchaseDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="semi.beans.MemberDto"%>
<%@page import="semi.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%   
	String root = request.getContextPath();

   int member;
   try{
      member = (int)session.getAttribute("member");
   }
   catch(Exception e){
      member = 0;
   }

%>
<%	

	PurchaseDao purchaseDao = new PurchaseDao();
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.getMember(member);
	Map<String,List<Integer>> map = purchaseDao.getMemberPurchaseStateCount(member);
	
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
<%
	
	

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
		if(pageSize < 8){
			throw new Exception();
		}
	}
	catch(Exception e){
		pageSize = 8;//기본값 10개
	}
	
	//rownum의 시작번호(startRow)와 종료번호(endRow)를 계산
	int startRow = pageNo * pageSize - (pageSize-1);
	int endRow = pageNo * pageSize;
	
	PurchaseBookMemberDao purchaseBookMemberDao = new PurchaseBookMemberDao();
	List<PurchaseBookMemberDto> purchaseList = purchaseBookMemberDao.myList(member, startRow, endRow);
	
	if(purchaseList.size() == 0){
		if(pageNo != 1){
			pageNo = 1;
			response.sendRedirect("bookLike.jsp?pageNo=" + pageNo);
			return;
		}
	}
	
	int count = purchaseBookMemberDao.getCoun(member);
	
	int blockSize = 10;
	int lastBlock = (count + pageSize - 1) / pageSize;
	//	int lastBlock = (count - 1) / pageSize + 1;
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
	if(endBlock > lastBlock){//범위를 벗어나면
		endBlock = lastBlock;//범위를 수정
	}
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
	window.onload = function(){
		var state = document.querySelectorAll('#state');
		var state1 = document.querySelectorAll(".state1");
		var state2 = document.querySelectorAll(".state2");
		var state3 = document.querySelectorAll(".state3");
		
		for(var i=0; i<state.length; i++){
			
			var stateType = state[i].innerHTML == "배송중";
			var stateTypeCan = state[i].innerHTML == "결제완료";
			if(stateType){
				state1[i].style.display = "none";
				state2[i].style.display = "";
				state3[i].style.display = "none";
			}
			else if(stateTypeCan){
				state1[i].style.display = "none";
				state2[i].style.display = "none";
				state3[i].style.display = "";
			}
			else{
				state1[i].style.display = "";
				state2[i].style.display = "none";
				state3[i].style.display = "none";
			}
		}
	}
</script>
<script>
	
	$(function(){
		 $(".purchase-cancel").click(function(){     
	    	  if(confirm("구매를 취소 하시겠습니까?") == true){
	         	$(location).attr("href", "<%=root%>/purchase/delete.kh?member=<%=member%>&purchaseNo=" + $(this).attr('id'));
	         }
	    	  else{
	    		  return;
	    	  }
	      });
	});
	
	$(function(){
		 $(".purchase-ok").click(function(){     
	    	  if(confirm("상품수령을 확인 하시겠습니까?") == true){
	         	$(location).attr("href", "<%=root%>/purchase/purchaseState.kh?member=<%=member%>&purchaseNo=" + $(this).attr('id'));
	         }
	    	  else{
	    		  return;
	    	  }
	      });
	});
	
</script>

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
			
			<form action="<%=root %>/purchase/purchaseState.kh" method="post">
			<div style="width: 90%; margin: 0 auto; min-height: 450px;">
				<table class="table table-border" style="font-size: 12px;">
					<thead style="border-bottom: 1px solid black; border-top: 1px solid black; background-color: #FAEBCD">
						<tr>
							<th style="width:70px;">주문번호</th>
							<th style="width:300px;">상품이름</th>
							<th style="width:53px;">수령인</th>
							<th style="width:134px;">배송지</th>
							<th style="width:60px;">수량</th>
							<th style="width:50px;">금액</th>
							<th style="width:70px;">주문일</th>
							<th style="width:65px;">상태</th>
							<th style="width:63px;">-</th>
						</tr>
					</thead>
					
					<%for(PurchaseBookMemberDto purchaseBookMemberDto : purchaseList){ %>
					<tbody style="border-bottom: 1px solid #bebebe; font-size: 10px; ">
						<tr style="margin: 10px 0; height: 50px; ">
							<th><%=purchaseBookMemberDto.getPurchaseNo() %></th>
							<th style=" text-align: left;"><a href="<%=root%>/book/bookDetail.jsp?no=<%=purchaseBookMemberDto.getPurchaseBook()%>"><%=purchaseBookMemberDto.getBookTitle() %></a></th>
							<th><%=purchaseBookMemberDto.getPurchaseRecipient() %></th>
							<th><%=purchaseBookMemberDto.getPurchaseAddress() %></th>
							<th><%=purchaseBookMemberDto.getPurchaseAmount() %></th>
							<%if(purchaseBookMemberDto.getBookDiscount() == 0){ %>
								<th ><%=purchaseBookMemberDto.getBookPrice() * purchaseBookMemberDto.getPurchaseAmount()%></th>
							<%} else{%>
								<th><%=purchaseBookMemberDto.getBookDiscount() * purchaseBookMemberDto.getPurchaseAmount()%></th>
							<%} %>
							<th ><%=purchaseBookMemberDto.getPurchaseDate() %></th>
							<th id="state"><%=purchaseBookMemberDto.getPurchaseState() %></th>
							<th style="display: none;" class="state1">-</th>
							<th style="display: none;" class="state2">
								<a style="color:#FF9B00;" class="purchase-ok purchase-link-btn" id="<%=purchaseBookMemberDto.getPurchaseNo()%>">상품수령</a>
							</th>
							<th style="display: none;" class="state3">
								<a style="color: #FF3232;" class="purchase-cancel purchase-link-btn" id="<%=purchaseBookMemberDto.getPurchaseNo()%>">구매취소</a>
							</th>
						</tr>
					</tbody>
					<%} %>
				</table>
			</div>
			</form>
			
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
				
				<form class="page-form" action="deliveryList.jsp" method="post">
					<input type="hidden" name="pageNo">
				</form>
			
   			
			</article>
      </section>      
   </main>
<jsp:include page="/template/footer.jsp"></jsp:include>