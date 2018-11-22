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
                            <h3 style="color: #605183;font-weight: bold;"></h3>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel" >
                                <div class="x_title">
                                    <h2 style="color: #605183;font-weight: bold;">${boardCateName}</h2>
                                    <button id="editBtn" class="btn btn-app" type="button" onclick="location.href='/BoardCategory/BoardCategoryList'" style="float: right;"
                                          data-placement="top" data-toggle="tooltip" data-original-title="게시판 카테고리 목록">                                        
                                        <i class="fa fa-list-ul" style="color: #7e498b;"></i> </button> 
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content" style="font-size:15px">
                                    <table id="datatable" class="table table-bordered" id="AdminList">
                                         <colgroup>
                                            <col width = "7%"/>
                                            <col width = "*"/>
                                            <col width = "13%"/>
                                            <col width = "14%"/>
                                            <col width = "14%"/>
                                            <col width = "14%"/>
                                            <col width = "8%"/>                   
                                        </colgroup>
                                        <thead style="background-color: #e6e6e8;">
                                            <tr>
                                                <th style="text-align: center; padding-left: 1.5%; color:#00003f;border-right: 1px solid #a6a6a6;border-bottom: 2px solid #a6a6a6;" class="sorting_desc">#</th>
                                                <th style="text-align: center; padding-left: 2%; color:#00003f;border-right: 1px solid #a6a6a6;border-bottom: 2px solid #a6a6a6;">게시판명</th>
                                                <th style="text-align: center; padding-left: 2%; color:#00003f;border-right: 1px solid #a6a6a6;border-bottom: 2px solid #a6a6a6;">생성 관리자 ID</th>
                                                <th style="text-align: center; padding-left: 2%; color:#00003f;border-right: 1px solid #a6a6a6;border-bottom: 2px solid #a6a6a6;">최근 수정 관리자 ID</th>
                                                <th style="text-align: center; padding-left: 2%; color:#00003f;border-right: 1px solid #a6a6a6;border-bottom: 2px solid #a6a6a6;">생성일시</th>
                                                <th style="text-align: center; padding-left: 2%; color:#00003f;border-right: 1px solid #a6a6a6;border-bottom: 2px solid #a6a6a6;">최근수정일시</th>
                                                <th style="text-align: center; padding-left: 2%; color:#00003f;border-bottom: 2px solid #a6a6a6;">작&nbsp;&nbsp;&nbsp;&nbsp;업</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="boardCategory" items="${boardCategory}" varStatus="status">
                                                <tr>
                                                    <td style="text-align: center; color:#3b5976;">${status.count}</td>                         
                                                    <td style="text-align: center; color:#3b5976;">
                                                        <a href="/AdminBoard/AdminBoardList?boardCateNo=${boardCategory.intBoardCateNo}" style="color:#3b5976;">${boardCategory.strBoardCateName}</a>
                                                    </td>
                                                    <td style="text-align: center; color:#3b5976;">${boardCategory.strBoardCreateAdminId}</td>
                                                    <td style="text-align: center; color:#3b5976;">${boardCategory.strBoardCreateAdminId}</td>
                                                    <td style="text-align: center; color:#3b5976;"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${boardCategory.dateBoardDate}"/></td>
                                                    <td style="text-align: center; color:#3b5976;"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${boardCategory.dateBoardDate}"/></td>
                                                    <td style="text-align: center; color:#3b5976;padding-top: 0.2%; padding-bottom: 0.2%;">
                                                        <button class="btn btn-app" type="button" onclick="location.href='/BoardCategory/ChildBoardCategoryUpdateForm?intboardCategoryNo=${boardCategory.intBoardCateNo}'" 
                                                                style="padding-top: 5%;" id="editBtn" data-placement="top" data-toggle="tooltip" data-original-title="수정">
                                                            <i class="fa fa-wrench" style="color: #626200;"></i></button>
                                                        <button class="btn btn-app" type="button" onclick="checkDelete(${boardCategory.intBoardCateNo})"
                                                                style="padding-top: 5%;" id="editBtn" data-placement="top" data-toggle="tooltip" data-original-title="삭제" style="margin-right: 0.5%;">                                                        
                                                            <i class="fa fa-trash-o" style="color: #a55663;"></i>
                                                        </button>
                                                    </td>
                                                </tr>   
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <button class="btn btn-app" type="button" onclick="location.href='/BoardCategory/ChildBoardCategoryEnrollForm?boardCateNo=${boardCateNo}'"  
                                                                id="editBtn" data-placement="top" data-toggle="tooltip" data-original-title="등록" style="float: right">
                                                            <i class="fa fa-check-square-o" style="color: #005e69;"></i></button>                                          
                                
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
            
    //게시판 카테고리 삭제 확인
    function checkDelete(intBoardCateNo){
        if((confirm("정말 삭제하시겠습니까?") == true)){
            location.href="/BoardCategory/ChildBoardCategoryDelete?boardCateNo="+intBoardCateNo;
        }
        else{
            return;
        }
    };
    </script>
</body>
</html>