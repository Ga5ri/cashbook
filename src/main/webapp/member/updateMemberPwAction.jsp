<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	if(session.getAttribute("loginMember") == null) {
		// 로그인되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	//session에 저장된 멤버(현재 로그인 사용자, 객체 생성
	Member loginMember = new Member();
	loginMember = (Member) session.getAttribute("loginMember");
	loginMember.setMemberPw(request.getParameter("memberPw"));
	
	String updatePw = request.getParameter("updatePw");
	
	MemberDao memberDao = new MemberDao();
	int row = memberDao.updatePw(loginMember, updatePw);
	
	if(row == 1) {
		System.out.println("pw변경 성공");
		response.sendRedirect(request.getContextPath()+"/member/memberOne.jsp");
	} else {
		System.out.println("pw변경 실패");
		response.sendRedirect(request.getContextPath()+"/member/updateMemberPwForm.jsp");
	}
%>