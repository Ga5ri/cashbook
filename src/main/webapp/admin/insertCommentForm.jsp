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
	String loginMemberId = loginMember.getMemberId();
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	// Model 호출
	HelpDao helpDao = new HelpDao();
	HashMap<String, Object> help = helpDao.selectHelpListByHelpNo(helpNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>문의사항 답변 입력</h1>
	<form action="<%=request.getContextPath()%>/admin/insertCommentAction.jsp" method="post">
		<input type="hidden" name="commentNo" value="">
		<table>
			<tr>
				<td>문의번호</td>
				<td><input type="number" name="helpNo" value="<%=helpNo%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>문의내용</td>
				<td><input type="text" name="helpMemo" value="<%=help.get("helpMemo")%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>회원아이디</td>
				<td><input type="text" name="memberId" value="<%=help.get("memberId")%>" readonly="readonly"></td>
	        </tr>
	        <tr>
	        	<td>답변내용</td>
	        	<td><textarea rows="5" cols="30" name="commentMemo"></textarea></td>
			</tr>
		</table>
		<div>
			<button type="submit">답변입력</button>
		</div>
	</form>
</body>
</html>