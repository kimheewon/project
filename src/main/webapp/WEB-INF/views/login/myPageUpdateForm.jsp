<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%  // 인증된 세션이 없는경우, 해당페이지를 볼 수 없게 함.
    if (session.getAttribute("id")  == null) {
        response.sendRedirect("/login/logout");
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyPage Update</title>
<script src="/js/jquery-1.12.3.min.js"></script>
<script src="/js/jquery-ui.min.js"></script>
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
		
		
		
		//빈값 확인
		$("#joinInformation").on("click",function(){
			var str = document.joinInfo;

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
	       	if(str.pw2.value == str.pw1.value){	//비밀번호 유효성 검사
	      		var pw = str.pw1.value;
				var reg_pw ="^(?=.*\\d)(?=.*[~`!@#$%\\^&*()-])(?=.*[a-z])(?=.*[A-Z]).{8,20}$";

				if(!pw.match(reg_pw)) {
					alert("8~20자 영문 대 소문자, 숫자, 특수문자를 사용하세요."); 
	      		    document.joinInfo.pw1.value="";
	      			document.joinInfo.pw2.value="";
	      		    return false; 
	      		}
	      	}else{
	      		alert("비밀번호가 일치하지 않습니다."); 
      		    document.joinInfo.pw1.value="";
      			document.joinInfo.pw2.value="";
      			document.joinInfo.pw1.focus();
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
	function go(val){
		var pw1 = document.joinInfo.pw1.value;
		var pw2 = document.joinInfo.pw2.value;
		
		if(pw1 != pw2){			
			document.getElementById("welcome").value = '비밀번호가 일치하지않습니다.';
		}
		else{
			document.getElementById("welcome").value = '비밀번호가 일치합니다.';
		}
		
	}
	
	
	
</script>
</head>
<body>
	<jsp:include page="navigation.jsp" flush="true"/>
	
	<!-- Contact Section -->
	<section id="contact">
		<div class="container">
			<h2 class="text-center text-uppercase text-secondary mb-0">정보 수정</h2>
			<hr class="star-dark mb-5">
			<div class="row">
				<div class="col-lg-10 mx-auto">
					<!-- To configure the contact form email address, go to mail/contact_me.php and update the email address in the PHP file on line 19. -->
					<!-- The form should work on most web servers, but if the form is not working you may need to configure your web server differently. -->
					<div style="text-align:right; color:#18BC9C;">
					*는 필수 입력값입니다.
					</div>
					<form name="joinInfo" action="/login/myPageUpdate" method="POST" autocomplete="off">
						<div class="control-group">
							<div class="form-group floating-label-form-group controls mb-0 pb-2" >
								<a class="font_required">아이디</a>
								<a style="color:#2C3E50; font-size:18px; font-weight:bold; padding-left:2em">${member.strUserid}</a>
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
							<div
								class="form-group floating-label-form-group controls mb-0 pb-2">
								<a class="font_required">* 비밀번호 확인</a>
								<p class="help-block text-danger"></p>
								&nbsp;&nbsp; &nbsp;&nbsp;<input class="form-control" id="pw2" name = "pw2" type="password" placeholder="영문대소문자,숫자,특수문자 모두 포함 최소 8자~최대 20자" required="required" 
								style="display:inline; border-radius: 8px;width:80%;background-color:#efefef "  onkeyup="go(this.value)">
								<br><span>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="welcome" style="color:#cc0000;font-size:10pt;width:50%" disabled></span>
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div
								class="form-group floating-label-form-group controls mb-0 pb-2">
								<a class="font_required">* 이름</a>
								<p class="help-block text-danger">
								&nbsp;&nbsp; &nbsp;&nbsp;<input class="form-control" id="name" name="name" type="text" required="required" value="${member.strUserName}" style="display:inline; border-radius: 8px;width:80%;background-color:#efefef ">
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div
								class="form-group floating-label-form-group controls mb-0 pb-2">
								<a class="font_required">* 전화번호</a>
								<p class="help-block text-danger"></p>
								&nbsp;&nbsp; &nbsp;&nbsp;
								<input type="tel" id="phone" name="phone" size="20" required="required" placeholder="- 없이 입력하세요" value="${member.strUserPhone}" style="display:inline; border-radius: 8px;width:80%;background-color:#efefef;padding: 0.5rem;"/>
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div
								class="form-group floating-label-form-group controls mb-0 pb-2">
								<a class="font_required">이메일</a><p class="help-block text-danger"></p>
								&nbsp;&nbsp; &nbsp;&nbsp;<input class="form-control" id="email" name="email" type="email" data-validation-required-message="Please enter your email address." value="${member.strUserEmail}" style="display:inline; border-radius: 8px;width:80%;background-color:#efefef ">
								<p class="help-block text-danger"></p>
							</div>
						</div>						
						<div class="control-group">
                            <div
                                class="form-group floating-label-form-group controls mb-0 pb-2">
                                <a class="font_required">* 우편번호</a>
                                <p class="help-block text-danger"><p class="help-block text-danger">
                                &nbsp;&nbsp;&nbsp;&nbsp;<input class="form-control" id="postcode" name="postcode" placeholder="우편번호" type="text" style="display:inline; border-radius: 8px;width:15%;background-color:white;border: 1px solid gray;" value="${member.strPostCode}" readonly> 
                              
                                <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" style="background-color:#2c3e50; color:white;padding: 0.5rem;border-radius: 8px;"> <br>
                                &nbsp;&nbsp;&nbsp;&nbsp;<input class="form-control" type="text" id="address" name="address" placeholder="주소" style="display:inline; border-radius: 8px;width:80%;background-color:white;border: 1px solid gray;" readonly  value="${member.strAdress}"> <br>
                                &nbsp;&nbsp;&nbsp;&nbsp;<input class="form-control" type="text" id="address2" name="address2" placeholder="상세주소" style="display:inline; border-radius: 8px;width:80%;background-color:#efefef " value="${member.strAdress2}">                            
                                <p class="help-block text-danger"></p>
                            </div>
                        </div>
						
						<br>
						<div id="success"></div>
						<div class="form-group" style="text-align:right;">
							<button class="btn btn-primary btn-x" onclick="location.href='/login/myPageForm'">취 소</button>
							&nbsp;&nbsp;<button class="btn btn-primary btn-x" id="joinInformation">수 정</button>
						</div>
					</form>
						
				</div>
			</div>
		</div>
	</section>

	
	
	
    <!-- Footer -->
    <footer>
 		<jsp:include page="../bottom.jsp" flush="true"/>
    </footer>
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
    
                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById('address2').focus();
                }
            }).open();
        }
    </script>
        
    
</body>
</html>