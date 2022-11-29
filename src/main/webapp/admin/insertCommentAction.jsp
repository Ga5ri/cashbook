<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	//session에 저장된 멤버(현재 로그인 사용자)
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 관리자
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	String memberId = loginMember.getMemberId();
	String commentMemo = request.getParameter("commentMemo");
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	// Model
	Comment comment = new Comment();
	comment.setHelpNo(helpNo);
	comment.setCommentMemo(commentMemo);
	comment.setMemberId(memberId);
	
	
	
	CommentDao commentDao = new CommentDao();
	int isResult = commentDao.insertComment(comment);
	if(isResult != 0){
		System.out.println("추가 성공");
	} else {
		System.out.println("추가 실패");
	}
	
	String redirectUrl = "/admin/helpListAll.jsp";
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>