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

<title>Cash Purchase</title>
<script src="/js/jquery-1.12.3.min.js"></script>
<script src="/js/jquery-ui.min.js"></script>

</head>

<body>

    
<jsp:include page="../../login/navigation.jsp" flush="true"/>

<div class="container_t">
       <h3 style="color:#2c3e50;margin-left: 1%;">캐시 구매</h3>
        <button type="button" onclick="location.href='/Cash/Purchase'" id="cashPurchaseBtn">캐시 구매</button>
  
<button type="button" onclick="location.href='" id="">캐시</button>

</div>        
</body>
<jsp:include page="../../bottom.jsp" flush="true"/>
<script type="text/javascript">
   
function commentUpd(intCmmtNo){
    
    var c = document.getElementById("commentContent");
        if (c.value == ""){
            alert("내용을 입력하세요.");
            c.focus();
            return false;
        }
      
    
    
    var commnet;
    
   $.ajax({
       type: "POST",
       async: false,
       url: "/board/commentUpdate",            
       dataType:"html",// JSON/html
       data:{
           "intCmmtNo":intCmmtNo, "strCmmtContent":$("#commentContent").val()              
       },
       error: function (request, status, error) {
           alert("Ajax Error - code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
       },
       success: function () {
         //  alert("수정되었습니다.");
           location.href = "/board/boardread?intBoardNo=" + $("#bno").val();
       
         
       }
   })    
</script>
</html>