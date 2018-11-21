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

<title>아이템 구매</title>
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
input[type="text"]:enabled {
    background: white !important;
}

input[type="text"]:disabled {
    background: #dddddd !important;
}
</style>
<body>

    
<jsp:include page="../../login/navigation.jsp" flush="true"/>

<div class="container_t">
    <h3 style="color:#2c3e50;margin-left: 6%;">아이템 구매</h3><br><br><br><br>
        <form action="/ItemShop/ItemPurchase" method="post">
            <input type="hidden" value="${item.intItemNo}" id="itemNo" name="itemNo">
            <input type="hidden" value="${item.intItemPrice}" id="itemPrice" name="itemPrice">
            <input type="hidden" value="${item.intDeliveryPrice}" id="deliveryPrice" name="deliveryPrice">
            <table id="itemTable" >
                <colgroup>
                   <col width = "*%"/>
                   <col width = "20%"/>
                   <col width = "18%"/>
                   <col width = "18%"/>
                   <col width = "18%"/>             
                </colgroup>
                <thead>
                    <tr>
                        <th colspan="2" style="border-right:1px solid #88887e;border-bottom:1px solid #88887e;">아이템</th>
                        <th style="border-right:1px solid #88887e;border-bottom:1px solid #88887e;">소계</th>
                        <th style="border-right:1px solid #88887e;border-bottom:1px solid #88887e;">수량</th>
                        <th style="border-bottom:1px solid #88887e;">합계</th>
                    </tr>
                </thead>
                <tbody>
                    <tr style="height: 220px;">
                        <td style="border-bottom:1px solid #aeaea7;"><img class="img-fluid" src="${item.strfileUrl}" style=" width: 270px; height: 180px;"></td>
                        <td style="border-right:1px solid #aeaea7;">
                            <p id="pItemNoStyle">${item.intItemNo}</p>
                            <p id="pItemNameStyle">${item.strItemName}</p>
                        </td>
                        <td style="border-right:1px solid #aeaea7;border-bottom:1px solid #aeaea7;font-size: 14pt;">
                            <fmt:formatNumber value="${item.intItemPrice}" pattern="#,###" />&nbsp;코인</td>
                        <td style="border-right:1px solid #aeaea7;border-bottom:1px solid #aeaea7;">
                            <select id="itemCount" name="itemCount">
							  <option value="1" selected>1</option>
							  <option value="2">2</option>
							  <option value="3">3</option>
							  <option value="4">4</option>
							  <option value="5">5</option>
							</select>&nbsp;개
                        </td>
                        <td id="priceStyle"><input type="text" id="price" pattern="#,###" readonly>&nbsp;코인</td>
                    </tr>                   
                    <tr style="height: 80px;">
                        <td colspan="3" style="border-right:1px solid #aeaea7;border-bottom:1px solid #aeaea7;">
                            <p style="margin-bottom: 0;font-weight: bold;">배송료</p>
                            <p style="margin-bottom: 0;font-size: 11pt;color: gray;">(* 5만원 이상 구매시 배송료 무료)</p>
                        </td>
                        <td colspan="2" style="border-bottom:1px solid #aeaea7;">
                            <input type="text" id="deliverPrice" pattern="#,###" value="${item.intDeliveryPrice}" style="border: none;width: 15%;text-align: right;" readonly>&nbsp;코인</td>
                    </tr>
                    <tr style="height: 80px;">
                        <td colspan="3" style="border-right:1px solid #aeaea7;border-bottom:1px solid #aeaea7;font-weight: bold">총합계</td>
                        <td colspan="2" style="border-bottom: 1px solid #aeaea7;color: #b13862;font-weight: bold;">
                            <input type="text" id="totalPrice" pattern="#,###" readonly>&nbsp;코인</td>
                    </tr>
                </tbody>
                    
            </table>
            <br><br><br><br>
            <p style="width:90%; margin-bottom: 0px;font-size: 20px;font-weight: bold;margin: auto;">배송지 정보</p>
            <hr style="width:90%">
            <table id="deliverTable">
                <colgroup>
                   <col width = "15%"/>
                   <col width = "*"/>            
                </colgroup>
               
                <tr>
                   <td style="padding-left: 2%;border-right: 1px solid #aeaea7;border-bottom: 1px solid #aeaea7;font-size: 12pt;height: 50px;font-weight:bold;">배송지 선택</td>
                   <td style="padding-left: 1%;border-bottom: 1px solid #aeaea7;"> 
                        <label class="checkcontainer" style="margin-bottom: 0px;">직접입력 &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp;
						  <input type="radio" checked="checked" name="radio" id="writeInfo">
						  <span class="radiobtn"></span>
						</label>
						<label class="checkcontainer" style="margin-bottom: 0px;">회원정보와 동일
						  <input type="radio" name="radio" id="memberInfo">
						  <span class="radiobtn"></span>
						</label>
                   </td>
                </tr>
                <tr>
                   <td style="padding-left: 2%;border-right: 1px solid #aeaea7;border-bottom: 1px solid #aeaea7;font-size: 12pt;height: 50px;">받으실 분</td>
                   <td style="padding-left: 1%;border-bottom: 1px solid #aeaea7;">
                    <input id="strName" name="strName" type="text" style="padding-left: 2%;font-size: 13pt;width:70%;border-radius: 8px;background-color: white;border: 1px solid gray;height: 31px;"></td>
                </tr>
                <tr>
                    <td style="padding-left: 2%;border-right: 1px solid #aeaea7;border-bottom: 1px solid #aeaea7;font-size: 12pt;height: 50px;">전화번호</td>
                    <td style="padding-left: 1%;border-bottom: 1px solid #aeaea7;">
                        <input id="strTel" name="strTel" type="text" style="padding-left: 2%;width: 23%;border-radius: 8px;background-color: white;border: 1px solid gray;height: 31px;font-size: 14pt;" maxlength="17" onkeyup="autoHypenPhone(this)"></td>
                </tr>
                <tr>
                   <td rowspan="3" style="padding-left: 2%;height: 124px;border-right: 1px solid #aeaea7;border-bottom: 1px solid #aeaea7;font-size: 12pt;height: 50px;">주소</td>
                   <td style="padding-left: 1%;height: 40px;padding-top: 10px;">
                    <input type="text" value="우편번호" readonly="readonly" style="width: 13%;border: none;color: #5d5d5d;font-size: 12pt; ">
                    <input id="strPostcode" name="strPostcode" type="text" style="padding-left: 2%;font-size: 14pt;letter-spacing: 1pt;border-radius: 8px;width: 15%;background-color: white;border: 1px solid gray;height: 31px;" readonly="readonly">
                    <input type="button" style="border-radius: 8px;width: 11%;background-color: #2c3e50;border: 1px solid #2c3e50;color:white;height: 31px;" value="주소 검색" onclick="execDaumPostcode()"></td>
               </tr>
               <tr>
                   <td style="padding-left: 1%;height: 40px;">
                    <input type="text" value="도로명주소" readonly="readonly" style="width: 13%;border: none;color: #5d5d5d;font-size: 12pt;">
                    <input id="strAddress" name="strAddress" type="text" style="padding-left: 2%;font-size: 13pt;border-radius: 8px;width: 80%;background-color: white;border: 1px solid gray;height: 31px;" readonly="readonly"></td>
               </tr>
               <tr>
                   <td style="padding-left: 1%;border-bottom: 1px solid #aeaea7;height: 40px;padding-bottom: 10px;">
                   <input type="text" value="상세주소" readonly="readonly" style="width: 13%;border: none;color: #5d5d5d;font-size: 12pt;">
                   <input type="text"id="strAddress2" disabled="disabled" name="strAddress2" style="padding-left: 2%;font-size: 13pt;border-radius: 8px;width: 80%;background-color: white;border: 1px solid gray;height: 31px;"></td>
               </tr>
               <tr>
                   <td style="padding-left: 2%;border-right: 1px solid #aeaea7;border-bottom: 1px solid #aeaea7;font-size: 12pt;height: 50px;">배송시 요청사항</td>
                   <td style="padding-left: 1%;border-bottom: 1px solid #aeaea7;">
                    <input id="strDeliverMsg" name="strDeliverMsg" type="text" style="padding-left: 2%;font-size: 13pt;width:70%;border-radius: 8px;background-color: white;border: 1px solid gray;height: 31px;width: 93.5%;"></td>
               </tr>		                
            </table>
            <br><br><br><br>
            <div style="text-align: center;">
                <button id="shopBtn" type="submit">아이템 구매하기</button>
            </div>
            <br><br><br>
                 
        </form>
        <br><br><br><br>
</div>        
</body>
<jsp:include page="../../bottom.jsp" flush="true"/>
 <!-- 우편번호 -->
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">

//빈값 확인
$("#shopBtn").on("click",function(){
	var name = document.getElementById("strName");
	var phone = document.getElementById("strTel");
	var postcode = document.getElementById("strPostcode");
	var address2 = document.getElementById("strAddress2");
	
	if(name.value == ""){
		alert("이름을 입력하세요.");
		name.focus();
		return false;	
	}
	if(phone.value == ""){
        alert("전화번호를 입력하세요.");
        phone.focus();
        return false;   
    }
	else if(phone.value != ""){
		var number = phone.value;
		var str = number.replace(/\ - /g,'');
		var phoneNumberRegex = /^[0-9]{3}[0-9]{4}[0-9]{4}$/;       
        
        if(!phoneNumberRegex.test(str)) {
            alert("전화번호가 잘못된 형식입니다.");
            phone.value="";
            phone.focus();
            return false; 
        }
	}
	if(address2.value == ""){
        alert("주소를 입력하세요.");
        address2.focus();
        return false;   
    }
	if(postcode.value == ""){
        alert("우편번호를 입력하세요.");
        postcode.focus();
        return false;   
    }
	
	
	
});
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = ''; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                fullAddr = data.roadAddress;

            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                fullAddr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
            if(data.userSelectedType === 'R'){
                //법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('strPostcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('strAddress').value = fullAddr;
            $('#strAddress2').attr('disabled', false);

            // 커서를 상세주소 필드로 이동한다.
            document.getElementById('strAddress2').focus();
        }
    }).open();
};
function autoHypenPhone(str){
    str.value = hypen(str.value);
     
};

function hypen(str){
    str = str.replace(/[^0-9]/g, '');
      var tmp = '';
      if( str.length < 4){
        return str;
        
      }else if(str.length < 7){
        tmp = tmp + str.substr(0, 3);
        tmp  = tmp + ' - ';
        tmp = tmp + str.substr(3);
        return tmp;
      }else if(str.length < 11){
        tmp += str.substr(0, 3);
        tmp += ' - ';
        tmp += str.substr(3, 3);
        tmp += ' - ';
        tmp += str.substr(6);
         return tmp;
      }else{        
        tmp += str.substr(0, 3);
        tmp += ' - ';
        tmp += str.substr(3, 4);
        tmp += ' - ';
        tmp += str.substr(7);
          return tmp;
      }
        return str;
};
    $(document).ready(function(){
    	
    	  var price = $('#itemPrice').val() * 1; 
          var total = Number(price) + Number($('#deliveryPrice').val());
          document.getElementById("price").value = comma(price);
          document.getElementById("totalPrice").value = comma(total);
         // $('#price').val(price);
        //  $('#totalPrice').val(total);
         
        $('select[name=itemCount]').change(function() {
        	var price = $('#itemPrice').val() * $(this).val();  
        	if(price >= 50000 ){
        		var total = Number(price);
        		$('#deliverPrice').val(0);
        	}else{
        		var total = Number(price) + Number($('#deliveryPrice').val());
        		$('#deliverPrice').val(3000);
        	}
        	//var total = Number(price) + Number($('#deliveryPrice').val());
        	document.getElementById("price").value = comma(price);
            document.getElementById("totalPrice").value = comma(total);
          //  $('#price').val(price);
          //  $('#totalPrice').val(total);
            });
        
        $("input[id=memberInfo]").click(function(){
        	$.ajax({
        		type:"POST",
                url:"/ItemShop/MemberInfo",   
                dataType:"json",// JSON/html
                async: false,
                data:{ 
                },          
                success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수                     
                	var info = data.user;
                	
                   $('#strName').val(info.strUserName);
                   var tel = hypen(info.strUserPhone);
                   $('#strTel').val(tel);
                   if(info.strPostCode != null){
                	   $('#strPostcode').val(info.strPostCode);
                       $('#strAddress').val(info.strAdress);
                       $('#strAddress2').attr('disabled', false);
                       $('#strAddress2').val(info.strAdress2);
                   }

                }
        		
        		
        	});
        	
        	
        });
        
        $("input[id=writeInfo]").click(function(){
        	$('#strName').val("");
            $('#strTel').val("");
            $('#strPostcode').val("");
            $('#strAddress').val("");
            $('#strAddress2').val("");
            
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