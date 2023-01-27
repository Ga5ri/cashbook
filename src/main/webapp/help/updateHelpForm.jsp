<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%	
	//Controller
	request.setCharacterEncoding("utf-8");
	if(session.getAttribute("loginMember") == null) {
		// 로그인되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 

	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String helpMemo = request.getParameter("helpMemo");
	
	// Model 호출
	HelpDao helpDao = new HelpDao();
	HashMap<String,Object> help = helpDao.selectHelpOne(helpNo);
%>
<!DOCTYPE html>
<html>
<head>
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
                        <form action="<%=request.getContextPath()%>/help/updateHelpAction.jsp" method="post" class="md-float-material">
                        	<input type="hidden" name="helpNo" value="<%=help.get("helpNo")%>">
                            <div class="auth-box">   
                                <div class="row m-b-20">
                                    <div class="col-md-12">
                                        <h3 class="text-center txt-primary">문의사항 수정</h3>
                                    </div>
                                </div>
                                <hr/>
                                <div class="input-group">
                                    <textarea name="helpMemo" rows="3" cols="50" class="form-control"><%=help.get("helpMemo")%></textarea>
                                    <span class="md-line"></span>
                                </div>                       
                                <div class="row m-t-30">
                                    <div class="col-md-12">
                                        <button type="submit" class="btn btn-primary btn-md btn-block waves-effect text-center m-b-20">수정하기</button>                                
                                    </div>
                                </div>
                                <hr/>
                                <div class="row">
                                    <div class="col-md-8">
                                        <p class="text-inverse text-left m-b-0">수정이 완료되면 수정하기 버튼을 눌러주세요.</p>
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
</body>
</html>