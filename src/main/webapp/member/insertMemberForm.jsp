<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	    <title>가계부 회원가입</title>
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
	<body class="fix-menu">
	    <section class="login p-fixed d-flex text-center bg-primary common-img-bg">
	        <!-- Container-fluid starts -->
	        <div class="container-fluid">
	            <div class="row">
	                <div class="col-sm-12">
	                    <!-- Authentication card start -->
	                    <div class="signup-card card-block auth-body mr-auto ml-auto">
	                        <form id="insertMember" action="<%=request.getContextPath()%>/member/insertMemberAction.jsp" method="post" class="md-float-material">
	                            <div class="auth-box">   
	                                <div class="row m-b-20">
	                                    <div class="col-md-12">
	                                        <h3 class="text-center txt-primary">간편 회원가입</h3>
	                                    </div>
	                                </div>
	                                <hr/>
	                                <div class="input-group">
	                                    <input type="text" id="memberName" name="memberName" class="form-control" placeholder="닉네임을 입력해주세요">
	                                    <span class="md-line"></span>
	                                </div>
	                                <div class="input-group">
	                                    <input type="text" id="memberId" name="memberId" class="form-control" placeholder="아이디를 입력해주세요">
	                                    <span class="md-line"></span>
	                                </div>
	                                <div class="input-group">
	                                    <input type="password" id="memberPw" name="memberPw" class="form-control" placeholder="비밀번호를 입력해주세요">
	                                    <span class="md-line"></span>
	                                </div>
	                                <div class="input-group">
	                                    <input type="password" id="pwConfirm" name="pwConfirm" class="form-control" placeholder="비밀번호를 한번 더 입력해주세요">
	                                    <span class="md-line"></span>
	                                </div>
	                                <div class="row m-t-30">
	                                    <div class="col-md-12">
	                                        <button type="button" id="insertBtn" class="btn btn-primary btn-md btn-block waves-effect text-center m-b-20">가입신청</button>
	                                    </div>
	                                </div>
	                                <hr/>
	                                <div class="row">
	                                    <div class="col-md-10">
	                                        <p class="text-inverse text-left m-b-0">가계부 사이트의 회원이 되신걸 환영합니다.</p>
	                                        <p class="text-inverse text-left"><b>항상 행복하세요.</b></p>
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
	    let insertBtn = document.querySelector('#insertBtn');
		   
	    insertBtn.addEventListener('click', function(){
			// 디버깅
		    console.log('insertBtn clik!');
		 	
			// NAME 폼 유효성 검사
		 	let memberName = document.querySelector('#memberName');
		    if(memberName.value == '') {
				alert('id를 입력하세요');
				memberName.focus(); // 브라우저의 커스를 id태그로 이동
				return;
		    }
		    
		    // ID 폼 유효성 검사
		    let memberId = document.querySelector('#memberId');
		    if(memberId.value == '') {
				alert('id를 입력하세요');
				memberId.focus(); // 브라우저의 커스를 id태그로 이동
				return;
		    }
		    
		    // PW 폼 유효성 검사
		    let memberPw = document.querySelector('#memberPw');
		    let pwConfirm = document.querySelector('#pwConfirm');
		    if(memberPw.value == '' || memberPw.value != pwConfirm.value) {
				alert('pw를 확인하세요');
				memberPw.focus();
				return;
		    }

		     let insertMember = document.querySelector('#insertMember');
		     insertMember.submit(); 
		});
	    </script>
	</body>
</html>