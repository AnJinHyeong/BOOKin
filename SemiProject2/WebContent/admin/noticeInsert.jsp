<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="semi.beans.GenreDto"%>
<%@page import="java.util.List"%>
<%@page import="semi.beans.GenreDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
		String root = request.getContextPath();
	%>
	
<style>
	.notice-type-select{
		width: 100%;
		height: 30px;
	}
</style>

<jsp:include page="/template/adminSidebar.jsp"></jsp:include>
	<section>
		<div class="admin-content_area">
			<div class="admin-content">
				<div class="admin-content_title">
					NOTICE 등록
				</div>
			</div>
		</div>
		<form action="<%=root%>/admin/qnaNoticeInsert.kh" method="post" >
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
					<input type='text' name="noticeBoardTitle" placeholder="제목을 입력하세요." required>
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
					<textarea name="noticeBoardContent" placeholder="내용을 입력해주세요." required></textarea>
					</div>
				</div>
			</div>
			
			<button class="submit-btn">등록</button>
		</form>
	</section>
</body>
</html>