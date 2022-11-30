<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
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
	if(request.getParameter("commentNo") == null || request.getParameter("commentNo").equals("")
		|| request.getParameter("commentMemo") == null || request.getParameter("commentMemo").equals("")){
		response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
		return;
	}
	
	String commentMemo = request.getParameter("commentMemo");
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	
	Comment comment = new Comment();
	comment.setCommentMemo(commentMemo);
	comment.setCommentNo(commentNo);
	
	// Model 호출
	CommentDao commentDao = new CommentDao();
	int row = commentDao.updateComment(comment);
	
	if(row == 0) {
		System.out.println("comment 수정 실패");
	} else {
		System.out.println("comment 수정 성공");
	}
	
	// View 대신 Redirect
	String redirectUrl = "/admin/helpListAll.jsp";
	response.sendRedirect(request.getContextPath()+redirectUrl);	
%>