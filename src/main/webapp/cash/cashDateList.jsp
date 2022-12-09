<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	request.setCharacterEncoding("utf-8");
	if(session.getAttribute("loginMember") == null) {
		// 로그인되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} 
	
	// session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	String loginMemberName = loginMember.getMemberName();
	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));


	// Model 호출
	// CategoryDao 호출
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList(); 
	// CashDao 호출
	CashDao cashDao = new CashDao(); 
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month, date);
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일별 가계부</title>
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
                                            <h5 class="m-b-10">일별 가계부 작성</h5>
                                            <p class="m-b-10">수입, 지출, 분류에 맞게 작성해주세요.</p>                                       
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
                                                        <h5><%=year%>년 <%=month%>월 <%=date%>일 가계부 목록</h5>
                                                        
                                                        <div class="card-header-right"><i
                                                            class="icofont icofont-spinner-alt-5"></i></div>

                                                            <div class="card-header-right">
                                                                <i class="icofont icofont-spinner-alt-5"></i>
                                                            </div>

                                                        </div>
                                                        <div class="card-block">
                                                                <div class="form-group row">            											
																		   <table class="table">
																				<tr>
																					<th>수입/지출</th>
																					<th>분류</th>
																					<th>금액</th>
																					<th>내용</th>
																					<th>수정</th>
																					<th>삭제</th>
																				</tr>
																				<%
																					for(HashMap<String, Object> m : list){
																						int cashNo = (Integer)m.get("cashNo"); // 수정 및 삭제를 위해 cashNo 받아옴
																				%>
																						<tr>
																							<td><%=m.get("categoryKind")%></td>
																							<td><%=m.get("categoryName")%></td>
																							<td><%=m.get("cashPrice")%></td>
																							<td><%=m.get("cashMemo")%></td>
																							<td><a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?cashNo=<%=cashNo%>&year=<%=year%>&month=<%=month%>&date=<%=date%>">수정</a></td>
																							<td><a href="<%=request.getContextPath()%>/cash/deleteCash.jsp?cashNo=<%=cashNo%>&year=<%=year%>&month=<%=month%>&date=<%=date%>">삭제</a></td>
																						</tr>
																				<%
																					}
																				%>
																			</table>
                                                                  
                                                                		</div>                                                                                                                         
                                                                    </div>
                                                                </div>
                                                                <!-- Basic Form Inputs card end -->        
                                                                 <!-- Inverse table card start -->
                                    <div class="card">
                                        <div class="card-header">
                                            <h5><%=month%>월 <%=date%>일 가계부 추가</h5>
                                            <span>일자를 확인해주세요.</span>                                          
                                        </div>
                                        <div class="card-block table-border-style">
                                            <div class="table-responsive">
                                            <form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
                                            <input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
												<input type="hidden" name="year" value="<%=year%>">
												<input type="hidden" name="month" value="<%=month%>">
												<input type="hidden" name="date" value="<%=date%>">
                                                <table class="table">
												<!-- memberId,년,월,일 hidden 처리 -->
													<tr>
														<td>날짜</td>
														<td>
															<input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
														</td>
													</tr>
													
													<tr>
														<td>(수입/지출)분류</td>
														<td>
															<select name="categoryNo">
															<%
																for(Category c : categoryList){
															%>
																	<option value="<%=c.getCategoryNo()%>">
																		(<%=c.getCategoryKind()%>) <%=c.getCategoryName()%>
																	</option>
															<%
																}
															%>
															</select>
														</td>
													</tr>		
													<tr>
														<td>금액</td>
														<td><input type="text" name="cashPrice"></td>
													</tr>
													<tr>
														<td>내용</td>
														<td><textarea rows="3" cols="50" name="cashMemo"></textarea></td>
													</tr>													                                              
                                                </table>
                                                <div class="col-sm-12">
                                                <button type="submit" class="btn btn-md btn-primary rounded text-center" style="width: 100px;">추가</button>
                                                </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Inverse table card end -->                                                       
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