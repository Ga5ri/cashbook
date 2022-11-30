<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	//Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	Member member = new Member();
	member.setMemberId(request.getParameter("memberId"));
	
	MemberDao memberDao = new MemberDao();
	int row = memberDao.deleteMemberByAdmin(member);
	
	if(row == 1) {
		System.out.println("강퇴 성공");
	} else {
		System.out.println("강퇴 실패");
	}
	
	String redirectUrl = "/admin/memberList.jsp";
	response.sendRedirect(request.getContextPath()+redirectUrl);

%>