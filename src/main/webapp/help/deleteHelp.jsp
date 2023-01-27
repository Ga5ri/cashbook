<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	if(session.getAttribute("loginMember") == null) {
		// 로그인되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 

	//session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));

	HelpDao helpDao = new HelpDao();
	int row = helpDao.deleteHelp(helpNo);

	if(row == 1){
		System.out.println("삭제성공!");
		response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
		return;
	}else {
		System.out.println("삭제실패");
	}
	

%>