<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	if(session.getAttribute("loginMember") != null) {
	// 로그인된 상태
	response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
	return;
	}
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage - 1) * rowPerPage;

	// Model 호출
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);

	// lastPage
	int lastPage = noticeDao.selectNoticeCount() / rowPerPage;
	if(noticeDao.selectNoticeCount() % rowPerPage != 0) {
		lastPage+=1;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
</head>
<body>
	<!--  공지(5개) list 페이징 -->
	<div>
		<h1>공지사항</h1>
		<table>
			<tr>
				<th>공지내용</th>
				<th>날짜</th>
			</tr>
			<%
				for(Notice n : list) {
			%>
					<tr>
						<td><%=n.getNoticeMemo()%></td>
						<td><%=n.getCreatedate()%></td>
					</tr>
			<%		
				}
			%>
		</table>
		<div>
			<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1">처음</a>
			<%
				if(currentPage > 1) {				
			%>
					<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%
				}
			%>
				<span><%=currentPage%></span>
			<%
				if(currentPage < lastPage) {
			%>
					<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>">다음</a>	
			<%
				}
			%>
			<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>">마지막</a>
		</div>
	</div>
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
	<div>
		<a href="<%=request.getContextPath()%>/member/insertMemberForm.jsp">회원가입</a>
	</div>
</body>
</html>