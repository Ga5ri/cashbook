<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("UTF-8");	//한글 인코딩
	if(session.getAttribute("loginMember") == null) {
		// 로그인되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	
	String cashMemo = request.getParameter("cashMemo");
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	
	// Model
	// CashDao 호출
	CashDao cashDao = new CashDao();
	
	int row = cashDao.updateCashList(categoryNo, cashPrice, cashMemo, cashNo, loginMemberId);
	System.out.println(row+"<-updateCashAction row");
	if(row == 1){
		System.out.println("가계부 수정성공");
	}else {
		System.out.println("가계부 수정실패");
	}


	// View 대신 redirect
	String targetUrl = "/cash/cashDateList.jspyear="+year+"&month="+month+"&date="+date;
	response.sendRedirect(request.getContextPath()+targetUrl);
%>