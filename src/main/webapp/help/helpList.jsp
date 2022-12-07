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
	String loginMemberName = loginMember.getMemberName();
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(memberId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
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
	<!-- Google font--><link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600" rel="stylesheet">
	<!-- Required Fremwork -->
	<link rel="stylesheet" type="text/css" href="../assets/css/bootstrap/css/bootstrap.min.css">
	<!-- themify-icons line icon -->
	   <link rel="stylesheet" type="text/css" href="../assets/icon/themify-icons/themify-icons.css">
	<link rel="stylesheet" type="text/css" href="../assets/icon/font-awesome/css/font-awesome.min.css">
	   <!-- ico font -->
	<link rel="stylesheet" type="text/css" href="../assets/icon/icofont/css/icofont.css">
	<!-- Style.css -->
	<link rel="stylesheet" type="text/css" href="../assets/css/style.css">
	<link rel="stylesheet" type="text/css" href="../assets/css/jquery.mCustomScrollbar.css">
</head>
<body>
    <div id="pcoded" class="pcoded">
        <div class="pcoded-overlay-box"></div>
        <div class="pcoded-container navbar-wrapper">

            <nav class="navbar header-navbar pcoded-header">
               <div class="navbar-wrapper">
                   <div class="navbar-logo">
                       <a class="mobile-menu" id="mobile-collapse" href="#!">
                           <i class="ti-menu"></i>
                       </a>
                       <a href="<%=request.getContextPath()%>/cash/cashList.jsp">
                           <img class="img-fluid" src="../assets/images/logo.png" alt="Theme-Logo" />
                       </a>
                       <a class="mobile-options">
                           <i class="ti-more"></i>
                       </a>
                   </div>

                   <div class="navbar-container container-fluid">
                       <ul class="nav-left">
                           <li>
                               <div class="sidebar_toggle"><a href="javascript:void(0)"><i class="ti-menu"></i></a></div>
                           </li>
                           <li class="header-search">
                               <div class="main-search morphsearch-search">
                                   <div class="input-group">
                                       <span class="input-group-addon search-close"><i class="ti-close"></i></span>
                                       <input type="text" class="form-control" placeholder="검색 기능 미구현">
                                       <span class="input-group-addon search-btn"><i class="ti-search"></i></span>
                                   </div>
                               </div>
                           </li>
                           <li>
                               <a href="#!" onclick="javascript:toggleFullScreen()">
                                   <i class="ti-fullscreen"></i>
                               </a>
                           </li>
                       </ul>
                       <ul class="nav-right">                           
                           <li class="user-profile header-notification">
                               <a href="#!">
                                   <span><%=loginMemberName%></span>
                                   <i class="ti-angle-down"></i>
                               </a>
                               <ul class="show-notification profile-notification">
                                   <li>
                                       <a href="<%=request.getContextPath()%>/logout.jsp">
                                       <i class="ti-layout-sidebar-left"></i> Logout
                                   </a>
                                   </li>
                               </ul>
                           </li>
                       </ul>
                   </div>
               </div>
           </nav>

            <div class="pcoded-main-container">
                <div class="pcoded-wrapper">
                    <nav class="pcoded-navbar">
                        <div class="sidebar_toggle"><a href="#"><i class="icon-close icons"></i></a></div>
                        <div class="pcoded-inner-navbar main-menu">
                            
                            <div class="pcoded-navigatio-lavel" data-i18n="nav.category.navigation">HOME</div>
                            <ul class="pcoded-item pcoded-left-item">
                                <li class="">
                                    <a href="index.html">
                                        <span class="pcoded-micon"><i class="ti-home"></i><b>D</b></span>
                                        <span class="pcoded-mtext" data-i18n="nav.dash.main">가계부 홈</span>
                                        <span class="pcoded-mcaret"></span>
                                    </a>
                                </li>
                                <%
                                	if(loginMember.getMemberLevel() > 0){
                                %>
                               			<li class="pcoded-hasmenu">
	                                    	<a href="javascript:void(0)">
		                                        <span class="pcoded-micon"><i class="ti-layout-grid2-alt"></i></span>
		                                        <span class="pcoded-mtext"  data-i18n="nav.basic-components.main">Components</span>
		                                        <span class="pcoded-mcaret"></span>
	                                    	</a>
	                                    <ul class="pcoded-submenu">
	                                        <li class=" ">
	                                            <a href="accordion.html">
	                                                <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
	                                                <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Accordion</span>
	                                                <span class="pcoded-mcaret"></span>
	                                            </a>
	                                        </li>
	                                        <li class=" ">
	                                            <a href="breadcrumb.html">
	                                                <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
	                                                <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Breadcrumbs</span>
	                                                <span class="pcoded-mcaret"></span>
	                                            </a>
	                                        </li>
	                                        <li class=" ">
	                                            <a href="button.html">
	                                                <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
	                                                <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Button</span>
	                                                <span class="pcoded-mcaret"></span>
	                                            </a>
	                                        </li>
	                                        <li class=" ">
	                                            <a href="tabs.html">
	                                                <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
	                                                <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Tabs</span>
	                                                <span class="pcoded-mcaret"></span>
	                                            </a>
	                                        </li>
                                   		 </ul>	
                                <%		
                                	}
                                %>
                            <div class="pcoded-navigatio-lavel" data-i18n="nav.category.forms">Help Center</div>
                            <ul class="pcoded-item pcoded-left-item">
                                <li>
                                    <a href="<%=request.getContextPath()%>/help/helpList.jsp">
                                        <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
                                        <span class="pcoded-mtext" data-i18n="nav.form-components.main">고객센터</span>
                                        <span class="pcoded-mcaret"></span>
                                    </a>
                                </li>
                            </ul>
                            <div class="pcoded-navigatio-lavel" data-i18n="nav.category.forms">my page</div>
                            <ul class="pcoded-item pcoded-left-item">               
                                <li class="pcoded-hasmenu">
                                    <a href="javascript:void(0)">
                                        <span class="pcoded-micon"><i class="ti-layout-grid2-alt"></i></span>
                                        <span class="pcoded-mtext"  data-i18n="nav.basic-components.main">개인정보 변경</span>
                                        <span class="pcoded-mcaret"></span>
                                    </a>
                                    <ul class="pcoded-submenu">
                                        <li class=" ">
                                            <a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp">
                                                <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                                <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">닉네임 수정</span>
                                                <span class="pcoded-mcaret"></span>
                                            </a>
                                        </li>
                                        <li class=" ">
                                            <a href="<%=request.getContextPath()%>/member/updateMemberPwForm.jsp">
                                                <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                                <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">비밀번호 변경</span>
                                                <span class="pcoded-mcaret"></span>
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>                         
                    </nav>
                    <div class="pcoded-content">
                        <div class="pcoded-inner-content">

                            <div class="main-body">
                                <div class="page-wrapper">
								
									<!-- Page-header start -->
                                    <div class="page-header card">
                                        <div class="card-block">
                                            <h5 class="m-b-10">고객센터</h5>
                                            <p class="text-muted m-b-10">사이트 이용중 불편 사항이나 문의사항을 편하게 물어보세요.</p>
                                        </div>
                                    </div>
                                    <!-- Page-header end -->
                                    

                                    <div class="page-body">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>고객센터 글목록</h5>
                                                        <span>
                                                        	<a href="<%=request.getContextPath()%>/help/insertHelpForm.jsp">문의글 작성하기</a>
                                                        </span>
                                                        <div class="card-header-right">
															<ul class="list-unstyled card-option">
																<li><i class="fa fa-chevron-left"></i></li>
																<li><i class="fa fa-window-maximize full-card"></i></li>
																<li><i class="fa fa-minus minimize-card"></i></li>
																<li><i class="fa fa-refresh reload-card"></i></li>
																<li><i class="fa fa-times close-card"></i></li>
															</ul>
														</div>

                                                    </div>
                                                    <div class="card-block">
                                                        <p>
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
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="styleSelector">

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- Warning Section Starts -->
    <!-- Older IE warning message -->
<!--[if lt IE 9]>
<div class="ie-warning">
    <h1>Warning!!</h1>
    <p>You are using an outdated version of Internet Explorer, please upgrade <br/>to any of the following web browsers
        to access this website.</p>
    <div class="iew-container">
        <ul class="iew-download">
            <li>
                <a href="http://www.google.com/chrome/">
                    <img src="assets/images/browser/chrome.png" alt="Chrome">
                    <div>Chrome</div>
                </a>
            </li>
            <li>
                <a href="https://www.mozilla.org/en-US/firefox/new/">
                    <img src="assets/images/browser/firefox.png" alt="Firefox">
                    <div>Firefox</div>
                </a>
            </li>
            <li>
                <a href="http://www.opera.com">
                    <img src="assets/images/browser/opera.png" alt="Opera">
                    <div>Opera</div>
                </a>
            </li>
            <li>
                <a href="https://www.apple.com/safari/">
                    <img src="assets/images/browser/safari.png" alt="Safari">
                    <div>Safari</div>
                </a>
            </li>
            <li>
                <a href="http://windows.microsoft.com/en-us/internet-explorer/download-ie">
                    <img src="assets/images/browser/ie.png" alt="">
                    <div>IE (9 & above)</div>
                </a>
            </li>
        </ul>
    </div>
    <p>Sorry for the inconvenience!</p>
</div>
<![endif]-->
<!-- Warning Section Ends -->
<!-- Required Jquery -->
<script type="text/javascript" src="../assets/js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="../assets/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="../assets/js/popper.js/popper.min.js"></script>
<script type="text/javascript" src="../assets/js/bootstrap/js/bootstrap.min.js"></script>
<!-- jquery slimscroll js -->
<script type="text/javascript" src="../assets/js/jquery-slimscroll/jquery.slimscroll.js"></script>
<!-- modernizr js -->
<script type="text/javascript" src="../assets/js/modernizr/modernizr.js"></script>
<script type="text/javascript" src="../assets/js/modernizr/css-scrollbars.js"></script>

<!-- Custom js -->
<script type="text/javascript" src="../assets/js/script.js"></script>
<script src="../assets/js/pcoded.min.js"></script>
<script src="../assets/js/vartical-demo.js"></script>
<script src="../assets/js/jquery.mCustomScrollbar.concat.min.js"></script>
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