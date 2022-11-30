<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	//Controller
	//session에 저장된 멤버(현재 로그인 사용자)
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 관리자
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeMemo = request.getParameter("noticeMemo");
	
	Notice notice = new Notice();
	notice.setNoticeMemo(noticeMemo);
	notice.setNoticeNo(noticeNo);
	
	NoticeDao noticeDao = new NoticeDao();
	if(noticeDao.updateNotice(notice) == 1) {
		System.out.println("공지수정성공");
		String redirectUrl = "/admin/noticeList.jsp";
		response.sendRedirect(request.getContextPath()+redirectUrl);
	} 
	
%>
