<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%  // 인증된 세션이 없는경우, 해당페이지를 볼 수 없게 함.
    if (session.getAttribute("AdminId")  == null) {
        response.sendRedirect("/loginAdmin/logout");
    }
%>
<!DOCTYPE html>
<html lang="UTF-8">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>상품 구매 상세보기 </title>

     <!-- Bootstrap -->
    <link href="/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- Datatables -->
    <link href="/vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="/vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="/vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="/vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="/vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="/build/css/custom.min.css" rel="stylesheet">

<style>
    #editBtn{
        height: 35px;
        min-width: 40px;
        margin: 0 0 0 0;
        padding-top: 0.6%;
    }
#shopBtn{
    background-color: #2c3e50;
    width: 39%;
    height: 26pt;
    font-size: 12pt;
    border-radius: 3pt;
    border: none;
    color: white;
    font-family: Bareun;
    font-weight: bold;
    border: 1px solid #2c3e50;
}

#shopBtn:hover{
    background: #f1f4f7;
    color: black;
    box-shadow: 0 2px #999;
    border: 2px solid #3a3e42;
    font-weight: bold;
}
#shopBtn:active {
    background: #f1f4f7;
    color: black;
    box-shadow: 0 2px #666;
    border: 2px solid #3a3e42;
    font-weight: bold;
    transform: translateY(4px);
}

#itemTable thead tr th{
    background-color: #f2f2f2 !important;
}
input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
#deliverBtn{
   background-color: white;
    width: 70px;
    height: 21pt;
    font-size: 11pt;
    border-radius: 3pt;
    border: none;
    color: #2c3e50;
    font-family: Bareun;
    border: 2px solid #56799c;
    margin-left: 1.5%;
}
#deliverBtn:hover{
    background: #f1f4f7;
    color: black;
    box-shadow: 0 2px #999;
    border: 2px solid #3a3e42;
    font-weight: bold;
}
#deliverBtn:active {
    background: #f1f4f7;
    color: black;
    box-shadow: 0 2px #666;
    border: 2px solid #3a3e42;
    font-weight: bold;
    transform: translateY(4px);
}
</style>
  </head>
<link type="text/css" rel="stylesheet" href="/css/itemPurchaseStyle.css" />
  <body class="nav-md">
     <div class="container body">
      <div class="main_container">
        <jsp:include page="../navigationAdmin.jsp" flush="true"/>

        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3></h3>
              </div>

              <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    
                  </div>
                </div>
              </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                      <h2 style="font-family: Bareun;font-weight: bold;">아이템 구매 내역 상세보기</h2>
                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content" style="font-size:15px">
                    <br>
                   <p style="width:90%; margin-bottom: 0px;font-size: 20px;font-weight: bold;margin: auto;">구매 아이템 정보</p>
                    <hr style="width:90%">
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
                        <th colspan="2" style="border-right:1px solid #88887e;border-bottom:2px solid #88887e;text-align: center;">아이템</th>
                        <th style="border-right:1px solid #88887e;border-bottom:2px solid #88887e;text-align: center;">소계</th>
                        <th style="border-right:1px solid #88887e;border-bottom:2px solid #88887e;text-align: center;">수량</th>
                        <th style="border-bottom:2px solid #88887e;text-align: center;">합계</th>
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
            <input type="hidden" value="${PurchaseNo}" id="purchaseNo">
            <input type="hidden" value="${deliver.intCompanyCode}" id="companyCode">
            <input type="hidden" value="${deliver.intInvoiceNumber}" id="invoiceNumber">
            <table id="deliverTable">
                <colgroup>
                   <col width = "17%"/>
                   <col width = "*"/>            
                </colgroup>
               
                <tr>
                   <td style="padding-left: 2%;border-right: 1px solid #aeaea7;border-bottom: 1px solid #aeaea7;font-size: 12pt;height: 50px;">구매번호</td>
                   <td style="padding-left: 2%;border-bottom: 1px solid #aeaea7;">${PurchaseNo}</td>
                </tr>
                <tr>
                   <td style="padding-left: 2%;border-right: 1px solid #aeaea7;border-bottom: 1px solid #aeaea7;font-size: 12pt;height: 50px;">운송장번호</td>
                   <td style="padding-left: 2%;border-bottom: 1px solid #aeaea7;vertical-align: middle;">
                        <c:choose>
                            <c:when test="${empty deliver.intInvoiceNumber}">
                                <select id="companyChoice" style="height: 30px;margin-right: 1%;border-radius: 4pt;width: 150px;border: 1px solid;">
                                    <option value="0">===택배회사===</option>
                                    <c:forEach var="company" items="${company}">
                                         <option value="${company.intCompanyCode}">${company.strCompanyName}</option>
                                    </c:forEach>
                               </select> 
                                <input type="number" id="invoice" placeholder="송장번호를 입력하세요" style="width: 421px;height: 30px;padding-left: 2%;margin-right: 1%;border-radius: 4pt;border: 1px solid;">
                                <button onclick="inputInvoice()" data-placement="bottom" data-toggle="tooltip" data-original-title="입력" style="width: 53px;height: 31px;margin-bottom: 0;border: 2px solid #8e688e;padding-bottom: 0;border-radius: 4pt;background-color: #fff6ff;">
                                    <img class="btn-img" src="/img/delivery-truck.png" style="width: 40px;height: 25px;"></button>
                            </c:when>
                            <c:otherwise>
                                ( ${deliver.strCompanyName} )  ${deliver.intInvoiceNumber}
                                <input type="button" id="deliverBtn" value="배송추적" onclick="deliver()">
                            </c:otherwise>
                        </c:choose>
                   
                   </td>
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
            <br><br><br><br><br><br>
            <div style="text-align: center;">
                <button id="shopBtn" type="button" onclick="location.href='/Product/PurchaseList'">아이템 구매 리스트</button>
            </div>
            <br><br><br>

        <br><br><br><br>
                  </div>
                </div>
              </div>

            </div>
 
        <!-- /page content -->

        </div>
      </div>
</div>
</div>

    
    
    <!-- Datatables -->
    <script src="/vendors/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="/vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <script src="/vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
    <script src="/vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
    <script src="/vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
    <script src="/vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
    <script src="/vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
    <script src="/vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
    <script src="/vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
    <script src="/vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
    <script src="/vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
    <script src="/vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
    <script src="/vendors/jszip/dist/jszip.min.js"></script>
    <script src="/vendors/pdfmake/build/pdfmake.min.js"></script>
    <script src="/vendors/pdfmake/build/vfs_fonts.js"></script>

    <!-- Custom Theme Scripts -->
    <script src="/build/js/custom.min.js"></script>
    
<jsp:include page="../bottomAdmin.jsp" flush="true"/>
<!-- Google Analytics -->
<script type="text/javascript">
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-23581568-13', 'auto');
ga('send', 'pageview');

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

//배송추적
function deliver(){
	var invoice = document.getElementById("invoiceNumber").value;
	var code = document.getElementById("companyCode").value;
	
	$.ajax({   
        type:"POST",
        url:"/Product/deliveryTrack",   
        dataType:"html",// JSON/html
        async: false,
        data:{ 
            "code": code
        },
    
        success: function(url){//통신이 성공적으로 이루어 졌을때 받을 함수                   
        	  window.open(url+invoice,"hiddenframe", "배송조회", "width=500, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" ); 
              
        }
    }); //--ajax
	
	
}
//송장입력
function inputInvoice(){
	var invoice = document.getElementById("invoice").value;
	var code = $("#companyChoice option:selected").val();
	var purchaseNo = document.getElementById("purchaseNo").value;
	
	if(invoice == ''){
		alert("송장번호를 입력해주세요.");
		document.getElementById("invoice").focus();
		return false;
	}
	else if(code == 0){
		alert("택배회사를 선택해주세요.");
		return false;
	}
	else{
		$.ajax({   
	        type:"POST",
	        url:"/Product/deliveryCompany",   
	        dataType:"html",// JSON/html
	        async: false,
	        data:{ 
	            "invoice": invoice,
	            "code": code,
	            "purchaseNo": purchaseNo
	        },
	    
	        success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수                   
	          location.href=""
	        }
	    }); //--ajax
		
	}
	
	
	
}
    function checkFunction(no){
         $.ajax({   
                type:"POST",
                url:"/Administrator/checkItemCount",   
                dataType:"html",// JSON/html
                async: false,
                data:{ 
                    "no": no
                },
            
                success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수                   
                    if(data==1){                    //마스터
                        location.href="/Administrator/UpdateFrom?intAdminNo="+no;                       
                    }
                    else{                           //그 이외
                        alert("수정할 권한이 없습니다."); 
                    }
                }
            }); //--ajax
        
    }

  //상품 삭제 확인
    function checkDelete(itemNo){
        if((confirm("정말 삭제하시겠습니까?") == true)){
            location.href="/Product/ProductDelete?itemNo="+itemNo;
        }
        else{
            return;
        }
    };
 
</script>
  </body>
</html>