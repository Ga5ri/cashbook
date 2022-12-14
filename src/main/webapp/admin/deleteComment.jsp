<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	//Controller
	//session에 저장된 멤버(현재 로그인 사용자)
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 관리자
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 공백 or null값시 리스트로 되돌리기
	if(request.getParameter("commentNo") == null || request.getParameter("commentNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
		return;
	}

	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	
	// Model 호출
	CommentDao commentDao = new CommentDao();
	int row = commentDao.deleteComment(commentNo);
	if(row == 0) {
		System.out.println("comment 삭제 실패");
	} else {
		System.out.println("comment 삭제 성공");
	}
	
	// View 대신 Redirect
	String redirectUrl = "/admin/helpListAll.jsp";
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>