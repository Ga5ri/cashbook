<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	if (session.getAttribute("loginMember") == null) {
		// 로그인되지 않은 상태
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}

	//session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member) session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	int year = 0;
	if(request.getParameter("year") == null) {
		Calendar c = Calendar.getInstance();
		year = c.get(Calendar.YEAR);
	} else {
		year = Integer.parseInt(request.getParameter("year"));
	}

	// Model 호출
	StatsDao statsDao = new StatsDao();
	ArrayList<HashMap<String, Object>> list = statsDao.selectCashListByMonth(memberId, year);
	HashMap<String, Object> map = statsDao.selectMaxMinYear();
	int minYear = (Integer)(map.get("minYear")); // 언박싱
	int maxYear = (Integer)(map.get("maxYear"));

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1><%=year%>년 월별 수입/지출 통계</h1>
	<table>
		<tr>
			<td>월</td>
			<td>수입횟수</td>
			<td>수입합산(원)</td>
			<td>수입평균(원)</td>
			<td>지출횟수</td>
			<td>지출합산(원)</td>
			<td>지출평균(원)</td>
		</tr>
		<%
			for(HashMap<String, Object> m : list) {
		%>
			<tr>
				<td><%=m.get("month")%></td>
				<td><%=m.get("icCnt")%></td>
				<td><%=m.get("icSum")%></td>
				<td><%=m.get("icAvg")%></td>
				<td><%=m.get("ecCnt")%></td>
				<td><%=m.get("ecSum")%></td>
				<td><%=m.get("ecAvg")%></td>
			</tr>
		<%		
			}
		%>
	</table>
	<%
		if(year > minYear) {	
	%>
			<a href="<%=request.getContextPath()%>/cash/cashListByMonth.jsp?year=<%=year-1%>">이전</a>
	<%
		}
	%>
	<%
		if(year < maxYear) {
	%>
			<a href="<%=request.getContextPath()%>/cash/cashListByMonth.jsp?year=<%=year+1%>">다음</a>
	<%		
		}
	%>
</body>
</html>