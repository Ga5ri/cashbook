<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	//session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String loginMemberId = loginMember.getMemberId();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>문의하기</h1>
	<form action="<%=request.getContextPath()%>/help/insertHelpAction.jsp" method="post">
		<table>
			<tr>
				<td>문의내용</td>
				<td><textarea rows="3" cols="30" name="helpMemo"></textarea></td>
			</tr>
		</table>	
		<div>
			<button type="submit">문의하기</button>
		</div>
	</form>
</body>
</html>