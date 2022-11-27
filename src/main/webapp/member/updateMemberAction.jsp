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
	String loginMemberId = loginMember.getMemberId();
	String memberName = request.getParameter("memberName");

	Member member = new Member();
	member.setMemberId(loginMemberId);
	member.setMemberName(memberName);
	
	// Model
	// MemberDao 호출
	MemberDao memberDao = new MemberDao();
	
	int row = memberDao.updateMember(member, loginMemberId);
	System.out.println(row+"<-updateMemberAction row");
	if(row == 1){
		System.out.println("닉네임 수정성공");
	}else {
		System.out.println("닉네임 수정실패");
	}


	// View 대신 redirect
	String targetUrl = "/member/memberOne.jsp";
	response.sendRedirect(request.getContextPath()+targetUrl);
%>