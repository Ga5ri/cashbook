<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// Controller
	// session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 페이징
	int currentPage = 1;
	int rowPerPage = 10;
	int beginRow = (currentPage - 1) * rowPerPage;

	
	// Model 호출
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);

	// int lastPage = 0; <--과제
	int lastPage = noticeDao.selectNoticeCount() / rowPerPage;
	if( noticeDao.selectNoticeCount() % rowPerPage != 0) {
		lastPage+=1;
	}
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리(목록, 레벨수정, 강제탈퇴)</a></li>
	</ul>
	<div>
		<!-- noticeList contents... -->
		<h1>공지사항</h1>
		<a href="<%=request.getContextPath()%>/admin/insertNoticeForm.jsp">공지입력</a>
		<table border="1">
			<tr>
				<th>공지내용</th>
				<th>공지날짜</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<%
				for(Notice n : list) {
			%>
					<tr>
						<td><%=n.getNoticeMemo()%></td>
						<td><%=n.getCreatedate()%></td>
						<td><a href="">수정</a></td>
						<td><a href="">삭제</a></td>
					</tr>
			<%		
				}
			%>
		</table>
	</div>
</body>
</html>