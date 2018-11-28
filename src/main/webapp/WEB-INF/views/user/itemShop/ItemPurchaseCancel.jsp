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

<title>아이템 구매 취소</title>
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
    <h3 style="color:#2c3e50;margin-left: 6%;"></h3><br><br><br>
        <form action="/ItemShop/ItemPurchaseCancel" method="post">
            <input type="hidden" name="intNumber" value="${PurchaseNo}">
            <input type="hidden" name="intItemTotalPrice" value="${item.intItemTotalPrice}">
            <p style="text-align: center;font-size: 36pt;font-weight: bold;font-family: Bareun;color: #2c3e50;margin-bottom: 10%;">아이템 <span style="color: #d11d53;">구매를 취소</span> 하겠습니까?</p>
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
                        <td style="border-bottom:1px solid #aeaea7;"><img class="img-fluid" src="${itemInfo.strfileUrl}" style=" width: 270px; height: 180px;"></td>
                        <td style="border-right:1px solid #aeaea7;">
                            <p id="pItemNoStyle">${itemInfo.intItemNo}</p>
                            <p id="pItemNameStyle">${itemInfo.strItemName}</p>
                        </td>
                        <td style="border-right:1px solid #aeaea7;border-bottom:1px solid #aeaea7;font-size: 14pt;">
                            <fmt:formatNumber value="${item.intItemPrice}" pattern="#,###" />&nbsp;코인</td>
                        <td style="border-right:1px solid #aeaea7;border-bottom:1px solid #aeaea7;">${item.itemCount}&nbsp;개
                        </td>
                        <td id="priceStyle"><fmt:formatNumber value="${item.intMiddlePrice}" pattern="#,###" />&nbsp;코인</td>
                    </tr>                   
                    <tr style="height: 80px;">
                        <td colspan="3" style="border-right:1px solid #aeaea7;border-bottom:1px solid #aeaea7;">
                            <p style="margin-bottom: 0;font-weight: bold;">배송료</p>
                            <p style="margin-bottom: 0;font-size: 11pt;color: gray;">(* 5만 코인 이상 구매시 배송료 무료)</p>
                        </td>
                        <td colspan="2" style="border-bottom:1px solid #aeaea7;"><fmt:formatNumber value="${item.intDeliveryPrice}" pattern="#,###" />&nbsp;코인</td>
                    </tr>
                    <tr style="height: 80px;">
                        <td colspan="3" style="border-right:1px solid #aeaea7;border-bottom:1px solid #aeaea7;font-weight: bold">총합계</td>
                        <td colspan="2" style="border-bottom: 1px solid #aeaea7;color: #b13862;font-weight: bold;">
                            <fmt:formatNumber value="${item.intItemTotalPrice}" pattern="#,###" />&nbsp;코인</td>
                    </tr>
                </tbody>
                    
            </table>
            <br><br><br><br>
            <p style="width:90%; margin-bottom: 0px;font-size: 20px;font-weight: bold;margin: auto;">배송지 정보</p>
            <hr style="width:90%">
            <table id="deliverTable">
                <colgroup>
                   <col width = "18%"/>
                   <col width = "*"/>            
                </colgroup>
               
                <tr>
                   <td style="padding-left: 2%;border-right: 1px solid #aeaea7;border-bottom: 1px solid #aeaea7;font-size: 12pt;height: 50px;">구매번호</td>
                   <td style="padding-left: 2%;border-bottom: 1px solid #aeaea7;">${PurchaseNo}</td>
                </tr>                
                <tr>
                   <td style="padding-left: 2%;border-right: 1px solid #aeaea7;border-bottom: 1px solid #aeaea7;font-size: 12pt;height: 50px;">받으실 분</td>
                   <td style="padding-left: 2%;border-bottom: 1px solid #aeaea7;">${deliver.strName}</td>
                </tr>
                <tr>
                    <td style="padding-left: 2%;border-right: 1px solid #aeaea7;border-bottom: 1px solid #aeaea7;font-size: 12pt;height: 50px;">전화번호</td>
                    <td style="padding-left: 1%;border-bottom: 1px solid #aeaea7;"><input id="strTel" name="strTel" value="${deliver.strTel}" type="text" style="padding-left: 1%;width: 23%;border-radius: 8px;background-color: white;border: none;height: 31px;font-size: 12pt;" readonly="readonly" ></td>
                </tr>
                <tr>
                   <td style="padding-left: 2%;border-right: 1px solid #aeaea7;border-bottom: 1px solid #aeaea7;font-size: 12pt;height: 50px;">주소</td>
                   <td style="padding-left: 1.5%;height: 40px;border-bottom: 1px solid #aeaea7;">(${deliver.strPostcode})&nbsp;${deliver.strAddress}&nbsp;${deliver.strAddress2}</td>
               </tr>
               <tr>
                   <td style="padding-left: 2%;border-right: 1px solid #aeaea7;border-bottom: 1px solid #aeaea7;font-size: 12pt;height: 50px;">배송시 요청사항</td>
                   <td style="padding-left: 2%;border-bottom: 1px solid #aeaea7;">${deliver.strDeliverMsg}</td>
               </tr>                        
            </table>
            <br><br><br><br>
            <div style="text-align: center;">
                <button id="shopBtn" type="submit">취소하기</button>
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

    $(document).ready(function(){
        var tel = $('#strTel').val();
        tel = hypen(tel);
        $('#strTel').val(tel);
    
    });
    
   
   
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