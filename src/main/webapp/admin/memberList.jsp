<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String loginMemberName = loginMember.getMemberName();
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage - 1) * rowPerPage;
	
	
	// Model 호출
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> list = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	int memberCount = memberDao.selectMemberCount(); // --> lastPage
	
	// lastPage
	int lastPage = memberDao.selectMemberCount() / rowPerPage;
	if(memberDao.selectMemberCount() % rowPerPage != 0) {
		lastPage+=1;
	}
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
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
<title>Insert title here</title>
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
                                                        <h5>카테고리 관리</h5>
                                                        <a href="<%=request.getContextPath()%>/admin/insertCategoryForm.jsp" class="btn btn-outline-dark">카테고리 추가</a>
                                                        <div class="card-header-right"><i
                                                            class="icofont icofont-spinner-alt-5"></i></div>

                                                            <div class="card-header-right">
                                                                <i class="icofont icofont-spinner-alt-5"></i>
                                                            </div>

                                                        </div>
                                                        <div class="card-block">
                                                        <table class="table">
															<tr>
																<th>멤버번호</th>
																<th>아이디</th>
																<th>회원구분(레벨)</th>
																<th>이름</th>
																<th>마지막수정일자</th>
																<th>생성일자</th>
																<th>레벨수정</th>
																<th>강제탈퇴</th>
															</tr>
															<%
																for(Member m : list) {
															%>
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
																		<td>
																			<form action="<%=request.getContextPath()%>/admin/updateMemberLevelAction.jsp" method="post">
																				<input type="hidden" name="memberId" value="<%=m.getMemberId()%>">
																				<select name="memberLevel">
																					<option value="0">0</option>
																					<option value="1">1</option>
																				</select>
																				<button type="submit">레벨수정</button>
																			</form>
																		</td>
																		<td><a href="<%=request.getContextPath()%>/admin/deleteMemberAction.jsp?memberId=<%=m.getMemberId()%>">강퇴</a></td>
																	</tr>
															<%		
																}
															%>
														</table>
														<div class="btn-group">
															<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=1" class="btn btn-info btn-round">처음</a>
															<%
																if(currentPage > 1) {				
															%>
																	<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>" class="btn btn-info btn-round">이전</a>
															<%
																}
															%>
																<span class="btn btn-info"><%=currentPage%></span>
															<%
																if(currentPage < lastPage) {
															%>
																	<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>" class="btn btn-info btn-round">다음</a>	
															<%
																}
															%>
															<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=lastPage%>" class="btn btn-info btn-round">마지막</a>
														</div>
													</div>
                                                           
                                                                <div class="form-group row">            																													                                                                   
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