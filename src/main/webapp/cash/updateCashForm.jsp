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
	
	// Model 호출
	// CategoryDao 호출
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	// CashDao 호출
	CashDao cashDao = new CashDao();
	HashMap<String, Object> cash = cashDao.selectCashListByCashNo(cashNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 수정</title>
</head>
<body>
	<div>
		<form method="post" action="<%=request.getContextPath()%>/cash/updateCashAction.jsp">
			<!-- cashNo,년,월,일 hidden 처리 -->
			<input type="hidden" name="cashNo" value="<%=cash.get("cashNo")%>">
			<input type="hidden" name="year" value="<%=year%>">
			<input type="hidden" name="month" value="<%=month%>">
			<input type="hidden" name="date" value="<%=date%>">
			<table>
				<tr>
					<td>날짜</td>
					<td>
						<input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>분류</td>
					<td>
						<select name="categoryNo">
						<%
							for(Category c : categoryList){ // 입력창과 동일하게 출력
						%>
								<option value="<%=c.getCategoryNo()%>">
								(<%=c.getCategoryKind()%>) <%=c.getCategoryName()%>
								</option>							
						<%
							}
						%>
						</select>
					</td>
				</tr>
				<tr>
					<td>금액</td>
					<td><input type="text" name="cashPrice" value="<%=cash.get("cashPrice")%>"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea name="cashMemo" rows="3" cols="50"><%=cash.get("cashMemo")%></textarea></td>
				</tr>
			</table>
			<button type="submit">수정</button>
		</form>
	</div>
</body>
</html>