<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("login");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// Model 호출
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> list = memberDao.selectMemberListByPage(0, 0);
	int memberCount = memberDao.selectMemberCount(); // --> lastPage
	
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
		<!-- memberList contents... -->
		<h1>멤버목록</h1>
		<table>
			<tr>
				<th>멤버번호</th>
				<th>아이디</th>
				<th>레벨</th>
				<th>이름</th>
				<th>마지막수정일자</th>
				<th>생성일자</th>
				<th>레벨수정</th>
				<th>강제탈퇴</th>
			</tr>
			<%
				for(Member m : list) {
					
				}
			%>
		</table>
	</div>
</body>
</html>