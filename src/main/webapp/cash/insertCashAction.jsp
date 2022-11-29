<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*"%>
<%@ page import ="java.net.*"%>
<%	
	// Controller
	request.setCharacterEncoding("utf-8");
	if(session.getAttribute("loginMember") == null) {
		// 로그인되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	
	String memberId = request.getParameter("memberId");
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	String cashMemo = request.getParameter("cashMemo");
	String cashDate = request.getParameter("cashDate");
	// 안전장치
	if(request.getParameter("categoryNo").equals("") || request.getParameter("cashPrice").equals("") || request.getParameter("cashMemo").equals("")){
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date);
		return;
	}	

	// Model
	CashDao cashDao = new CashDao();
	int isResult = cashDao.insertCash(memberId, cashMemo, cashDate, categoryNo, cashPrice);
	if(isResult != 0){
		System.out.println("추가 성공");
	} else {
		System.out.println("추가 실패");
	}
	
	// View 대신 redirect
	response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date);
%>