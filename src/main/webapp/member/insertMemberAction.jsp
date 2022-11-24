<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*"%>
<%@ page import = "dao.*"%>
<%
	// Controller
	request.setCharacterEncoding("utf-8");

	// 안전장치
	if(request.getParameter("memberId")==null || request.getParameter("memberId").equals("")
		|| request.getParameter("memberName")==null || request.getParameter("memberName").equals("")
		|| request.getParameter("memberPw")==null || request.getParameter("memberPw").equals("")){
		response.sendRedirect(request.getContextPath()+"/member/insertMemberForm.jsp");
		return;
	}
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	
	Member member = new Member();// 모델 호출시 매개값
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	member.setMemberName(memberName);
	
	// Model
	// 분리된 Model 호출
	MemberDao memberDao = new MemberDao();
	if(memberDao.selectMemberIdCk(memberId)){
		System.out.println("중복된 아이디");
		response.sendRedirect(request.getContextPath()+"/member/insertMemberForm.jsp");
		return;
	}
	int row = memberDao.insertMember(member);
	System.out.println(row+"<-insertMemberAction row");
	if(row == 1){
		System.out.println("회원가입 성공");
	} else {
		System.out.println("회원가입 실패");
	}
	
	
	String redirectUrl = "/loginForm.jsp";

	// View
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>