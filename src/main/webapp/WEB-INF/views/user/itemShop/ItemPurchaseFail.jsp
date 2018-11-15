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

<title>아이템 구매 결과</title>
<script src="/js/jquery-1.12.3.min.js"></script>
<script src="/js/jquery-ui.min.js"></script>
<link type="text/css" rel="stylesheet" href="/css/itemPurchaseStyle.css" />
</head>
<style>
input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
        }
        
#shopBtn{
    background-color: #b13862;
    width: 20%;
    height: 30pt;
    border-radius: 8pt;
    border: none;
    color:white;
    font-family: Bareun;
}
#shopBtn:hover{
    background: #772642;   
    color: white;
    box-shadow: 0 2px #999;
}
#shopBtn:active {
    background-color: #772642;
    color: white;
    box-shadow: 0 2px #666;
    transform: translateY(4px);
}
</style>
<body>

    
<jsp:include page="../../login/navigation.jsp" flush="true"/>

<div class="container_t">
    <h3 style="color:#2c3e50;margin-left: 6%;"></h3><br>
        <form action="/ItemShop/" method="post">
            <p style="text-align: center;font-size: 36pt;font-weight: bold;font-family: Bareun;color: #2c3e50;">아이템 <span style="color: #d11d53;">구매가 실패</span> 하였습니다.</p>
            <p style="text-align: center;font-size: 28pt;font-weight: bold;font-family: Bareun;color: #d11d53;">잔액이 부족합니다.</p>
            <p style="text-align: center;font-size: 20pt;font-weight: bold;font-family: Bareun;color: #2c3e50;margin-bottom: 6%;">코인을 <span style="color: #d11d53;">충전</span> 해주세요.</p>
            <p style="text-align: center;"><img src="/img/crying.png" style="width: 26%;"><p>
            <br><br><br><br>
            <div style="text-align: center;">
                <button id="shopBtn" type="submit">충전하기</button>
            </div>
            <br><br><br>
                 
        </form>
        <br><br><br><br>
</div>        
</body>
<jsp:include page="../../bottom.jsp" flush="true"/>

</html>