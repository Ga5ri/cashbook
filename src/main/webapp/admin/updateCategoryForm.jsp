<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	//Controller
	// session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String categoryNo = request.getParameter("categoryNo");
	
	Category category = new Category();
	category.setCategoryNo(Integer.parseInt(categoryNo));
	
	// Model 호출
	CategoryDao categoryDao = new CategoryDao();
	Category paramCategory = categoryDao.selectCategoryOne(category);

%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>카테고리 수정</h1>
	<form action="<%=request.getContextPath()%>/admin/updateCategoryAction.jsp" method="post">
		<table>
			<tr>
				<td>번호</td>
				<td><input type="number" name="categoryNo" value="<%=paramCategory.getCategoryNo()%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>수입/지출</td>
				<td>
					<%
						if(paramCategory.getCategoryKind().equals("수입")) {
					%>
						<input type="radio" name="categoryKind" value="수입" checked>수입
						<input type="radio" name="categoryKind" value="지출">지출
					<%
						} else {
					%>
						<input type="radio" name="categoryKind" value="수입">수입
						<input type="radio" name="categoryKind" value="지출" checked>지출
					<%	
						}
					%>
				</td>
			</tr>
			<tr>
				<td>분류</td>
				<td><input type="text" name="categoryName" value="<%=paramCategory.getCategoryName()%>"></td>
			</tr>
		</table>
		<div>
			<button type="submit">수정</button>
		</div>
	</form>
</body>
</html>