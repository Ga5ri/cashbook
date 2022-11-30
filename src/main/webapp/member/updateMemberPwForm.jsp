<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	if(session.getAttribute("loginMember") == null) {
		// 로그인되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	//session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>비밀번호 변경</h1>
	<form action="<%=request.getContextPath()%>/member/updateMemberPwAction.jsp" method="post">
		<table>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="memberId" value="<%=memberId%>"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="memberPw" value=""></td>
			</tr>
			<tr>
				<td>변경할 비밀번호</td>
				<td><input type="password" name="updatePw" value=""></td>
			</tr>
		</table>
		<div>
			<button type="submit">변경</button>
		</div>
	</form>
</body>
</html>