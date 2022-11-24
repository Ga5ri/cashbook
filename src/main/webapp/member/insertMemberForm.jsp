<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<h1>회원가입</h1>
		<form action="<%=request.getContextPath()%>/member/insertMemberAction.jsp" method="post">
			<table>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="memberId" value=""></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="memberPw" value=""></td>
				</tr>
				<tr>
					<td>닉네임</td>
					<td><input type="text" name="memberName" value=""></td>
				</tr>
			</table>
			<div>
				<button type="submit">가입신청</button>
			</div>
		</form>
	</div>
</body>
</html>