<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%
	//session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	String loginMemberName = loginMember.getMemberName();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<h1>닉네임 변경</h1>
		<form action="<%=request.getContextPath()%>/member/updateMemberAction.jsp" method="post">
			<table>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="memberId" value="<%=loginMemberId%>" readonly="readonly"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="memberPw" value=""></td>
				</tr>
				<tr>
					<td>닉네임</td>
					<td><input type="text" name="memberName" value="<%=loginMemberName%>"></td>
				</tr>
			</table>
			<div>
				<button type="submit">변경</button>
			</div>
		</form>
	</div>
</body>
</html>