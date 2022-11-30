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
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
		return;
	}

	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	// Model 호출
	NoticeDao noticeDao = new NoticeDao();
	int row = noticeDao.deleteNotice(noticeNo);
	if(row == 0) {
		System.out.println("comment 삭제 실패");
	} else {
		System.out.println("comment 삭제 성공");
	}
	
	// View 대신 Redirect
	String redirectUrl = "/admin/noticeList.jsp";
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>