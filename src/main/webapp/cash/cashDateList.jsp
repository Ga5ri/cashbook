<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	if(session.getAttribute("loginMember") == null) {
		// 로그인되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	
	// session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	String loginMemberName = loginMember.getMemberName();
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));


	// Model 호출
	// CategoryDao 호출
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList(); 
	// CashDao 호출
	CashDao cashDao = new CashDao(); 
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month, date);
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일별 가계부</title>
</head>
<body>
	<!-- cash 입력 폼 -->
	<div>
		<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
			<!-- memberId,년,월,일 hidden 처리 -->
			<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
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
					<td>(수입/지출)분류</td>
					<td>
						<select name="categoryNo">
						<%
							for(Category c : categoryList){
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
					<td><input type="text" name="cashPrice"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea rows="3" cols="50" name="cashMemo"></textarea></td>
				</tr>
			</table>
			<button type="submit">추가</button>
		</form>
	</div>	
	<!-- cash 목록 출력 -->
	<div>
		<table>
			<tr>
				<th>수입/지출</th>
				<th>분류</th>
				<th>금액</th>
				<th>내용</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<%
				for(HashMap<String, Object> m : list){
					int cashNo = (Integer)m.get("cashNo"); // 수정 및 삭제를 위해 cashNo 받아옴
			%>
					<tr>
						<td><%=m.get("categoryKind")%></td>
						<td><%=m.get("categoryName")%></td>
						<td><%=m.get("cashPrice")%></td>
						<td><%=m.get("cashMemo")%></td>
						<td><a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?cashNo=<%=cashNo%>&year=<%=year%>&month=<%=month%>&date=<%=date%>">수정</a></td>
						<td><a href="<%=request.getContextPath()%>/cash/deleteCash.jsp?cashNo=<%=cashNo%>&year=<%=year%>&month=<%=month%>&date=<%=date%>">삭제</a></td>
					</tr>
			<%
				}
			%>
		</table>
		<div>
			<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
		</div>
	</div>
</body>
</html>