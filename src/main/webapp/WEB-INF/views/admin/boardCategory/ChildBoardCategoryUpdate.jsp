<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%  // 인증된 세션이 없는경우, 해당페이지를 볼 수 없게 함.
    if (session.getAttribute("AdminId")  == null) {
        response.sendRedirect("/loginAdmin/logout");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>게시판 카테고리 수정 </title>

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
<script src="/js/jquery-1.12.3.min.js"></script>
<script src="/js/jquery-ui.min.js"></script>
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
                            <h3></h3>
                        </div>
	                    <div class="title_right">
	                       <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
	                           <div class="input-group"></div>
		                    </div>
	                    </div>
		            </div>
		            <div class="row">              
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="x_panel">
                                <div class="x_title" >
		                            <h2 style="color: #605183;font-weight: bold;">${board.strBoardCateName}</h2>
                                    <button id="editBtn" class="btn btn-app" type="button" onclick="location.href='/BoardCategory/BoardCategoryList?boardCateNo=${board.intBoardCateNo}'"
                                          data-placement="top" data-toggle="tooltip" data-original-title="${board.strParentBoardCateName} 목록">                                        
                                        <i class="fa fa-list-ul" style="color: #7e498b;"></i> </button>                                      
                                   <div class="clearfix"></div>
                                </div>
			                    <div class="x_content">
			                        <h2 style="margin-top: 0px;margin-right: 35px;">
                                        <small style="color: #2c3e50;  font-weight: bold;float: right;font-size: 10pt;">*은 필수항목입니다.</small></h2> <br/>
                                    <form autocomplete="off" id="enrollInfo" name="enrollInfo" data-parsley-validate class="form-horizontal form-label-left" action="/BoardCategory/ChildBoardCategoryUpdate?parentBoardCateNo=${board.intParentBoardCateNo}" method="POST">
                                        <input type="hidden" name="no" id="no" value="${board.intBoardCateNo}">
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="id" style="font-size: 13px; color: #00003f;">게시판명 <span class="required">*</span></label>
				                            <div class="input-group" style="width:49.5%; padding-left:0.9rem">
                                                <span class="input-group-btn"><input type="text" class="form-control" id="boardName" name="boardName" required="required" value="${board.strBoardCateName}" >
					                            <button type="button"  class="btn btn-primary"  id="boardNameCheck">중복확인</button></span>
				                            </div>
				                        </div>
				                        <div class="ln_solid"></div>
				                        <div class="form-group">
				                            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3" style="margin-left: 43%;">
					                            <button class="btn btn-primary" type="button" onclick="location.href='/BoardCategory/ChildBoardList?boardCateNo=${board.intParentBoardCateNo}'">취소</button>
					                            <button type="submit" class="btn btn-success" id="enroll">수정</button>
				                            </div>
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
    <jsp:include page="../bottomAdmin.jsp" flush="true"/>
    
    <!-- bootstrap-progressbar -->
    <script src="/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
    <!-- iCheck -->
    <script src="/vendors/iCheck/icheck.min.js"></script>
    <!-- bootstrap-daterangepicker -->
    <script src="/vendors/moment/min/moment.min.js"></script>
    <script src="/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
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
    <!-- Custom Theme Scripts -->
    <script src="/build/js/custom.min.js"></script>
<!-- Google Analytics -->
    <script type="text/javascript" >
	(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
	
	ga('create', 'UA-23581568-13', 'auto');
	ga('send', 'pageview');
	
	    $(document).ready(function () {
	        var val = 1;
	        $("#boardNameCheck").on("click",function(){
	            
	            if(document.getElementById("boardName").value==""){
	                alert("게시판명을 입력하세요.");
	                document.getElementById("boardName").focus();   
	            }
	            else{
	             $.ajax({   
	                type:"POST",
	                url:"/BoardCategory/UpdateBoardCategoryNameCheck",   
	                dataType:"html",// JSON/html
	                async: false,
	                data:{ 
	                    "boardName": $("#boardName").val(),
	                    "no": $("#no").val()
	                },
	            
	                success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
	                    
	                    if(data==0){                    
	                        alert("사용해도 되는 게시판명입니다.");
	                        val = 0; //중복체크함
	                        
	                    }
	                    else if(data==2){
	                    	alert("기존 권한명입니다.");
	                    	val=0;    //중복체크 함
	                    }
	                    else{
	                        alert("중복된 게시판명입니다.");
	                        document.getElementById("boardName").value="";
	                        document.getElementById("boardName").focus();   
	                    }
	                }
	            }); //--ajax
	            }
	            
	        });
	        
	        
	        //빈값 확인
	        $("#enroll").on("click",function(){
	            var str = document.enrollInfo;
	            
	            if(document.getElementById("boardName").value==""){
                    alert("게시판명을 입력하세요.");
                    document.getElementById("boardName").focus();  
                    return false;
                }
	            if(val == 1){
	            	alert("중복체크를 해주세요.");
	            	return false;
	            }
	            
	        });     
	    });
	
	    </script>
    
</body>
</html>
