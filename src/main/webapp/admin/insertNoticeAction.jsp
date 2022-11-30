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
	String noticeMemo = request.getParameter("noticeMemo");

	// 객체생성
	Notice notice = new Notice();
	notice.setNoticeMemo(noticeMemo);

	// Model 호출
	NoticeDao noticeDao = new NoticeDao();
	int isResult = noticeDao.insertNotice(notice);
	if(isResult != 0){
		System.out.println("notice추가 성공");
	} else {
		System.out.println("notice추가 실패");
	}
	
	String redirectUrl = "/admin/noticeList.jsp";
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>
