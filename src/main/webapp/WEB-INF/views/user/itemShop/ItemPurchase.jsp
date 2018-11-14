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

</style>
<body>

    
<jsp:include page="../../login/navigation.jsp" flush="true"/>

<div class="container_t">
    <h3 style="color:#2c3e50;margin-left: 6%;">아이템 구매</h3><br><br><br><br>
        <form action="/Cash/Purchase" method="post">
            <input type="hidden" value="${item.intItemPrice}" id="itemPrice">
            <input type="hidden" value="${item.intDeliveryPrice}" id="deliveryPrice">
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
                        <td colspan="2" style="border-bottom:1px solid #aeaea7;"><fmt:formatNumber value="${item.intDeliveryPrice}" pattern="#,###" />&nbsp;코인</td>
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
                   <col width = "20%"/>
                   <col width = "*"/>            
                </colgroup>
               <tr>
                   <td>배송지 선택</td>
                   <td> 
                        <label class="checkcontainer">회원정보와 동일 &nbsp; &nbsp;&nbsp;
						  <input type="radio" checked="checked" name="radio">
						  <span class="radiobtn"></span>
						</label>
						<label class="checkcontainer">직접입력
						  <input type="radio" name="radio">
						  <span class="radiobtn"></span>
						</label>
                   </td>
               </tr>
               <tr>
                   <td id="cashChoosStyle"><input type="radio" value="1000" name="cashChoose">&nbsp;&nbsp;1,000 원</td>
                   <td id="cashChoosStyle"><input type="radio" value="5000" name="cashChoose">&nbsp;&nbsp;5,000 원</td>
                   <td id="cashChoosStyle"><input type="radio" value="10,000" name="cashChoose">&nbsp;&nbsp;1,0000 원</td>
               </tr>
               <tr>
                   <td id="cashChoosStyle"><input type="radio" value="50,000" name="cashChoose">&nbsp;&nbsp;50,000 원</td>
                   <td id="cashChoosStyle"><input type="radio" value="100,000" name="cashChoose">&nbsp;&nbsp;100,000 원</td>
                   <td id="cashChoosStyle"><input type="radio" value="직접입력" name="cashChoose" >&nbsp;&nbsp;직접입력&nbsp;&nbsp;
                        <input type="text" name="cashWrite" id="cashWrite" value="" onkeyup="inputNumberFormat(this)" style="width: 40%;text-align: right;">&nbsp;&nbsp;원</td>
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

    $(document).ready(function(){
    	  var price = $('#itemPrice').val() * 1; 
          var total = Number(price) + Number($('#deliveryPrice').val());
          document.getElementById("price").value = comma(price);
          document.getElementById("totalPrice").value = comma(total);
         // $('#price').val(price);
        //  $('#totalPrice').val(total);
         
        $('select[name=itemCount]').change(function() {
        	var price = $('#itemPrice').val() * $(this).val();  
        	var total = Number(price) + Number($('#deliveryPrice').val());
        	document.getElementById("price").value = comma(price);
            document.getElementById("totalPrice").value = comma(total);
          //  $('#price').val(price);
          //  $('#totalPrice').val(total);
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