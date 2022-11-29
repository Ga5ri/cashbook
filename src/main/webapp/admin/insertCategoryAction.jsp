<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	//session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
	
	
	// Model
	Category category = new Category();
	category.setCategoryName(categoryName);
	category.setCategoryKind(categoryKind);
	
	CategoryDao categoryDao = new CategoryDao();
	int isRow = categoryDao.insertCategory(category);
	
	if(isRow == 1){
		System.out.println("입력 성공");
		String redirectUrl = "/admin/categoryList.jsp";
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
%>