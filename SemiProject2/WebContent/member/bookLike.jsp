<%@page import="semi.beans.MemberDto"%>
<%@page import="semi.beans.MemberDao"%>
<%@page import="java.util.Map"%>
<%@page import="semi.beans.PurchaseDao"%>
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
		
	List<BookLikeDto> bookLikeList;	
	BookLikeDao bookLikeDao = new BookLikeDao();
	bookLikeList = bookLikeDao.list(memberNo, startRow, endRow);
	if(bookLikeList.size() == 0){
		if(pageNo != 1){
			pageNo = 1;
			response.sendRedirect("bookLike.jsp?pageNo=" + pageNo);
			return;
		}
	}

	int count = bookLikeDao.getCount(memberNo);
	
	int blockSize = 10;
	int lastBlock = (count + pageSize - 1) / pageSize;
	//	int lastBlock = (count - 1) / pageSize + 1;
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
	if(endBlock > lastBlock){//범위를 벗어나면
		endBlock = lastBlock;//범위를 수정
	}

	DecimalFormat format = new DecimalFormat("###,###");
	BookDao bookDao = new BookDao();
	
	
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
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){		
		$(".book-like").click(function(){
			if(<%=memberNo %> == 0){
				alert("로그인이 필요한 기능입니다.");
				return;
			}
			var type;
			
			if($(this).hasClass("book-good")){
				$(this).removeClass("book-good");
				$(this).addClass("book-good-on");
				type = "insert";
			}
			else{
				$(this).removeClass("book-good-on");
				$(this).addClass("book-good");
				type = "delete";
			}			
			
			var url = "<%=root%>/book/bookLike.kh";
			$.ajax({
				type:"GET",
				url:url,
				dataType:"html",
				data:{
					type : type,
					memberNo : <%=memberNo%>,
					bookOrigin : $(this).attr("id")
				},
				error : function(request,status,error){
					alert('code:'+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); //에러 상태에 대한 세부사항 출력
					alert(e);
				}
			});
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
	
	var allSelected = false;
	
	$(function(){
		$("#allSelect-btn").click(function(){	
			if(!allSelected){
				$(".book-like-checkbox").prop("checked", true);
				$(this).val("전체선택 해제");
			}
			else{
				$(".book-like-checkbox").prop("checked", false);
				$(this).val("전체선택");
			}
			allSelected = !allSelected;
		});
		
		$(".book-like-delete-btn").click(function(){
			$(".book-like-checkbox").each(function(index){
				if($(this).is(":checked")){
					$(this).next().click();
				}				
			});
			location.replace("bookLike.jsp");
		});		
		
		$(window).bind("pageshow", function(event){
			if(event.originalEvent.persisted){
				console.log("back");
			}
		});
		
		$(".into-purchase-btn").click(function(){				
			$(".book-like-checkbox").each(function(index){
				var url = "<%=root%>/member/cartInsert.kh";
				
				if($(this).is(":checked")){					
					$.ajax({
						type:"POST",
						url: url,
						dataType:"html",
						data:{		
							memberNo: <%=memberNo%>,
							bookNo : $(this).val(),
							cartAmount : 1,							
						},
						error : function(request,status,error){
							alert('code:'+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); //에러 상태에 대한 세부사항 출력
							alert(e);
						}
					});
				}				
			});
			
			if(confirm("장바구니로 이동하시겠습니까?"))
				location.replace("cart.jsp");
			else
				location.reload();
		});
	});	
	
</script>

<jsp:include page="/template/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=root%>/css/myInfoLayout.css">
<link rel="stylesheet" type="text/css" href="<%=root%>/css/template.css">
<link rel="stylesheet" type="text/css" href="<%= root%>/css/list.css">
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
				<li ><a href="myInfo_check.jsp" id="edit-info">회원정보 수정 / 탈퇴</a></li>
				<li><a href="deliveryList.jsp">주문목록 / 배송조회</a></li>
				<li><a href="review.jsp">리뷰관리</a></li>				
				<li><a href="<%=root%>/qna/qnaNotice.jsp">고객센터</a></li>
				<li><a href="cart.jsp">장바구니</a></li>
				<li class="on"><a href="bookLike.jsp">좋아요</a></li>
			</ul>
		</aside>
		
		<!-- 컨텐츠영역 -->
		<section class="myInfo-section">			
			<article class="myInfo-article text-center">
				<div class="row ">
					<h3 style=" margin-bottom: 40px;font-size:40px;" class="site-color">좋아요</h3>
				</div>
				<form action="<%=root%>/purchase/purchase.jsp">
				<div class="book-list inf-list book-like-div" style="min-height: 200px;">					
					<%for(BookLikeDto bookLikeDto : bookLikeList){ %>
						<%BookDto bookDto = bookDao.get(bookLikeDto.getBookOrigin()); %>
						<div class="book-item">	
							<a href="<%=root%>/book/bookDetail.jsp?no=<%=bookDto.getBookNo()%>" class="book-img-a" >
								<%if(bookDto.getBookImage()==null){
									bookDto.setBookImage(root+"/image/nullbook.png");
								} %>
								<%if(bookDto.getBookImage().startsWith("https")){ %>
					           	 	<img title="<%=bookDto.getBookTitle() %>" class="book-img" src="<%=bookDto.getBookImage()%>">
					            <%}else{ %>
					            	<img title="<%=bookDto.getBookTitle() %>" class="book-img" src="<%=root%>/book/bookImage.kh?bookNo=<%=bookDto.getBookNo()%>">
					            <%} %>
							</a>
							
							<input type="checkbox" class="book-like-checkbox" name="no" value="<%=bookDto.getBookNo()%>">	
							<a href="javascript:void(0);" class="book-like book-good-on" id="like<%=bookDto.getBookNo()%>" style="visibility: hidden;"></a>	
							<a class="book-publisher"><span><%=bookDto.getBookPublisher() %></span></a>
							<a href="<%=root%>/book/bookDetail.jsp?no=<%=bookDto.getBookNo()%>" class="book-title overflow"  title="<%=bookDto.getBookTitle() %>"><%=bookDto.getBookTitle() %></a>
								<%if(bookDto.getBookAuthor()==null){
									bookDto.setBookAuthor("편집부");
								} %>
							<a class="book-author overflow" title="<%=bookDto.getBookAuthor() %>"><%=bookDto.getBookAuthor() %></a>
					
							<%if(bookDto.getBookDiscount()!=0 && bookDto.getBookDiscount()!=bookDto.getBookPrice()){ %>
								<div style="width: 100%;text-align: right;">
									<a class="book-discount"><%=bookDto.getBookPrice()/(bookDto.getBookPrice()-bookDto.getBookDiscount())%>%</a>
									<a class="book-price"><%=format.format(bookDto.getBookDiscount()) %></a><a style="font-weight: 900;color:rgba(0,0,0,0.5);"> 원</a>
								</div>
							<%}else{ %>
								<div style="width: 100%;text-align: right;">								
									<a class="book-price"><%=format.format(bookDto.getBookPrice()) %></a><a style="font-weight: 900;color:rgba(0,0,0,0.5);"> 원</a>
								</div>
							<%} %>
						</div> 
					<%} %> 
				</div>
				
				<div class="row text-center" style="margin-bottom: 30px; margin-top: 30px;">
					<input type="button" id="allSelect-btn" class="book-like-btn" value="전체선택">
					<input type="submit" class="book-like-btn" value="선택상품 구매">
					<input type="button" class="book-like-btn book-like-delete-btn" value="선택상품 삭제">
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
				
				<form class="page-form" action="bookLike.jsp" method="post">
					<input type="hidden" name="pageNo">
				</form>
			</article>
		</section>
		
	</main>
<jsp:include page="/template/footer.jsp"></jsp:include>