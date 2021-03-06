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
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<title>아이템 구매 리스트</title>
<script src="/js/jquery-1.12.3.min.js"></script>
<script src="/js/jquery-ui.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"/>

</head>

<style>    
   #cursor{
    cursor: pointer;
    }
    
[data-tooltip-text]:hover {
    position: relative;
}

[data-tooltip-text]:hover:after {
    background-color: #000000;
    background-color: rgba(0, 0, 0, 0.8);

    -webkit-box-shadow: 0px 0px 3px 1px rgba(50, 50, 50, 0.4);
    -moz-box-shadow: 0px 0px 3px 1px rgba(50, 50, 50, 0.4);
    box-shadow: 0px 0px 3px 1px rgba(50, 50, 50, 0.4);

    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
    border-radius: 5px;

    color: #FFFFFF;
    font-size: 12px;
    content: attr(data-tooltip-text);

  margin-bottom: 10px;
    top: 130%;
    left: 0;    
    padding: 7px 12px;
    position: absolute;
    width: auto;
    min-width: 100px;
    max-width: 300px;
    word-wrap: break-word;

    z-index: 9999;
}        
            /* Default */
    input[type=text],input[type=password]{font-family:"Malgun Gothic","맑은 고딕",Dotum,"돋움",Arial,sans-serif}
    *{margin:0;padding:0;font-family:"Malgun Gothic","맑은 고딕",Dotum,"돋움",Arial,sans-serif}
    body{font-size:12px;color:#555;background:transparent;-webkit-user-select:none;-moz-user-select:none;-webkit-text-size-adjust:none;-moz-text-size-adjust:none;-ms-text-size-adjust:none}
    ol,ul{list-style:none} 
    table{table-layout:fixed;width:100%;border-collapse:collapse;border-spacing:0}
    caption{overflow:hidden;width:0;height:0;font-size:0;line-height:0;text-indent:-999em}
    img,fieldset{border:0}
    legend{height:0;visibility:hidden}
    em,address{font-style:normal}
    img{border:0 none;vertical-align:middle}
    a{color:#555;text-decoration:none}
    input,select{margin:0;padding:0;vertical-align:middle}
    button{margin:0;padding:0;font-family:inherit;border:0 none;background:transparent;cursor:pointer}
    button::-moz-focus-inner{border:0;padding:0}
    header,footer,aside,nav,section,article{display:block}

    .clearfix{*zoom:1}
    .clearfix:after{content:"";display:block;clear:both;overflow:hidden}

    /* Search */
    .searchBox{border:none}
    .searchBox tbody th{font-size: 15px;font-weight: bold;text-align: center;vertical-align: top;border: none;background: #e6e6e6;vertical-align: middle;}
    .searchBox tbody td{padding:12px 10px 12px 25px;border:none;background-color:#efefef}
        
    .searchDate{overflow:hidden;margin-bottom:10px;*zoom:1}
    .searchDate:after{display:block;clear:both;content:''}
    .searchDate li{position:relative;float:left;margin:0 7px 0 0}
    .searchDate li .chkbox2{display:block;text-align:center}
    .searchDate li .chkbox2 input{position:absolute;z-index:-1}
    .searchDate li .chkbox2 label{display:block;width:72px;height:26px;font-size:14px;font-weight:bold;color:#fff;text-align:center;line-height:25px;text-decoration:none;cursor:pointer;background:#a5b0b6}
    .searchDate li .chkbox2.on label{background:#ec6a6a}
        
    .demi{display:inline-block;margin:0 1px;vertical-align:middle}
    .inpType{text-align: center;height:24px;line-height:24px;border:1px solid #dbdbdb}
    .btncalendar{display:inline-block;width:22px;height:22px;background:url(/img/small-calendar.png) center center no-repeat;text-indent:-999em}
</style>
<style>
@font-face{font-family:'Bareun'; src:url('/font/BareunDotumOTF1.otf')}
@font-face{font-family:'candy'; src:url('/font/THE_candybar.ttf')}
@font-face{font-family:'TmonTium'; src:url('/font/TmonTium.ttf')}
.container_t {    
        padding-right: 15px;
        padding-left: 15px;
        margin-right: auto;
        margin-left: auto;
        width: 80%;
        margin: 0 auto;     /* 가로로 중앙에 배치 */
        padding-top: 3%;   /* 테두리와 내용 사이의 패딩 여백 */
    }
 
 th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }
#cancelBtn{
    background-color: white;
    width: 34%;
    height: 21pt;
    font-size: 11pt;
    border-radius: 3pt;
    border: none;
    color: #2c3e50;
    font-family: Bareun;
    border: 1px solid #2c3e50;
}
#cancelBtn:hover{
    background: #f1f4f7;
    color: black;
    box-shadow: 0 2px #999;
    border: 2px solid #3a3e42;
    font-weight: bold;
}
#cancelBtn:active {
    background: #f1f4f7;
    color: black;
    box-shadow: 0 2px #666;
    border: 2px solid #3a3e42;
    font-weight: bold;
    transform: translateY(4px);
}
#shopBtn{
    background-color: #b13862;
    width: 40%;
    height: 21pt;
    font-size: 11pt;
    border-radius: 3pt;
    border: none;
    color: white;
    font-family: Bareun;
}
#shopBtn:hover{
    background: #772642;
    color: white;
    box-shadow: 0 2px #999;
    font-weight: bold;
    border: 2px solid #3d1322;
}
#shopBtn:active {
    background-color: #772642;
    color: white;
    box-shadow: 0 2px #666;
    transform: translateY(4px);
}
#search{
    background-color: #f3f3f3;
    margin-bottom: 3%;
    text-align: center;
    border: 1px solid lightgray;
    border-radius: 8pt;
}
#searchBtn{
   margin-right: 3%;
    /* text-align: left; */
    font-size: 13pt;
    font-weight: bold;
    /* font-family: Bareun; */
    background-color: #ec6a6a;
    border: 1px solid #efefef;
    border-radius: 3pt;
    width: 125px;
    color: white;
    }
#listBtn{
       /* margin-right: 3%; */
    /* text-align: left; */
    font-size: 12pt;
    font-weight: bold;
    /* font-family: Bareun; */
    background-color: white;
    border: 1px solid #f3f3f3;
    border-radius: 3pt;
    width: 65px;
    vertical-align: middle;
    height: 24px;
}
</style>
<body>

    
<jsp:include page="../../login/navigation.jsp" flush="true"/>

<div class="container_t" style="min-height: 800px;">
    <h3 style="color:#2c3e50;margin-left: 6%;">아이템 구매 내역</h3><br><br><br>
     <form action="/ItemShop/ItemPurchaseList">
        <!-- search -->
        <table class="searchBox">
            <caption>조회</caption>
            <colgroup>
                <col width="12%">
                <col width="*">
            </colgroup>
            <tbody>
                <tr>
                    <th>조회기간</th>
                    <td>
                        <ul class="searchDate">
                            <li>
                                <span class="chkbox2">
                                    <input type="radio" name="dateType" id="dateType1" onclick="setSearchDate('0d')"/>
                                    <label for="dateType1">당일</label>
                                </span>
                            </li>
                            <li>
                                <span class="chkbox2">
                                    <input type="radio" name="dateType" id="dateType2" onclick="setSearchDate('3d')"/>
                                    <label for="dateType2">3일</label>
                                </span>
                            </li>
                            <li>
                                <span class="chkbox2">
                                    <input type="radio" name="dateType" id="dateType3" onclick="setSearchDate('1w')"/>
                                    <label for="dateType3">1주</label>
                                </span>
                            </li>
                            <li>
                                <span class="chkbox2">
                                    <input type="radio" name="dateType" id="dateType4" onclick="setSearchDate('2w')"/>
                                    <label for="dateType4">2주</label>
                                </span>
                            </li>
                            <li>
                                <span class="chkbox2">
                                    <input type="radio" name="dateType" id="dateType5" onclick="setSearchDate('1m')"/>
                                    <label for="dateType5">1개월</label>
                                </span>
                            </li>
                            <li>
                                <span class="chkbox2">
                                    <input type="radio" name="dateType" id="dateType6" onclick="setSearchDate('3m')"/>
                                    <label for="dateType6">3개월</label>
                                </span>
                            </li>
                            <li>
                                <span class="chkbox2">
                                    <input type="radio" name="dateType" id="dateType7" onclick="setSearchDate('6m')"/>
                                    <label for="dateType7">6개월</label>
                                </span>
                            </li>
                            <li>
                                <span class="chkbox2">
                                    <input type="radio" name="dateType" id="dateType8" onclick="location.href='/ItemShop/ItemPurchaseList'"/>
                                    <label for="dateType8">전체</label>
                                </span>
                            </li>
                        </ul>
                        
                        <div class="clearfix">
                            <!-- 시작일 -->
                            <span class="dset">
                                <input type="text" readonly="readonly" class="datepicker inpType" name="searchStartDate" id="searchStartDate" value="${searchStartDate}">
                                <img src="/img/small-calendar.png" class="btncalendar dateclick">
                            </span>
                            <span class="demi">~</span>
                            <!-- 종료일 -->
                            <span class="dset">
                                <input type="text" readonly="readonly" class="datepicker inpType" name="searchEndDate" id="searchEndDate" value="${searchEndDate}" >
                                <img src="/img/small-calendar.png" class="btncalendar dateclick" style="margin-right: 3%;">
                            </span>
                             <button id="searchBtn" type="submit">조회하기</button>
                        </div>    
                    </td>
                </tr>

            <tbody>
        </table>

      </form>  
    <form action="/Cash/Purchase" method="post">
        <table style="margin-bottom: 1rem;width:100%;margin: auto;">
            <colgroup>
                <col width = "7%"/>
                <col width = "15%"/>
                <col width = "20*"/>
                <col width = "15%"/>
                <col width = "18%"/> 
                <col width = "*"/>                         
            </colgroup>
            <thead style="text-align: center;font-size: 20px;background-color: #f2f2e8;color: #2c3e50;font-family: TmonTium;">
                <tr>                        
                    <th style="padding-bottom: 1%;padding-top: 1%;">#</th>
                    <th style="padding-bottom: 1%;padding-top: 1%;">구매번호</th>
                    <th style="padding-bottom: 1%;padding-top: 1%;">아이템</th>
                    <th style="padding-bottom: 1%;padding-top: 1%;">캐&nbsp;&nbsp;시</th>
                    <th style="padding-bottom: 1%;padding-top: 1%;">거래일시</th>
                    <th style="padding-bottom: 1%;padding-top: 1%;"></th>
                </tr>
            </thead>
            <tbody style="text-align: center;font-size: 17px;font-family: Bareun;">
                <c:if test="${empty item}">
                   <tr>
                       <td colspan="6" style="color: #5a5a5a;font-size: 14pt;text-align: center;font-style: italic;">아이템 구매 내역이 없습니다.</td>
                   </tr>
                </c:if>                
                <c:forEach var="item" items="${item}" varStatus="status">   
		            <tr>   
		                <td style="padding-top: 1%;padding-bottom: 1%;">${item.intNum}</td>
		                <td style="padding-top: 1%;padding-bottom: 1%;">${item.intNumber}</td>
		                <td style="padding-top: 1%;padding-bottom: 1%;color: #3e0321;font-weight: bold;text-align: left;padding-left: 4%;">
		                  <c:choose>
		                      <c:when test="${item.strItemName eq '캐시 회수'}">
		                         <span id="cursor" data-tooltip-text="${item.strReason}">${item.strItemName}</span>
		                      </c:when>
		                      <c:otherwise>
		                          <c:choose>
		                              <c:when test="${item.intFlag ne 0}">
		                                  <a href="/ItemShop/ItemPurchaseResult?PurchaseNo=${item.intNumber}" style="color: #b13862;;font-weight: bold;">
                                            ${item.strItemName}</a>
		                              </c:when>
		                              <c:otherwise>
		                                  <span style="font-weight: normal;font-style: italic;text-decoration: line-through;">
		                                  ${item.strItemName}</span>
		                              </c:otherwise>
		                          </c:choose>
		                      </c:otherwise>
		                  </c:choose>
		                 
		                </td>
		                <td style="padding-top: 1%;padding-bottom: 1%;text-align: right;padding-right: 3%;"><fmt:formatNumber value="${item.intItemTotalPrice}" pattern="#,###" />&nbsp;코인</td>
                        <td style="padding-top: 1%;padding-bottom: 1%;"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${item.datePurchaseDate}" /></td>
		                <td style="padding-top: 1%;padding-bottom: 1%;font-weight: bold;">
		                  <c:if test="${item.strItemName ne '캐시 회수'}">
		                      <c:choose>
			                      <c:when test="${item.intFlag eq 1}">
			                          <span style="font-family: Bareun;color: rebeccapurple;font-weight: bold;">아이템 준비중  (  			                          
			                             <button id="cancelBtn" type="button" onclick="location.href='/ItemShop/ItemPurchaseCancelForm?PurchaseNo=${item.intNumber}'">구매 취소 </button> )
			                          </span>
			                      </c:when>
			                      <c:when test="${item.intFlag eq 2}">
                                       <button id="shopBtn" type="button" onclick="deliver(${item.intNumber})">배송 추적</button>
                                     
                                  </c:when>
			                      <c:otherwise>구매 취소</c:otherwise>
			                  </c:choose>
		                  </c:if>
		                </td>	
		            </tr>   
	            </c:forEach>
            </tbody>     
        </table>
        <br><br><br><br>
        
                 
    </form>
        <!-- page -->
    <form name="frm">
        <div class="container_t">
            <ul class="pagination justify-content-center">
                <c:if test="${pagination.curRange ne 1 }">
                    <li class="page-item"><a class="page-link" href="#" style="color:#2c3e50;" onClick="fn_paging(1)">[처음]</a></li>
                </c:if>
                <c:if test="${pagination.curPage ne 1}">
                    <li class="page-item"><a href="#" class="page-link" style="color:#2c3e50;" onClick="fn_paging('${pagination.prevPage }')">[이전]</a></li>
                </c:if>
                <c:forEach var="pageNum" begin="${pagination.startPage}" end="${pagination.endPage}">
                    <c:choose>
                        <c:when test="${pageNum eq  pagination.curPage}">
                            <li class="page-item"><span style="font-weight: bold;"><a href="#" class="page-link"  style="color:#2c3e50;" onClick="fn_paging('${pageNum }')">${pageNum }</a></span></li> 
                        </c:when>
                        <c:otherwise>
                            <li class="page-item"><a href="#" class="page-link" style="color:#2c3e50;" onClick="fn_paging('${pageNum }')">${pageNum }</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${pagination.curPage ne pagination.pageCnt and pagination.pageCnt > 0}">
                    <li class="page-item"><a href="#" class="page-link"  style="color:#2c3e50;"onClick="fn_paging('${pagination.nextPage }')">[다음]</a></li> 
                </c:if>
                <c:if test="${pagination.curRange ne pagination.rangeCnt and pagination.rangeCnt > 0}">
                    <li class="page-item"><a href="#" class="page-link" style="color:#2c3e50;" onClick="fn_paging('${pagination.pageCnt }')">[끝]</a></li>
                </c:if>
            </ul>
         </div>
    </form>        
        <br><br><br><br>
</div>        
</body>
<jsp:include page="../../bottom.jsp" flush="true"/>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- datepicker 한국어로 -->
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>
    
<script>                

//배송추적
function deliver(purchaseNo){
   
    $.ajax({   
        type:"POST",
        url:"/Product/listDeliveryTrack",   
        dataType:"html",// JSON/html
        async: false,
        data:{ 
            "purchaseNo": purchaseNo
        },
    
        success: function(invoice){//통신이 성공적으로 이루어 졌을때 받을 함수                   
              window.open(invoice,"hiddenframe", "배송조회", "width=400, height=500, toolbar=no, menubar=no, scrollbars=no, resizable=yes" ); 
        	// window.open(invoice,"hiddenframe", "배송조회", "width="+screen.availWidth-300+",height="+screen.availHeight-500+""); 
             
        }
    }); //--ajax
    
    
}

$("#searchBtn").click(function(){
	
    var start = document.getElementById("searchStartDate").value;
    var end = document.getElementById("searchEndDate").value;
	
    if(start == ""){
    	alert("시작일을 입력하세요.");
    	return false;
    }
    if(end == ""){
    	alert("종료일을 입력하세요.");
        return false;
    }
	
});
$(document).ready(function() {
	//datepicker 한국어로 사용하기 위한 언어설정
    $.datepicker.setDefaults($.datepicker.regional['ko']);     
        
    // Datepicker            
    $(".datepicker").datepicker({
        showButtonPanel: true,
        dateFormat: "yy-mm-dd",
        onClose : function ( selectedDate ) {
                
            var eleId = $(this).attr("id");
            var optionName = "";

            if(eleId.indexOf("StartDate") > 0) {
                eleId = eleId.replace("StartDate", "EndDate");
                optionName = "minDate";
            }
            else {
                    eleId = eleId.replace("EndDate", "StartDate");
                    optionName = "maxDate";
            }

            $("#"+eleId).datepicker( "option", optionName, selectedDate );        
            $(".searchDate").find(".chkbox2").removeClass("on"); 
            }
    }); 

    //시작일.
    $('#searchStartDate').datepicker("option","onClose", function( selectedDate ) {    
	    // 시작일 datepicker가 닫힐때
	    // 종료일의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
	    $("#searchEndDate").datepicker( "option", "minDate", selectedDate );
	    $(".searchDate").find(".chkbox2").removeClass("on");
    });
            

    //종료일.
 /*   $('#searchEndDate').datepicker("option","onClose", function( selectedDate ) {    
	    // 종료일 datepicker가 닫힐때
	    // 시작일의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
	    $("#searchStartDate").datepicker( "option", "maxDate", selectedDate );
	    $(".searchDate").find(".chkbox2").removeClass("on");
    });
    */

    $(".dateclick").dateclick();    // DateClick
    $(".searchDate").schDate();        // searchDate
            
});

        // Search Date
        jQuery.fn.schDate = function(){
            var $obj = $(this);
            var $chk = $obj.find("input[type=radio]");
            $chk.click(function(){                
                $('input:not(:checked)').parent(".chkbox2").removeClass("on");
                $('input:checked').parent(".chkbox2").addClass("on");                    
            });
        };

        // DateClick
        jQuery.fn.dateclick = function(){
            var $obj = $(this);
            $obj.click(function(){
                $(this).parent().find("input").focus();
            });
        }    

        
        function setSearchDate(start){

            var num = start.substring(0,1);
            var str = start.substring(1,2);

            var today = new Date();

            //var year = today.getFullYear();
            //var month = today.getMonth() + 1;
            //var day = today.getDate();
            
            var endDate = $.datepicker.formatDate('yy-mm-dd', today);
            $('#searchEndDate').val(endDate);
            
            if(str == 'd'){
                today.setDate(today.getDate() - num);
            }else if (str == 'w'){
                today.setDate(today.getDate() - (num*7));
            }else if (str == 'm'){
                today.setMonth(today.getMonth() - num);
                today.setDate(today.getDate() + 1);
            }

            var startDate = $.datepicker.formatDate('yy-mm-dd', today);
            $('#searchStartDate').val(startDate);
                    
            // 종료일은 시작일 이전 날짜 선택하지 못하도록 비활성화
            $("#searchEndDate").datepicker( "option", "minDate", startDate );
            
            // 시작일은 종료일 이후 날짜 선택하지 못하도록 비활성화
            $("#searchStartDate").datepicker( "option", "maxDate", endDate );

        }

            
</script>
        
        
<script type="text/javascript">
function fn_paging(curPage) {
    var f = document.frm;
    var start = document.getElementById("searchStartDate").value;
    var end =  document.getElementById("searchEndDate").value;
    f.method = "post"
    if(start == ""){
        f.action = "/ItemShop/ItemPurchaseList?curPage="+curPage;
    }
    else{
    	f.action = "/ItemShop/ItemPurchaseList?curPage="+curPage+"&&searchStartDate="+start+"&&searchEndDate="+end;
    }
    f.submit();    
}



</script>
</html>