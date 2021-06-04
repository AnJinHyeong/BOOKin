<%@page import="semi.beans.ReviewDto"%>
<%@page import="semi.beans.ReviewDao"%>
<%@page import="semi.beans.NoticeBoardDto"%>
<%@page import="semi.beans.NoticeBoardDao"%>
<%@page import="semi.beans.QnaReplyDto"%>
<%@page import="semi.beans.QnaReplyDao"%>
<%@page import="semi.beans.MemberDto"%>
<%@page import="semi.beans.MemberDao"%>
<%@page import="semi.beans.QnaBoardDto"%>
<%@page import="semi.beans.QnaBoardDao"%>
<%@page import="semi.beans.QnaReplyMemberDto"%>
<%@page import="semi.beans.QnaReplyMemberDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String root = request.getContextPath();
	int member;
	try{
		member = (int)session.getAttribute("member");
	}
	catch(Exception e){
		member = 0;
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
		pageSize = 20;//기본값 15개
	}
	
	//rownum의 시작번호(startRow)와 종료번호(endRow)를 계산
	int startRow = pageNo * pageSize - (pageSize-1);
	int endRow = pageNo * pageSize;
	
	ReviewDao reviewDao = new ReviewDao();
	List<ReviewDto> reviewList = reviewDao.list(startRow, endRow);
	
	int count = reviewDao.get();
		
	int blockSize = 10;
	int lastBlock = (count + pageSize - 1) / pageSize;
	//	int lastBlock = (count - 1) / pageSize + 1;
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
	if(endBlock > lastBlock){//범위를 벗어나면
		endBlock = lastBlock;//범위를 수정
	}
	
%>
<style>
	.pagination{
		padding: 10px 0;
		margin: 0 auto;
		text-align: center;
	}
	.pagination > a {
		color:grey;
		text-decoration: none;
		display:inline-block; 
		min-width:35px;
		
		border:1px solid transparent;
		padding:0.5rem;
		text-align: center;
	}
	.pagination > a:hover,
	.pagination > a.on {
		border:1px solid lightgray;
		color:#ff9f43;
	}
	.q1-a1{
		background-color: rgb(231, 241, 253,0.5);
	}
	
 	.admin-qna-row{ 
 		width: 100%;
 		margin: 5px auto;
 		padding-left: 10px;
 	} 
	.notice-regit-reply {
		width: 98%;
		min-height: 100px;
		margin: 10px auto ;
 	    padding: 5px 0 ;
	    border: 2px solid #cfcfcf;
	    border-radius: 6px;
	    box-sizing: border-box;
	}
	.comment_inbox_text{
	    display: block;
	    width: 100%;
	    min-height: 100px;
	    border: 0;
	    font-size: 13px;
	    resize: none;
	    box-sizing: border-box;
	    background: transparent;
	    color: var(--skinTextColor);
	    outline: 0;
	}
	.form-btn {
		border:none;
	}
	.form-btn.form-btn-normal {
		background-color: white;
		color:gray;
		border:1px solid gray;	
		width: 50px;
		height: 30px;
		padding: 5px;
	}
</style>
<jsp:include page="/template/adminSidebar.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>


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
<section>
	<div class="admin-content_area">
		<div class="admin-content">
			<div class="admin-content_title">리뷰 관리</div>
		</div>
	</div>
	
	<form action="#" method="post">
		<div class="admin-content_area">
			<div class="admin-content">
				<div class="admin-content_title">
					검색
				</div>
				<div class="admin-search">
					<div>책 번호</div>
					<input type='number' name="bookNo">
				</div>
				<div class="admin-search">
					<div>책 제목</div>
					<input type='text' name="bookTitle" >
				</div>
				<div class="admin-search">
					<div>작성자</div>
					<input type='text' name="bookAuthor" >
				</div>
			</div>
		</div>
		<button class="submit-btn">검색</button>
	</form>
	
	
	<div class="admin-content_area" style="margin-top: 45px;">
		<div class="admin-content">
			<div class="admin-content_title">리뷰 목록</div>
			<div class="align-row choice-genre-area">
				<div class="search-table" style="min-height: 820px;">
					<table class="table table-border table-hover table-striped" style="text-align: center;">
						<thead>
							<tr>
								<th style="width: 1%;">리뷰번호</th>
								<th style="width: 1%;">상품번호</th>
								<th style="width: 15%;">리뷰내용</th>
								<th style="width: 2%;">작성자</th>
								<th style="width: 3%;">별점</th>
								<th style="width: 3%;">등록일자</th>
								<th style="width: 3%;">상품정보</th>
							</tr>
						</thead>
						<tbody>
						<%for(ReviewDto reviewDto : reviewList){ %>
							<tr>
								<td><%=reviewDto.getReviewNo() %></td>
								<td><%=reviewDto.getReviewBook() %></td>
								<td style="text-align: left;"><%=reviewDto.getReviewContent() %></td>
								<td>
									<%
										MemberDao memberDao = new MemberDao();
									    MemberDto memberDto = memberDao.getMember(reviewDto.getReviewMember());
									    String Id = memberDto.getMemberId();
								    %>
								    <%=Id %>
							    </td>
								<td>
									<span style="display: none;"><%=reviewDto.getReviewRate() %></span>
									<%long reviewRate = reviewDto.getReviewRate() ; %>
									<%for(int i=0; i<reviewRate; i++){ %>
										<img src="<%=root%>/image/star_on.png">
									<%} %>
									<%for(int i=0; i<5-reviewRate; i++){ %>
										<img src="<%=root%>/image/star_off.png">
									<%} %>
								</td>
								<td><%=reviewDto.getReviewTime() %></td>
								<td><a class="update-btn" href="<%=root%>/book/bookDetail.jsp?no=<%=reviewDto.getReviewBook()%>">상품정보 이동</a></td>
							</tr>
						<%} %>
						</tbody>
					</table>
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
		</div>
		
	</div>
</section>
</body>
</html>