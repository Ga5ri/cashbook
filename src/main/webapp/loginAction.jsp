<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*"%>
<%@ page import = "dao.*"%>
<%
	// Controller
	// 안정장치, 로그인되있으면 오면 안된다
	request.setCharacterEncoding("UTF-8");
	//안전장치
	if(request.getParameter("memberId")==null 
			|| request.getParameter("memberPw")==null
			|| request.getParameter("memberId").equals("") 
			|| request.getParameter("memberPw").equals("")){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	

	Member paramMember = new Member(); // 모델 호출시 매개값
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	
	System.out.println("getmemberID:REQUEST" + paramMember.getMemberId());
	System.out.println("getmemberPw:REQUEST" + paramMember.getMemberPw());

	
	// 분리된 Model 호출
	MemberDao memberDao = new MemberDao();
	Member resultMember = memberDao.login(paramMember);
	System.out.println(memberDao.login(paramMember)+"<-resultMember");
	
	String redirectUrl = "/loginForm.jsp";
	
	if(resultMember != null){
		session.setAttribute("loginMember", resultMember); // session안에 로그인 아이디 & 이름을 저장
		redirectUrl = "/cash/cashList.jsp";
		System.out.println("로그인 성공");
	} 
	
	// View없음 대신 redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>
