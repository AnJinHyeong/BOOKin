<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String root = request.getContextPath();
%>

<link rel="stylesheet" type="text/css" href="<%= root%>/css/template.css">
<jsp:include page="/template/homeHeader.jsp"></jsp:include>
<jsp:include page="/template/homelist.jsp"></jsp:include>
<jsp:include page="/template/footer.jsp"></jsp:include>

