<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%  // 인증된 세션이 없는경우, 해당페이지를 볼 수 없게 함.
    if (session.getAttribute("id")  == null) {
        response.sendRedirect("/login/logout");
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>


<title>HOME</title>
</head>
<body>

	<jsp:include page="navigation.jsp" flush="true"/>
	<!-- Header -->
    <header class="masthead bg-primary text-white text-center" style="padding-top: 8.3%;">
      <div class="container">
        <img class="img-fluid mb-5 d-block mx-auto" src="/img/profile.png" alt="">
        <h1 class="text-uppercase mb-0">Welcome Home~!!</h1>
        <hr class="star-light">
        <h2 class="font-weight-light mb-0">This is Payletter Home Page.</h2>
      </div>
    </header>
    <!-- Footer -->
  
 	<jsp:include page="../bottom.jsp" flush="true"/>


</body>

</html>