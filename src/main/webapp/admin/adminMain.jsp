<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1 ){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	}
	
	String memberId = loginMember.getMemberId();
	String loginMemberName = loginMember.getMemberName();

	// 최근공지 5개, 최근멤버 5명, 최근 고객센터 5건 
	NoticeDao noticeDao = new NoticeDao();
	MemberDao memberDao = new MemberDao();
	HelpDao helpDao = new HelpDao();
	
	// 5개까지
	int beginRow = 0;
	int rowPerPage = 5;
	
	// Model 호출
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	ArrayList<HashMap<String, Object>> helpList = helpDao.selectHelpList(beginRow, rowPerPage);
	// View
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>adminMain</title>
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
                                            <h5 class="m-b-10">관리자페이지</h5>
                                            <p class="m-b-10">관리자 기능</p>
                                         <div class="btn-group">
                                         <a href="<%=request.getContextPath()%>/admin/noticeList.jsp" class="btn btn-outline-dark">공지관리</a>
										 <a href="<%=request.getContextPath()%>/admin/helpListAll.jsp" class="btn btn-outline-dark">고객센터관리</a>
										 <a href="<%=request.getContextPath()%>/admin/categoryList.jsp" class="btn btn-outline-dark">카테고리관리</a>
										 <a href="<%=request.getContextPath()%>/admin/memberList.jsp" class="btn btn-outline-dark">멤버관리(목록, 레벨수정, 강제탈퇴)</a>
		
                                         </div>                         
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
                                                        <h5>최근 공지사항</h5>
                                                        <a href="<%=request.getContextPath()%>/admin/noticeList.jsp" class="btn btn-outline-dark" style="float:right;">공지관리</a>
                                                        <div class="card-header-right"><i
                                                            class="icofont icofont-spinner-alt-5"></i></div>

                                                            <div class="card-header-right">
                                                                <i class="icofont icofont-spinner-alt-5"></i>
                                                            </div>

                                                        </div>
                                                        <div class="card-block">
                                                        <table class="table">
                                                        	<thead class="bg-success">									
																<tr>
																	<th>공지내용</th>
																	<th>공지일자</th>
																</tr>	
															</thead>																
																<%
																	for(Notice n : noticeList) {
																%>
																	<tbody>
																		<tr>
																			<td><%=n.getNoticeMemo() %></td>
																			<td><%=n.getCreatedate() %></td>
																		</tr>
																	</tbody>
																<%
																}
																%>												
														</table>
                                                           
                                                                <div class="form-group row">            											
																		  
                                                                  
                                                                		</div>                                                                                                                         
                                                                    </div>
                                                                </div>
                                                                <!-- Basic Form Inputs card end -->
                                                                 <!-- Inverse table card start -->
							                                    <div class="card">
							                                        <div class="card-header">
							                                            <h5>최근 회원</h5>
							                                            <a href="<%=request.getContextPath()%>/admin/memberList.jsp" class="btn btn-outline-dark" style="float:right;">멤버관리(목록, 레벨수정, 강제탈퇴)</a>							                                   				
							                                        </div>
							                                        <div class="card-block table-border-style">
							                                            <div class="table-responsive">
							                                            <table class="table">
							                                            	<thead class="bg-success">
																			<tr>
																				<td>회원번호</td>
																				<td>아이디</td>
																				<td>회원구분(레벨)</td>
																				<td>닉네임</td>
																				<td>업데이트일</td>
																				<td>회원가입일</td>
																			</tr>
																			</thead>
																			<%
																				for(Member m : memberList){
																			%>
																				<tbody>
																					<tr>
																						<td><%=m.getMemberNo()%></td>
																						<td><%=m.getMemberId()%></td>
																						<td>
																						<%
																							if(m.getMemberLevel() == 0) {
																						%> 
																								<sapn>회원</sapn>
																						<%		
																							} else if(m.getMemberLevel() == 1) {
																						%>
																								<sapn>관리자</sapn>
																						<%		
																							}
																						%>
																						(<%=m.getMemberLevel()%>)
																					</td>
																						<td><%=m.getMemberName()%></td>
																						<td><%=m.getUpdatedate()%></td>
																						<td><%=m.getCreatedate()%></td>
																					</tr>
																				</tbody>
																			<%
																				}
																			%>
																		</table>
							                                                
							                                            </div>
							                                        </div>
							                                    </div>
							                                    <!-- Inverse table card end -->
							                                     <!-- Hover table card start -->
							                                    <div class="card">
							                                        <div class="card-header">
							                                            <h5>최근 문의사항</h5>
							                                            <a href="<%=request.getContextPath()%>/admin/helpListAll.jsp" class="btn btn-outline-dark" style="float:right;">고객센터관리</a>					                                  						
							                                        </div>
							                                        <div class="card-block table-border-style">
							                                            <div class="table-responsive">
							                                                <table class="table">
									   											<thead class="bg-success">
																					<tr>
																						<td>문의내용</td>
																						<td>작성자</td>
																						<td>작성일</td>
																					</tr>
																				</thead>
																				<%
																					for(HashMap<String, Object> h : helpList){
																				%>
																					<tbody>
																						<tr>
																							<td><%=h.get("helpMemo")%></td>
																							<td><%=h.get("memberId")%></td>
																							<td><%=h.get("helpCreatedate")%></td>
																						</tr>
																					</tbody>
																				<%
																					}
																				%>
							                                               
							                                                </table>
							                                            </div>
							                                        </div>
							                                    </div>
							                                    <!-- Hover table card end -->                                                               
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