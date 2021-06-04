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
			location.reload();
		});		
		
		$(window).bind("pageshow", function(event){
			if(event.originalEvent.persisted){
				console.log("back");
			}
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
				<li ><a href="myInfo_check.jsp" id="edit-info">회원정보 수정 / 탈퇴</a></li>
				<li><a href="#">주문목록 / 배송조회</a></li>
				<li class="on"><a href="review.jsp">리뷰관리</a></li>				
				<li><a href="<%=root%>/qna/qnaNotice.jsp">고객센터</a></li>
				<li><a href="cart.jsp">장바구니</a></li>
				<li><a href="bookLike.jsp">좋아요</a></li>
			</ul>
		</aside>
		
		<!-- 컨텐츠영역 -->
		<section class="myInfo-section">
			<article class="myInfo-article text-center">
				<div class="row ">
					<h3 style=" margin-bottom: 40px;font-size:40px;" class="site-color">리뷰</h3>
				</div>
			</article>
		</section>
		
	</main>
<jsp:include page="/template/footer.jsp"></jsp:include>