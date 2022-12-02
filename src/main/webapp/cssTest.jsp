<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>

<%
	StudentDao studentDao = new StudentDao();
	ArrayList<Student> list = studentDao.selectStudnetList();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>studentList</title>
</head>
<body>
	<%
		for(Student s : list) {
	%>
			<div>
				<%=s.studentId%>
				<%=s.familyName%>
				<%=s.name%>
				<%=s.gender%>
				<%=s.birth%>
				<%=s.city%>
				<%=s.updatedate%>
				<%=s.createdate%>
			</div>
	<%		
		}
	%>
</body>
</html>
	<!--  공지(5개) list 페이징 -->
	<div>
		<h1>공지사항</h1>
		<table>
			<tr>
				<th>공지내용</th>
				<th>날짜</th>
			</tr>
			<%
				for(Notice n : list) {
			%>
					<tr>
						<td><%=n.getNoticeMemo()%></td>
						<td><%=n.getCreatedate()%></td>
					</tr>
			<%		
				}
			%>
		</table>
		<div>
			<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1">처음</a>
			<%
				if(currentPage > 1) {				
			%>
					<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%
				}
			%>
				<span><%=currentPage%></span>
			<%
				if(currentPage < lastPage) {
			%>
					<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>">다음</a>	
			<%
				}
			%>
			<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>">마지막</a>
		</div>
	</div>
	<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
		<table>
			<tr>
				<td>ID</td>
				<td><input type="text" name="memberId"></td>
			</tr>
			<tr>
				<td>PW</td>
				<td><input type="password" name="memberPw"></td>
			</tr>
		</table>
		<button type="submit">로그인</button>
	</form>
	<div>
		<a href="<%=request.getContextPath()%>/member/insertMemberForm.jsp">회원가입</a>
	</div>
		<div>
			<!--  로그인 정보 (세션 loginMember 변수) 출력 -->
			<span><%=loginMemberName%>님 반갑습니다.</span>
			<%
				System.out.println(loginMember.getMemberLevel()+"<--level");
				if(loginMember.getMemberLevel() > 0){
			%>
					<a href="<%=request.getContextPath()%>/admin/adminMain.jsp">관리자 페이지</a>
			<%		
				}
			%>
			<a href="<%=request.getContextPath()%>/member/memberOne.jsp">마이페이지</a>
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
													(<%=(String)(m.get("categoryKind"))%>)
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
			</table>
		</div>
		<div>
			<jsp:include page="/inc/footer.jsp"></jsp:include>
		</div>