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
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
.mySlides {display:none}
.w3-left, .w3-right, .w3-badge {cursor:pointer}
.w3-badge {height:13px;width:13px;padding:0}
</style>
<title>HOME</title>
</head>
<body>

	<jsp:include page="navigation.jsp" flush="true"/>
	<!-- Header -->
    <header class="masthead bg-primary text-white text-center" style=" padding-top: 3rem;
    padding-bottom: 2.8rem;
    background-color: black !important;">
      <div class="container" style="padding-right: 0px;
    padding-left: 0px;
    margin-right: 0;
    margin-left: 0;
    max-width: 100%;
    background-color:black;">
        <div class="w3-content w3-display-container" style="    height: 719px;
    max-width: 70%;
    margin: auto;">
  <img class="mySlides" src="/img/home3.jpg" style="width:100%;height: 100%;">
  <img class="mySlides" src="/img/home2.jpg" style="width:100%;height: 100%;">
  <img class="mySlides" src="/img/home1.jpg" style="width:100%;height: 100%;">
  <div class="w3-center w3-container w3-section w3-large w3-text-white w3-display-bottommiddle" style="width:100%">
    <div class="w3-left w3-hover-text-khaki" onclick="plusDivs(-1)">&#10094;</div>
    <div class="w3-right w3-hover-text-khaki" onclick="plusDivs(1)">&#10095;</div>
    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(1)"></span>
    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(2)"></span>
    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(3)"></span>
  </div>
</div>
      </div>
    </header>
    
    <!-- Footer -->
  
 	<jsp:include page="../bottom.jsp" flush="true"/>


</body>

<script>
var slideIndex = 1;
var myIndex = 0;
carousel();
showDivs(slideIndex);

function carousel() {
    var i;
    var x = document.getElementsByClassName("mySlides");
    var dots = document.getElementsByClassName("demo");
    for (i = 0; i < x.length; i++) {
       x[i].style.display = "none";
      
    }
    for (i = 0; i < dots.length; i++) {
     dots[i].className = dots[i].className.replace(" w3-white", "");
  }
    myIndex++;
    if (myIndex > x.length) {myIndex = 1}    
    x[myIndex-1].style.display = "block";  
    dots[myIndex-1].className += " w3-white";
    setTimeout(carousel, 1700); // Change image every 2 seconds
}
function plusDivs(n) {
  showDivs(slideIndex += n);
}

function currentDiv(n) {
  showDivs(slideIndex = n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("demo");
  if (n > x.length) {slideIndex = 1}    
  if (n < 1) {slideIndex = x.length}
  for (i = 0; i < x.length; i++) {
     x[i].style.display = "none";  
  }
  for (i = 0; i < dots.length; i++) {
     dots[i].className = dots[i].className.replace(" w3-white", "");
  }
  x[slideIndex-1].style.display = "block";  
  dots[slideIndex-1].className += " w3-white";
}
</script>

</html>