<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "dao.*"%>
<%@ page import = "vo.*"%>
<%
	// Controller : session, request
	// request 년 + 월
	request.setCharacterEncoding("UTF-8");
	
	if(session.getAttribute("loginMember") == null) {
		// 로그인되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 

	// session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	String loginMemberName = loginMember.getMemberName();
	System.out.println(loginMemberId);
	System.out.println(loginMemberName);
	
	int year = 0;
	int month = 0;
	
	// year,month null 값시 오늘날짜 출력
	if(request.getParameter("year") == null || request.getParameter("month")==null ){
		Calendar today = Calendar.getInstance(); // 오늘날짜
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH); // 0~11
	} else {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		// month -> -1, month -> 12 일경우
		if(month == -1){ 
			month = 11;
			year -= 1;
		}
		if(month == 12){
			month = 0;
			year += 1;
		}
	}
	
	// 출력하고자 하는 년, 월과 월의 1일의 요일 (일 1, 월 2, 화 3, ... 토 7)
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	
	// firstDay는 1일의 요일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK); // 요일 (일 1, 월 2, 화 3, ... 토 7)
	
	// 마지막날짜
	int lastDate = targetDate.getActualMaximum(Calendar.DATE);
	
	// begin blank개수는 firstDay - 1
	// 달력 출력테이브르이 시작 공백셀(td)과 마지막 공백셀(td)의 개수
	int beginBlank = firstDay - 1;
	int endBlank = 0; //  beginBlank + lastDate + endBlank -> 7로 나누어 떨어진다 -> totalTd
	if((beginBlank + lastDate)%7 != 0){
		endBlank = 7 - ((beginBlank + lastDate) % 7);
	}
	
	// 전체 td의 개수 : 7로 나누어 떨어져야 한다.
	int totalTd = beginBlank + lastDate + endBlank;
	
	// Model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month+1);
	// View : 달력출력 + 일별 cash 목록 출력
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<div>
			<!--  로그인 정보 (세션 loginMember 변수) 출력 -->
			<span><%=loginMemberName%>님 반갑습니다.</span>
			<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
		</div>
		<div>
			<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>">
				&#8701;이전달
			</a>
			<%=year%> 년 <%=month+1%> 월
			<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>">
				다음달&#8702;
			</a>
		</div>
		<!-- 달력 출력 -->
		<div>
			<table border=1>
				<tr>
					<th>일</th>
					<th>월</th>
					<th>화</th>
					<th>수</th>
					<th>목</th>
					<th>금</th>
					<th>토</th>
				</tr>
				<tr>
					<% 
						for(int i=1; i<=totalTd; i++){
					%>
							<td>
					<%
								int date = i - beginBlank;
								if(date > 0 && date <= lastDate){				
					%>
									<div>
										<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">
											<%=date%>
										</a>
									</div>
									<div>
										<%
											for(HashMap<String, Object> m : list){ // 해당 월에 일수를 date와 비교
												String cashDate = (String)(m.get("cashDate"));
												if(Integer.parseInt(cashDate.substring(8)) == date){
										%>
													[<%=(String)(m.get("categoryKind"))%>]
													<%=(Long)(m.get("cashPrice"))%>원
													<%=(String)(m.get("categoryName"))%>
													<br>
										<%	
												}
											}
										%>
									</div>
					<%			
								}
					%>
							</td>
					<%	
							if(i % 7 == 0 && i != totalTd) { // 줄바꿈, 마지막 공백 한줄 출력을 막기위한 조건식
					%>
								<tr></tr> <!-- td7개 만들어진 후 테이블 줄바꿈 -->
					<%			
							}
						}
					%>
				</tr>
			</table>
		</div>
	</body>
</html>