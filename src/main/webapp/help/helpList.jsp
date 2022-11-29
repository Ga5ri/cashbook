<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String memberId = loginMember.getMemberId();

	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(memberId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
</head>
<body>
   <h1>고객센터</h1>
   <div>
      <a href="<%=request.getContextPath()%>/help/insertHelpForm.jsp">문의추가</a>
   </div>
   <table border="1">
      <tr>
         <th>문의내용</th>
         <th>문의날짜</th>
         <th>답변내용</th>
         <th>답변날짜</th>
         <th>수정</th>
         <th>삭제</th>
      </tr>
      <%
         for(HashMap<String, Object> m : list) {
      %>
            <tr>
               <td><%=m.get("helpMemo")%></td>
               <td><%=m.get("helpCreatedate")%></td>
               <td>
	               <%
	                  if(m.get("commentMemo") == null) {
	               %>
	                     답변전
	               <%      
	                  } else {
	               %>
	                     <%=m.get("commentMemo")%>
	               <%   
	                  }
	               %>   
               </td>
               <td>
	               <%
	                  if(m.get("commentCreatedate") == null) {
	               %>
	                     답변전   
	               <%      
	                  } else {
	               %>
	                     <%=m.get("commentCreatedate")%>
	               <%   
	                  }
	               %>   
               </td>
               <td>
	               <%
	                  if(m.get("commentMemo") == null) {
	               %>
	                     <a href="">수정</a>   
	               <%      
	                  } else {
	               %>
	                     &nbsp;
	               <%   
	                  }
	               %>   
               </td>
               <td>
	               <%
	                  if(m.get("commentMemo") == null) {
	               %>
	                     <a href="">삭제</a>   
	               <%      
	                  } else {
	               %>
	                     &nbsp;
	               <%   
	                  }
	               %>
               </td>
       	    </tr>
	    <%      
	       }
	    %>
	</table>
	<div>
		<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
	</div>
</body>
</html>