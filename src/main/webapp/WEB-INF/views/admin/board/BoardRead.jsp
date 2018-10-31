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

<title>게시글 일기</title>

    
<!-- Datatables -->
<link href="/vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
<link href="/vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
<link href="/vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
<link href="/vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
<link href="/vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">

<!-- Custom Theme Style -->
<link href="/build/css/custom.min.css" rel="stylesheet">

<!-- 스마트 에디터 -->
<script type="text/javascript" src="/smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>


<!-- bootstrap-wysiwyg -->
<link href="/vendors/google-code-prettify/bin/prettify.min.css" rel="stylesheet">
<!-- Select2 -->
<link href="/vendors/select2/dist/css/select2.min.css" rel="stylesheet">
<!-- Switchery -->
<link href="/vendors/switchery/dist/switchery.min.css" rel="stylesheet">
<!-- starrr -->
<link href="/vendors/starrr/dist/starrr.css" rel="stylesheet">
<!-- bootstrap-daterangepicker -->
<link href="/vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">


<style>
    #editBtn{
        height: 35px;
        min-width: 40px;
        margin: 0 0 0 0;
        padding-top: 0.6%;
        float: right;
    }

    #contentStyle{
        width: 90%;
        float: center;
        margin-left: 5%;
        margin-top: 3%;
    }
    #titleSytle{
        font-size: 14px;
        color: #00003f;
        width: 8%;
        text-align: center;
        height: 15%;
        padding-top: 0.6%;
    }
    #buttonStyle{
	    height: 35px;
	    min-width: 40px;
	    margin: 0 0 0 0;
	    padding-top: 8%;
    
    }
    #buttonStyle2{
        height: 35px;
        min-width: 40px;
        margin: 0 0 0 0;
        padding-top: 8%;
    
    }
    #normalStyle{
        width: 7%;
        text-align: left;
        padding-left: 3.1%;
        font-weight: bold;
        color: #4d4d4d;
	    font-size: 15px;  
	    padding-top: 1%;
    }
    #vipStyle{
        width: 7%;
        text-align: left;
        padding-left: 3.1%;
        font-weight: bold;
        color: #18bc9c;  
        font-size: 15px;  
        padding-top: 1%;
    }
    #adminStyle{
        width: 7%;
        text-align: left;
        padding-left: 3.1%;
        font-weight: bold;
        color: #800000;  
        font-size: 15px;  
        padding-top: 1%;
    }
</style>
</head>

<body class="nav-md">
   <body class="nav-md">
    <div class="container body">
        <div class="main_container">
            <jsp:include page="../navigationAdmin.jsp" flush="true"/>

            <!-- page content -->
            <div class="right_col" role="main">
                <div class="">
                    <div class="page-title">
                        <div class="title_left">
                           <h3 style="color: #605183;font-weight: bold;"> </h3>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel" >
                                <div class="x_title">
                                    <h2 style="color: #605183;font-weight: bold;margin-left: 2%;">${boardName}</h2>
                                        <a id="editBtn" href="/AdminBoard/AdminBoardList?boardCateNo=${boardCateNo}" style="margin-right: 5%;" class="btn btn-app">
                                            <i class="fa fa-list-ul" style="color: #7e498b;"></i>
                                        </a>                                                   
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content" id="contentStyle">
                                    <form method="POST" action="/board/boardchange?intBoardNo=${board.intBoardNo}">
								        <div style="border:1px solid #c1c1c1; padding : 1.5%">
								            <input type="hidden" id="bno" value="${board.intBoardNo}">
								            <table class="" style="text-align: center;  ">
								                <tr style=" border-bottom: 1px dashed  #c1c1c1;">
								                    
								                    <td style="width: 40%;font-weight: bold;font-size: 20px;color: #2c3e50;text-align: left;padding-left: 3%;    padding-bottom: 1%;">${board.strBoardTitle}</td>
								                    <td style="width: 80%;  text-align: right;  font-size: 15px;  padding-right: 2%;    color: #7f7f7f; ">
								                    <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.dateBoardDate}" /></td>
								                </tr>
								                <tr>
								                    <c:choose>
								                        <c:when test="${board.strGrade eq '일반'}">
								                            <td id="normalStyle"><img class="btn-img" src="/img/lego.png" style=" width: 7%; ">&nbsp;&nbsp;&nbsp;${board.strUserId}</td>
								                        </c:when>
								                        <c:when test="${board.strGrade eq 'VIP'}">
									                         <td id="vipStyle"><img class="btn-img" src="/img/vip.png" style=" width: 7%; ">&nbsp;&nbsp;&nbsp;${board.strUserId}</td>
	                                                    </c:when>
								                        <c:otherwise>
								                             <td id="adminStyle"><img class="btn-img" src="/img/vip.png" style=" width: 7%; ">&nbsp;&nbsp;&nbsp;${board.strUserId}(${board.strAdminId})</td>
								                        </c:otherwise>
								                    </c:choose>
								                    <td style="width:25%; text-align:right;padding-right: 2%; border-bottom:hidden;font-size: 14px;">조회수&nbsp;&nbsp;&nbsp;${board.intHit}</td>
								                <tr height="250">                   
								                    <td colspan="50" style="text-align: left; padding-left: 3%;  padding-bottom: 5%;  padding-top: 4%;">${board.strBoardContent}</td>
								                </tr>
								            </table>
	                                    </div>
								        <br>
								            <a id="editBtn" onclick="" class="btn btn-app">
                                                <i class="fa fa-wrench" style="color: #005e69;"></i>
                                            </a>
                                            <a id="editBtn" onclick="checkDelete(${board.intBoardNo},${board.intBoardCateNo})"  style="margin-right: 0.5%;" class="btn btn-app">
                                                <i class="fa fa-trash-o" style="color: #a55663;"></i>
                                            </a>  
	                                        
								       
							        </form>
                                </div>
                                <div class="x_content" id="contentStyle">
							        <form>
							            <a style="font-weight: bold; color: #2c3e50;font-size:15px">댓글&nbsp;&nbsp;${board.inttotalComment}</a> <br>
							            <div class="container_c">
							                <hr class="hr">
							                <c:forEach var="comment" items="${commentlist}">
							                    <a style="color: #2C3E50;font-size: 15px; font-weight: bold">${comment.strUserId}&nbsp;&nbsp;&nbsp;</a>
							                    <a style="font-size: small; color: gray;">
							                         <fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${comment.dateCmmtDate}" /></a>							                    
							                    <div>
							                        <p style="padding-left: 0.5%;padding-top: 0.5%;font-size: 17px;" class="cContentAll" id="cContentAll${comment.intCmmtNo}">${comment.strCmmtComment}</p>
							                    </div>
							                    
							                    <hr class="hr">
							                </c:forEach>							                
							                <br>
							            </div>
							        </form>							                                  
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
    
    <!-- bootstrap-wysiwyg -->
    <script src="/vendors/bootstrap-wysiwyg/js/bootstrap-wysiwyg.min.js"></script>
    <script src="/vendors/jquery.hotkeys/jquery.hotkeys.js"></script>
    <script src="/vendors/google-code-prettify/src/prettify.js"></script>
    <!-- jQuery Tags Input -->
    <script src="/vendors/jquery.tagsinput/src/jquery.tagsinput.js"></script>
    <!-- Switchery -->
    <script src="/vendors/switchery/dist/switchery.min.js"></script>
    <!-- Select2 -->
    <script src="/vendors/select2/dist/js/select2.full.min.js"></script>
    <!-- Parsley -->
    <script src="/vendors/parsleyjs/dist/parsley.min.js"></script>
    <!-- Autosize -->
    <script src="/vendors/autosize/dist/autosize.min.js"></script>
    <!-- jQuery autocomplete -->
    <script src="/vendors/devbridge-autocomplete/dist/jquery.autocomplete.min.js"></script>
    <!-- starrr -->
    <script src="/vendors/starrr/dist/starrr.js"></script>
    
    <jsp:include page="../bottomAdmin.jsp" flush="true"/>
    
    <!-- Google Analytics -->
    <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
        
        ga('create', 'UA-23581568-13', 'auto');
        ga('send', 'pageview'); 
    
      //글 삭제 확인
        function checkDelete(bno,categoryNo){
            if((confirm("정말 삭제 하시겠습니까?") == true)){
                location.href="/AdminBoard/AdminBoardDelete?BoardNo="+bno+"&&CategoryNo="+categoryNo;
            }                
            else{
                return;
            }
        }
        
   

    </script>
</body>
</html>