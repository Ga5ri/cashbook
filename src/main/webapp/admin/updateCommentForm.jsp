<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	//session에 저장된 멤버(현재 로그인 사용자)
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 관리자
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	System.out.println("commentNo->"+commentNo);
	String commentMemo = request.getParameter("commentMemo");
	
	// Model 호출 1
	CommentDao commentDao = new CommentDao();
	Comment comment = commentDao.selectCommentOne(commentNo);
	// Model 호출 2
	HelpDao helpDao = new HelpDao();
	int helpNo = comment.getHelpNo();
	HashMap<String, Object> help = helpDao.selectHelpListByHelpNo(helpNo);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- Meta -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="Gradient Able Bootstrap admin template made using Bootstrap 4. The starter version of Gradient Able is completely free for personal project." />
    <meta name="keywords" content="free dashboard template, free admin, free bootstrap template, bootstrap admin template, admin theme, admin dashboard, dashboard template, admin template, responsive" />
    <meta name="author" content="codedthemes">
    <!-- Favicon icon -->
    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
    <!-- Google font--><link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600" rel="stylesheet">
    <!-- Required Fremwork -->
    <link rel="stylesheet" type="text/css" href="../assets/css/bootstrap/css/bootstrap.min.css">
    <!-- themify-icons line icon -->
    <link rel="stylesheet" type="text/css" href="../assets/icon/themify-icons/themify-icons.css">
    <!-- ico font -->
    <link rel="stylesheet" type="text/css" href="../assets/icon/icofont/css/icofont.css">
    <!-- Style.css -->
    <link rel="stylesheet" type="text/css" href="../assets/css/style.css">
    <style>
		.ct {
			text-align: center;
			color:black;
		}
	</style>
<title>Insert title here</title>
</head>
<body>
	<section class="login p-fixed d-flex text-center bg-primary common-img-bg">
		<!-- Container-fluid starts -->
        <div class="container-fluid">
			<div class="row">
				<div class="col-sm-12">
					<!-- Authentication card start -->
					<div class="signup-card card-block auth-body mr-auto ml-auto">
						<form action="<%=request.getContextPath()%>/admin/updateCommentAction.jsp?commentNo=<%=commentNo%>" method="post" class="md-float-material">
                            <div class="auth-box">   
                                <div class="row m-b-20">
                                    <div class="col-md-12">
                                        <h3 class="text-center txt-primary">답변수정</h3>
                                    </div>
                                </div>
                                <hr/>
                                <table class="table table-bordered">		
	                               <tr>
										<td class="ct">회원아이디</td>
										<td><input type="text" name="memberId" value="<%=help.get("memberId")%>" readonly="readonly"></td>
									</tr>
									<tr>
										<td class="ct">회원문의사항</td>
										<td><input type="text" name="helpMemo" value="<%=help.get("helpMemo")%>" readonly="readonly"></td>
									</tr>
									<tr>
										<td class="ct">답변번호</td>
										<td><input type="number" name="helpNo" value="<%=help.get("helpNo")%>" readonly="readonly"></td>
									</tr>
									<tr>
										<td class="ct">내용수정</td>
										<td><textarea rows="3" cols="30" name="commentMemo"><%=comment.getCommentMemo()%></textarea></td>
									</tr>														                                              
                                </table>
                                <div class="col-sm-12">
                                	<button type="submit" class="btn btn-md btn-primary rounded text-center" style="width: 100px;">수정</button>
                                </div>
                                <hr/>
                                <div class="row">
                                    <div>
                                    	<a href="<%=request.getContextPath()%>/cash/cashList.jsp" class="btn btn-outline-secondary">가계부 홈으로</a>
                                    	<a href="<%=request.getContextPath()%>/admin/adminMain.jsp" class="btn btn-outline-secondary">관리자 홈으로</a>
                                    </div>
                                </div>
                            </div>
						</form>
                        <!-- end of form -->
					</div>
                    <!-- Authentication card end -->
				</div>
                <!-- end of col-sm-12 -->
			</div>
            <!-- end of row -->
		</div>
        <!-- end of container-fluid -->
    </section>
	<h1>답변수정</h1>
	<table>
		<tr>
			<td>회원아이디</td>
			<td><input type="text" name="memberId" value="<%=help.get("memberId")%>" readonly="readonly"></td>
		</tr>
		<tr>
			<td>회원문의사항</td>
			<td><input type="text" name="helpMemo" value="<%=help.get("helpMemo")%>" readonly="readonly"></td>
		</tr>
		<tr>
			<td>답변번호</td>
			<td><input type="number" name="helpNo" value="<%=help.get("helpNo")%>" readonly="readonly"></td>
		</tr>
	</table>
	<form action="<%=request.getContextPath()%>/admin/updateCommentAction.jsp?commentNo=<%=commentNo%>" method="post">
		<table>
			<tr>
				<td>내용수정</td>
				<td><textarea rows="3" cols="30" name="commentMemo"><%=comment.getCommentMemo()%></textarea></td>
			</tr>
		</table>
		<div>
			<button type="submit">수정</button>
		</div>
	</form>
</body>
</html>