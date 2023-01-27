<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	if (session.getAttribute("loginMember") == null) {
		// 로그인되지 않은 상태
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
	
	// session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	StatsDao statsDao = new StatsDao();
	ArrayList<HashMap<String, Object>> list = statsDao.selectCashListByYear(memberId);

%>
<!DOCTYPE html>
<html>
<head>
	<!-- Meta -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="description" content="Gradient Able Bootstrap admin template made using Bootstrap 4. The starter version of Gradient Able is completely free for personal project." />
	<meta name="keywords"
	content=", Flat ui, Admin , Responsive, Landing, Bootstrap, App, Template, Mobile, iOS, Android, apple, creative app">
	<meta name="author" content="codedthemes">
	<!-- Favicon icon -->
	<link rel="icon" href="../assets/images/favicon.ico" type="image/x-icon">
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
<title>년도별 수입/지출 통계</title>
</head>
<body>
	<div id="pcoded" class="pcoded">
		<div class="pcoded-overlay-box"></div>
        <div class="pcoded-container navbar-wrapper">
			<div>
				<jsp:include page="/inc/head.jsp"></jsp:include>
			</div>

            <div class="pcoded-main-container">
                <div class="pcoded-wrapper">
                    <nav class="pcoded-navbar">
                        <div class="sidebar_toggle"><a href="#"><i class="icon-close icons"></i></a></div>
                        <div class="pcoded-inner-navbar main-menu">
                            
                            <div class="pcoded-navigatio-lavel" data-i18n="nav.category.navigation">Layout</div>
                            <ul class="pcoded-item pcoded-left-item">
								<li class="">
                                    <a href="<%=request.getContextPath()%>/cash/cashList.jsp">
                                        <span class="pcoded-micon"><i class="ti-home"></i><b>D</b></span>
                                        <span class="pcoded-mtext" data-i18n="nav.dash.main">가계부 홈</span>
                                        <span class="pcoded-mcaret"></span>
                                    </a>
                                </li>
                                <li class="pcoded-hasmenu">
                                    <a href="javascript:void(0)">
                                        <span class="pcoded-micon"><i class="ti-layout-grid2-alt"></i></span>
                                        <span class="pcoded-mtext"  data-i18n="nav.basic-components.main">가계부 통계</span>
                                        <span class="pcoded-mcaret"></span>
                                    </a>
                                    <ul class="pcoded-submenu">
                                        <li class=" ">
                                            <a href="<%=request.getContextPath()%>/cash/cashListByYear.jsp">
                                                <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                                <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">년도별 통계</span>
                                                <span class="pcoded-mcaret"></span>
                                            </a>
                                        </li>
                                        <li class=" ">
                                            <a href="<%=request.getContextPath()%>/cash/cashListByMonth.jsp">
                                                <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                                <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">월별 통계</span>
                                                <span class="pcoded-mcaret"></span>
                                            </a>
                                        </li>                                                 
                                    </ul>
                                </li>                                
                                 <li>
                                    <a href="<%=request.getContextPath()%>/help/helpList.jsp">
                                        <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
                                        <span class="pcoded-mtext" data-i18n="nav.form-components.main">고객센터</span>
                                        <span class="pcoded-mcaret"></span>
                                    </a>
                                </li>
                            </ul>                     
                        </div>
                    </nav>
                    <div class="pcoded-content">
                        <div class="pcoded-inner-content">

                            <!-- Main-body start -->
                            <div class="main-body">
                                <div class="page-wrapper">
									<!-- Page-header start -->
                                    <div class="page-header card">
                                        <div class="card-block">
                                            <h5 class="m-b-10">수입/지출 통계</h5>
                                            <p class="m-b-10">년도별 수입 및 지출 통계 내역입니다.</p>                                       
                                        </div>
                                    </div>
                                    <!-- Page-header end -->
                                    
                                    <!-- Page body start -->
                                    <div class="page-body">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <!-- Basic Form Inputs card start -->
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>년도별 수입/지출 통계</h5>
                                                        
                                                        <div class="card-header-right"><i
                                                            class="icofont icofont-spinner-alt-5"></i></div>

                                                            <div class="card-header-right">
                                                                <i class="icofont icofont-spinner-alt-5"></i>
                                                            </div>

                                                        </div>
                                                        <div class="card-block">
                                                                <div class="form-group row">            											
																		   <table class="table table-hover table-bordered">
																		   	<thead class="bg-info">
																				<tr>
																					<td>년도</td>
																				<td>수입횟수</td>
																				<td>수입합산(원)</td>
																				<td>수입평균(원)</td>
																				<td>지출횟수</td>
																				<td>지출합산(원)</td>
																				<td>지출평균(원)</td>
																				</tr>
																		      </thead>
																		      <tbody>
																					<%
																						for(HashMap<String, Object> m : list) {
																					%>
																							<tr>
																								<td><%=m.get("year")%></td>
																								<td><%=m.get("icCnt")%></td>
																								<td><%=m.get("icSum")%></td>
																								<td><%=m.get("icAvg")%></td>
																								<td><%=m.get("ecCnt")%></td>
																								<td><%=m.get("ecSum")%></td>
																								<td><%=m.get("ecAvg")%></td>
																							</tr>
																					<%		
																						}
																					%>
																			    </tbody>
																			</table>
                                                                		</div>                                                                                                                         
                                                                    </div>
                                                                </div>
                                                                <!-- Basic Form Inputs card end -->                                                               
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- Page body end -->
                                                </div>
                                            </div>
                                            <!-- Main-body end -->
                                            <div id="styleSelector">

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
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
</body>
</html>
	<h1>년도별 수입/지출 통계</h1>
	<table>
		<tr>
			<td>년도</td>
			<td>수입횟수</td>
			<td>수입합산(원)</td>
			<td>수입평균(원)</td>
			<td>지출횟수</td>
			<td>지출합산(원)</td>
			<td>지출평균(원)</td>
		</tr>
		<%
			for(HashMap<String, Object> m : list) {
		%>
				<tr>
					<td><%=m.get("year")%></td>
					<td><%=m.get("icCnt")%></td>
					<td><%=m.get("icSum")%></td>
					<td><%=m.get("icAvg")%></td>
					<td><%=m.get("ecCnt")%></td>
					<td><%=m.get("ecSum")%></td>
					<td><%=m.get("ecAvg")%></td>
				</tr>
		<%		
			}
		%>
	</table>
</body>
</html>