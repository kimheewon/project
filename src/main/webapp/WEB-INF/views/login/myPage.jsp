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
<title>MyPage</title>
<style>


</style>
</head>
<body>
	<jsp:include page="navigation.jsp" flush="true"/>
	
	<!-- Contact Section -->
	<section id="contact">
		<div class="container">
			<h2 class="text-center text-uppercase text-secondary mb-0">마이페이지</h2>
			<hr class="star-dark mb-5">
			<div class="row">
				<div class="col-lg-10 mx-auto">
					<!-- To configure the contact form email address, go to mail/contact_me.php and update the email address in the PHP file on line 19. -->
					<!-- The form should work on most web servers, but if the form is not working you may need to configure your web server differently. -->
					<form name="joinInfo" action="/login/myPageUpdateForm" method="POST">
						<div class="control-group">
							<div class="form-group floating-label-form-group controls mb-0 pb-2" >
								<a class="font_required">아이디</a>
								<p class="help-block "></p>
								<a style="color:#2C3E50; font-size:25px; font-weight:bold; padding-left:7em">${member.strUserid}</a>
								<p class="help-block "></p>
							</div>
						</div>
						<div class="control-group">
							<div
								class="form-group floating-label-form-group controls mb-0 pb-2">
								<a class="font_required">비밀번호</a>
								<p class="help-block"></p>
								<a style="color:#2C3E50; font-size:25px; font-weight:bold; padding-left:7em">${member.strUserPw}</a>
								<p class="help-block "></p>
							</div>
						</div>						
						<div class="control-group">
							<div
								class="form-group floating-label-form-group controls mb-0 pb-2">
								<a class="font_required">이름</a>
								<p class="help-block "></p>
								<a style="color:#2C3E50; font-size:25px; font-weight:bold; padding-left:7em">${member.strUserName}</a>
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div
								class="form-group floating-label-form-group controls mb-0 pb-2">
								<a class="font_required">전화번호</a>
								<p class="help-block "></p>
								<a style="color:#2C3E50; font-size:25px; font-weight:bold; padding-left:7em">${member.strUserPhone}</a>
								<p class="help-block "></p>
							</div>
						</div>
						<div class="control-group">
							<div
								class="form-group floating-label-form-group controls mb-0 pb-2">
								<a class="font_required">이메일</a><p class="help-block "></p>
								<a style="color:#2C3E50; font-size:25px; font-weight:bold; padding-left:7em">${member.strUserEmail}</a>
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div class="form-group floating-label-form-group controls mb-0 pb-2">
								<a class="fontsize">성별</a><p class="help-block "></p>
								<a style="color:#2C3E50; font-size:25px; font-weight:bold; padding-left:7em">${member.strUserSex}</a>
								<p class="help-block text-danger"></p>
							</div>
						</div>						
						<div class="control-group">
							<div
								class="form-group floating-label-form-group controls mb-0 pb-2">
								<a class="fontsize">가입일</a>								
								<p class="help-block "></p>
								<a style="color:#2C3E50; font-size:25px; font-weight:bold; padding-left:7em"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${member.dateUserDate}"/></a>
								<p class="help-block text-danger"></p>
							</div>
						</div>
						<div class="control-group">
							<div
								class="form-group floating-label-form-group controls mb-0 pb-2">
								<a class="fontsize">등급</a>								
								<p class="help-block "></p>
								<a style="color:#2C3E50; font-size:25px; font-weight:bold; padding-left:7em">${member.strUserGrade}</a>
								<p class="help-block text-danger"></p>
							</div>
						</div>

						<br>
						<div id="success"></div>
						<div class="form-group" style="text-align:right;">
							<button class="btn btn-primary btn-xl" >수 정</button>
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
    
</body>
</html>