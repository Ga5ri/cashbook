<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	//session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 관리자
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	System.out.println("commentNo->"+commentNo);
	String commentMemo = request.getParameter("commentMemo");
	
	// Model 호출
	CommentDao commentDao = new CommentDao();
	HashMap<String, Object> comment = commentDao.selectCommentOne(commentNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>답변수정</h1>
	<table>
		<tr>
			<td>답변번호</td>
			<td><input type="text" name="commentNo" value="<%=commentNo%>" readonly="readonly"></td>
		</tr>
		<tr>
			<td>내용수정</td>
			<td><textarea rows="3" cols="30" name="commentMemo"></textarea></td>
		</tr>
	</table>
</body>
</html>