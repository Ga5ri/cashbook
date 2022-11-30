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
		<h1>마이페이지</h1>
		<table>
			<tr>
				<td>ID :</td>
				<td><%=loginMemberId%></td>
			</tr>
			<tr>
				<td>닉네임 :</td>
				<td><%=loginMemberName%></td>
			</tr>
		</table>
		<div>
			<a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp">닉네임 변경</a>
			<a href="<%=request.getContextPath()%>/member/updateMemberPwForm.jsp">비밀번호 변경</a>
		</div>
		<div>
			<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
		</div>
	</div>
</body>
</html>