<%@ page language="java" contentType="text/html; charset=EUC-KR"  pageEncoding="EUC-KR"%>
<%@ page import = "java.util.List" %>
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


<style>
    .session{
		background : #18bc9c;
		padding-top:calc(3rem + 55px);
	  	font-size:16px;
	  	line-height:1.6;
	  	font-family: 'Lato';

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
                    <li class="dropdown nav-item mx-0 mx-lg-1 ">
                        <a id="aa" class="dropdown-toggle nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger  " href="#" data-toggle="dropdown">게시판</a>
	                    <ul class="dropdown-menu" role="menu">
                            <c:forEach var="board" items="${boardCategory}" varStatus="status">
					            <li style="margin-top: 7%;margin-bottom: 7%;margin-left: 3%;">
					                <a class="nav-link2 py-3 px-0 px-lg-3 rounded js-scroll-trigger" style="font-size:14px;text-decoration: none;" href="/board/boardlist?intBoardCateNo=${board.intBoardCateNo}">${board.strBoardCateName}</a>
					            </li>
                            </c:forEach>
                        </ul>
                    </li> 
                    <li class="nav-item mx-0 mx-lg-1">
                        <a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="/login/myPageForm">마이페이지</a>
                    </li>
                    <li class="nav-item mx-0 mx-lg-1">
                        <a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="/login/logout">로그아웃</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    
    <header class="session text-white text-right">
        <div class="container">
            <%= session.getAttribute("id") %>님 <small>반갑습니다.</small>
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