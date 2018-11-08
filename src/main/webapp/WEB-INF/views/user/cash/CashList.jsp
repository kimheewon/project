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
    <h3 style="color:#2c3e50;margin-left: 6%;">캐시 내역</h3><br><br><br>
        <form action="/Cash/Purchase" method="post">
            <table style="margin-bottom: 1rem;width: 80%;margin: auto;border: 1px solid #3a5269">
                <colgroup>
                   <col width = "10%"/>
                   <col width = "*"/>
                   <col width = "10%"/>
                   <col width = "10%"/> 
                   <col width = "10%"/>
                   <col width = "10%"/>                           
                </colgroup>
                <thead>
                    <tr>
                        <th>일시</th>
                        <th>번호</th>
                        <th>내역</th>
                        <th>금액</th>
                        <th>상태</th>
                        <th>결제수단</th>
                    </tr>
                </thead>
                <tbody>
	                <tr>
	                   <td style="font-size: 23px;text-align: center;background-color: #3a5269; color: white;height: 65px;">충전 금액</td>
	                   <td style="font-size: 21px;color: #3a5269;font-weight: bold; padding-left: 3%;">
	                      <input type="text" id="money" name="money" pattern="#,###" readonly style="border: 0px;background-color: #f0efef;text-align: center;">&nbsp;원
	                      <small style="padding-left: 3%;font-weight: bold;color: #5e646b;">(&nbsp;보유캐시&nbsp;:&nbsp;&nbsp;&nbsp;<fmt:formatNumber value='<%= session.getAttribute("cash") %>' pattern="#,###" />&nbsp;원&nbsp;)</small></td>                
	                </tr>   
                </tbody>     
            </table>
            <br><br><br><br>
            <table style="margin-bottom: 1rem;width: 80%;margin: auto;">
               <colgroup>
                   <col width = "33%"/>
                   <col width = "33%"/>
                   <col width = "*"/>            
                </colgroup>
               <tr>
                   <th colspan="3" style="border-bottom: 1px solid #8f959c;font-size: 20px;padding-bottom: 1%;">충전금액 선택</th>
               </tr>
               <tr>
                   <td id="cashChoosStyle"><input type="radio" value="1000" name="cashChoose">&nbsp;&nbsp;1,000 원</td>
                   <td id="cashChoosStyle"><input type="radio" value="5000" name="cashChoose">&nbsp;&nbsp;5,000 원</td>
                   <td id="cashChoosStyle"><input type="radio" value="10000" name="cashChoose">&nbsp;&nbsp;1,0000 원</td>
               </tr>
               <tr>
                   <td id="cashChoosStyle"><input type="radio" value="50000" name="cashChoose">&nbsp;&nbsp;50,000 원</td>
                   <td id="cashChoosStyle"><input type="radio" value="100000" name="cashChoose">&nbsp;&nbsp;100,000 원</td>
                   <td id="cashChoosStyle"><input type="radio" value="직접입력" name="cashChoose" >&nbsp;&nbsp;직접입력&nbsp;&nbsp;
                        <input type="number" name="cashWrite" id="cashWrite" value=""style=" width: 40%;">&nbsp;&nbsp;원</td>
               </tr>
            </table>
            <br><br><br><br>
            <table style="margin-bottom: 1rem;width: 80%;margin: auto;">
               <colgroup>
                   <col width = "33%"/>
                   <col width = "33%"/>
                   <col width = "*"/>            
               </colgroup>
               <tr>
                   <th colspan="3" style="border-bottom: 1px solid #8f959c;font-size: 20px;padding-bottom: 1%;">간편결제</th>
               </tr>
               <tr>
                   <td id="cashChoosStyle"><input type="button" name="purchase" id="" value="네이버페이"></td>
                   <td id="cashChoosStyle"><input type="button" name="purchase"  value="creditcard" alt="신용카드"></td>
                   <td id="cashChoosStyle"><input type="button" name="purchase" value="mobile" alt="휴대폰"></td>
               </tr>
            </table>
            <br><br><br>
                 
        </form>
        <br><br><br><br>
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
                       //window.opener.location.reload();               

                       window.open(url,"hiddenframe", "결제", "width=500, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" ); 
                     //  window.opener.location.reload();    //부모창 reload
                      // window.close(); 
                   }
                   
    
               }); //--ajax
           }
       });
}); 

       
</script>
</html>