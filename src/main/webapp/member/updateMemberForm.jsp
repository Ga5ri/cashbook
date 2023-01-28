<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	if(session.getAttribute("loginMember") == null) {
		// 로그인되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	//session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	String memberName = loginMember.getMemberName();
%>
<!DOCTYPE html>
<html>
	<head>
		<title>updateMemberForm</title>
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
	</head>
	<body>
	    <section class="login p-fixed d-flex text-center bg-primary common-img-bg">
	        <!-- Container-fluid starts -->
	        <div class="container-fluid">
	            <div class="row">
	                <div class="col-sm-12">
	                    <!-- Authentication card start -->
	                    <div class="signup-card card-block auth-body mr-auto ml-auto">
	                        <form id="umForm" action="<%=request.getContextPath()%>/member/updateMemberAction.jsp" method="post" class="md-float-material">
	                            <div class="auth-box">   
	                                <div class="row m-b-20">
	                                    <div class="col-md-12">
	                                        <h3 class="text-center txt-primary">닉네임 변경</h3>
	                                    </div>
	                                </div>
	                                <hr/>
	                                <div class="input-group">
	                                    <input type="text" name="memberId" value="<%=memberId%>" readonly="readonly" class="form-control">
	                                    <span class="md-line"></span>
	                                </div>
	                                <div class="input-group">
	                                    <input type="text" id="memberName" name="memberName" value="<%=memberName%>" class="form-control">
	                                    <span class="md-line"></span>
	                                </div>
	                                <div class="input-group">
	                                    <input type="password" id="memberPw" name="memberPw" value="" class="form-control" placeholder="PASSWORD 입력"> 
	                                    <span class="md-line"></span>
	                                </div>
	                                <div class="row m-t-30">
	                                    <div class="col-md-12">
	                                        <button id="umBtn" type="button" class="btn btn-primary btn-md btn-block waves-effect text-center m-b-20">변경</button>
	                                    </div>
	                                </div>
	                                <hr/>
	                                <div class="row">
	                                    <div class="col-md-10">
	                                        <p class="text-inverse text-left"><b>변경할 닉네임과 비밀번호를 입력해주세요.</b></p>
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
	    let umBtn = document.querySelector('#umBtn');
		   
	    umBtn.addEventListener('click', function(){
			// 디버깅
		    console.log('umBtn clik!');
		    
		    // memberName 폼 유효성 검사
		    let memberName = document.querySelector('#memberName');
		    if(memberName.value == '') {
				alert('닉네임을 입력하세요');
				memberName.focus();
				return;
		    }
		    
		    // PW 폼 유효성 검사
		    let memberPw = document.querySelector('#memberPw');
		    if(memberPw.value == '') {
				alert('pw를 확인하세요');
				memberPw.focus();
				return;
		    }
		    
		     let umForm = document.querySelector('#umForm');
		     umForm.submit();
		});		
	    </script>
	</body>
</html>