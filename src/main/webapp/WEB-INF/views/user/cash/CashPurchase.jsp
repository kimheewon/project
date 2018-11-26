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
        font-family: Bareun;
        padding-right: 15px;
        padding-left: 15px;
        margin-right: auto;
        margin-left: auto;
        width: 85%;
        margin: 0 auto;     /* 가로로 중앙에 배치 */
        padding-top: 3%;   /* 테두리와 내용 사이의 패딩 여백 */
    }
 #cashChoosStyle{  
        padding-top: 1%;
    font-size: 18px;
    padding-left: 2%;
        font-family: Bareun;
}
#credit{
    cursor: pointer;
    /* border: none; */
    /* width: 50%; */
    width: 15%;
    height: 50pt;
    font-weight: bold;
    background-color: #ececec;
    border: 2px solid lightgray;
    color: #343434;
    margin-right: 3%;
}
#credit:hover{
    cursor: pointer;
    /* border: none; */
    /* width: 50%; */
    width: 15%;
    height: 50pt;
    font-weight: bold;
    background-color: #767676;
    border: 2px solid lightgray;
    color: white;
    margin-right: 3%;
}
#mobile{
    cursor: pointer;
    /* border: none; */
    /* width: 50%; */
    width: 15%;
    height: 50pt;
    font-weight: bold;
    background-color: #ececec;
    border: 2px solid lightgray;
    color: #343434;
}
#mobile:hover{
    cursor: pointer;
    /* border: none; */
    /* width: 50%; */
    width: 15%;
    height: 50pt;
    font-weight: bold;
    background-color: #767676;
    border: 2px solid lightgray;
    color: white;
    
}
</style>
<body>

    
<jsp:include page="../../login/navigation.jsp" flush="true"/>

<div class="container_t">
    <h3 style="color:#2c3e50;margin-left: 6%;">캐시 충전</h3><br><br>
        <form action="/Cash/Purchase" method="post">
            <table style="margin-bottom: 1rem;width: 80%;margin: auto;border: 1px solid #3a5269">
                <colgroup>
	               <col width = "40%"/>
	               <col width = "*"/>             
	            </colgroup>
		        <tr>
		           <td style="font-size: 23px;text-align: center;background-color: #3a5269; color: white;height: 65px;">충전 금액</td>
		           <td style="font-size: 21px;color: #3a5269;font-weight: bold; padding-left: 3%;">
		              <input type="text" id="money" name="money" pattern="#,###" value="1,000" readonly style="border: 0px;background-color: #f0efef;text-align: center;">&nbsp;원
		              <small style="padding-left: 3%;font-weight: bold;color: #5e646b;">(&nbsp;보유캐시&nbsp;:&nbsp;&nbsp;&nbsp;<fmt:formatNumber value='<%= session.getAttribute("cash") %>' pattern="#,###" />&nbsp;코인&nbsp;)</small></td>                
		           </tr>        
            </table>
            <br><br>
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
	               <td id="cashChoosStyle"><input type="radio" value="1,000" name="cashChoose" checked="checked">&nbsp;&nbsp;1,000 원</td>
	               <td id="cashChoosStyle"><input type="radio" value="5,000" name="cashChoose">&nbsp;&nbsp;5,000 원</td>
	               <td id="cashChoosStyle"><input type="radio" value="10,000" name="cashChoose">&nbsp;&nbsp;1,0000 원</td>
	           </tr>
	           <tr>
                   <td id="cashChoosStyle"><input type="radio" value="50,000" name="cashChoose">&nbsp;&nbsp;50,000 원</td>
                   <td id="cashChoosStyle"><input type="radio" value="100,000" name="cashChoose">&nbsp;&nbsp;100,000 원</td>
                   <td id="cashChoosStyle"><input type="radio" value="직접입력" name="cashChoose" >&nbsp;&nbsp;직접입력&nbsp;&nbsp;
                        <input type="text" name="cashWrite" id="cashWrite" value="" onkeyup="inputNumberFormat(this)" style="width: 40%;text-align: right;">&nbsp;&nbsp;원</td>
               </tr>
	        </table>
	        <br><br>
            <table style="margin-bottom: 1rem;width: 80%;margin: auto;">
               
               <tr>
                   <th colspan="3" style="border-bottom: 1px solid #8f959c;font-size: 20px;padding-bottom: 1%;">간편결제</th>
               </tr>
               <tr>
                   <td id="cashChoosStyle"><input type="button" name="purchase" id="credit" value="creditcard" alt="신용카드" >
                   <input type="button" id="mobile" name="purchase" value="mobile" alt="휴대폰"></td>
               </tr>
            </table>
            <br><br><br>
            <div class="container_t" style="border: 1px solid #2c3e50; padding-top: 1%; font-family: Bareun;width: 80%;">
		        <ul>
		            <li> 캐시는 구매 후 <span style="color: #d11d53;">현금으로 환불이 되지 않습니다.</span></li>
		            <li> 결제 후 바로 캐시로 적립됩니다.</li>
		            <li> 적립된 캐시는 <span style="color: #d11d53;">내 정보 > 캐시 내역</span>에서 확인할 수 있습니다.</li>
		            <li> 문의전화 : 010-3337-5421 (오전 9시 ~ 오후 6시. 주말 및 공휴일 제외)</li>
		        </ul>
	        </div>
                 
        </form>
        <br><br>
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
		    document.getElementById("money").value = document.getElementById("cashWrite").value; 
		    
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
			   alert("충전할 금액을 입력해주세요.");
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

function inputNumberFormat(obj) {
    obj.value = comma(uncomma(obj.value));
}
 
//콤마
function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}
//콤마풀기
function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}
	   
</script>
</html>