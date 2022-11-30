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
	
	int categoryNo= Integer.parseInt(request.getParameter("categoryNo"));
	
	// Model 호출
	CategoryDao categoryDao = new CategoryDao();
	if(categoryDao.deleteCategory(categoryNo) == 1) {
		String redirectUrl = "/admin/categoryList.jsp";
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;		
	}
%>