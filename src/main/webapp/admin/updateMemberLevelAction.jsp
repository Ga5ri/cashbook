<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	//Controller
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 객체생성
	Member member = new Member();
	member.setMemberLevel(Integer.parseInt(request.getParameter("memberLevel")));
	member.setMemberId(request.getParameter("memberId"));
	
	// Model 호출
	MemberDao memberDao = new MemberDao();
	int row = memberDao.updateMemberLevel(member);
	
	if(row == 1) {
		System.out.println("level변경 성공");
	} else {
		System.out.println("level변경 실패");
	}
	
	String redirectUrl = "/admin/memberList.jsp";
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>