<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	if(session.getAttribute("loginMember") == null) {
		// 로그인되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	loginMember.setMemberId(request.getParameter("memberId"));
	loginMember.setMemberName(request.getParameter("memberName"));
	loginMember.setMemberPw(request.getParameter("memberPw"));
	
	// Model
	// MemberDao 호출
	MemberDao memberDao = new MemberDao();
	Member updateMember = memberDao.updateMember(loginMember);
	if(updateMember != null) {
		session.setAttribute("loginMember", loginMember);
		String targetUrl = "/member/memberOne.jsp";
		response.sendRedirect(request.getContextPath()+targetUrl);
	} else {
		response.sendRedirect(request.getContextPath()+"/member/updateMemberForm.jsp");
	}

	// View
%>