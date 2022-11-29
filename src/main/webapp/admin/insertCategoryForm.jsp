<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// Controller
	// session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<h1>카테고리 추가</h1>
	</div>
	<form action="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp" method="post">
		<table>
			<tr>
				<th>categoryKind</th>
			</tr>
			<tr>
				<td>
					<input type="radio" name="categoryKind" value="수입">수입
					<input type="radio" name="categoryKind" value="지출">지출
				</td>
			</tr>
			<tr>
				<td>CategoryName<td>
				<td><input type="text" name="categoryName"></td>
			</tr>
		</table>
		<div>
			<button type="submit">추가</button>
		</div>
	</form>
</body>
</html>