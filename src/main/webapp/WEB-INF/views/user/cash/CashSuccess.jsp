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
<style>
@font-face{font-family:'Bareun'; src:url('/font/BareunDotumOTF1.otf')}
@font-face{font-family:'candy'; src:url('/font/THE_candybar.ttf')}
@font-face{font-family:'TmonTium'; src:url('/font/TmonTium.ttf')}
.container_t {
    
        padding-right: 15px;
        padding-left: 15px;
        margin-right: auto;
        margin-left: auto;
        width: 70%;
        margin: 0 auto;     /* 가로로 중앙에 배치 */
        padding-top: 3%;   /* 테두리와 내용 사이의 패딩 여백 */
    }
  #cashChoosStyle{  
        padding-top: 1%;
    font-size: 18px;
    padding-left: 2%;
}
</style>
<body>

    
<jsp:include page="../../login/navigation.jsp" flush="true"/>

<div class="container_t">
    <h3 style="color:#2c3e50;margin-left: 6%;">캐시 구매(결제 완료)</h3><br><br><br>
        <p style="text-align: center;"><img style="width: 10%;" src="/img/piggy-bank.png"></p>
        <br><p style="text-align: center;font-size: 30px; font-weight: bold; color: #2c3e50; font-family: TmonTium;"><span style="color:#d11d53">충전</span>이 <span style="color:#d11d53">완료 </span>되었습니다.</p>
        <br><br>
        <form action="/Cash/Purchase" method="post">
            <table style="margin-bottom: 1rem;width: 60%;margin: auto;border: 1px solid #3a5269">
                <colgroup>
                   <col width = "40%"/>
                   <col width = "*"/>             
                </colgroup>
                <tr>
                   <td style="font-size: 21px;text-align: center;background-color: #3a5269; color: white;height: 55px;font-family: Bareun;">아이디</td>
                   <td style="font-size: 21px;color: #282a2d; padding-left: 3%;">${id}</td>             
                </tr> 
                <tr>
                   <td style="font-size: 21px;text-align: center;background-color: #3a5269; color: white;height: 55px;font-family: Bareun;border-top: 1px solid #e0e0e0;border-bottom: 1px solid #e0e0e0;">충전한 금액</td>
                   <td style="font-size: 21px;color: #d11d53;font-weight: bold; padding-left: 3%;border-top: 1px solid #888888;border-bottom: 1px solid #888888;"><fmt:formatNumber value="${result.intAmount}" pattern="#,###" />&nbsp;원</td>    
                </tr>
                <tr>
                   <td style="font-size: 21px;text-align: center;background-color: #3a5269; color: white;height: 55px;font-family: Bareun;">현재 보유 캐시</td>
                   <td style="font-size: 21px;color: #282a2d; padding-left: 3%;">
                    <fmt:formatNumber value="${result.intTotalCashAmt}" pattern="#,###" />&nbsp;코인</td>
              
                </tr>            
            </table>
            <br><br><br><br>         
          
        </form>
        <div class="container_t" style="border: 1px solid #d11d53;padding-top: 1%;font-family: Bareun;">
        <ul>
            <li> 캐시는 구매 후 <span style="color: #d11d53;">현금으로 환불이 되지 않습니다.</span></li>
            <li> 결제 후 바로 캐시로 적립됩니다.</li>
            <li> 적립된 캐시는 <span style="color: #d11d53;">내 정보 > 캐시 내역</span>에서 확인할 수 있습니다.</li>
        </ul>
        </div>
        <br><br><br>  
        
</div>        
</body>
<jsp:include page="../../bottom.jsp" flush="true"/>
<script type="text/javascript">
$(document).ready(function() { // 해당 페이지 Loading 후, 
    $("input[name=cashWrite]").attr("disabled",true); 

    $("input[name=cashChoose]").click(function(){ // 라디오버튼 클릭 이벤트 
        if($("input[name=cashChoose]:checked").val() == "직접입력"){ 
            $("input[name=cashWrite]").attr("disabled",false); 
            document.getElementById("money").value = "";
            
        } else { 
            $("input[name=cashWrite]").attr("value",""); 
            // 만약에 기존 textbox에 데이터가 입력된 상태에서 테스트1에 갔다가 다시 돌아왔을때를 위해 초기화 
            $("input[name=cashWrite]").attr("disabled",true); 
            // 테스트1 라디오를 클릭하면 비활성화 
            document.getElementById("money").value = $("input[name=cashChoose]:radio:checked").val();
        } 
    });
    
       $("#cashWrite").change(function(){ // 라디오버튼 클릭 이벤트 
            document.getElementById("money").value = document.getElementById("cashWrite").value;  
            
        });
        
       $("input[name=purchase]").on("click",function(){
           if($("#money").val() == ""){
               alert("충전할 금액을 선택하세요.");
               return;
           }
           else{
               $.ajax({   
                   type:"POST",
                   url:"/Cash/Purchase",   
                   dataType:"json",// JSON/html
                   async: false,
                   data:{ 
                       "money": $("#money").val(),
                       "pgcode":$(this).val()
                   },          
                   success: function(responseData){//통신이 성공적으로 이루어 졌을때 받을 함수                     
                       var url = responseData.onlineUrl;                   
                       window.open(url, "결제", "width=500, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" ); 
                   }
                   
    
               }); //--ajax
           }
       });
}); 

       
</script>
</html>