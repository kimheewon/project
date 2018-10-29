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

<title>게시판 카테고리 목록 리스트</title>

    
<!-- Datatables -->
<link href="/vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
<link href="/vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
<link href="/vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
<link href="/vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
<link href="/vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">

<!-- Custom Theme Style -->
<link href="/build/css/custom.min.css" rel="stylesheet">

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
		                   <h3>게시판 카테고리 관리 </h3>
                        </div>
                    </div>
                    <div class="clearfix"></div>

                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
			                <div class="x_panel" >
                                <div class="x_title">
                                    <h2>목록</h2>			                    
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content" style="font-size:15px">
                    
				                    <table id="datatable" class="table table-striped table-bordered" id="AdminList">
				                        <colgroup>
					                        <col width = "7%"/>
					                        <col width = "*"/>
					                        <col width = "13%"/> 
					                        <col width = "20%"/>
					                        <col width = "20%"/>                    
                                        </colgroup>
                                        <thead>
				                            <tr>
                                                <th style="text-align: center; padding-left: 1.5%; color:#00003f" class="sorting_desc">#</th>
                                                <th style="text-align: center; padding-left: 2%; color:#00003f">게시판명</th>
                                                <th style="text-align: center; padding-left: 2%; color:#00003f">생성 관리자 ID</th>
                                                <th style="text-align: center; padding-left: 2%; color:#00003f">생성일시</th>
					                            <th style="text-align: center; padding-left: 2%; color:#00003f">작&nbsp;&nbsp;&nbsp;&nbsp;업</th>
				                            </tr>
				                        </thead>
				                        <tbody>
					                        <c:forEach var="boardCategory" items="${boardCategory}" varStatus="status">
                                                <tr>
                                                    <td style="text-align: center; color:#3b5976;">${status.count}</td>                         
                                                    <td style="text-align: center; color:#3b5976;">${boardCategory.strBoardCateName}</td>
                                                    <td style="text-align: center; color:#3b5976;">${boardCategory.strBoardCreateAdminId}</td>
                                                    <td style="text-align: center; color:#3b5976;"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${boardCategory.dateBoardDate}"/></td>
					                                <td style="text-align: center; color:#3b5976;"><a href="/Auth/AuthUpdateForm?authNo=${boardCategory.intBoardCateNo}" style="text-align: center; color:#3b5976;">수정하기</a>
					                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <a href="/AdminBoard/AdminBoardList?boardCateNo=${boardCategory.intBoardCateNo}" style="color:#3b5976;">관리하기</a>
                                                    </td>
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
		
		$(document).ready(function () {
			$("#moveBoard").on("click",function(){
				$.ajax({   
	                type:"POST",
	                url:"/AdminBoard/AdminBoardList",   
	                dataType:"html",// JSON/html
	                async: false,
	                data:{ 
	                    "boardCateNo": $(".admin_Id").val()
	                },
	                success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
	                    
	                    if(data==0){                    
	                        alert("사용해도 되는 아이디입니다.");
	                        val = 0; //중복체크함
	                        
	                    }
	                    else{
	                        alert("중복된 아이디입니다.");
	                        document.getElementById("admin_Id").value="";   
	                    }
	                }
	            }); //--ajax
			});
            
        });
			
	
	
	</script>
</body>
</html>