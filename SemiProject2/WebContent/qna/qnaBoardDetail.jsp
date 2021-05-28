<%@page import="semi.beans.QnaReplyMemberDto"%>
<%@page import="semi.beans.QnaReplyMemberDao"%>
<%@page import="semi.beans.QnaReplyDto"%>
<%@page import="java.util.List"%>
<%@page import="semi.beans.QnaReplyDao"%>
<%@page import="semi.beans.MemberDto"%>
<%@page import="semi.beans.MemberDao"%>
<%@page import="semi.beans.QnaBoardDto"%>
<%@page import="semi.beans.QnaBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	int qnaBoardNo = Integer.parseInt(request.getParameter("qnaBoardNo"));	

	QnaBoardDao qnaBoardDao = new QnaBoardDao();
	QnaBoardDto qnaBoardDto = qnaBoardDao.get(qnaBoardNo);
	
	QnaReplyMemberDao qnaReplyMemberDao = new QnaReplyMemberDao();
	List<QnaReplyMemberDto> list = qnaReplyMemberDao.list(qnaBoardNo);
	
	int memberNo = (int)session.getAttribute("member");
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.getMember(memberNo);
	
	
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

.qna-notice-row{
	width: 1000px;
	min-height: 500px;
	margin: 10px auto;
	border: 2px solid #cfcfcf;
    border-radius: 6px;    
	padding: 16px 10px 10px 18px;
}

.notice-title{
	width: 950px;
	height: 50px;
	line-height: 50px;
	border-bottom: solid 2px #cfcfcf;
	padding: 0 90px 15px 0;
	position: relative;
}

.notice-title> span{
	right: 0;
	position: absolute;
}

.notice-content{
	width: 950px;
	position: relative;
	min-height: 300px;
}

.notice-regit-reply {
	width: 950px;
	min-height: 130px;
	margin-top: 0px;
	margin-bottom: 10px;
    padding: 5px 10px 10px 18px;
    border: 2px solid #cfcfcf;
    border-radius: 6px;
    box-sizing: border-box;
}

.notice-update-reply{
	width: 930px;
	min-height: 130px;
	margin-top: 10px;
	margin-bottom: 0px;
    padding: 5px 10px 10px 18px;
    border: 2px solid #cfcfcf;
    border-radius: 6px;
    box-sizing: border-box;
}

.notice-reply-content{
	width: 950px;
	min-height: 130px;
	margin-top: 20px;
	margin-bottom: 10px;
    padding: 5px 10px 10px 18px;
    border: 2px solid #cfcfcf;
    border-radius: 6px;
    box-sizing: border-box;
}

.notice-reply-line{
	width: 930px;
    border-top: 1px solid #cfcfcf;
    min-height: 10px;
    margin-top: 20px;
}

.notice-reply{ 
	padding: 0px 10px 5px 10px;
	width: 950px;
}

.regit-btn{
	width: 60px;
}

.notice-bottom{
	width: 950px; 
	margin: 15px auto;
	padding: 10px 20px 10px 0;
	text-align: right;	
}

.notice-bottom > btn{	

	height: 30px;		
	line-height: 30px;	
	font-size: 20px;
	text-align: right;
	display: inline-block;
	width: 30px;
}

.list-btn:hover{
	background-color: #FFD5B4;
	border: none;
	color: black;
}

.comment_inbox_text{
    display: block;
    width: 100%;
    min-height: 17px;
    padding-right: 1px;
    border: 0;
    font-size: 13px;
    -webkit-appearance: none;
    resize: none;
    box-sizing: border-box;
    background: transparent;
    color: var(--skinTextColor);
    outline: 0;
}

.update-btn, .delete-btn{
	display:inline-block;
	line-height: 14px;
	text-align: center;
	width: 48px;
	height: 33px;
	font-size: 14px;
}

</style>

<script>
	function updateReply(obj){
		var viewClass = document.querySelectorAll(".re");
		var editClass = document.querySelectorAll(".up");
		
		for(var i=0; i<viewClass.length; i++){
			viewClass[i].style.display = "";
			editClass[i].style.display = "none";
		}
		
		var viewWindow = document.querySelector("#re"+obj.id);
		var editWindow = document.querySelector("#up"+obj.id);
		
		if(viewWindow != null)
			viewWindow.style.display = "none";
		
		if(editWindow != null)
			editWindow.style.display = "";	
		
		var textarea = document.querySelector("#comment_update");
		textarea.focus();
	}
	
	function cancleUpdate(){
		var viewClass = document.querySelectorAll(".re");
		var editClass = document.querySelectorAll(".up");
		
		for(var i=0; i<viewClass.length; i++){
			viewClass[i].style.display = "";
			editClass[i].style.display = "none";
		}
	}
</script>

<div class="qna">

	<h2 class="title">고객센터</h2>
	
	<div class="tabmenu-black">
		<a href="qnaList.jsp"> 
			<span>고객의 소리</span>
		</a> 
		<a href="qnaInsert.jsp"> 
			<span>1:1 문의 등록</span>
		</a> 
		<a class="on" href="qnaMyList.jsp"> 
			<span>1:1 문의 확인</span>
		</a> 
		<a href="qnaNotice.jsp"> 
			<span>공지사항</span>
		</a>
	</div>
	
	<h2 class="subtitle">문의확인</h2>
	
	<div class="qna-notice-row">
     
		<div class="notice-title">
			<strong style="padding:0 0 0 10px;"><%=qnaBoardDto.getQnaBoardTitle() %></strong>
			<span><%=qnaBoardDto.getQnaBoardTime() %></span>
		</div>
		
		<div class="notice-content">
			<div style="float: left; width: 100%;min-height: 200px; padding: 10px 20px 10px 20px;">
				<pre><%=qnaBoardDto.getQnaBoardContent() %></pre>
			</div>
		</div>
	<!-- 버튼 -->
		<%if(memberNo == qnaBoardDto.getQnaBoardWriter()){ %>
    	<div class="notice-bottom">
	        <a class="form-btn form-btn-normal delete-btn" href="qnaBoardEdit.jsp?qnaBoardNo=<%=qnaBoardNo%>">수정</a>
	        <a class="form-btn form-btn-normal delete-btn" href="qnaboardDelete.kh?qnaBoardNo=<%=qnaBoardNo%>" >삭제</a>
     	</div>
     	<%} %>
     	
		<div class="notice-reply-line" style="margin-left:10px;">	</div>
					
		<div class="notice-reply">
			<%if(list != null) { %>
				<%for(QnaReplyMemberDto qnaReplyMemberDto : list){ %>
					<div class="row re" id="re<%=qnaReplyMemberDto.getQnaReplyNo() %>">
						<div class="row">
							<span><%=qnaReplyMemberDto.getMemberId() %></span>
						</div>
						<div class="row">
							<span><%=qnaReplyMemberDto.getQnaReplyContent() %></span>
						</div>
						<div class="row">
							<span style="display:inline-block; text-align:left;"><%=qnaReplyMemberDto.getQnaReplyTime().toLocaleString() %></span>
							<%if(memberNo == qnaReplyMemberDto.getQnaReplyWriter()) {%>
								<div style="float:right;">																
									<a id="<%=qnaReplyMemberDto.getQnaReplyNo()%>" href="#" onclick="updateReply(this); return false" class="form-btn form-btn-normal update-btn">수정</a>							
									<a href="deleteQnaReply.kh?qnaReplyNo=<%=qnaReplyMemberDto.getQnaReplyNo() %>&qnaReplyWriter=<%=qnaReplyMemberDto.getQnaReplyWriter() %>&qnaReplyOrigin=<%=qnaReplyMemberDto.getQnaReplyOrigin() %>" 
									class="form-btn form-btn-normal delete-btn">삭제</a>															
								</div>								
							<%} %>
						</div>
					</div>
					
					<div class="notice-update-reply up" id="up<%=qnaReplyMemberDto.getQnaReplyNo() %>" style="display:none;">
						<form action="updateQnaReply.kh" method="post" >
							<div class="row">
								<div class="row">
									<strong><%=memberDto.getMemberId() %></strong>
								</div>
								<div class="row">							
									<textarea name="qnaReplyContent" placeholder="<%=qnaReplyMemberDto.getQnaReplyContent() %>" rows="1" class="comment_inbox_text" id="comment_update" style="overflow: hidden; overflow-wrap: break-word; height: 30px;" required></textarea>
									<input type="hidden" name="qnaReplyNo" value="<%=qnaReplyMemberDto.getQnaReplyNo() %>">
									<input type="hidden" name="qnaReplyWriter" value="<%=memberNo %>">
									<input type="hidden" name="qnaReplyOrigin" value="<%=qnaBoardNo %>" >
								</div>
							</div>
							
							<div class="row text-right" style="padding:0 10px 5px 0;">
								<input type="submit" class="form-btn form-btn-normal regit-btn" value="수정" style="width:50px; ">
								<input type="button" class="form-btn form-btn-normal regit-btn" value="취소" onclick="cancleUpdate();" style="width:50px; ">
							</div>
						</form>
					</div>	
								
					<div class="notice-reply-line">
					</div>
				<%} %>
			<%} %>
		</div>
		
		<div class="notice-regit-reply">
				<form action="insertQnaReply.kh" method="post">
					<div class="row">
						<div class="row">
							<strong><%=memberDto.getMemberId() %></strong>
						</div>
						<div class="row">							
							<textarea name="qnaReplyContent" placeholder="댓글을 남겨보세요" rows="1" class="comment_inbox_text" style="overflow: hidden; overflow-wrap: break-word; height: 30px;" required></textarea>
							<input type="hidden" name="qnaReplyWriter" value="<%=memberNo %>">
							<input type="hidden" name="qnaReplyOrigin" value="<%=qnaBoardNo %>" >
						</div>
					</div>
					
					<div class="row text-right" style="padding:0 10px 5px 0;">
						<input type="submit" class="form-btn form-btn-normal regit-btn" value="등록">
					</div>
				</form>
		</div>	
	</div>
	
	<div class="notice-bottom">
			<a class="form-btn form-btn-normal list-btn" href="qnaMyList.jsp" >나의 1:1 문의목록</a>
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>
