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

<title>게시판 등록</title>

    
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
        margin-right: 5%;
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
                                    <h2 style="color: #605183;font-weight: bold;  margin-left: 2%;">${boardName}</h2> 
                                        <button id="editBtn" class="btn btn-app" type="button" onclick="location.href='/AdminBoard/AdminBoardList?boardCateNo=${boardCateNo}'"
                                                     data-placement="top" data-toggle="tooltip" data-original-title="${boardName} 목록">
                                        <i class="fa fa-list-ul" style="color: #7e498b;"></i></button>                                                                  
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content" id="contentStyle">
                                    <form action="/AdminBoard/AdminBoardEnroll?boardCateNo=${boardCateNo}" method="post" name="info">
                                        
		                                <div class="form-group">
		                                    <label id="titleSytle" class="control-label col-md-3 col-sm-3 col-xs-12" for="id">제   목
		                                    </label>
					                        <div class="input-group" style="width:91.5%; padding-left:0.9rem">
					                            <span class="input-group-btn">
		                                            <input type="text" class="form-control" id="strBoardTitle" name="strBoardTitle">
			                                    </span>
		                                    </div>
		                                    <hr style="border: 1px solid #dbdfe5;">
		                                    <div >
		                                       <textarea name="strBoardContent" id="strBoardContent" style="display:none;width: 100%;" ></textarea>
		                                       </div>
		                                    <br/>  
		                                    <div class="ln_solid"></div>
		                                    <div class="btn-group" style="float: right;">
		                                       <button class="btn btn-app" type="button" onclick="location.href='/AdminBoard/AdminBoardList?boardCateNo=${boardCateNo}'"
		                                            id="buttonStyle2" data-placement="top" data-toggle="tooltip" data-original-title="뒤로" style="margin-right: 0.5%;">
	                                                <i class="fa fa-repeat" style="color: #005e69;"></i></button>
					                            <button class="btn btn-app" type="button" id="buttonStyle"  name="buttonStyle" data-placement="top" data-toggle="tooltip" data-original-title="저장">
					                                <i class="fa fa-save" style="color: #a55663;"></i></button>				                            
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
    
        
        //스마트에디터
    var oEditors = [];

     // Editor Setting
     nhn.husky.EZCreator.createInIFrame({
         oAppRef : oEditors,
         elPlaceHolder : "strBoardContent", // 에디터를 적용할 textarea ID에 맞게 변경
         sSkinURI : "/smarteditor/SmartEditor2Skin.html", // Editor HTML파일 위치로 변경
         fCreator : "createSEditor2", // SE2BasicCreator.js 메소드명으로 변경하면 안된다.
         htParams : { // 툴바 사용 여부 (true/false)
             bUseToolbar : true, // 입력창 크기 조절바 사용 여부 (true/false)
             bUseVerticalResizer : true, // 모드 탭(Editor|HTML|TEXT) 사용 여부 (true/false)
             bUseModeChanger : true,// 전송버튼 클릭이벤트
             fOnBeforeUnload : function(){
                 
             }
         },
         fOnAppLoad : function(){
      
         }
     });

     window.onload = function(){
         var btn = document.getElementById("buttonStyle");
         btn.onclick = function(){
             submitContents(btn);    
                 
         }
         
     };
     function submitContents(btn) {
         // 에디터의 내용이 textarea에 적용
         oEditors.getById["strBoardContent"].exec("UPDATE_CONTENTS_FIELD", []);
       
             var str = document.info;
             var title = str.strBoardTitle;
             var content = document.getElementById("strBoardContent");
             
             if(title.value == ""){
                 alert("제목을 입력해 주세요");
                 title.focus();
                 return false;
             }
             if(content.value == ""){
                 alert("내용을 입력해 주세요");
                 return false;
             }
         
         try{
             
             btn.form.submit();
             
         }catch(e){}
     };

    </script>
</body>
</html>