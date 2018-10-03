<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  // 인증된 세션이 없는경우, 해당페이지를 볼 수 없게 함.
    if (session.getAttribute("userid") == null) {
        response.sendRedirect("logout");
    }
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    

<html lang="ko">

<jsp:include page="navigation.jsp" flush="true"/>

<body>

	    
	<header class="session text-white text-right">
		<div class="container">
	        <%= session.getAttribute("userid") %>님 <small>반갑습니다.</small>
		</div>
	</header>

    
</body>
<jsp:include page="../bottom.jsp" flush="true"/>
</html>