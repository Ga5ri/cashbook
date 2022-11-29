<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	if(session.getAttribute("loginMember") == null) {
		// 로그인되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String memberId = request.getParameter("memberId");
	System.out.println("memberId->>"+memberId);
	String helpMemo = request.getParameter("helpMemo");
	
	// Model
	HelpDao helpDao = new HelpDao();
	int isResult = helpDao.insertHelp(memberId, helpMemo);
	if(isResult != 0){
		System.out.println("추가 성공");
	} else {
		System.out.println("추가 실패");
	}
	
	String redirectUrl = "/help/helpList.jsp";
	response.sendRedirect(request.getContextPath()+redirectUrl);
	
%>