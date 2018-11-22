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

    <title>권한 목록 리스트</title>

    
    <!-- Datatables -->
    <link href="/vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="/vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="/vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="/vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="/vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="/build/css/custom.min.css" rel="stylesheet">
<style type="text/css">
    #editBtn{
           height: 23px;
        min-width: 40px;
        margin: 0 0 0 0;
        padding-top: 0.6%;
        border: none;
        background-color: white;
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
                <h3></h3>
              </div>

              
            </div>

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel" >
                  <div class="x_title">
                    <h2 style="font-family: Bareun;font-weight: bold;">권한 목록</h2>           
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content" style="font-size:15px">
                    
                    <table id="datatable" class="table table-bordered" id="AdminList">
                       <colgroup>
			    		<col width = "7%"/>
			    		<col width = "*"/>
			    		<col width = "15%"/>		    		
			    	</colgroup>
                      <thead style="background-color: #e6e6e8;">
                        <tr>
                          <th style="text-align: center; padding-left: 1.5%; color:#00003f;border-right: 1px solid #a6a6a6;border-bottom: 2px solid #a6a6a6;" class="sorting_desc">#</th>
                          <th style="text-align: center; padding-left: 2%; color:#00003f;border-right: 1px solid #a6a6a6;border-bottom: 2px solid #a6a6a6;">권한 유형</th>
                          <th style="text-align: center; padding-left: 2%; color:#00003f;border-bottom: 2px solid #a6a6a6;">작    업</th>
                        </tr>
                      </thead>
                      <tbody>
                        <c:forEach var="authList" items="${authList}" varStatus="status">
							<tr>
								<td style="text-align: center; color:#3b5976;">${status.count}</td>							
								<td style="text-align: center; color:#3b5976;">${authList.strAuthName}</td>
								<td style="text-align: center; color:#3b5976;">
								    <button class="btn btn-app" type="button" onclick="location.href='/Auth/AuthUpdateForm?authNo=${authList.intAuthNo}'" 
                                          id="editBtn" data-placement="top" data-toggle="tooltip" data-original-title="수정">
                                            <i class="fa fa-wrench" style="color: #626200;"></i></button></td>
							</tr>	
						</c:forEach>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>

            </div>
 


        </div>
      </div>
              <!-- /page content -->
          


</div>
</div>

    <!-- jQuery -->
    
    <!-- iCheck -->
    <script src="/vendors/iCheck/icheck.min.js"></script>
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
<script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-23581568-13', 'auto');
ga('send', 'pageview');




</script>
  </body>
</html>