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


    <title>회원정보 수정 </title>

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
	<script type="text/javascript" >
	
	//아이디 중복 체크
	$(document).ready(function () {

	
	

		//빈값 확인
		$("#update").on("click",function(){
			var str = document.updateInfo;
			
			var count=$("#select_grade").val(); //<-- option값
		     
	 		
			
	      	
	       	if(str.name.value == ""){
				alert("이름을 입력하지 않았습니다. 입력해주세요");
				document.getElementById("name").focus();
	           	return false;
	       	}
	       	if(str.phone.value == ""){
				alert("전화번호를 입력하지 않았습니다. 입력해주세요");
				document.getElementById("phone").focus();
	           	return false;
	       	}
	      	else{	//전화번호 형식 확인
		       	var phoneNumberRegex = /^[0-9]{3}[0-9]{4}[0-9]{4}$/;
		    	var phone = document.updateInfo.phone.value;
		    		
		    	if(!phoneNumberRegex.test(phone)) {
		    		alert("전화번호가 잘못된 형식입니다.");
		    		document.updateInfo.phone.value="";
		    		document.getElementById("phone").focus();
		    		return false; 
		    	}
		    }	      	
			if(count == '0'){
	       		alert("회원 등급을 선택하지 않습니다.");
	       		return false;
	       	}   
		});		
	});
		
	
	
	
	
	</script>
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
                  <div class="input-group">
                    
                  </div>
                </div>
              </div>
            </div>
          
            <div class="row">              
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                   <div class="x_title">
                     <h2 style="width: 100%;font-weight: bold;font-family: Bareun;">회원 정보 수정</h2>                   
                     <div class="clearfix"></div>
                   </div>
                   <div class="x_content">
                        <h2 style="margin-top: 0px;margin-right: 35px;">
                            <small style="color: #2c3e50;  font-weight: bold;float: right;font-size: 10pt;">*은 필수항목입니다.</small></h2> <br/>
                                    
                    <form autocomplete="off" style="font-size: 15px;" id="updateInfo" name="updateInfo" data-parsley-validate class="form-horizontal form-label-left" action="/Membership/MembershipUpdate?intUserNo=${intUserNo}" method="POST">

                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="id" style="font-size: 15px; color: #00003f;">아이디 <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12" >
                            <span class="input-group-btn"><input type="text" class="form-control" id="id" name="id" style="background-color: #efefef;" value="${member.strUserId}" disabled>  </span>
                       </div>
                      </div>           
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name" style="font-size: 15px; color: #00003f;">이름 <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input id="name" class="form-control col-md-7 col-xs-12" style="background-color: white;" type="text" name="name" value="${member.strUserName}">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="phone" style="font-size: 15px; color: #00003f;">전화번호 <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input id="phone" class="form-control col-md-7 col-xs-12" style="background-color: white;" type="tel" name="phone" value="${member.strUserPhone}">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="email" style="font-size: 15px; color: #00003f;">이메일 
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input id="email" class="form-control col-md-7 col-xs-12" style="background-color: white;" type="email" name="email" value="${member.strUserEmail}">
                        </div>
                      </div>                      
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="sex" style="font-size: 15px; color: #00003f;">성별 <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
	                       <div class="form-control col-md-7 col-xs-12" style="border: 0px white; box-shadow: 0px 0px 0px white;">
	                           <c:choose>
	                         	<c:when test="${member.strUserSex eq '남성'}">
			                         <input type="radio" class="flat" name="gender" id="gender" value="남성" checked="checked" />&nbsp;&nbsp;남성
			                      	 &nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" class="flat" name="gender" id="gender" value="여성" />&nbsp;&nbsp;여성
			                    </c:when>
			                    <c:otherwise>
			                      	 <input type="radio" class="flat" name="gender" id="gender" value="남성"  />&nbsp;&nbsp;남성
			                      	 &nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" class="flat" name="gender" id="gender" value="여성"checked="checked" />&nbsp;&nbsp;여성
	                      	 	</c:otherwise>
	                      	 </c:choose>
	                        </div>
	                        
                        </div>
                      </div>                     
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="date" style="font-size: 15px; color: #00003f;">가입일시
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                        <a class="form-control col-md-7 col-xs-12" style="background-color: #efefef;" ><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${member.dateUserDate}"/></a>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" style="font-size: 15px; color: #00003f;">등급 <span class="required">*</span></label> 
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <select  id="select_grade" name="select_grade" class="form-control">                        
                          <option value="0" selected>===========================&nbsp;&nbsp;&nbsp;Select&nbsp;&nbsp;&nbsp;===========================</option>           
                            <c:choose>
                            <c:when test="${member.strUserGrade eq '일반'}">                                 
	                            <option value="일반" id="grade" selected>일반 회원</option>
	                            <option value="VIP" id="grade" >VIP 회원</option>
	                          </c:when>
	                          <c:otherwise>
	                         	 <option value="일반" id="grade" >일반 회원</option>
	                            <option value="VIP" id="grade" selected>VIP 회원</option>
	                          </c:otherwise> 
	                          </c:choose>                          
                          </select>  
                        </div>
                      </div>
                      
                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3" style="margin-left: 43%;">
                          <button class="btn btn-primary" type="button" onclick="location.href='/Membership/MembershipRead?intUserNo=${intUserNo}'">취소</button>
                          <button type="submit" class="btn btn-success" id="update">저장</button>
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

	


</script>
	
  </body>
</html>
