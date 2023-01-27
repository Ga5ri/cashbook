<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	if(session.getAttribute("loginMember") == null) {
		// 로그인되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String helpMemo = request.getParameter("helpMemo");
	
	// Model 호출
	HelpDao helpDao = new HelpDao();
	int row = helpDao.updateHelp(helpNo, helpMemo);
	
	if(row == 1) {
		System.out.println("문의 수정 성공!");
		response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
		return;
	} else {
		System.out.println("문의 수정 실패!");
	}
%>