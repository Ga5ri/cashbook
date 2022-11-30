<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	
	// Model 호출
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> list = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	int memberCount = memberDao.selectMemberCount(); // --> lastPage
	
	// lastPage
	int lastPage = memberDao.selectMemberCount() / rowPerPage;
	if(memberDao.selectMemberCount() % rowPerPage != 0) {
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
	<div>
		<jsp:include page="/inc/head.jsp"></jsp:include>
	</div>
	<div>
		<!-- memberList contents... -->
		<h1>멤버목록</h1>
		<table>
			<tr>
				<th>멤버번호</th>
				<th>아이디</th>
				<th>회원구분(레벨)</th>
				<th>이름</th>
				<th>마지막수정일자</th>
				<th>생성일자</th>
				<th>레벨수정</th>
				<th>강제탈퇴</th>
			</tr>
			<%
				for(Member m : list) {
			%>
					<tr>
						<td><%=m.getMemberNo()%></td>
						<td><%=m.getMemberId()%></td>
						<td>
							<%
								if(m.getMemberLevel() == 0) {
							%> 
									<sapn>회원</sapn>
							<%		
								} else if(m.getMemberLevel() == 1) {
							%>
									<sapn>관리자</sapn>
							<%		
								}
							%>
							(<%=m.getMemberLevel()%>)
						</td>
						<td><%=m.getMemberName()%></td>
						<td><%=m.getUpdatedate()%></td>
						<td><%=m.getCreatedate()%></td>
						<td>
							<form action="<%=request.getContextPath()%>/admin/updateMemberLevelAction.jsp" method="post">
								<input type="hidden" name="memberId" value="<%=m.getMemberId()%>">
								<select name="memberLevel">
									<option value="0">0</option>
									<option value="1">1</option>
								</select>
								<button type="submit">레벨수정</button>
							</form>
						</td>
						<td><a href="<%=request.getContextPath()%>/admin/deleteMemberAction.jsp?memberId=<%=m.getMemberId()%>">강퇴</a></td>
					</tr>
			<%		
				}
			%>
		</table>
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=1">처음</a>
		<%
			if(currentPage > 1) {				
		%>
				<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
		%>
			<span><%=currentPage%></span>
		<%
			if(currentPage < lastPage) {
		%>
				<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>">다음</a>	
		<%
			}
		%>
		<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=lastPage%>">마지막</a>
	</div>
</body>
</html>