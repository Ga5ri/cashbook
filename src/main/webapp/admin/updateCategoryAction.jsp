<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	//Controller
	request.setCharacterEncoding("utf-8");
	// session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int categoryNo= Integer.parseInt(request.getParameter("categoryNo"));
	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
	
	// 공백 or null값시 리스트로 되돌리기
	if(request.getParameter("categoryName") == null || request.getParameter("categoryName").equals("")) {
		String redirectUrl = "/admin/updateCategoryForm.jsp";
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;		
		
	}
	
	// 객체 생성
	Category category = new Category();	
	category.setCategoryNo(categoryNo);
	category.setCategoryKind(categoryKind);
	category.setCategoryName(categoryName);

	// Model 호출
	CategoryDao categoryDao = new CategoryDao();
	if(categoryDao.updateCategory(category) == 1) {		
		String redirectUrl = "/admin/categoryList.jsp";
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;		
	}
%>