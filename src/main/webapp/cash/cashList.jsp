<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	
	if (session.getAttribute("loginMember") == null) {
		// 로그인되지 않은 상태
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		return;
	}
	
	// session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member) session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	String loginMemberName = loginMember.getMemberName();
	System.out.println(loginMemberId);
	System.out.println(loginMemberName);
	
	int year = 0;
	int month = 0;
	
	// year,month null 값시 오늘날짜 출력
	if (request.getParameter("year") == null || request.getParameter("month") == null) {
		Calendar today = Calendar.getInstance(); // 오늘날짜
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH); // 0~11
	} else {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		// month -> -1, month -> 12 일경우
		if (month == -1) {
			month = 11;
			year -= 1;
		}
		if (month == 12) {
			month = 0;
			year += 1;
		}
	}
	
	// 출력하고자 하는 년, 월과 월의 1일의 요일 (일 1, 월 2, 화 3, ... 토 7)
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	
	// firstDay는 1일의 요일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK); // 요일 (일 1, 월 2, 화 3, ... 토 7)
	
	// 마지막날짜
	int lastDate = targetDate.getActualMaximum(Calendar.DATE);
	
	// begin blank개수는 firstDay - 1
	// 달력 출력테이브르이 시작 공백셀(td)과 마지막 공백셀(td)의 개수
	int beginBlank = firstDay - 1;
	int endBlank = 0; //  beginBlank + lastDate + endBlank -> 7로 나누어 떨어진다 -> totalTd
	if ((beginBlank + lastDate) % 7 != 0) {
		endBlank = 7 - ((beginBlank + lastDate) % 7);
	}
	
	// 전체 td의 개수 : 7로 나누어 떨어져야 한다.
	int totalTd = beginBlank + lastDate + endBlank;
	
	// Model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month + 1);
	// View : 달력출력 + 일별 cash 목록 출력
%>
<!DOCTYPE html>
<html>
<head>
<title>가계부 사이트 마이페이지</title>
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
	<style>
		table {
			width: 1500px;
			table-layout: fixed;
			}
		.cn {
			font-size: 30px;
		}
	</style>
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
                       <div class="mobile-search">
                           <div class="header-search">
                               <div class="main-search morphsearch-search">
                                   <div class="input-group">
                                       <span class="input-group-addon search-close"><i class="ti-close"></i></span>
                                       <input type="text" class="form-control" placeholder="Enter Keyword">
                                       <span class="input-group-addon search-btn"><i class="ti-search"></i></span>
                                   </div>
                               </div>
                           </div>
                       </div>
                       <a href="<%=request.getContextPath()%>/cash/cashList.jsp">
                           <img class="img-fluid" src="../assets/images/logo.png" alt="Theme-Logo" />
                       </a>
                       <a class="mobile-options">
                           <i class="ti-more"></i>
                       </a>
                   </div>

                   <div class="navbar-container container-fluid">					
                       <ul class="nav-right">                       
                           <li class="user-profile header-notification">
                               <a href="#!">
                                   <span><%=loginMemberName%></span>
                                   <i class="ti-angle-down"></i>
                               </a>
                               <ul class="show-notification profile-notification">
                                   <%
                                   	   if(loginMember.getMemberLevel() > 0){
                                   %>
                                   			<li>
		                                        <a href="<%=request.getContextPath()%>/admin/adminMain.jsp">
		                                            <i class="ti-settings"></i> 관리자메뉴
		                                        </a>
		                                    </li>
                                   <%		   
                                   	   }
                                   %>
                                   <li>
                                       <a href="<%=request.getContextPath()%>/member/memberOne.jsp">
                                           <i class="ti-user"></i> 마이페이지
                                       </a>
                                   </li>
                                   <li>
                                       <a href="<%=request.getContextPath()%>/logout.jsp">
                                       <i class="ti-layout-sidebar-left"></i> 로그아웃
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
                            
                            <div class="pcoded-navigatio-lavel" data-i18n="nav.category.navigation">Layout</div>
                            <ul class="pcoded-item pcoded-left-item">
                                <li class="">
                                    <a href="<%=request.getContextPath()%>/cash/cashList.jsp">
                                        <span class="pcoded-micon"><i class="ti-home"></i><b>D</b></span>
                                        <span class="pcoded-mtext" data-i18n="nav.dash.main">가계부 홈</span>
                                        <span class="pcoded-mcaret"></span>
                                    </a>
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
                                            <h5 class="m-b-10">가계부 사이트</h5>
                                            <p class="m-b-10"><%=loginMemberName%>님 환영합니다. 사이트 이용중 추가 문의사항이나 불편사항은 고객센터 접수 부탁드립니다.</p>
                                        </div>
                                    </div>
                                    <!-- Page-header end -->
                                    
                                <!-- Page-body start -->
                                <div class="page-body">
                                    <!-- Basic table card start -->
                                    <div class="card">
                                        <div class="card-header">
                                            <h5>가계부 캘린더</h5>
                                            <span></span>
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
                                        <div class="card-block table-border-style">
                                            <div class="table-responsive">
	                                            <div class="text-center">
													<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>" style="float: left" class="btn btn-round btn-outline-primary">
														&#8701;이전달
													</a>
													<sapn class="cn"><%=year%> 년 <%=month+1%> 월</sapn>
													<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>" style="float: right" class="btn btn-round btn-outline-primary">
														다음달&#8702;
													</a>
												</div>
												<table class="table">
													<thead class="bg-primary text-center">
														<tr>
															<th>일</th>
															<th>월</th>
															<th>화</th>
															<th>수</th>
															<th>목</th>
															<th>금</th>
															<th>토</th>
														</tr>
													</thead>
													<tbody>
															<% 
																for(int i=1; i<=totalTd; i++){
															%>
																	<td>
															<%
																		int date = i - beginBlank;
																		if(date > 0 && date <= lastDate){				
															%>
																			<div>
																				<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">
																					<%=date%>
																				</a>
																			</div>
																			<div>
																				<%
																					for(HashMap<String, Object> m : list){ // 해당 월에 일수를 date와 비교
																						String cashDate = (String)(m.get("cashDate"));
																						if(Integer.parseInt(cashDate.substring(8)) == date){
																				%>
																							(<%=(String)(m.get("categoryKind"))%>)
																							<%=(Long)(m.get("cashPrice"))%>원
																							<%=(String)(m.get("categoryName"))%>
																							<br>
																				<%	
																						}
																					}
																				%>
																			</div>
															<%			
																		}
															%>
																	</td>
															<%	
																	if(i % 7 == 0 && i != totalTd) {
															%>
																		<tr></tr> <!-- td7개 만들어진 후 테이블 줄바꿈 -->
															<%			
																	}
																}
															%>
														</tbody>
												</table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Page-body end -->
                            </div>
                        </div>
                        <!-- Main-body end -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
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