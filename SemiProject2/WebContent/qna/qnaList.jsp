<%@page import="semi.beans.MemberDto"%>
<%@page import="semi.beans.MemberDao"%>
<%@page import="semi.beans.QnaReplyDto"%>
<%@page import="semi.beans.QnaReplyDao"%>
<%@page import="semi.beans.QnaBoardDto"%>
<%@page import="semi.beans.QnaBoardDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	int member;
	try{
		member = (int)session.getAttribute("member");
	}
	catch(Exception e){
		member = 0;
	}
	String qnaBoardHeader = request.getParameter("qnaBoardHeader");
	
	boolean isHeader = qnaBoardHeader != null ;
	
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
		pageSize = 10;//기본값 10개
	}
	
	//rownum의 시작번호(startRow)와 종료번호(endRow)를 계산
	int startRow = pageNo * pageSize - (pageSize-1);
	int endRow = pageNo * pageSize;
	
	QnaBoardDao qnaBoardDao = new QnaBoardDao();
	List<QnaBoardDto> list; 
		if(isHeader){
			list = qnaBoardDao.titleList(qnaBoardHeader,startRow, endRow);
		}
		else{
			list = qnaBoardDao.list(startRow, endRow);
		}
	
	int count;
		if(isHeader){
			count = qnaBoardDao.getCountHeader(qnaBoardHeader);
		}
		else{
			count = qnaBoardDao.getCount();
		}
		
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

<style>
.qna {
	margin: 0px;
	width: 1200px;
}

.qna>.title {
	margin: 50px 0px;
	font-family: 'Noto-B';
	font-size: 40px;
	color: #FF8E99;
	text-align: center;
}

.qna>.subtitle {
	margin: 30px 0px;
	font-family: 'Noto-B';
	font-size: 30px;
	color: black;
	text-align: center;
}

.qna>.tabmenu-black {
	margin: 20px auto;
	width: 1000px;
 	overflow: hidden; 
}

.tabmenu-black :hover, .tabmenu-black .on {
	position: relative;
	color: #fff;
	border-color: #ff7d9e;
	background: #FF8E99;
}

.tabmenu-black>a {
	float: left;
	width: 25%;
	height: 67px;
	font: inherit;
	background-color: #39373a;
	font-size: 20px;
	text-align: center;
	box-sizing: border-box;
	color: #fff;
	line-height: 67px;
}

.qna>.qna-type {
	margin: 20px auto;
	width: 1000px;
 	overflow: hidden;
 	box-sizing: border-box;
    font-size: 16px;
    color: #676767;
    text-align: center;
    line-height: 68px;
    background: #f9f9f9;
    box-sizing: border-box;
}

.qna-type > a {
	float: left;
	width: 20%;
	height: 65px;
	font: inherit;
	background-color: white;
	font-size: 20px;
	text-align: center;
	color: #bebebe;
	line-height: 67px;
	border: 1px solid #d2d2d2;
	border-bottom: 1px solid #ff7d9e;
}

.qna-type > a:hover {
	background-color: #F2EDED;
	color: #ff7d9e;
}

.qna-type > .on{
	position: relative;
    height: 65px;
    color: #ff7d9e;
    border-color: #ff7d9e;
    background: #fff;
    border-bottom: 0;
}

.qna> .qna-list{
	margin: 20px auto;
	width: 1000px;
    box-sizing: border-box;
}

.qna-table{
	width: 100%;
	margin: 40px 0px;
	border-collapse: collapse;
}

.qna-table>thead>tr, 
.qna-table>tbody>tr,
.qna-table>tfoot>tr {
	border-bottom: 1px solid #b4b4b4;
	border-top: 1px solid #b4b4b4;
}

.qna-table>thead>tr>th, 
.qna-table>thead>tr>td, 
.qna-table>tbody>tr>th,
.qna-table>tbody>tr>td, 
.qna-table>tfoot>tr>th,
.qna-table>tfoot>tr>td {
	padding: 10px 0px;
	text-align: center;
}

.qna-table>thead>tr>td, 
.qna-table>tbody>tr>td, 
.qna-table>tfoot>tr>td {
	font-size: 12px;
}

.qna-table>thead>tr>th:nth-child(1), 
.qna-table>thead>tr>td:nth-child(1), 
.qna-table>tbody>tr>th:nth-child(1),
.qna-table>tbody>tr>td:nth-child(1), 
.qna-table>tfoot>tr>th:nth-child(1),
.qna-table>tfoot>tr>td:nth-child(1) {
	width: 100px;
}

.qna-table>thead>tr>th:nth-child(3), 
.qna-table>thead>tr>td:nth-child(3), 
.qna-table>tbody>tr>th:nth-child(3),
.qna-table>tbody>tr>td:nth-child(3), 
.qna-table>tfoot>tr>th:nth-child(3),
.qna-table>tfoot>tr>td:nth-child(3) {
	width: 600px;
}

.q1-a1{
	padding: 10px 0;
	background-color: #F5F5F5;
}

.pagination{
	margin: 0 auto;
	text-align: center;
}


</style>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
		
	
	
	window.onload = function(){
		
		//parameter 뽑아오기
		function getParameterByName(name) {
		    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
		    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
		            results = regex.exec(location.search);
		    return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
		}
		var patId = getParameterByName('qnaBoardHeader'); 	
			
		//윈도우 시작하면서 class 부여 설정
		var headerLink = document.querySelectorAll(".header-link");
		
		for(var i=0; i<headerLink.lenght; i++){
			headerLink[i].classList.remove("on");
		}
		
		if(patId == headerLink[1].innerText){
			headerLink[1].classList.add("on");
		}
		else if(patId == headerLink[2].innerText){
			headerLink[2].classList.add("on");
		}
		else if(patId == headerLink[3].innerText){
			headerLink[3].classList.add("on");
		}
		else if(patId == headerLink[4].innerText){
			headerLink[4].classList.add("on");
		}
		else{
			headerLink[0].classList.add("on");
		}
	}
	
</script>
<script>
	function viewContent(obj){
		var con = document.querySelectorAll(".con");
		var ans = document.querySelectorAll(".ans");
				
		if(con != null){
			for(var i=0; i<con.length; i++){
				con[i].style.display = "none";	
			}				
		}
		
		if(ans != null){
			for(var i=0; i<ans.length; i++){
				ans[i].style.display = "none";	
			}				
		}
		
		var q1 = document.querySelectorAll(".q"+obj.id);
		var a1 = document.querySelectorAll(".a"+obj.id);
		
		if(q1 != null){
			for(var i=0; i<q1.length; i++){
				q1[i].style.display = "";	
			}				
		}
		
		if(a1 != null){
			for(var i=0; i<a1.length; i++){
				a1[i].style.display = "";	
			}				
		}
		
	}
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



<div class="qna">

	<h2 class="title">고객센터</h2>
	
	<div class="tabmenu-black">
		<a class="on"> 
			<span>고객의 소리</span>
		</a> 
		<a href="qnaInsert.jsp" >
			<span>1:1 문의 등록</span>
		</a> 
		<a href="qnaMyList.jsp"> 
			<span>1:1 문의 확인</span>
		</a> 
		<a href="qnaNotice.jsp"> 
			<span>공지사항</span>
		</a>
	</div>

	<h2 class="subtitle">문의목록</h2>
	
	<div class="qna-type">
		<a class="header-link" href="qnaList.jsp"> 
			<span>전체</span>
		</a> 
		<a class="header-link" href="<%=request.getContextPath()%>/qna/qnaList.jsp?qnaBoardHeader=주문/결제"> 
			<span>주문/결제</span>
		</a> 
		<a class="header-link" href="<%=request.getContextPath()%>/qna/qnaList.jsp?qnaBoardHeader=배송" > 
			<span>배송</span>
		</a> 
		<a class="header-link" href="<%=request.getContextPath()%>/qna/qnaList.jsp?qnaBoardHeader=환불/교환" > 
			<span>환불/교환</span>
		</a> 
		<a class="header-link" href="<%=request.getContextPath()%>/qna/qnaList.jsp?qnaBoardHeader=기타"> 
			<span>기타</span>
		</a>
	</div>
	
	<div class="qna-list">
		<table class="qna-table">
			<thead>
				<tr>
					<th>번호</th>
					<th>구분</th>
					<th>제목</th>
					<th>작성자</th>
					<th>등록일자</th>
					<th>답변여부</th>
				</tr>
			</thead>
			
			<%for(QnaBoardDto boardDto : list){ %>
			<tbody>
				<tr>
					<td ><%=boardDto.getQnaBoardNo() %></td>
					<td >[<%=boardDto.getQnaBoardHeader() %>]</td>
					<td ><a id="<%=boardDto.getQnaBoardNo() %>" onclick="viewContent(this); return false" href="javascript:"><%=boardDto.getQnaBoardTitle() %></a>
					<%if(boardDto.getQnaBoardReply() > 0){ %>
						<!-- 댓글 개수 출력 : 0보다 클 경우만 출력 -->
						<span style="color:#ff9f43; margin-left: 3px;">[<%=boardDto.getQnaBoardReply()%>]</span>
					<%} %>	
					</td>
					<td ><%MemberDao memberDao = new MemberDao();
		               MemberDto memberDto = memberDao.getMember(boardDto.getQnaBoardWriter());
		               String Id = memberDto.getMemberId();
		               Id = Id.replaceAll(".(?=.{4})", "*");%>   
                  	<%=Id %>
                 	</td>
					<td ><%=boardDto.getQnaBoardTime() %></td>
					<td >
						<span class="contents-info" oninput="contentsInfo();">							
							<!-- 댓글 개수 0보다 클 경우 답변완료 -->
							<%if(boardDto.getQnaBoardReply() > 0){ %>							
								답변완료
							<%}	else{ %>
								답변대기
							<%} %>						
						</span>
					</td>
				<tr>
				<%if(member == boardDto.getQnaBoardWriter()) {%>
					<tr class="q<%=boardDto.getQnaBoardNo() %> con" style="display:none;">
						<td class="q1-a1" colspan="1" ><div >문의내용</div></td>
						<td class="q1-a1" colspan="5" style="text-align: left;"><%=boardDto.getQnaBoardContent() %></td>
					</tr>
					<%if(boardDto.getQnaBoardReply() > 0) {%>
						<%QnaReplyDao qnaReplyDao = new QnaReplyDao();%>
						<%List<QnaReplyDto> replyList = qnaReplyDao.list(boardDto.getQnaBoardNo());%>
						<%for(QnaReplyDto qnaReplyDto : replyList){ %>
							<tr class="a<%=boardDto.getQnaBoardNo() %> ans" style="display:none;">
								<td class="q1-a1" colspan="1" ><div >답변</div></td>
								<td class="q1-a1" colspan="5" style="text-align: left;"><%=qnaReplyDto.getQnaReplyContent() %></td>						
							</tr>
						<%} %>
					<%} %>
				<% } %>
			</tbody>
			<%} %>	
		</table>
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
	
	<form class="page-form" action="qnaList.jsp" method="post">
		<input type="hidden" name="pageNo">
	</form>

		
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>
