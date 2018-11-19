<%@ page language="java" contentType="text/html; charset=EUC-KR"  pageEncoding="EUC-KR"%>
<%@ page import = "java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import = "com.interntraining.admin.boardCategory.domain.*" %>
<%  // 인증된 세션이 없는경우, 해당페이지를 볼 수 없게 함.
    if (session.getAttribute("id")  == null) {
        response.sendRedirect("/login/logout");
    }
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="ko">

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Welcome Home~!</title>
<!-- Bootstrap core CSS -->
<link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>

<!-- Custom fonts for this template -->
<link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css"/>
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css"/>
<link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css"/>
<!-- Plugin CSS -->
<link href="/vendor/magnific-popup/magnific-popup.css" rel="stylesheet" type="text/css"/>

<!-- Custom styles for this template -->
<link href="/css/freelancer.min.css" rel="stylesheet"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link type="text/css" rel="stylesheet" href="/css/navigationCss.css" />

<style>
#menuLink{
    text-decoration: none !important;
    display: block !important;
    width: 130px !important;
    font-size: 16px !important;
    font-weight: bold !important;
    line-height: 2em !important;
    font-family: "Trebuchet MS", Dotum !important;
}
</style>
</head>

<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg bg-secondary fixed-top text-uppercase" id="mainNav"> 
        <div class="container">
            <a class="navbar-brand js-scroll-trigger" href="/login/home">PayLetter</a>
            <div class="collapse navbar-collapse " id="navbarResponsive">
                <ul class="navbar-nav ml-auto">
                    <li id="menuLi">
                        <a id="menuLink" >게시판</a>
                        <ul id="submenu" >
                            <c:forEach var="board" items="${boardCategory}" varStatus="status">                             
                                <c:if test="${board.intParentBoardCateNo eq 0}">
                                    <li class='has-sub 'id="submenuLi">
                                        <a id="submenuLink"  style="font-size:14px;text-decoration: none;" >${board.strBoardCateName}</a>                                                
                                        <ul >
                                            <c:set var="parentNo" value="${board.intBoardCateNo}" />
                                            <c:forEach var="childBoard" items="${boardCategory}" varStatus="status">
                                                <c:if test="${childBoard.intParentBoardCateNo eq parentNo}">
                                                    <li>
                                                        <a href="/board/boardlist?intBoardCateNo=${childBoard.intBoardCateNo}">${childBoard.strBoardCateName}</a>
                                                    </li>
                                                </c:if>                                                   
                                            </c:forEach>
                                        </ul>
                                   </li>
                               </c:if>                                  
                            </c:forEach>
                        </ul>
                    </li>
                    <li>|</li>
                    <li  id="menuLi" >
                        <a id="menuLink"  href="/ItemShop/ItemShopList">아이템샵</a>
                    </li>
                    <li>|</li>
                    <li  id="menuLi" >
                        <a id="menuLink"  >마이페이지</a>
                        <ul id="submenu" >
                            <li class='has-sub2'id="submenuLi">
                                <a id="submenuLink" href="/login/passwordCheckForm" style="font-size:14px;text-decoration: none;" >내 정보</a>      
                            </li>
                            <li class='has-sub2' id="submenuLi">
                                <a id="submenuLink" href="/Cash/PurchaseForm" style="font-size:14px;text-decoration: none;" >캐시 충전(PG)</a>      
                            </li>  
                            <li class='has-sub2' id="submenuLi">
                                <a id="submenuLink" href="/Cash/CashList" style="font-size:14px;text-decoration: none;" >캐시 충전 내역</a>      
                            </li>
                            <li class='has-sub2' id="submenuLi">
                                <a id="submenuLink" href="/ItemShop/ItemPurchaseList" style="font-size:14px;text-decoration: none;" >아이템 구매 내역</a>      
                            </li>                                                
                         </ul>                                            
                    </li>
                    <li>|</li>
                    <li  id="menuLi" >
                        <a id="menuLink"  href="/login/logout">로그아웃</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    
    <header class="session text-white text-right">
        <div class="container" style="font-size: 17px">
            <%= session.getAttribute("id") %>님 <small>반갑습니다.&nbsp;&nbsp;(&nbsp;보유캐시&nbsp;:&nbsp;<fmt:formatNumber value='<%= session.getAttribute("cash") %>' pattern="#,###" />&nbsp;코인&nbsp;)</small>
        </div>
    </header>
    
    <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes) -->
    <div class="scroll-to-top d-lg-none position-fixed ">
        <a class="js-scroll-trigger d-block text-center text-white rounded" href="#page-top"> <i class="fa fa-chevron-up"></i></a>
    </div>
    <!-- Bootstrap core JavaScript -->
    <script src="/vendor/jquery/jquery.min.js"></script>
    <script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="/vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="/vendor/magnific-popup/jquery.magnific-popup.min.js"></script>

    <!-- Contact Form JavaScript -->
    <script src="/js/jqBootstrapValidation.js"></script>
    <script src="/js/contact_me.js"></script>

    <!-- Custom scripts for this template -->
    <script src="/js/freelancer.min.js"></script>
</body>
</html>