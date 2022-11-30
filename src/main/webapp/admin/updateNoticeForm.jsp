<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	// Controller
	//session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 관리자
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println("noticeNo->"+noticeNo);
	String noticeMemo = request.getParameter("noticeMemo");
	
	NoticeDao noticeDao = new NoticeDao();
	Notice notice = noticeDao.selectNoticeOne(noticeNo);
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>공지사항 수정</h1>
	<form action="<%=request.getContextPath()%>/admin/updateNoticeAction.jsp" method="post">
		<table>
			<tr>
				<td>번호</td>
				<td><input type="number" name="noticeNo" value="<%=noticeNo%>"></td>
			</tr>
			<tr>
				<td>공지사항 입력</td>
				<td><textarea rows="5" cols="50" name="noticeMemo"><%=notice.getNoticeMemo()%></textarea>
			</tr>
		</table>
		<div>
			<button type="submit">수정</button>
		</div>
	</form>
</body>
</html>