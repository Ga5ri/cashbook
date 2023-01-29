<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// Controller
	if(session.getAttribute("loginMember") == null) {
		// 로그인되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	//session에 저장된 멤버(현재 로그인 사용자)
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	// Model 호출
	// CategoryDao 호출
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	// CashDao 호출
	CashDao cashDao = new CashDao();
	HashMap<String, Object> cash = cashDao.selectCashListByCashNo(cashNo);
%>
<!DOCTYPE html>
<html>
	<head>
		<title>가계부 수정</title>
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
	                        <form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp" method="post" class="md-float-material">
	                        	<!-- cashNo,년,월,일 hidden 처리 -->
								<input type="hidden" name="cashNo" value="<%=cash.get("cashNo")%>">
								<input type="hidden" name="year" value="<%=year%>">
								<input type="hidden" name="month" value="<%=month%>">
								<input type="hidden" name="date" value="<%=date%>">
	                            <div class="auth-box">   
	                                <div class="row m-b-20">
	                                    <div class="col-md-12">
	                                        <h3 class="text-center txt-primary">가계부 수정</h3>
	                                    </div>
	                                </div>
	                                <hr/>
	                                <div class="input-group">
	                                    <input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly" class="form-control">
	                                    <span class="md-line"></span>
	                                </div>
	                                <div class="input-group">
	                                    <select name="categoryNo" class="form-control">
										<%
											for(Category c : categoryList){ // 입력창과 동일하게 출력
										%>
												<option value="<%=c.getCategoryNo()%>">
												(<%=c.getCategoryKind()%>) <%=c.getCategoryName()%>
												</option>							
										<%
											}
										%>
										</select>
	                                    <span class="md-line"></span>
	                                </div>
	                                <div class="input-group">
	                                    <input type="text" name="cashPrice" value="<%=cash.get("cashPrice")%>" class="form-control">
	                                    <span class="md-line"></span>
	                                </div>
	                                <div class="input-group">
	                                    <textarea name="cashMemo" rows="3" cols="50" class="form-control"><%=cash.get("cashMemo")%></textarea>
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