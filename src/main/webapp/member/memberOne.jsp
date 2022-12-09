<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%
	//session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	String loginMemberName = loginMember.getMemberName();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <!-- Meta -->
    <meta charset="utf-8">
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
    	.mp {
    		font-size: 30px;
    		text-align: center;
    	}
    </style>
</head>
<body>
    <section class="login p-fixed d-flex text-center bg-primary common-img-bg">
        <!-- Container-fluid starts -->
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12">
                    <!-- Authentication card start -->
                    <div class="signup-card card-block auth-body mr-auto ml-auto">
                        <form action="<%=request.getContextPath()%>/member/insertMemberAction.jsp" method="post" class="md-float-material">
                            <div class="auth-box">   
                                <div class="row m-b-20">
                                    <div class="col-md-12">
                                        <h3 class="text-center txt-primary">마이페이지</h3>
                                    </div>
                                </div>
                                <hr/>
                                <div class="text-inverse mp">
									<table class="table table-borderless">
										<tr>
											<td>아이디 : <%=loginMemberId%></td>
										</tr>
										<tr>
											<td>닉네임 : <%=loginMemberName%></td>
										</tr>
									</table>	
								</div>
								<div class="btn-group">
									<a href="<%=request.getContextPath()%>/cash/cashList.jsp" class="btn btn-outline-info">가계부 홈으로</a>
									<a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp" class="btn btn-outline-info">닉네임 변경</a>
									<a href="<%=request.getContextPath()%>/member/updateMemberPwForm.jsp" class="btn btn-outline-info">비밀번호 변경</a>
									<a href="<%=request.getContextPath()%>/logout.jsp" class="btn btn-outline-info">로그아웃</a>
								</div>
                                <hr/>
                                <div class="row">
                                    <div class="col-md-10">
                                        <p class="text-inverse text-left m-b-0">사이트를 이용해 주셔서 감사합니다.</p>
                                        <p class="text-inverse text-left"><b></b></p>
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
</body>
</html>