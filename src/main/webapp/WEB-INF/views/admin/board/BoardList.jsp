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

<title>게시판 목록 리스트</title>

    
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
        float: right;
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
                            <h3 style="color: #605183;font-weight: bold;"></h3>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel" >
                                <div class="x_title">
                                    <h2 style="color: #605183;font-weight: bold;">${boardName}</h2>                                        
                                        <a id="editBtn" href="/BoardCategory/BoardCategoryList" class="btn btn-app">
                                            <i class="fa fa-list-ul" style="color: #7e498b;"></i>                                            
                                        </a>                             
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content" style="font-size:15px">
                                    <table id="datatable" class="table table-striped table-bordered" id="AdminList">
                                        <colgroup>
                                            <col width = "7%"/>
                                            <col width = "*"/>
                                            <col width = "15%"/>
                                            <col width = "15%"/>
                                            <col width = "15%"/>                    
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th style="text-align: center; padding-left: 1.5%; color:#00003f" class="sorting_desc">#</th>
                                                <th style="text-align: center; padding-left: 2%; color:#00003f">제&nbsp;&nbsp;&nbsp;&nbsp;목</th>
                                                <th style="text-align: center; padding-left: 2%; color:#00003f">작성자</th>
                                                <th style="text-align: center; padding-left: 2%; color:#00003f">작성&nbsp;일시</th>
                                                <th style="text-align: center; padding-left: 2%; color:#00003f">조회수</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="board" items="${board}" varStatus="status">
                                                <tr>
                                                    <td style="text-align: center; color:#3b5976;">${status.count}</td>
                                                    <c:choose>
									                    <c:when test="${board.inttotalComment eq 0}">
									                    <td style="padding-left: 2%; color:#3b5976;">
									                        <a href="/AdminBoard/AdminBoardRead?boardCateNo=${boardCateNo}&&BoardNo=${board.intBoardNo}">${board.strBoardTitle}</a>
										                    <c:choose>
										                       <c:when test="${board.intNewCheck eq 1}">
										                           <img src="/img/new.png" alt="..." style="height: 20px;width: 20px;margin-left: 1%;margin-top: 0%;padding: 0% 0% 0% 0%;border: none;"class="img-circle profile_img">
										                       </c:when>
										                    </c:choose>
									                    </td>
										                </c:when>
										                <c:otherwise>
										                    <td style="padding-left: 2%; color:#3b5976;">
                                                                <a href="/AdminBoard/AdminBoardRead?boardCateNo=${boardCateNo}&&BoardNo=${board.intBoardNo}">${board.strBoardTitle}</a>&nbsp;&nbsp;[${board.inttotalComment}]
		                                                        <c:choose>
		                                                            <c:when test="${board.intNewCheck eq 1}">
											                           <img src="/img/new.png" alt="..." style="height: 20px;width: 20px;margin-left: 1%;margin-top: 0%;padding: 0% 0% 0% 0%;border: none;">
											                        </c:when>
											                    </c:choose>
										                    </td>
										                </c:otherwise>
									                </c:choose>
									                <c:choose>
									                    <c:when test="${board.strGrade eq '일반'}">
									                        <td style="text-align: center; color:#3b5976;">${board.strUserId}</td>
									                    </c:when>
									                    <c:when test="${board.strGrade eq 'VIP'}">									                    
									                        <td style="text-align:center;color:#18bc9c;padding-bottom:0.4%;padding-top:0.4%;">${board.strUserId}
									                        <img src="/img/crown.png" alt="..." style="height: 25px;margin-left:2%;margin-top: 0%;width: 25px;padding: 0% 0% 0% 0%;"class="img-circle profile_img"></td>
									                    </c:when>
									                    <c:otherwise>
                                                            <td style="text-align: center; color:#800000;">${board.strUserId}(${board.strAdminId})</td>
									                    </c:otherwise>
									                </c:choose>                                                                         
                                                    <td style="text-align: center; color:#3b5976;">${board.strBoardDate}</td>
                                                    <td style="text-align: center; color:#3b5976;">${board.intHit}</td>
                                                    
                                                </tr>   
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <a id="editBtn" href="/AdminBoard/AdminBoardEnrollForm?boardCateNo=${boardCateNo}" class="btn btn-app">
                                            <i class="fa fa-edit" style="color: #7e498b;"></i>                                            
                                </a>
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