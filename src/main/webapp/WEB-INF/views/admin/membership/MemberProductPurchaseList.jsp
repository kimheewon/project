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

    <title>회원의 상품 구매 리스트</title>

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
        background-color: white;
        border: none;
    }
#shopBtn{
    background-color: white;
    width: 65%;
    height: 21pt;
    font-size: 11pt;
    border-radius: 3pt;
    border: none;
    color: #3d1322;
    font-family: Bareun;
    border: 2px solid #772642;
}
#shopBtn:hover{
    background: #772642;
    color: white;
    box-shadow: 0 2px #999;
    border: 2px solid #772642;
    font-weight: bold;
}
#shopBtn:active {
    background: #772642;
    color: white;
    box-shadow: 0 2px #999;
    border: 2px solid #772642;
    font-weight: bold;
    transform: translateY(4px);
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
                    <h2 style="font-family: Bareun;font-weight: bold;">아이템 구매 내역</h2>
                    <button class="btn btn-app" type="button" onclick="location.href='/Membership/MembershipRead?intUserNo=${userNo}'"
                         id="editBtn" data-placement="top" data-toggle="tooltip" data-original-title="상세보기" style="float: right;padding-top: 8px;">                                                       
                        <i class="fa fa-newspaper-o" style="color: #a55663;"></i>
                    </button>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content" style="font-size:15px">
                    
                    <table id="datatable" class="table table-striped table-bordered" id="AdminList">
                    <colgroup>
                        <col width = "6%"/>
                        <col width = "13%"/>	                
		                <col width = "*"/>
		                <col width = "14%"/>		                
		                <col width = "15%"/> 
		                <col width = "12%"/>                        
                    </colgroup>
                      <thead>
                        <tr>
                          <th style="text-align: center; padding-left: 1.5%; color:#00003f" class="sorting_desc">#</th>
                          <th style="text-align: center; padding-left: 2%; color:#00003f">구매&nbsp;번호</th>
                          <th style="text-align: center; padding-left: 2%; color:#00003f">아 이 템</th>
                          <th style="text-align: center; padding-left: 2%; color:#00003f">캐&nbsp;&nbsp;&nbsp;시</th>
                          
                          <th style="text-align: center; padding-left: 2%; color:#00003f">거래&nbsp;일시</th>
                          <th style="text-align: center; padding-left: 2%; color:#00003f"></th>
                        </tr>
                      </thead>
                      <tbody>
                        <c:forEach var="list" items="${product}" varStatus="status">

                            <tr>
                                <td style="text-align: center; color:#3b5976;vertical-align: middle;">${status.count}</td>
                                <td style="text-align: center; color:#3b5976;vertical-align: middle;">${list.intNumber}</td>
                                <td style="text-align: left;padding-left: 2%; color:#3b5976;vertical-align: middle;">
	                                <c:choose>
			                              <c:when test="${list.strItemName eq '캐시 회수'}">
			                                 <span data-toggle="tooltip" data-placement="bottom" data-original-title="${list.strReason}" style="cursor: pointer;">${list.strItemName}</span>
			                              </c:when>
			                              <c:otherwise>
			                                  <c:choose>
			                                      <c:when test="${list.intFlag ne 0}">
			                                          <a href="/Product/MemberPurchaseView?PurchaseNo=${list.intNumber}" style="color: #b13862;;font-weight: bold;">
			                                            ${list.strItemName}</a>
			                                      </c:when>
			                                      <c:otherwise>
			                                          <span style="font-weight: normal;font-style: italic;text-decoration: line-through;">${list.strItemName}</span>
			                                      </c:otherwise>
			                                  </c:choose>
			                              </c:otherwise>
			                          </c:choose>
                                </td>
                                <td style="text-align: right; padding-right:4%; color:#3b5976;vertical-align: middle;"><fmt:formatNumber value="${list.intItemTotalPrice}" pattern="#,###" />&nbsp;코인</td>
                                <td style="text-align: center; color:#3b5976;vertical-align: middle;"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${list.datePurchaseDate}"/></td>
                                <td style="text-align: center; color:#3b5976;vertical-align: middle;">
	                                <c:if test="${list.strItemName ne '캐시 회수'}">
		                              <c:choose>
		                                  <c:when test="${list.intFlag eq 1}">
		                                      <span style="font-family: Bareun;color: rebeccapurple;font-weight: bold;">상품 준비중</span>
		                                  </c:when>
		                                  <c:when test="${list.intFlag eq 2}">
                                              <button id="shopBtn" type="button" onclick="deliver(${list.intNumber})" style="margin-right: 0;">배송 추적</button>
                                          </c:when>
		                                  <c:otherwise>구매 취소</c:otherwise>
		                              </c:choose>
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

//배송추적
function deliver(purchaseNo){
    //var invoice = document.getElementById("invoiceNumber").value;
    //var code = document.getElementById("companyCode").value;
    
    $.ajax({   
        type:"POST",
        url:"/Product/listDeliveryTrack",   
        dataType:"html",// JSON/html
        async: false,
        data:{ 
            "purchaseNo": purchaseNo
        },
    
        success: function(invoice){//통신이 성공적으로 이루어 졌을때 받을 함수                   
              window.open(invoice,"hiddenframe", "배송조회", "width=500, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" ); 
              
        }
    }); //--ajax
    
    
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