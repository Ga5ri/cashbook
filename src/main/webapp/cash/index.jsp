<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<ul>
			<li>
				<a href="<%=request.getContextPath()%>/cash/cashListByCategory.jsp?category=수입">년도별 수입목록</a>
			</li>
			<li>
				<a href="<%=request.getContextPath()%>/cash/cashListByCategory.jsp?category=지출">년도별 지출목록</a>
			</li>
			<li>
				<a href="<%=request.getContextPath()%>/cash/cashListByMonth.jsp?category=수입">월별 수입목록</a>
			</li>
			<li>
				<a href="<%=request.getContextPath()%>/cash/cashListByMonth.jsp?category=지출">월별 지출목록</a>
			</li>
		</ul>
	</body>
</html>