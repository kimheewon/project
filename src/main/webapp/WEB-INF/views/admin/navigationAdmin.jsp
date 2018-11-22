<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import = "com.interntraining.admin.authority.domain.AuthMapp" %>
<%@ page import ="java.util.ArrayList"%>
<%@ page import ="java.util.List"%>
<%  // 인증된 세션이 없는경우, 해당페이지를 볼 수 없게 함.
    if (session.getAttribute("AdminId")  == null) {
        response.sendRedirect("/login/logout");
    }
%>
<html lang="ko">
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>  PayLetter ~! </title>

    <!-- Bootstrap -->
    <link href="/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
	
    <!-- bootstrap-progressbar -->
    <link href="/vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet">
    <!-- JQVMap -->
    <link href="/vendors/jqvmap/dist/jqvmap.min.css" rel="stylesheet"/>
    <!-- bootstrap-daterangepicker -->
    <link href="/vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="/build/css/custom.min.css" rel="stylesheet">
  </head>

<style>

@font-face{font-family:'Bareun'; src:url('/font/BareunDotumOTF1.otf')}
@font-face{font-family:'candy'; src:url('/font/THE_candybar.ttf')}
@font-face{font-family:'TmonTium'; src:url('/font/TmonTium.ttf')}


</style>
 <body>

        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;  margin-top: 5%;">
              <a href="/loginAdmin/home" class="site_title"><i class="fa fa-paw"></i> <span>&nbsp;&nbsp;&nbsp;PayLetter ~! </span></a>
            </div>

            <div class="clearfix"></div>

            <!-- menu profile quick info -->
            <div class="profile clearfix">
              <div class="profile_pic">
                <img src="/img/profile.png" alt="..." class="img-circle profile_img">
              </div>
              <div class="profile_info">
                <span>Welcome,</span>
                <h2><%= session.getAttribute("AdminId") %> 관리자님</h2>
              </div>
            </div>
            <!-- /menu profile quick info -->

            <br />

            <!-- sidebar menu -->
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section">                
                <ul class="nav side-menu">
                  <li><a href="/loginAdmin/home" style=" font-size: 14px;"><i class="fa fa-home"></i> Home </a>
                    
                  </li>
                  
                  <c:forEach var="item" items="${items}">
                	<c:if test="${1 eq item.intAuthItemNo}">
	                  <li><a style=" font-size: 14px;"><i class="fa fa-edit"></i> 권  한 <span class="fa fa-chevron-down"></span> </a>
	                    <ul class="nav child_menu">
	                      <li><a href="/Auth/AuthList">권한 목록</a></li>
	                      <li><a href="/Auth/AuthEnrollForm">권한 등록</a></li>                      
	                    </ul>
	                  </li>
                  </c:if>
                  </c:forEach>
                  
                  <c:forEach var="item" items="${items}">
                  	<c:if test="${2 eq item.intAuthItemNo}">
                  <li><a style=" font-size: 14px;"><i class="fa fa-users"></i> 관리자 <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="/Administrator/AdministratorList">관리자 목록</a></li>
                      <li><a href="/Administrator/AdministratorEnrollForm">관리자 등록</a></li>                      
                    </ul>
                  </li>
                  </c:if>
                  </c:forEach>
                  
                   <c:forEach var="item" items="${items}">
                  	<c:if test="${3 eq item.intAuthItemNo}">
                  <li><a style=" font-size: 14px;"><i class="fa fa-sitemap"></i> 회  원 <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="/Membership/MembershipList">회원 목록</a></li>
                      <li><a href="/Membership/MembershipEnrollForm">회원 등록</a></li>                 
                    </ul>
                  </li>
                  </c:if>
                  </c:forEach>
                  
                  <c:forEach var="item" items="${items}">
                    <c:if test="${4 eq item.intAuthItemNo}">
	                  <li><a style=" font-size: 14px;"><i class="fa fa-desktop"></i> 게시판 카테고리<span class="fa fa-chevron-down"></span></a>
	                    <ul class="nav child_menu">
	                      <li><a href="/BoardCategory/BoardCategoryList">게시판 카테고리 목록</a></li>
	                      <li><a href="/BoardCategory/BoardCategoryEnrollForm">게시판 카테고리 등록</a></li>                      
	                    </ul>
	                  </li>
	                  </c:if>
                  </c:forEach>
                  
                  <c:forEach var="item" items="${items}">
                    <c:if test="${5 eq item.intAuthItemNo}">
                      <li><a style=" font-size: 14px;"><i class="fa fa-tasks"></i> 아이템 관리<span class="fa fa-chevron-down"></span></a>
                        <ul class="nav child_menu">
                          <li><a href="/Product/ProductList">아이템 목록</a></li>
                          <li><a href="/Product/ProductEnrollForm">아이템 등록</a></li>  
                        </ul>
                      </li>
                      </c:if>
                  </c:forEach>  
                  
                  <c:forEach var="item" items="${items}">
                    <c:if test="${6 eq item.intAuthItemNo}">
                      <li><a style=" font-size: 14px;"><i class="fa fa-reorder"></i> 구매 내역 관리<span class="fa fa-chevron-down"></span></a>
                        <ul class="nav child_menu">
                          <li><a href="/AdminCash/AdminCashAllList">캐시 충전 내역</a></li>
                         <li><a href="/Product/PurchaseList">아이템 구매 내역</a></li>  
                        </ul>
                      </li>
                      </c:if>
                  </c:forEach>  
                  
                  
                </ul>
              </div>
              

            </div>
            <!-- /sidebar menu -->

            <!-- /menu footer buttons -->

            <!-- /menu footer buttons -->
          </div>
        </div>

        <!-- top navigation -->
        <div class="top_nav">
          <div class="nav_menu">
            <nav>
              <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
              </div>

              <ul class="nav navbar-nav navbar-right">
                <li class="">
                  <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false" style="width: 240px;text-align:center; font-weight:bold">
                    <img src="/img/profile.png" alt=""><%= session.getAttribute("AdminId") %> 관리자님 &nbsp;&nbsp;&nbsp;
                    <span class=" fa fa-angle-down"></span>
                  </a>
                  <ul class="dropdown-menu dropdown-usermenu pull-right" style="width: 240px;">
                    <li><a href="/loginAdmin/logout"><i class="fa fa-sign-out pull-right"></i> Log Out</a></li>
                  </ul>
                </li>

                
              </ul>
            </nav>
          </div>
        </div>
        <!-- /top navigation -->



 	<!-- jQuery -->
    <script src="/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="/vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="/vendors/nprogress/nprogress.js"></script>
    <!-- Chart.js -->
    <script src="/vendors/Chart.js/dist/Chart.min.js"></script>
    <!-- gauge.js -->
    <script src="/vendors/gauge.js/dist/gauge.min.js"></script>
    <!-- bootstrap-progressbar -->
    <script src="/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
    <!-- iCheck -->
    <script src="/vendors/iCheck/icheck.min.js"></script>
    <!-- Skycons -->
    <script src="/vendors/skycons/skycons.js"></script>
    <!-- Flot -->
    <script src="/vendors/Flot/jquery.flot.js"></script>
    <script src="/vendors/Flot/jquery.flot.pie.js"></script>
    <script src="/vendors/Flot/jquery.flot.time.js"></script>
    <script src="/vendors/Flot/jquery.flot.stack.js"></script>
    <script src="/vendors/Flot/jquery.flot.resize.js"></script>
    <!-- Flot plugins -->
    <script src="/vendors/flot.orderbars/js/jquery.flot.orderBars.js"></script>
    <script src="/vendors/flot-spline/js/jquery.flot.spline.min.js"></script>
    <script src="/vendors/flot.curvedlines/curvedLines.js"></script>
    <!-- DateJS -->
    <script src="/vendors/DateJS/build/date.js"></script>
    <!-- JQVMap -->
    <script src="/vendors/jqvmap/dist/jquery.vmap.js"></script>
    <script src="/vendors/jqvmap/dist/maps/jquery.vmap.world.js"></script>
    <script src="/vendors/jqvmap/examples/js/jquery.vmap.sampledata.js"></script>
    <!-- bootstrap-daterangepicker -->
    <script src="/vendors/moment/min/moment.min.js"></script>
    <script src="/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>

    
<!-- Google Analytics -->
<script>

(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-23581568-13', 'auto');
ga('send', 'pageview');

</script>