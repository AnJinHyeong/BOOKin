<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%for(int i=1;i<=19;i++){ %>
	<a href="savebook.kh?start=<%=10*i-9%>&end=<%=10*i%>">책 추가 <%=i%></a>
	<br>
	<%} %>
</body>
</html>