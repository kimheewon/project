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

    <title>회원 목록 리스트</title>

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
    
.sorting{
    vertical-align: middle !important;
    text-align: center !important;
    color: #3b5976 !important;
    font-size: 14.5pt !important;
    font-weight: bold !important;
    height: 35px !important;
   } 

#btnStyle{
    background-color: white;
    color: #2c3e50;
    font-family: Bareun;
    border: 1px solid #2c3e50;
}

#btnStyle:hover{
    background-color: #2c3e50;
    color: white;
    box-shadow: 0 2px #999;
}
#btnStyle:active {
    background-color: #2c3e50;
    color: white;
    box-shadow: 0 2px #666;
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
                <h3 style="font-family: Bareun;color: #605183;font-weight: bold;">${id}&nbsp;&nbsp;회원님의,</h3>
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
                    <h2 style="font-family: Bareun;font-weight: bold;">캐시 지급</h2>
                    <button class="btn btn-app" type="button" onclick="location.href='/Membership/MembershipRead?intUserNo=${userNo}'"
                                                                id="editBtn" data-placement="top" data-toggle="tooltip" data-original-title="상세보기" style="margin-right: 0.5%;">                                                       
                        <i class="fa fa-newspaper-o" style="color: #a55663;"></i>
                    </button>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content" style="font-size:18px;margin-top: 6%; margin-bottom: 6%;"> 
                    <p style="text-align: center;"><img style="width: 13%;" src="/img/piggy-bank2.png"></p>                   
                    <br><br><br>
                    <form action="/AdminCash/AdminCashPayment" method="POST" name="info">
                        <input type="hidden" value="${userNo}" id="intUserNo" name="intUserNo">
                        <input type="hidden" value="${id}" id="strUserId" name="strUserId">                         
	                    <table id="datatable" class="table table-bordered" id="AdminList" style="font-family: Bareun; width: 55%;margin-left: auto;margin-right: auto;">
		                    <colgroup>
		                        <col width = "25%"/>
		                        <col width = "*"/>                        
		                    </colgroup>
		                    <tbody>
		                        <tr>
		                            <td style="text-align: center; color:#3b5976;" class="sorting">보유 캐시액 *</td>         
		                            <td style="padding-left: 3%; font-size: 15pt; color:#3b5976;vertical-align: middle;"><fmt:formatNumber value="${cash}" pattern="#,###" />&nbsp;&nbsp;코인</td>
		                        </tr>
		                        <tr>
	                                <td style="text-align: center; color:#3b5976;" class="sorting">지급 캐시액 *</td>         
	                                <td style="font-size: 15pt;color:#3b5976;vertical-align: middle;">
									    <p style="padding-left: 3%;margin-bottom: 0px;">
									        <input id="intAmount" required="required" class="form-control col-md-7 col-xs-12" style="background-color: white;width:50%;text-align: right;
									            font-size: 20px; color: #d11d53;" type="text" onkeyup="inputNumberFormat(this)"  name="strCash" id="strCash" >&nbsp;&nbsp;코인</p></td>
	                            </tr>
	                            <tr>
	                                <td style="text-align: center; color:#3b5976;" class="sorting">사&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;유 *</td>         
	                                <td style="text-align: center; vertical-align:middle;color:#3b5976;">
		                                <p style="padding-left: 3%;padding-right: 3%;margin-bottom: 0px;">
		                                    <input id="strMemo"  required="required" class="form-control col-md-7 col-xs-12" style="background-color: white;font-size: 18px;" type="text" name="strMemo" maxlength="44" placeholder="최대 44자까지 작성 가능합니다."> 
		                                </p>
	                                </td>
	                            </tr>
		                    </tbody>
	                    </table>
                        <br><br><br>
	                    <p style="text-align: center">
	                        <button class="btn btn-primary" style="font-family: Bareun;" type="submit" id="btnStyle" >지급하기</button>
	                    </p>
                    </form>
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
  </body>
</html>