<%@page import="home.beans.ReplyListDao"%>
<%@page import="home.beans.ReplyListDto"%>
<%@page import="home.beans.ReplyDto"%>
<%@page import="java.util.List"%>
<%@page import="home.beans.ReplyDao"%>
<%@page import="home.beans.BoardLikeDto"%>
<%@page import="home.beans.BoardLikeDao"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="home.beans.MemberDto"%>
<%@page import="home.beans.MemberDao"%>
<%@page import="home.beans.BoardDto"%>
<%@page import="home.beans.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	BoardDao boardDao = new BoardDao();
	
	//조회수 증가는 무조건 이루어지는 작업이 아니다.
	//= 조회수는 자신의 글을 읽는 경우에는 늘어나면 안된다
	//		= 현재 회원의 번호를 조회수 증가 기능에 같이 전달하여 조건으로 사용
	//= 한 번 읽었던 글을 또 읽는 경우에는 늘어나면 안된다(세션)
	
	int memberNo = (int)session.getAttribute("memberNo");
	Set<Integer> boardNoSet;
	if(session.getAttribute("boardNoSet") != null){//세션에 boardNoSet이라는 이름의 저장소가 있다면 --> 저장소 추출
		boardNoSet = (Set<Integer>)session.getAttribute("boardNoSet");
	}
	else{//세션에 boardNoSet이라는 이름의 저장소가 없다면 --> 저장소 생성
		boardNoSet = new HashSet<>();
	}
	if(boardNoSet.add(boardNo)){//boardNoSet에 현재 글번호(boardNo)가 추가되었다면 --> 처음 읽는 글이라면
		boardDao.read(boardNo, memberNo); //조회수 증가
// 		System.out.println("조회수 증가");
	}
// 	System.out.println("저장소 : "+boardNoSet);
	
	//저장소 갱신
	session.setAttribute("boardNoSet", boardNoSet);
	
	BoardDto boardDto = boardDao.get(boardNo);//게시글 불러오기 
	
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.find(boardDto.getBoardWriter());
	
	//좋아요 한 적이 있는 글인지 확인하는 코드
	BoardLikeDao boardLikeDao = new BoardLikeDao();
	BoardLikeDto boardLikeDto = new BoardLikeDto();
	boardLikeDto.setBoardNo(boardNo);
	boardLikeDto.setMemberNo(memberNo);
	boolean isLike = boardLikeDao.check(boardLikeDto);
	
	//이전글 정보 불러오기
	BoardDto prevBoardDto = boardDao.getPrevious(boardNo);
	
	//다음글 정보 불러오기
	BoardDto nextBoardDto = boardDao.getNext(boardNo);
	
	//댓글 목록 불러오기
	
	//- 기존 방식 : 회원 닉네임을 불러올 수 없음
	//ReplyDao replyDao = new ReplyDao();
	//List<ReplyDto> replyList = replyDao.list(boardNo);
	
	//- 변경 방식 : 회원 닉네임을 join 을 통해 불러옴
	ReplyListDao replyListDao = new ReplyListDao();
	List<ReplyListDto> replyList = replyListDao.list(boardNo);
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<style>
	/* 
		댓글이 영역을 넘어갈 경우 자동 줄바꿈이 이루어지도록 하는 스타일 설정
		white-space : 공백 처리 규칙 
		word-break : 줄바꿈 시 분리 규칙
		overflow : 영역 밖으로 나간 내용에 대한 표시 여부 설정
		text-overflow : 영역 밖으로 글자가 나간 경우의 표시 여부 설정
	*/
	pre {
/* 		자동줄바꿈 스타일 설정 */
 		white-space: pre-wrap; 
 		word-break: break-all; 
/* 		말줄임표 스타일 설정 */
/*
		overflow: hidden;
		white-space: nowrap;
		text-overflow: ellipsis;
*/
	}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	//목표 : 삭제버튼을 누르면 확인창 출력 후 확인을 누르면 전송
	$(function(){
		$(".reply-delete-btn").click(function(e){
			var choice = window.confirm("정말 삭제하시겠습니까?");
			if(!choice){
				e.preventDefault();
			}
		});
	});
	
	//목표 : 수정버튼을 누르면 댓글 수정영역을 표시, 작성 취소를 누르면 댓글 수정영역을 숨김
	$(function(){
		
		$(".reply-edit-area").hide();//처음에 모든 수정 영역을 숨김
		
		$(".reply-edit-btn").click(function(){
			//표시 영역 : 수정 버튼(this) 기준으로 위로 두번 뒤로 한번 이동하면 나온다
			//수정 영역 : 수정 버튼(this) 기준으로 위로 두번 뒤로 두번 이동하면 나온다
			$(this).parent().parent().next().hide();
			$(this).parent().parent().next().next().show();
		});
		
		$(".reply-edit-cancel-btn").click(function(){
			//표시 영역 : 수정취소 버튼(this) 기준으로 위로 두번 앞으로 한번 이동하면 나온다
			//수정 영역 : 수정취소 버튼(this) 기준으로 위로 두번 이동하면 나온다
			$(this).parent().parent().prev().show();
			$(this).parent().parent().hide();
		});
	});
</script>

<style>
	.heart > a{
		color:red;
		text-decoration: none;
	}
</style>

<div class="container-900">
	<div class="row text-left">
		<h2>
			<%=boardNo%>번 게시글
			
			<%if(isLike){ %>
				<span class="heart"><a href="boardLikeDelete.kh?boardNo=<%=boardNo%>&memberNo=<%=memberNo%>">♥</a></span>
			<%}else{ %>
				<span class="heart"><a href="boardLikeInsert.kh?boardNo=<%=boardNo%>&memberNo=<%=memberNo%>">♡</a></span>
			<%} %>
		</h2>
	</div>
	
	<div class="row text-left">
		<h3>
			<%if(boardDto.getBoardHeader()!=null){ %>
				[<%=boardDto.getBoardHeader()%>]
			<%} %>
			<%=boardDto.getBoardTitle()%>
		</h3>
	</div>
	
	<div class="row float-container">
		<div class="left">
			<%=memberDto.getMemberNick()%>
			(<%=memberDto.getMemberId()%>)
		</div>
		<div class="right">
			조회수 <%=boardDto.getBoardRead()%>
			좋아요 <%=boardDto.getBoardLike()%>
			싫어요 <%=boardDto.getBoardHate()%>					
		</div>		
		<div class="right">
			<%=boardDto.getBoardTime().toLocaleString()%>
		</div>
	</div>
	
	<div class="row text-left" style="min-height:300px;">
		<!-- pre 태그는 작성된 글자가 HTML 화면에 그대로 형태를 유지하여 출력되도록 한다 -->
		<pre><%=boardDto.getBoardContent()%></pre>
	</div>
	
	<!-- 
		댓글 목록 영역
	 -->
	<div class="row text-left">
		<h4>댓글 목록</h4>
	</div>
	<%for(ReplyListDto replyListDto : replyList) { %>
	<div class="row text-left" style="border:1px solid gray;">
		<div class="float-container">
			<div class="left"><%=replyListDto.getMemberNick()%></div>
			
			<!-- 
				수정과 삭제 메뉴는 "본인 글"에만 표시되어야 한다
				= 본인글 : 댓글작성자번호(replyDto.getReplyWriter()) == 로그인된 회원번호(memberNo) 
			-->
			<%if(replyListDto.getReplyWriter() == memberNo){ %>
			<div class="right">
				<a class="reply-edit-btn">수정</a> 
				| 
				<a class="reply-delete-btn" href="replyDelete.kh?replyNo=<%=replyListDto.getReplyNo()%>&replyOrigin=<%=boardNo%>">삭제</a>
			</div>
			<%} %>
		</div>
		<!-- 화면 표시 댓글 -->
		<div class="reply-display-area">
			<pre><%=replyListDto.getReplyContent()%></pre>
		</div>
		<!-- 
			댓글 수정 영역 : 게시글번호(hidden), 댓글번호(hidden), 댓글내용(textarea)
			= 이 영역은 "나의 댓글" 일 경우에만 출력되어야 한다.
			= 나의 댓글 판정 : 회원번호(memberNo) == 댓글작성자번호(replyDto.getReplyWriter()) 
		-->
		<%if(memberNo == replyListDto.getReplyWriter()){ %>
		<div class="reply-edit-area">
			<form action="replyEdit.kh" method="post">
				<input type="hidden" name="replyNo" value="<%=replyListDto.getReplyNo()%>">
				<input type="hidden" name="replyOrigin" value="<%=replyListDto.getReplyOrigin()%>">
				
				<textarea name="replyContent" required><%=replyListDto.getReplyContent()%></textarea>
				<input type="submit" value="댓글 수정">		
				<input type="button" value="작성 취소" class="reply-edit-cancel-btn">		
			</form>
		</div>
		<%} %>
		<div><%=replyListDto.getReplyTime().toLocaleString()%></div>
	</div>
	<%} %>
	
	<!-- 
		댓글 작성 영역 : 게시글번호(replyOrigin), 댓글내용(replyContent)로 전송
	 -->
	<form action="replyInsert.kh" method="post">
		<input type="hidden" name="replyOrigin" value="<%=boardNo%>">
		
		<div class="row">
			<textarea name="replyContent" required class="form-input"></textarea>
		</div>
		<div class="row">
			<input type="submit" value="댓글 작성" class="form-btn form-btn-normal">
		</div>
	</form>
	
	<!-- 
		버튼 영역
	 -->
	<div class="row text-right">
		<a href="boardWrite.jsp" class="link-btn">글쓰기</a>
	    <a href="boardWrite.jsp?superNo=<%=boardNo%>" class="link-btn">답글쓰기</a>
		
		<!-- 본인 및 관리자에게만 표시되도록 하는 것이 좋다 -->
		<a href="boardEdit.jsp?boardNo=<%=boardNo%>" class="link-btn">수정</a>
		<a href="boardDelete.kh?boardNo=<%=boardNo%>" class="link-btn">삭제</a>
		
		
		<a href="boardList.jsp" class="link-btn">목록</a>
	</div>
	
	<div class="row text-left">
		다음글 : 
		<%if(nextBoardDto == null){%>
		다음글이 없습니다.
		<%}else{ %>
		<a href="boardDetail.jsp?boardNo=<%=nextBoardDto.getBoardNo()%>">
			<%=nextBoardDto.getBoardTitle()%>
		</a>
		<%} %>
	</div>
	<div class="row text-left">
		이전글 : 
		<%if(prevBoardDto == null){%>
		이전글이 없습니다.
		<%}else{ %>
		<a href="boardDetail.jsp?boardNo=<%=prevBoardDto.getBoardNo()%>">
			<%=prevBoardDto.getBoardTitle()%>
		</a>
		<%} %>
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>