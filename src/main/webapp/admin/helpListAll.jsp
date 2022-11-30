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
	
	String memberId = loginMember.getMemberId();
	System.out.println("memberId->>"+memberId);
	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	// Model 호출
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(beginRow, rowPerPage);
	
	// lastPage
	int lastPage = helpDao.selectHelpCount() / rowPerPage;
	if(helpDao.selectHelpCount() % rowPerPage != 0) {
		lastPage+=1;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- head include -->
	<div>
		<jsp:include page="/inc/head.jsp"></jsp:include>
	</div>
	<h1>문의사항관리</h1>
	<!-- 고객센터 문의목록 출력 -->
	<table>
		<tr>
			<th>문의내용</th>
			<th>회원아이디</th>
        	<th>문의날짜</th>
        	<th>답변내용</th>
        	<th>답변날짜</th>
        	<th>답변추가 / 수정 / 삭제</th>
		</tr>
		<%
			for(HashMap<String, Object> m : list) {
		%>
				<tr>
					<td><%=m.get("helpMemo")%></td>
					<td><%=m.get("memberId")%></td>
					<td><%=m.get("helpCreatedate")%></td>
					<td>
	                 	 <%
	                     	if(m.get("commentMemo") == null) {
	                 	 %>
	                        답변전
	                 	 <%      
	                     	} else {
	                 	 %>
	                        <%=m.get("commentMemo")%>
	                 	 <%   
	                    	 }
	                 	 %>   
	             	</td>
	             	<td>
	             	     <%
	                     	if(m.get("commentCreatedate") == null) {
	             	     %>
	                        답변전   
	              	    <%      
	                    	 } else {
	              	    %>
	                        <%=m.get("commentCreatedate")%>
	               	   	<%   
	                     	}
	                	%>   
              	 	</td>
					<td>
						<%
							if(m.get("commentMemo") == null) {
						%>
								<a href="<%=request.getContextPath()%>/admin/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>">
									답변입력
								</a>
						<%		
							} else {
						%>
								<a href="<%=request.getContextPath()%>/admin/updateCommentForm.jsp?commentNo=<%=m.get("commentNo")%>">답변수정</a>
								<a href="<%=request.getContextPath()%>/admin/deleteComment.jsp?commentNo=<%=m.get("commentNo")%>">답변삭제</a>
						<%		
							}
						%>
					</td>
				</tr>
		<%		
			}
		%>
	</table>
	<div>
		<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=1">처음</a>
		<%
			if(currentPage > 1) {				
		%>
				<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
		%>
			<span><%=currentPage%></span>
		<%
			if(currentPage < lastPage) {
		%>
				<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage+1%>">다음</a>	
		<%
			}
		%>
		<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=lastPage%>">마지막</a>
	</div>
	<!-- footer include -->
</body>
</html>