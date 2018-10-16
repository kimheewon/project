<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Join</title>

<!-- Bootstrap core CSS -->
<link href="/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom fonts for this template -->
<link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic"
	rel="stylesheet" type="text/css">

<!-- Plugin CSS -->
<link href="/vendor/magnific-popup/magnific-popup.css" rel="stylesheet"
	type="text/css">

<script src="/js/jquery-1.12.3.min.js"></script>
<script src="/js/jquery-ui.min.js"></script>

<!-- Custom styles for this template -->
<link href="/css/freelancer.min.css" rel="stylesheet">
<style>
	.sex{
		top: 0;
	    opacity: 1;
		font-size: .85em;
	    line-height: 1.764705882em;
	    position: relative;
	    z-index: 0;
	    
	    display: block;
	    margin: 0;
	   
	    transition: top .3s ease,opacity .3s ease;
	    
	    vertical-align: baseline;
 	}
 	.fontsize{
 		font-size: 11pt;
 		color:#18BC9C;

 	}
 	.font_required{
 		font-size: 11pt;
 		color:#18BC9C;

 	} 
 	.fontpw{
 		color:red;
 	    display: block;
	    width: 100%;
	    height: calc(2.25rem + 2px);
	    padding: .375rem .75rem;
	    font-size: 0.7rem;
	    line-height: 1.5;
	    background-color: #fff;
	    background-clip: padding-box;
	    border: 1px solid #ced4da;
	    border-radius: .25rem;
	    transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
		
	}


</style>
<script type="text/javascript" >

	$(document).ready(function () {
		var val = 1;
		$("#userIdCheck").on("click",function(){
			
			if(document.joinInfo.userId.value==""){
				alert("아이디를 입력하세요.");
         		document.joinInfo.userId.value="";	
			}
			else{
			 $.ajax({   
				type:"POST",
				url:"/user/joinCheck",   
				dataType:"html",// JSON/html
				async: false,
              	data:{ 
                    "id": $("#userId").val()
                },
			
                success: function(data){//통신이 성공적으로 이루어 졌을때 받을 함수
                	
                	if(data==0){					
                 		alert("사용해도 되는 아이디입니다.");
                 		val = 0; //중복체크함
                 	}
                 	else{
                 		alert("중복된 아이디입니다.");
                 		document.joinInfo.userId.value="";	
                 	}
                }
			}); //--ajax
			}
			
		});
		
		
		//빈값 확인
		$("#joinInformation").on("click",function(){
			var str = document.joinInfo;
			
			if(str.userId.value == ""){
		 		alert("아이디를 입력하지 않았습니다. 입력해주세요");
		     	str.userId.focus();
		   		return false;
		       }
			if(val == 1){
				alert("중복체크를 하지 않았습니다.");
				return false;
			}
	      	if(str.pw1.value == ""){
	           	alert("비밀번호를 입력하지 않았습니다. 입력해주세요");
	           	str.pw1.focus();
	           	return false;
	       	}
	      	else{	//비밀번호 유효성 검사
	      		var pw = str.pw1.value;
				var reg_pw ="^(?=.*\\d)(?=.*[~`!@#$%\\^&*()-])(?=.*[a-z])(?=.*[A-Z]).{8,20}$";

				if(!pw.match(reg_pw)) {
					alert("8~20자 영문 대 소문자, 숫자, 특수문자를 사용하세요."); 
	      		    document.joinInfo.pw1.value="";
	      			document.joinInfo.pw2.value="";
	      		    return false; 
	      		}
	      	}
	       	if(str.pw2.value == ""){
	           	alert("비밀번호 확인을 입력하지 않았습니다. 입력해주세요");
	           	str.pw2.focus();
	           	return false;
	       	}
	       	
	       	if(str.name.value == ""){
				alert("이름을 입력하지 않았습니다. 입력해주세요");
				str.name.focus();
	           	return false;
	       	}
	       	if(str.phone.value == ""){
				alert("전화번호를 입력하지 않았습니다. 입력해주세요");
				str.phone.focus();
	           	return false;
	       	}
	       	else{	//전화번호 형식 확인
	       		var phoneNumberRegex = /^[0-9]{3}[0-9]{4}[0-9]{4}$/;
	    		var phone = document.joinInfo.phone.value;
	    		
	    		if(!phoneNumberRegex.test(phone)) {
	    			alert("전화번호가 잘못된 형식입니다.");
	    			document.joinInfo.phone.value="";
	    			return false; 
	    		}
	       	}
		});		
	});
	
	
	
	//비밀번호 확인
	function onblur_event(){
		var pw1 = document.joinInfo.pw1.value;
		var pw2 = document.joinInfo.pw2.value;
		
		if(pw1 != pw2){			
			alert("비밀번호가 일치하지 않습니다");
			document.joinInfo.pw2.value="";		
		}	
	 }
	
</script>
</head>

<body id="page-top">

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg bg-secondary fixed-top text-uppercase" id="mainNav">
		<div class="container"></div>
	</nav>



	<!-- Contact Section -->
	<section id="contact">
		<div class="container">
			<h2 class="text-center text-uppercase text-secondary mb-0">Join	Us</h2>
			<hr class="star-dark mb-5">
			<div class="row">
				<div class="col-lg-10 mx-auto">
					<!-- To configure the contact form email address, go to mail/contact_me.php and update the email address in the PHP file on line 19. -->
					<!-- The form should work on most web servers, but if the form is not working you may need to configure your web server differently. -->
					<div style="text-align:right; color:#18BC9C;">
					*는 필수 입력값입니다.
					</div>
					<form name="joinInfo" action="/user/joinSave" method="POST">
						<div class="control-group">
							<div class="form-group floating-label-form-group controls mb-0 pb-2" >
								<a class="font_required">* 아이디</a>
								<p class="help-block text-danger"><p class="help-block text-danger">
								<span>&nbsp;&nbsp;&nbsp;&nbsp;<input class="form-control" id="userId" name="userId"	type="text" required="required" size="15" style="display:inline; border-radius: 8px;width:80%;background-color:#efefef ">
								&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="userIdCheck" value="중복확인" style="background-color:#2c3e50; color:white;padding: 0.5rem;border-radius: 8px;"/></span>
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div
								class="form-group floating-label-form-group controls mb-0 pb-2">
								<a class="font_required">* 비밀번호</a>
								<p class="help-block text-danger"><p class="help-block text-danger">
								&nbsp;&nbsp;&nbsp;&nbsp;<input class="form-control" id="pw1" name="pw1" type="text" placeholder="영문대소문자,숫자,특수문자 모두 포함 최소 8자~최대 20자" required="required"  style="display:inline; border-radius: 8px;width:80%;background-color:#efefef ">
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div
								class="form-group floating-label-form-group controls mb-0 pb-2">
								<a class="font_required">* 비밀번호 확인</a>
								<p class="help-block text-danger"></p>
								<p class="help-block text-danger">
								&nbsp;&nbsp;&nbsp;&nbsp;<input class="form-control" id="pw2" name = "pw2" type="text" placeholder="영문대소문자,숫자,특수문자 모두 포함 최소 8자~최대 20자" required="required"style="display:inline; border-radius: 8px;width:80%;background-color:#efefef " onblur="javascript:onblur_event();">
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div
								class="form-group floating-label-form-group controls mb-0 pb-2">
								<a class="font_required">* 이름</a>
								<p class="help-block text-danger"><p class="help-block text-danger">
								&nbsp;&nbsp;&nbsp;&nbsp;<input class="form-control" id="name" name="name" type="text" required="required"style="display:inline; border-radius: 8px;width:80%;background-color:#efefef ">
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div
								class="form-group floating-label-form-group controls mb-0 pb-2">
								<a class="font_required">* 전화번호</a>
								<p class="help-block text-danger"></p><p class="help-block text-danger">
								&nbsp;&nbsp; &nbsp;&nbsp;<input type="tel" id="phone" name="phone" required="required" placeholder="- 없이 입력하세요" style="display:inline; border-radius: 8px;width:80%;background-color:#efefef; padding: 0.5rem;"/>
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div
								class="form-group floating-label-form-group controls mb-0 pb-2">
								<a class="font_required">이메일</a>
								<p class="help-block text-danger"></p>
								&nbsp;&nbsp; &nbsp;&nbsp;<input class="form-control" id="email" name="email" type="email" data-validation-required-message="Please enter your email address." style="display:inline; border-radius: 8px;width:80%;background-color:#efefef ">
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div class="form-group floating-label-form-group controls mb-0 pb-2">
								<a class="fontsize">* 성별</a>
								<p class="help-block text-danger"></p> &nbsp;&nbsp; &nbsp;&nbsp;
								<input class="sex_f" id="sex" type="radio" name="sex"  value="남성" checked="checked" >남성 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input class="sex_f" type="radio" id="sex" name="sex" value="여성" />여성								
								<p class="help-block text-danger"></p>
							</div>
						</div>
						
						<br>
						<div id="success"></div>
						<div class="form-group" style="text-align:right;">
							<button class="btn btn-primary btn-xl" onclick="location='/login'">취 소</button>
							<button class="btn btn-primary btn-xl" id="joinInformation">가 입</button>							
						</div>
						
					</form>
						
				</div>
			</div>
		</div>
	</section>


	<!-- Scroll to Top Button (Only visible on small and extra-small screen sizes) -->
	<div class="scroll-to-top d-lg-none position-fixed ">
		<a class="js-scroll-trigger d-block text-center text-white rounded"
			href="#page-top"> <i class="fa fa-chevron-up"></i>
		</a>
	</div>


	<!-- Bootstrap core JavaScript -->
	<script src="/vendor/jquery/jquery.min.js"></script>
	<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Plugin JavaScript -->
	<script src="/vendor/jquery-easing/jquery.easing.min.js"></script>
	<script src="/vendor/magnific-popup/jquery.magnific-popup.min.js"></script>

	<!-- Contact Form JavaScript -->
	<script src="/js/jqBootstrapValidation.js"></script>
	<script src="/js/contact_me.js"></script>

	<!-- Custom scripts for this template -->
	<script src="/js/freelancer.min.js"></script>
    <footer>
 		<jsp:include page="../bottom.jsp" flush="true"/>
    </footer>
</body>

</html>
