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

<title>비밀번호 확인</title>
<style>
	.container_t {
    
		padding-right: 15px;
		padding-left: 15px;
		margin-right: auto;
		margin-left: auto;
		width: 70%;
		margin: 0 auto;     /* 가로로 중앙에 배치 */
		padding-top: 3%;   /* 테두리와 내용 사이의 패딩 여백 */
		height: 564pt;
    }
#btn{ 
       margin-top: 7%;
    display: block;
    margin: auto;
    width: 61px;
    border: 1px solid gray;
    border-radius: 4pt;
    font-weight: bold;
    font-family: Bareun;
    background-color: gray;
    color: white;
    height: 31px;}

</style>

<script src="/js/jquery-1.12.3.min.js"></script>
<script src="/js/jquery-ui.min.js"></script>

</head>

<body>

	
<jsp:include page="../login/navigation.jsp" flush="true"/>
	<div class="container_t">
	   <h3 style="color:#2c3e50;margin-left: 1%;margin-bottom: 10%;">비밀번호 확인</h3>
	   <div style="background-color: #ededed;padding: 5%;width: 1000px;margin: auto;">
	       <form> 
	           <table style="margin: auto;width: 900px;margin-bottom: 1%;">
	               <tr>
				        <td style="padding-right: 17px;font-size: 15pt;font-weight: bold;text-align: right;width: 100px;">비밀번호 입력</td>
				        <td style="padding-right: 20px;width: 250px;"><input type="password" id="password" style="width: 100%;" ></td>
				        <td style="width: 30px;"><button type="button" onclick="check()" id="btn" style="display: block;margin: auto;float: left;">확인</button></td>
				    </tr>
				</table> 
	 
	           
	       </form>
	   </div>
    <br>
	
    </div>
<br><br>
</body>
<jsp:include page="../bottom.jsp" flush="true"/>

<script type="text/javascript">

function check(){
	var pw = document.getElementById("password").value;
	if(pw == ''){
		alert("비밀번호를 입력해주세요.")
	}
	else{
		$.ajax({   
	        type:"POST",
	        url:"/login/passwordCheck",   
	        dataType:"html",// JSON/html
	        async: false,
	        data:{ 
	            "password": document.getElementById("password").value
	        },
	    
	        success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수

	            if(data==1){                    
	            	location.href = '/login/myPageForm';
	            }
	            else{
	               alert("비밀번호가 틀렸습니다.");
	               document.getElementById("password").value = "";
	            }
	        }
	    }); //--ajax
	}
}


</script>
</html>