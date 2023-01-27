<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	//session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String loginMemberId = loginMember.getMemberId();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</head>
	<body>
		<section class="login p-fixed d-flex text-center bg-primary common-img-bg">
	        <!-- Container-fluid starts -->
	        <div class="container-fluid">
	            <div class="row">
	                <div class="col-sm-12">
	                    <!-- Authentication card start -->
	                    <div class="signup-card card-block auth-body mr-auto ml-auto">
	                        <form id="helpForm" action="<%=request.getContextPath()%>/help/insertHelpAction.jsp" method="post" class="md-float-material">
	                        
	                            <div class="auth-box">   
	                                <div class="row m-b-20">
	                                    <div class="col-md-12">
	                                        <h3 class="text-center txt-primary">고객센터 글작성</h3>
	                                    </div>
	                                </div>
	                                <hr/>
	                                <div class="input-group">
	                                    <textarea rows="5" cols="30" id="helpMemo" name="helpMemo" class="form-control" placeholder="이용중 요구사항이나 불편사항을 적어주세요"></textarea>
	                                    <span class="md-line"></span>
	                                </div>                       
	                                <div class="row m-t-30">
	                                    <div class="col-md-12">
	                                        <button type="button" id="helpBtn" class="btn btn-primary btn-md btn-block waves-effect text-center m-b-20">문의하기</button>                                
	                                    </div>
	                                </div>
	                                <hr/>
	                                <div class="row">
	                                    <div class="col-md-8">
	                                        <p class="text-inverse text-left m-b-0">불편없이 이용하실 수 있도록 최선을 다하겠습니다.</p>
	                                        <p class="text-inverse text-left"><b>관리자 올림</b></p>        
	                                    </div>
	                                    <div class="col-md-2">
	                                    	<a href="<%=request.getContextPath()%>/cash/cashList.jsp" class="btn btn-outline-secondary">가계부 홈으로</a>
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
	    let helpBtn = document.querySelector('#helpBtn');
		   
	    helpBtn.addEventListener('click', function(){
			// 디버깅
		    console.log('siginBtn clik!');
		    
		    // HELPMEMO 폼 유효성 검사
		    let helpMemo = document.querySelector('#helpMemo');
		    if(helpMemo.value == '') {
				alert('문의사항을 입력하세요');
				helpMemo.focus();
				return;
		    }
		
		     let helpForm = document.querySelector('#helpForm');
		     helpForm.submit(); 
		});
	    </script>
	</body>
</html>