<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	//session에 저장된 멤버(현재 로그인 사용자)
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 관리자
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	System.out.println("commentNo->"+commentNo);
	String commentMemo = request.getParameter("commentMemo");
	
	// Model 호출 1
	CommentDao commentDao = new CommentDao();
	Comment comment = commentDao.selectCommentOne(commentNo);
	// Model 호출 2
	HelpDao helpDao = new HelpDao();
	int helpNo = comment.getHelpNo();
	HashMap<String, Object> help = helpDao.selectHelpListByHelpNo(helpNo);
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
			<td>회원아이디</td>
			<td><input type="text" name="memberId" value="<%=help.get("memberId")%>" readonly="readonly"></td>
		</tr>
		<tr>
			<td>회원문의사항</td>
			<td><input type="text" name="helpMemo" value="<%=help.get("helpMemo")%>" readonly="readonly"></td>
		</tr>
		<tr>
			<td>답변번호</td>
			<td><input type="number" name="helpNo" value="<%=help.get("helpNo")%>" readonly="readonly"></td>
		</tr>
	</table>
	<form action="<%=request.getContextPath()%>/admin/updateCommentAction.jsp?commentNo=<%=commentNo%>" method="post">
		<table>
			<tr>
				<td>내용수정</td>
				<td><textarea rows="3" cols="30" name="commentMemo"><%=comment.getCommentMemo()%></textarea></td>
			</tr>
		</table>
		<div>
			<button type="submit">수정</button>
		</div>
	</form>
</body>
</html>