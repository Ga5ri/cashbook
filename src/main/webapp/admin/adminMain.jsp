<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1 ){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	}

	// Model 호출
	
	// 최근공지 5개, 최근멤버 5명 
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<jsp:include page="/inc/head.jsp"></jsp:include>
	</div>
</body>
</html>