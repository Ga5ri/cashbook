<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("loginMember") != null) {
	// 로그인된 상태
	response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
		<table>
			<tr>
				<td>ID</td>
				<td><input type="text" name="memberId"></td>
			</tr>
			<tr>
				<td>PW</td>
				<td><input type="password" name="memberPw"></td>
			</tr>
		</table>
		<button type="submit">로그인</button>
	</form>
</body>
</html>