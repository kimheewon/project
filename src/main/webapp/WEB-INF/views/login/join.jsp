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
	.flat{
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

#address2:enabled {
    background: white !important;
    border: 1px solid gray!important;
}

#address2:disabled {
    background-color:#efefef !important;
}

/* Custom labels: the container */
.checkcontainer {
    position: relative !important;
    padding-left: 35px !important;
    margin-bottom: 12px !important;
    cursor: pointer !important;
    font-size: 17px !important;
    -webkit-user-select: none !important; /* Chrome, Opera, Safari */
    -moz-user-select: none !important; /* Firefox 2+ */
    -ms-user-select: none !important; /* IE 10+ */
    user-select: none !important; /* Standard syntax */
}

/* Hide the browser's default checkbox */
.checkcontainer input {
    position: absolute !important;
      opacity: 0 !important;
cursor: pointer !important;}

/* Create a custom checkbox */
.checkmark {
    position: absolute !important;
    top: 0 !important;
    left: 0 !important;
    height: 25px !important;
    width: 25px !important;
    background-color: #eee !important;
}

/* On mouse-over, add a grey background color */
.checkcontainer:hover input ~ .checkmark {
    background-color: #ccc !important;
}

/* When the checkbox is checked, add a blue background */
.checkcontainer input:checked ~ .checkmark {
    background-color: #2196F3 !important;
}

/* Create the checkmark/indicator (hidden when not checked) */
.checkmark:after {
    content: "" !important;
    position: absolute !important;
    display: none !important;
}

/* Show the checkmark when checked */
.checkcontainer input:checked ~ .checkmark:after {
    display: block !important;
}

/* Style the checkmark/indicator */
.checkcontainer .checkmark:after {
    left: 10px !important;
    top: 6px !important;
    width: 7px !important;
    height: 12px !important;
    border: solid white !important;
    border-width: 0 3px 3px 0 !important;
    -webkit-transform: rotate(45deg) !important;
    -ms-transform: rotate(45deg) !important;
    transform: rotate(45deg) !important;
}

/* Create a custom radio button */
.radiobtn{
  position: absolute !important;
  top: 0 !important;
  left: 0 !important;
  height: 25px !important;
  width: 25px !important;
  background-color: #eee !important;
  border-radius: 50% !important;
}

/* On mouse-over, add a grey background color */
.checkcontainer:hover input ~ .radiobtn{
  background-color: #ccc !important;
}

/* When the radio button is checked, add a blue background */
.checkcontainer input:checked ~ .radiobtn{
  background-color: #2196F3 !important;
}

/* Create the indicator (the dot/circle - hidden when not checked) */
.radiobtn:after {
  content: "" !important;
  position: absolute !important;
  display: none !important;
}

/* Show the indicator (dot/circle) when checked */
.checkcontainer input:checked ~ .radiobtn:after {
  display: block !important;
}

/* Style the indicator (dot/circle) */
.checkcontainer .radiobtn:after {
  top: 9px !important;
  left: 9px !important;
  width: 8px !important;
  height: 8px !important;
  border-radius: 50% !important;
  background: white !important;
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
			var pw1 = document.joinInfo.pw1.value;
			var pw2 = document.joinInfo.pw2.value;
			
			if(str.userId.value == ""){
		 		alert("아이디를 입력하지 않았습니다. 입력해주세요");
		     	str.userId.focus();
		   		return false;
		       }
			else{
				var idReg = /^[a-zA-Z](?=.{0,28}[0-9])[0-9a-zA-Z]{6,15}$/	//영문 대문자 또는 소문자로 시작하는 아이디, 길이는 6~15자, 끝날때 제한 없음
				if(!idReg.test(str.userId.value)) {
					alert("6~15자 영문대소문자,숫자를 사용하세요.");
					str.userId.value = "";
					str.userId.focus();					
			   		return false;
				}	
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
	      	if(str.pw2.value == ""){
	           	alert("비밀번호 확인을 입력하지 않았습니다. 입력해주세요");
	           	str.pw2.focus();
	           	return false;
	       	}
	      	if(pw1 != pw2){
	       		alert("비밀번호가 일치하지 않습니다");
				document.joinInfo.pw2.value="";
				str.pw2.focus()
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
	function go(val){
		var pw1 = document.joinInfo.pw1.value;
		var pw2 = document.joinInfo.pw2.value;
		
		if(pw1 != pw2){			
			document.getElementById("welcome").value = '비밀번호가 일치하지않습니다.';
		}
		else{
			document.getElementById("welcome").value = '';
		}
		
	}
	
	//아이디 확인
	function go2(val){
		var userId = document.joinInfo.userId.value;
		
		//var idReg = /^[A-za-z0-9]{6,15}$/g;		
		
		var idReg = /^[a-zA-Z](?=.{0,28}[0-9])[0-9a-zA-Z]{6,15}$/;	//영문 대문자 또는 소문자로 시작하는 아이디, 길이는 6~15자, 끝날때 제한 없음
		
		if(!idReg.test(userId)) {
			document.getElementById("welcome2").value = '아이디 형식이 맞지않습니다.';
		}
		else{
			document.getElementById("welcome2").value = '';
		}
		
	}
	
	//전화번호
	function go3(val){
		
		
		var phoneNumberRegex = /^[0-9]{3}[0-9]{4}[0-9]{4}$/;
		var phone = document.joinInfo.phone.value;
		
		if(!phoneNumberRegex.test(phone)) {
			document.getElementById("welcome3").value = '전화번호 형식이 맞지않습니다.';
		}
		else{
			document.getElementById("welcome3").value = '';
		}
		
	}
	
</script>


</head>
<link type="text/css" rel="stylesheet" href="/css/itemPurchaseStyle.css" />
<body id="page-top">

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg bg-secondary fixed-top text-uppercase" id="mainNav">
		<div class="container"></div>
	</nav>



	<!-- Contact Section -->
	<section id="contact">
		<div class="container">
			<h2 class="text-center text-uppercase text-secondary mb-0">회원가입</h2>
			<hr class="star-dark mb-5">
			<div class="row">
				<div class="col-lg-10 mx-auto">
					<!-- To configure the contact form email address, go to mail/contact_me.php and update the email address in the PHP file on line 19. -->
					<!-- The form should work on most web servers, but if the form is not working you may need to configure your web server differently. -->
					<div style="text-align:right; color:#18BC9C;">
					*는 필수 입력값입니다.
					</div>
					<form name="joinInfo" action="/user/joinSave" method="POST" autocomplete="off">
						<div class="control-group">
							<div class="form-group floating-label-form-group controls mb-0 pb-2" >
								<a class="font_required">* 아이디</a>
								<p class="help-block text-danger"><p class="help-block text-danger">
								<span>&nbsp;&nbsp;&nbsp;&nbsp;<input class="form-control" id="userId" name="userId"	type="text" required="required" placeholder="첫글자는 영문대소자. 영문대소문자,숫자 모두 포함 최소 6자~최대 15자" 
								size="15" style="display:inline; border-radius: 8px;width:80%;background-color:#efefef" onkeyup="go2(this.value)">
								&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="userIdCheck" value="중복확인" style="background-color:#2c3e50; color:white;padding: 0.5rem;border-radius: 8px;"/></span>
								<br><span>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="welcome2" style="color:#cc0000;font-size:10pt;width:50%" disabled></span>
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div
								class="form-group floating-label-form-group controls mb-0 pb-2">
								<a class="font_required">* 비밀번호</a>
								<p class="help-block text-danger"><p class="help-block text-danger">
								&nbsp;&nbsp;&nbsp;&nbsp;<input class="form-control" id="pw1" name="pw1" type="password" placeholder="영문대소문자,숫자,특수문자 모두 포함 최소 8자~최대 20자" required="required"  
								style="display:inline; border-radius: 8px;width:80%;background-color:#efefef ">
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div class="form-group floating-label-form-group controls mb-0 pb-2">
								<a class="font_required">* 비밀번호 확인</a>
								<p class="help-block text-danger"></p>
								<p class="help-block text-danger">
								&nbsp;&nbsp;&nbsp;&nbsp;<input class="form-control" id="pw2" name = "pw2" type="password" placeholder="영문대소문자,숫자,특수문자 모두 포함 최소 8자~최대 20자" required="required"
								style="display:inline; border-radius: 8px;width:80%;background-color:#efefef " onkeyup="go(this.value)">
								<br><span>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="welcome" style="color:#cc0000;font-size:10pt;width:50%" disabled></span>
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div
								class="form-group floating-label-form-group controls mb-0 pb-2">
								<a class="font_required">* 이름</a>
								<p class="help-block text-danger"><p class="help-block text-danger">
								&nbsp;&nbsp;&nbsp;&nbsp;<input class="form-control" id="name" name="name" type="text" style="display:inline; border-radius: 8px;width:80%;background-color:#efefef " >								
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div
								class="form-group floating-label-form-group controls mb-0 pb-2">
								<a class="font_required">* 전화번호</a>
								<p class="help-block text-danger"></p><p class="help-block text-danger">
								&nbsp;&nbsp; &nbsp;&nbsp;<input type="tel" id="phone" name="phone" required="required" placeholder="- 없이 입력하세요" 
									style="display:inline; border-radius: 8px;width:80%;background-color:#efefef; padding: 0.5rem;"onkeyup="go3(this.value)"/>
									<br><span>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="welcome3" style="color:#cc0000;font-size:10pt;width:50%" disabled></span>
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div class="form-group floating-label-form-group controls mb-0 pb-2">
								<a class="font_required" style="color: #2c3e50;">이메일</a>
								<p class="help-block text-danger"></p>
								&nbsp;&nbsp; &nbsp;&nbsp;<input class="form-control" id="email" name="email" type="email" data-validation-required-message="Please enter your email address." style="display:inline; border-radius: 8px;width:80%;background-color:#efefef ">
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div class="form-group">
								<div class="" style="border-bottom: 1px solid #e9ecef;">
									<a class="fontsize">* 성별</a>   
									<p class="help-block text-danger"></p>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<label class="checkcontainer" style="margin-bottom: 0px;opacity: inherit;margin-right:3%">남성
									   <input class="radio" id="sex" type="radio" name="sex"  value="남성" checked="checked" >
									   <span class="radiobtn"></span>
									</label>
									<label class="checkcontainer" style="margin-bottom: 0px;opacity: inherit;">여성
                                       <input class="radio" type="radio" id="sex2" name="sex" value="여성" />
                                       <span class="radiobtn"></span>
                                    </label>
									
										
									<p class="help-block text-danger"></p>
							     </div>
							</div>
						</div>
                        <div class="control-group">
                            <div
                                class="form-group floating-label-form-group controls mb-0 pb-2">
                                <a class="font_required" style="color: #2c3e50;">우편번호</a>
                                <p class="help-block text-danger"><p class="help-block text-danger">
                                &nbsp;&nbsp;&nbsp;&nbsp;<input class="form-control" id="postcode" name="postcode" placeholder="우편번호" type="text" style="height: 35px;margin-bottom: 3px;display:inline; border-radius: 8px;width:15%;background-color:white;border: 1px solid gray;" readonly> 
                              
                                <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" style="background-color: #2c3e50;color: white;border-radius: 8px;height: 35px;width: 130px;padding-left: 0;margin-bottom: 3px;"> <br>
                                &nbsp;&nbsp;&nbsp;&nbsp;<input class="form-control" type="text" id="address" name="address" placeholder="주소" style="margin-bottom: 3px;height: 35px;display:inline; border-radius: 8px;width:80%;background-color:white;border: 1px solid gray;" readonly> <br>
                                &nbsp;&nbsp;&nbsp;&nbsp;<input class="form-control" disabled="disabled" type="text" id="address2" name="address2" placeholder="상세주소" style="display:inline;border: 1px solid lightgray;height: 35px; border-radius: 8px;width:80%;background-color:#efefef ">                            
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
    
						<br>
						<div id="success"></div>
						<div class="form-group" style="text-align:right; margin-right: 10%;">
							<button class="btn btn-primary btn-x" onclick="location='/login'">취 소</button>
							&nbsp;&nbsp;&nbsp;<button class="btn btn-primary btn-x" id="joinInformation">가 입</button>							
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

 
    <!-- 우편번호 -->
    <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
	<script>
	    function execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var fullAddr = ''; // 최종 주소 변수
	                var extraAddr = ''; // 조합형 주소 변수
	
	                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    fullAddr = data.roadAddress;
	
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    fullAddr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	                if(data.userSelectedType === 'R'){
	                    //법정동명이 있을 경우 추가한다.
	                    if(data.bname !== ''){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있을 경우 추가한다.
	                    if(data.buildingName !== ''){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
	                document.getElementById('address').value = fullAddr;
	                $('#address2').attr('disabled', false);
	                
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById('address2').focus();
	            }
	        }).open();
	    }
	</script>
	    
    
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
