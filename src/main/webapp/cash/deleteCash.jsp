<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	if(session.getAttribute("loginMember") == null) {
		// 로그인되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 

	//session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));

	CashDao cashDao = new CashDao();
	int row = cashDao.deleteCash(cashNo);
	System.out.println(row+"<-deleteCash row");
	if(row == 1){
		System.out.println("내역 삭제성공");
	}else {
		System.out.println("내역 삭제실패");
	}
	

	// View 대신 redirect
	String targetUrl = "/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date;
	response.sendRedirect(request.getContextPath()+targetUrl);
%>