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


    <title>관리자 등록 </title>

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
                <h3>관리자 등록</h3>
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
                    <h2>Form Basic Elements <small>different form elements</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                   <div class="x_content">
                    <br />
                    <form id="enrollInfo" name="enrollInfo" data-parsley-validate class="form-horizontal form-label-left" action="/Administrator/Enroll" method="POST">

                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="id">아이디 <span class="required">*</span>
                        </label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="admin_Id" name="admin_Id">
                            <span class="input-group-btn"><button type="button"  class="btn btn-primary"  id="adminIdCheck">중복확인</button></span>
                       </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="password">비밀번호 <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input type="password" id="admin_Pw" name="admin_Pw" required="required" class="form-control col-md-7 col-xs-12" placeholder="영문대소문자,숫자,특수문자 모두 포함 최소 8자~최대 20자">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="password2">비밀번호 확인 <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input id="admin_Pw2" class="form-control col-md-7 col-xs-12" type="password" name="admin_Pw2" placeholder="영문대소문자,숫자,특수문자 모두 포함 최소 8자~최대 20자">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">이름 <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input id="admin_Name" class="form-control col-md-7 col-xs-12" type="text" name="admin_Name">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">관리자 권한 유형 <span class="required">*</span></label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <select  id="admin_Auth" name="admin_Auth" class="form-control">
                          <option value="0" selected>====Select====</option>
                          <c:forEach var="authList" items="${authList}">				                           
                            <option value="${authList.intAuthNo}" id="auth">${authList.strAuthName}</option>
                            </c:forEach>
                          </select>
                        </div>
                      </div>
                      
                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                          <button class="btn btn-primary" type="button">Cancel</button>
						  <button class="btn btn-primary" type="reset">Reset</button>
                          <button type="submit" class="btn btn-success" id="adminEnroll">등록</button>
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
    <!-- jQuery -->
    <script src="/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="/vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="/vendors/nprogress/nprogress.js"></script>
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
		$("#adminIdCheck").on("click",function(){
			
			if(document.getElementById("admin_Id").value==""){
				alert("아이디를 입력하세요.");
	     		document.getElementById("admin_Id").value="";	
			}
			else{
			 $.ajax({   
				type:"POST",
				url:"/Administrator/AdministratorIdCheck",   
				dataType:"html",// JSON/html
				async: false,
	          	data:{ 
	                "id": $("#admin_Id").val()
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
			}
			
		});
		
		
		//빈값 확인
		$("#adminEnroll").on("click",function(){
			var str = document.enrollInfo;
			var pw1 = document.getElementById("admin_Pw");
			var pw2 = document.getElementById("admin_Pw2");
			var target = document.getElementById("admin_Auth");
     		var auth = target.options[target.selectedIndex].value;
     		
     		
			if(str.admin_Id.value == ""){
		 		alert("아이디를 입력하지 않았습니다. 입력해주세요");
		     	str.adminEnroll.focus();
		   		return false;
		       }
			if(val == 1){
				alert("중복체크를 해주세요");
				return false;
			}
	      	if(str.admin_Pw.value == ""){
	           	alert("비밀번호를 입력하지 않았습니다. 입력해주세요");
	           	str.admin_Pw.focus();
	           	return false;
	       	}
	      	else{	//비밀번호 유효성 검사
	      		var pw = str.admin_Pw.value;
				var reg_pw ="^(?=.*\\d)(?=.*[~`!@#$%\\^&*()-])(?=.*[a-z])(?=.*[A-Z]).{8,20}$";
	
				if(!pw.match(reg_pw)) {
					alert("8~20자 영문 대 소문자, 숫자, 특수문자를 사용하세요."); 
	      		    document.enrollInfo.admin_Pw.value="";
	      			document.enrollInfo.admin_Pw2.value="";
	      		    return false; 
	      		}
	      	}
	       	if(str.admin_Pw2.value == ""){
	           	alert("비밀번호 확인을 입력하지 않았습니다. 입력해주세요");
	           	str.admin_Pw2.focus();
	           	return false;
	       	}
	       	if(pw1.equals(pw2)){			
				alert("비밀번호가 일치하지 않습니다");
				document.getElementById("admin_Pw2").value="";
				return false;
			}	
	       	if(str.admin_Name.value == ""){
				alert("이름을 입력하지 않았습니다. 입력해주세요");
				str.admin_Name.focus();
	           	return false;
	       	}
	       //관리자 권한 확인
		});		
	});

	


</script>
	
  </body>
</html>
