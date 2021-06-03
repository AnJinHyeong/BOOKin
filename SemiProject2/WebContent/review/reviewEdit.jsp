<%@page import="semi.beans.ReviewDto"%>
<%@page import="semi.beans.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
ReviewDao reviewDao = new ReviewDao();
ReviewDto reviewDto = reviewDao.get(reviewNo);
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>리뷰 수정</h2>
<!-- 보내야 할 항목 제목,이미지,내용,작성자,작성시간,평점 -->
<form action="reviewEdit.kh">
<input type="hidden" name="reviewNo" value=<%=reviewDto.getReviewNo() %>">
<textarea name="reviewContent"><%=reviewDto.getReviewContent() %></textarea>
<input type="text" name="reviewRate" value="<%=reviewDto.getReviewRate() %>">
<input type="submit" value="수정">

</form>
<jsp:include page="/template/footer.jsp"></jsp:include>
</body>
</html>