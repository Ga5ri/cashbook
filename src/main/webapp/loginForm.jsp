<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	if(session.getAttribute("loginMember") != null) {
	// 로그인된 상태
	response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
	return;
	}
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage - 1) * rowPerPage;

	// Model 호출
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);

	// lastPage
	int lastPage = noticeDao.selectNoticeCount() / rowPerPage;
	if(noticeDao.selectNoticeCount() % rowPerPage != 0) {
		lastPage+=1;
	}
%>
<!DOCTYPE html>
<html>
<head>
    <title>가계부 로그인창</title>
    <!-- HTML5 Shim and Respond.js IE9 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
      <![endif]-->
    <!-- Meta -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="Gradient Able Bootstrap admin template made using Bootstrap 4. The starter version of Gradient Able is completely free for personal project." />
    <meta name="keywords" content="free dashboard template, free admin, free bootstrap template, bootstrap admin template, admin theme, admin dashboard, dashboard template, admin template, responsive" />
    <meta name="author" content="codedthemes">
    <!-- Favicon icon -->
    <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
    <!-- Google font-->
    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600" rel="stylesheet">
    <!-- Required Fremwork -->
    <link rel="stylesheet" type="text/css" href="assets/css/bootstrap/css/bootstrap.min.css">
    <!-- themify-icons line icon -->
    <link rel="stylesheet" type="text/css" href="assets/icon/themify-icons/themify-icons.css">
    <!-- ico font -->
    <link rel="stylesheet" type="text/css" href="assets/icon/icofont/css/icofont.css">
    <!-- Style.css -->
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
    <style>
    	.notice {
    		padding-top: 50px;
    	}
    	.login {
    		padding-bottom: 400px;
    	}
    </style>
</head>
	<body class="fix-menu">
		<section class="notice p-fixed d-flex text-center bg-primary common-img-bg">
			<div class="notice-card card-block auth-body mr-auto ml-auto">
		<!--  공지(5개) list 페이징 -->
		<div>
			<h1>공지사항</h1>
			<table class="text-left">
				<tr>
					<td>공지내용</td>
					<td>날짜</td>
				</tr>
				<%
					for(Notice n : list) {
				%>
						<tr>
							<td><%=n.getNoticeMemo()%></td>
							<td>[<%=n.getCreatedate()%>]</td>
						</tr>
				<%		
					}
				%>
			</table>
			<div>
				<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1" class="btn">처음</a>
				<%
					if(currentPage > 1) {				
				%>
						<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>" class="btn">이전</a>
				<%
					}
				%>
					<span class="btn"><%=currentPage%></span>
				<%
					if(currentPage < lastPage) {
				%>
						<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>" class="btn">다음</a>	
				<%
					}
				%>
				<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>" class="btn">마지막</a>
			</div>
			</div>
		</div>
		</section>	
		<!-- login form -->
	    <section class="login p-fixed d-flex text-center bg-primary">
	        <!-- Container-fluid starts -->
	        <div class="container">
	            <div class="row">
	                <div class="col-sm-12">
	                    <!-- Authentication card start -->
	                    <div class="login-card card-block auth-body mr-auto ml-auto">
	                        <form id="signinForm" action="<%=request.getContextPath()%>/loginAction.jsp" method="post" class="md-float-material">
	                            <div class="auth-box">
	                                <div class="row m-b-20">
	                                    <div class="col-md-12">
	                                        <h3 class="text-left txt-primary">로그인</h3>
	                                    </div>
	                                </div>
	                                <hr/>
	                                <div class="input-group">
	                                    <input type="text" id="memberId" name="memberId" class="form-control" placeholder="ID" value="">
	                                    <span class="md-line"></span>
	                                </div>
	                                <div class="input-group">
	                                    <input type="password" id="memberPw" name="memberPw" class="form-control" placeholder="Password">
	                                    <span class="md-line"></span>
	                                </div>
	                                <div class="row m-t-25 text-left">
	                                    <div class="col-sm-7 col-xs-12">
	                                        <div class="checkbox-fade fade-in-primary">
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="col-sm-12 col-xs-12 forgot-phone text-right">
	                                	<a href="<%=request.getContextPath()%>/member/insertMemberForm.jsp" class="text-right f-w-600 text-inverse"> 회원가입</a>
	                                </div>
	                                <div class="row m-t-30">
	                                    <div class="col-md-12">
	                                        <button type="button" id="signinBtn" class="btn btn-primary btn-md btn-block waves-effect text-center m-b-20">로그인</button>
	                                    </div>
	                                </div>
	                                <hr/>
	                                <div class="row">
	                                    <div class="col-md-10">
	                                        <p class="text-inverse text-left m-b-0">가계부 관리사이트에 오신것을 환영합니다.</p>
	                                        <p class="text-inverse text-left"><b>함께 알뜰해지는 시간</b></p>
	                                    </div>
	                                    <div class="col-md-2">
	                                        <img src="assets/images/auth/Logo-small-bottom.png" alt="small-logo.png">
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
		<script>
		let signinBtn = document.querySelector('#signinBtn');
		   
		signinBtn.addEventListener('click', function(){
			// 디버깅
		    console.log('siginBtn clik!');
		    
		    // ID 폼 유효성 검사
		    let memberId = document.querySelector('#memberId');
		    if(memberId.value == '') {
				alert('id를 입력하세요');
				memberId.focus(); // 브라우저의 커스를 id태그로 이동
				return;
		    }
		    
		    // PW 폼 유효성 검사
		    let memberPw = document.querySelector('#memberPw');
		    if(memberPw.value == '') {
				alert('pw를 확인하세요');
				memberPw.focus();
				return;
		    }	
		     let signinForm = document.querySelector('#signinForm');
		     signinForm.submit(); 
		});		    
		</script>
	</body>
</html>