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

    <title>상세보기 - 충전 내역</title>

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
@font-face{font-family:'Bareun'; src:url('/font/BareunDotumOTF1.otf')}
@font-face{font-family:'candy'; src:url('/font/THE_candybar.ttf')}
@font-face{font-family:'TmonTium'; src:url('/font/TmonTium.ttf')}

#editBtn{
    height: 25px;
    min-width: 40px;
    margin: 0 0 0 0;
    float: right;
    padding-top: 0.5%;
    padding-bottom: 1.5%;
    background-color: white;
    border: none;
}
#cancelBtn{
font-family: Bareun;margin-bottom: 0px;background-color: white;color:#2c3e50;padding-top: 0.7%;padding-bottom: 0.7%;
}
</style>
</head>

  <body class="nav-md">
     <div class="container body">
      <div class="main_container">
        <jsp:include page="../navigationAdmin.jsp" flush="true"/>

        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3 style="font-family: Bareun;color: #605183;font-weight: bold;font-size: 15pt;">${id}&nbsp;&nbsp;회원님의,</h3>
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
                    <h2 style="font-family: Bareun;font-weight: bold;">충전 내역 상세보기</h2>
                    <button class="btn btn-app" type="button" onclick="location.href='/Membership/MembershipRead?intUserNo=${userNo}'"
                                                                id="editBtn" data-placement="top" data-toggle="tooltip" data-original-title="상세보기" style="margin-right: 0.5%;">                                                       
                        <i class="fa fa-newspaper-o" style="color: #a55663;"></i>
                    </button>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content" style="font-size:15px">
                    <input type="hidden" value="${userNo}" id="userNoHidden">
                    <table id="datatable" class="table table-striped table-bordered" id="AdminList" style="font-family: Bareun;">
                    <colgroup>
                        <col width = "6%"/>
                        <col width = "*"/>
                        <col width = "12%"/>
                        <col width = "12%"/>
                        <col width = "13%"/> 
                        <col width = "17%"/>
                        <col width = "18%"/>
                        <col width = "9%"/>
                    </colgroup>
                      <thead>
                        <tr>
                          <th style="text-align: center; padding-left: 1.5%; color:#00003f" class="sorting_desc">#</th>
                          <th style="text-align: center; padding-left: 2%; color:#00003f">번&nbsp;&nbsp;호</th>                          
                          <th style="text-align: center; padding-left: 2%; color:#00003f">금&nbsp;&nbsp;액</th>
                          <th style="text-align: center; padding-left: 2%; color:#00003f">캐&nbsp;&nbsp;시</th>
                          <th style="text-align: center; padding-left: 2%; color:#00003f">결제&nbsp;수단</th>   
                          <th style="text-align: center; padding-left: 2%; color:#00003f">상&nbsp;&nbsp;태</th>
                          <th style="text-align: center; padding-left: 2%; color:#00003f">일&nbsp;&nbsp;시</th>
                          <th style="text-align: center; padding-left: 2%; color:#00003f">취&nbsp;&nbsp;소</th>
                        </tr>
                      </thead>
                      <tbody>
                      
                        <c:forEach var="cash" items="${cash}" varStatus="status">

                            <tr>
                                <td style="text-align: center; color:#3b5976;" class="sorting">${status.count}</td>   
                                <td style="text-align: center; color:#3b5976;">${cash.intCashNo}</td>
                                <td style="text-align: right;color: #3b5976;padding-right: 1%;">
                                    <c:if test="${cash.amount ne 0}"><fmt:formatNumber value="${cash.amount}" pattern="#,###" />&nbsp;원</c:if></td>
                                <td style="text-align: right;color: #3b5976;padding-right: 1%;"><fmt:formatNumber value="${cash.intCashAmt}" pattern="#,###" />&nbsp;코인</td>
                                <td style="text-align: center; color:#3b5976;">${cash.strPurchasekind}</td>
                                 <td style="text-align: center; color:#3b5976;">
                                    <c:choose>
                                       <c:when test="${cash.strReason ne '0'}">                                        
                                          <span style="line-height: 22px;cursor: pointer;color: brown;" data-toggle="tooltip" data-placement="bottom" data-original-title="${cash.strReason}" >${cash.strPurchaseState}(${cash.strAdminId})</span>  
                                       </c:when>
                                       <c:otherwise>
                                            <c:choose>
                                                <c:when test="${cash.strPurchaseState eq '결제 완료'}">
                                                    <span style="color: #0000ff;">${cash.strPurchaseState}</span>
                                                </c:when>
	                                            <c:otherwise>
	                                                <span style="font-style: italic;">${cash.strPurchaseState}</span>
	                                            </c:otherwise>
	                                        </c:choose>
                                       </c:otherwise>
                                    </c:choose>                                
                                </td>
                                <td style="text-align: center; color:#3b5976;">${cash.transaction_date}</td>
                                <td style="text-align: center; color:#3b5976;padding-top: 0.5%;padding-bottom: 0.5%;">
                                    <c:if test="${cash.strPurchaseState eq '결제 완료'}">
                                        <c:if test="${cash.intCashAmt eq cash.intRemainCashAmt}">
                                             <button id="cancelBtn" class="btn btn-primary" type="button" onclick="cancelBtn(${cash.intCashNo})" value="${cash.intCashNo}">취소</button>
                                        </c:if>
                                    </c:if>
                                </td>   
                            </tr>   
                        </c:forEach>
                      </tbody>
                    </table>
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

function cancelBtn(no){
    if((confirm("결제 취소 하시겠습니까?") == true)){
        //location.href="/AdminCash/CashAllCancel?cashNo="+no;
         $.ajax({   
             type:"POST",
             url:"/AdminCash/CashAllCancel",   
             dataType:"html",// JSON/html
             async: false,
             data:{ 
                 "cashNo": no
             },
         
             success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수                   
                  alert("취소가 완료 되었습니다.");
                  location.href="/AdminCash/AdminCashAllList"; 
             }
         }); //--ajax
     
    }                
    else{
        return;
    }
    
    
}

/*$("#cancelBtn").click(function() {
    var no =  $(this).val();
    var userNoHidden = $("#userNoHidden").val();
    if((confirm("결제 취소 하시겠습니까?") == true)){
       //location.href="/AdminCash/CashCancel?cashNo="+no;
       
        $.ajax({   
            type:"POST",
            url:"/AdminCash/CashCancel",   
            dataType:"html",// JSON/html
            async: false,
            data:{ 
                "cashNo": no
            },
        
            success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수                   
               
            	   alert("취소가 완료 되었습니다.");
            	   location.href="/AdminCash/AdminCashList?userNo="+userNoHidden; 
                
            }
        }); //--ajax
    
   }                
   else{
       return;
   }
   

});*/

 
</script>
  </body>
</html>