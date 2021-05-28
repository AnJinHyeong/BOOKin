<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String root = request.getContextPath();
%>
<style>
	.row > a {
		display:inline-block;
		width:30%;
		text-align:center;
	}
</style>

<jsp:include page="/template/header.jsp"></jsp:include>
<meta http-equiv="refresh" content="5; url=<%=root%>">
<div class="container-600">
	<div class="row text-center" style="margin-top: 100px;">
		<span style="font-size: 40px; color: #ff9f43;">가입해주셔서 감사합니다</span>		
	</div>
	<div class="row text-center" style="margin-top: 50px;">
		<span style="font-size: 20px; ">5초 뒤에 메인페이지로 이동합니다</span>
	</div>
	
	<div class="row text-center" style="margin-top: 120px;">
		<a href="<%=root %>" class="form-btn form-btn-normal">메인페이지</a>
		<a href="<%=root %>/member/login.jsp" class="form-btn form-btn-positive">로그인</a>
	</div>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>