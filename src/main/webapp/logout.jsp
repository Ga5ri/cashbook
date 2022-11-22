<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// logout
	session.invalidate();
	response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
%>