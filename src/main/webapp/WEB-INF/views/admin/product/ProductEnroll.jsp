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


<title>상품 등록 </title>

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

<style type="text/css">
	.img_wrap {
	    width: 600px;
	    margin-top: 50px;
	}
    .img_wrap img {
        max-width: 100%;
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
                                <div class="x_title">
                                    <h2 style="width: 100%;font-weight: bold;font-family: Bareun;">아이템 등록</h2>                   
                                    <div class="clearfix"></div>
                                </div>
                                <div class="x_content">
                                <h2 style="margin-top: 0px;margin-right: 35px;">
                                        <small style="color: #2c3e50;  font-weight: bold;float: right;font-size: 10pt;">*은 필수항목입니다.</small></h2> <br/>
                                    <form autocomplete="off" id="enrollInfo" name="enrollInfo" data-parsley-validate class="form-horizontal form-label-left" enctype="multipart/form-data"
                                        action="/Product/ProductEnroll" method="POST" >
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" style="font-size: 13px; color: #00003f;">아이템명 <span class="required">*</span>
                                            </label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" id="strItemName" name="strItemName" required="required" class="form-control col-md-7 col-xs-12">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" style="font-size: 13px; color: #00003f;">캐시금액 <span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="text" id="strPrice" name="strPrice" class="form-control col-md-7 col-xs-12" required="required" onkeyup="inputNumberFormat(this)">
                                             
                                            </div>                                           
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 col-sm-3 col-xs-12" style="font-size: 13px; color: #00003f;">이미지 업로드 <span class="required">*</span></label>
                                            <div class="col-md-6 col-sm-6 col-xs-12">
                                                <input type="file" id="file" name="file" class="form-control col-md-7 col-xs-12" required="required" 
                                                    style="background-color: white;border: none;box-shadow: none;" >
                                                <div class="img_wrap">
                                                    <img id="img">
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="ln_solid"></div>
                                        <div class="form-group">
                                            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3" style="margin-left: 43%;">
                                                <button class="btn btn-primary" type="button" onclick="location.href='/Product/ProductList'">취소</button>
                                                <button type="submit" class="btn btn-success" id="productEnroll">등록</button>
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
         
        //이미지 미리보기
        $("#file").on("change", handleImgFileSelect);
	       

        function handleImgFileSelect(e) {
            var files = e.target.files;
            var filesArr = Array.prototype.slice.call(files);
           
            
            filesArr.forEach(function(f) {
                if(!f.type.match("image.*")) {
                    alert("확장자는 이미지 확장자만 가능합니다.");
                    document.getElementById("file").value="";
                    return false;
                }
                else{
	                sel_file = f;
	 
	                var reader = new FileReader();
	                reader.onload = function(e) {
	                	$img = $("#img").attr("src", e.target.result);                            //파일을 선택했을 경우 정보를 $img 객체에 저장  
	                    
	                }
	                reader.readAsDataURL(f);
                }
            });
        }
       
      
    });

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
 
    //이미지 미리보기
    function readURL(input) {
 
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	 
	        reader.onload = function (e) {
	            $('#img').attr('src', e.target.result);
	        }
	 
	        reader.readAsDataURL(input.files[0]);
	    }
	}
/*	 
	$("#file").change(function(){
	    readURL(this);
	});
*/
	//이미지 크기
/*
$(document).on('change', 'input[type=file]', function(){
    var $width = $(this).attr('data-width');
    var $height = $(this).attr('data-height');
    var $target = $(this);


	if(window.FileReader){ //FileReader를 지원하는 브라우저의 경우 IE 10이상, 크롬..
	
	   var reader = new FileReader();	
	       reader.onload = function (e) {	
	           $('body').append('<img src="" id="temp_img" style="display:none;" />');  //보이지 않는 임시 img 태그를 생성.	
	           $img = $('#temp_img').attr('src', e.target.result);                          //파일을 선택했을 경우 정보를 $img 객체에 저장	
	           if($img.width() >= $width || $img.height() >= $height){                  //가로 세로 사이즈 비교 후 반환	
	              alert('지정된 크기와 맞지 않습니다.('+$width + 'x'+ $height +')');	
	              $target.val('');	
	              $('#temp_img').remove(); //위에서 생성한 임시 img 태그 삭제	
	              return false;
	
	           }
	           else{
	        	   readURL(this);
	           }
	
	      };
	
	     
	} else {                                               //FileReader를 지원하지 않는 브라우저의 경우 IE 9 이하	
	    $(this)[0].select();	
	    var src = document.selection.createRange().text;	
	    $('body').append('<img src="" id="temp_img" style="display:none;" />');	
	    $img = $('#temp_img').attr('src', src);	
	    $('#temp_img').remove();	
	    if($img.width() >= $width || $img.height() >= $height){	
	        alert('지정된 크기와 맞지 않습니다.('+$width + 'x'+ $height +')');	
	        $(this).val('');	
	        return false;	
	    }
	    else{
            readURL(this);
        }
	
	}
	$('#temp_img').remove();
});*/
</script>
    
</body>
</html>
