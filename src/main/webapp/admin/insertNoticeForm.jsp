<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
//session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 관리자
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>공지사항 입력</h1>
	<form action="<%=request.getContextPath()%>/admin/insertNoticeAction.jsp" method="post">
		<table>
			<tr>
				<td>입력할 공지사항</td>
				<td><textarea rows="5" cols="50" name="noticeMemo"></textarea></td>
			</tr>
		</table>
		<div>
			<button type="submit">입력</button>
		</div>
	</form>
</body>
</html>