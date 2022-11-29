<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	//Controller
	request.setCharacterEncoding("utf-8");
	//session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String categoryNo = request.getParameter("categoryNo");
	
	// Model
	Category category = new Category();
	category.setCategoryNo(Integer.parseInt(categoryNo));
	
	CategoryDao categoryDao = new CategoryDao();
	int delRow = categoryDao.deleteCategory(categoryNo);
	
	if(delRow == 1){
		System.out.println("삭제 성공");
		String redirectUrl = "/admin/categoryList.jsp";
		response.sendRedirect(request.getContextPath()+redirectUrl);
	}
	
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>