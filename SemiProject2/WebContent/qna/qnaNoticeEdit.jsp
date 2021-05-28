<%@page import="semi.beans.NoticeBoardDto"%>
<%@page import="semi.beans.NoticeBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	int noticeBoardNo = Integer.parseInt(request.getParameter("noticeBoardNo"));
	NoticeBoardDao noticeBoardDao = new NoticeBoardDao();
	
	NoticeBoardDto noticeBoardDto = noticeBoardDao.get(noticeBoardNo);
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

.qna-type>a {
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

.qna-type>.on {
	position: relative;
	height: 65px;
	color: #ff7d9e;
	border-color: #ff7d9e;
	background: #fff;
	border-bottom: 0;
}

.qna-insert {
	width: 500px;
	margin: 0 auto;
}

.qna-row {
	margin: 10px auto;
	padding: 10px;
	text-align: center;
	justify-content: space-between;
	display: flex;
	line-height: 30px;
}

.qna-form-input {
	width: 300px;
	height: 30px;
}

.qna-form-content {
	height: 200px;
	width: 300px;
	resize: none;
}

.qna-row-btn {
	margin: 10px auto;
	padding: 20px;
	text-align: center;
	justify-content: space-between;
}

.qna-form-btn {
	margin: 0 15px;
	width: 120px;
	height: 30px;
	background-color: black;
	color: white;
	line-height: 30px;
	border-style: none;
}

.qna-form-btn:hover {
	background-color: #FFB900;
}

.qna-cancel {
	display: inline-block;
	width: 120px;
	height: 30px;
	background-color: #dcdcdc;
	color: #3c3c3c;
	line-height: 30px;
	border-style: none;
}

.qna-cancel:hover {
	background-color: #d2d2d2;
}

</style>


<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
		$("select[name=noticeBoardHeader]").val("<%=noticeBoardDto.getNoticeBoardHeader()%>");
	});
</script>

<div class="qna">

	<h2 class="title">고객센터</h2>

	<div class="tabmenu-black">
		<a href="qnaList.jsp"> <span>고객의 소리</span>
		</a> <a href="qnaInsert.jsp"> <span>1:1 문의 등록</span>
		</a> <a href="qnaMyList.jsp"> <span>1:1 문의 확인</span>
		</a> <a class="on" href="qnaNotice.jsp"> <span>공지사항</span>
		</a>
	</div>

	<h2 class="subtitle">NOTICE 수정</h2>
	
	<hr style="width: 1000px; margin: 0px auto;">

	<!-- 보내야 할 항목 4개, 사용자가 고칠 수 있는 항목 3개, 히든 1개 -->
	<div class="qna-insert">
		<form action="qnaNoticeEdit.kh" method="post">
			<input type="hidden" name="noticeBoardNo" value="<%=noticeBoardDto.getNoticeBoardNo()%>">  
			
			<div class="qna-row">
				<span>문의유형</span>
				<select name="noticeBoardHeader" class="qna-form-input" required>
					<option value="">선택</option>
					<option>공지</option>
					<option>이벤트</option>
				</select> 
			</div>
			
			<div class="qna-row">
				<label>제목</label> 
				<input class="qna-form-input" type="text" name="noticeBoardTitle" required value="<%=noticeBoardDto.getNoticeBoardTitle()%>">
			</div>
			
			<div class="qna-row">
				<label>내용</label>
				<textarea class="qna-form-content" name="noticeBoardContent" required><%=noticeBoardDto.getNoticeBoardContent()%></textarea>
			</div>	
			
			<div class="qna-row-btn">
				<input class="qna-form-btn" type="submit" value="수정">
				<a class="qna-cancel" href="qnaNoticeDetail.jsp?noticeBoardNo=<%=noticeBoardDto.getNoticeBoardNo()%>">취소</a>
			</div>
		</form>
	</div>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>
