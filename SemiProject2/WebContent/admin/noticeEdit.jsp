<%@page import="semi.beans.NoticeBoardDto"%>
<%@page import="semi.beans.NoticeBoardDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	int noticeBoardNo = Integer.parseInt(request.getParameter("noticeBoardNo"));	
    
		String root = request.getContextPath();
		NoticeBoardDao noticeBoardDao = new NoticeBoardDao();
		NoticeBoardDto noticeBoardDto = noticeBoardDao.get(noticeBoardNo);
	%>
	
<style>
	.notice-type-select{
		width: 100%;
		height: 30px;
	}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
		$("select[name=noticeBoardHeader]").val("<%=noticeBoardDto.getNoticeBoardHeader()%>");
	});
</script>

<jsp:include page="/template/adminSidebar.jsp"></jsp:include>
	<section>
		<div class="admin-content_area">
			<div class="admin-content">
				<div class="admin-content_title">
					<%=noticeBoardDto.getNoticeBoardNo() %>번 NOTICE 수정
				</div>
			</div>
		</div>
		<form action="<%=root%>/admin/qnaNoticeEdit.kh" method="post" >
		<input type="hidden" name="noticeBoardNo" value="<%=noticeBoardDto.getNoticeBoardNo()%>">
		
			<div class="admin-content_area">
				<div class="admin-content">
					<div class="admin-content_title">
						<span>구분</span>
					</div>
					<div class="admin-input_text">
						<select name="noticeBoardHeader" required class="notice-type-select">
							<option value="">선택하세요</option>
							<option>공지</option>
							<option>이벤트</option>
						</select>
					</div>
				</div>
			</div>
			
			<div class="admin-content_area">
				<div class="admin-content">
					<div class="admin-content_title">
						<span>제목</span>
					</div>
					<div class="admin-input_text">
					<input type='text' name="noticeBoardTitle" placeholder="제목을 입력하세요." required value="<%=noticeBoardDto.getNoticeBoardTitle()%>">
					</div>
				</div>
			</div>
			
	<!-- 		<div class="admin-content_area"> -->
	<!-- 			<div class="admin-content "> -->
	<!-- 				<div class="admin-content_title"> -->
	<!-- 					상품 이미지 -->
	<!-- 				</div> -->
	<!-- 				<div class='img-up-text'><span>이미지 등록</span></div> -->
	<!-- 				<label for="input-file"> -->
	<!-- 				  <img class='admin-upload_img'> -->
	<!-- 				</label> -->
	<!-- 				<input class="input_img" required type="file" accept=".png, .jpg, .gif" id="input-file" name="bookImage" style="display: none"/> -->
	<!-- 			</div> -->
	<!-- 		</div> -->
			
			<div class="admin-content_area">
				<div class="admin-content">
					<div class="admin-content_title">
						<span>내용</span>
					</div>
					<div class="admin-input_text">
					<textarea name="noticeBoardContent" placeholder="내용을 입력해주세요." required><%=noticeBoardDto.getNoticeBoardContent() %></textarea>
					</div>
				</div>
			</div>
			
			<button class="submit-btn">등록</button>
		</form>
	</section>
</body>
</html>