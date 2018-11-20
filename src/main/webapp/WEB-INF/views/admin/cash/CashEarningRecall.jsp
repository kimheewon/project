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

    <title>캐시 적립/회수</title>

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
                <h3 style="font-family: Bareun;color: #605183;font-weight: bold;"></h3>
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
                    <h2 style="font-family: Bareun;font-weight: bold;">캐시 보유 상태</h2>
                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content" style="font-size:15px">
                    
                    <table id="datatable" class="table table-striped table-bordered" id="AdminList" style="font-family: Bareun;">
                    <colgroup>
                        <col width = "6%"/>
                        <col width = "15%"/>                                           
                        <col width = "15%"/>
                        <col width = "15%"/>
                        <col width = "*"/>
                        <col width = "15%"/>
                        <col width = "15%"/>
                    </colgroup>
                      <thead>
                        <tr>
                          <th style="text-align: center; padding-left: 1.5%; color:#00003f" class="sorting_desc">#</th>                         
                          <th style="text-align: center; padding-left: 2%; color:#00003f">아&nbsp;이&nbsp;디</th>
                          <th style="text-align: center; padding-left: 2%; color:#00003f">총 적립 캐시</th>
                          <th style="text-align: center; padding-left: 2%; color:#00003f">총 사용 캐시</th>
                          <th style="text-align: center; padding-left: 2%; color:#00003f">보유&nbsp;&nbsp;캐시</th>
                          <th style="text-align: center; padding-left: 2%; color:#00003f">등&nbsp;&nbsp;급</th>
                          <th style="text-align: center; padding-left: 2%; color:#00003f">작&nbsp;&nbsp;업</th>
                        </tr>
                      </thead>
                      <tbody>
                      
                        <c:forEach var="member" items="${member}" varStatus="status">

                            <tr>
                                <td style="text-align: center; color:#3b5976;" class="sorting">${status.count}</td> 
                                <td style="text-align: center; color:#3b5976;">${member.strUserid}</td>        
                                <td style="text-align: right;color: #3b5976;padding-right: 4.5%;"><fmt:formatNumber value="${member.intTotalInCashAmt}" pattern="#,###" />&nbsp;코인</td>
                                <td style="text-align: right;color: #3b5976;padding-right: 4.5%;"><fmt:formatNumber value="${member.intTotalOutCashAmt}" pattern="#,###" />&nbsp;코인</td>
                                <td style="text-align: right;color: #3b5976;padding-right: 7%;"><fmt:formatNumber value="${member.intTotalCashAmt}" pattern="#,###" />&nbsp;코인</td>
                                <td style="text-align: center; color:#3b5976;">${member.strUserGrade}&nbsp;회원</td>
                                <td style="text-align: center; color:#3b5976;padding-top: 0.5%;padding-bottom: 0.5%;">
                                   <button class="btn btn-primary" style="font-family: Bareun;margin-bottom: 0px;background-color: white; color: #d11d53;border-color: #d11d53;padding-top: 0.7%;padding-bottom: 0.7%;" type="button"
                                    onclick="location.href='/AdminCash/AdminCashPaymentForm?userNo=${member.intUserNo}'">지급</button>&nbsp;|&nbsp;
                                   <button class="btn btn-primary" style="font-family: Bareun;margin-bottom: 0px;background-color: white;color:#2c3e50;padding-top: 0.7%;padding-bottom: 0.7%;" type="button"
                                    onclick="location.href='/AdminCash/AdminCashRecallForm?userNo=${member.intUserNo}'">회수</button>
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


 
</script>
  </body>
</html>