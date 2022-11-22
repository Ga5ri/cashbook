<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "dao.*"%>
<%@ page import = "vo.*"%>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	System.out.println(loginMember+"<-session");
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));

	// Model
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month, date);
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- cash 입력 폼 -->
	<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
		<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
		<table border=1>
			<tr>
				<td>categoryNo</td>
				<td>
					<select name="categoryNo">
						<%
							for(Category c : categoryList){
						%>
								<option value="<%=c.getCategoryNo()%>">
									<%=c.getCategoryKind()%> <%=c.getCategoryName()%>
								</option>
						<%		
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>cashDate</td>
				<td><input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly"></td>
			</tr>
			<tr>
				<td>cashMemo</td>
				<td>
					<textarea rows="3" cols="50" name="cashMemo"></textarea>
				</td>
			</tr>
		</table>
		<button type="submit">입력</button>
	</form>
	<!-- cash 목록 출력 -->
	<table border=1>
		<tr>
			<th>categoryKind</th>
			<th>categoryName</th>
			<th>cashPrice</th>
			<th>cashMemo</th>
			<th>수정</th> <!-- /cash/updateCashForm.jsp?cashNo= -->
			<th>삭제</th> <!-- /cash/deleteCash.jsp?cashNo= -->
		</tr>
		<%
			for(HashMap<String, Object> m : list){
		%>
				<tr>
					<td><%=m.get("categoryKind")%></td>
					<td><%=m.get("categoryName")%></td>
					<td><%=m.get("cashPrice")%></td>
					<td><%=m.get("cashMemo")%></td>
					<td><a href="">수정</a></td>
					<td><a href="">삭제</a></td>
				</tr>
		<%		
			}
		%>
	</table>
</body>
</html>