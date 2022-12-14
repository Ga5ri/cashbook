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
