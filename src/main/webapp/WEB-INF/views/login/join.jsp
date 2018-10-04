<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<style type="text/css">
		.form{
			border: thick dashed #FF5D37;
			border-radius: 20px;
			margin:100px 400px;
			text-align: center;
			line-height:40px;
	 	}
	 	body {
            background-color: #FEF6F0;
        }
        #form_up{
        	border-bottom:3px solid #FF5D37; 
        	margin:10px 200px;
        }
        #button1{
        	text-align:center;
        	padding:5px;
        	background-color:#FFC000;
        	border:#FFC000;
        	border-radius: 5px;
        }
        #button2{
        	text-align:center;
        	padding:10px;
        	background-color:#FFC000;
        	border:#FFC000;
        	border-radius: 5px;
        	margin:10px 5px;
        }
	</style>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

	<form class="form" name="frm" action="./register.jsp" OnSubmit='return submitCheck()'>
		<h1 id="form_up">회원가입</h1>
		이름&nbsp;&nbsp;<input type="text" name="name" size="15"/><br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		아이디&nbsp;&nbsp;&nbsp;
		<input type="text" name="id" size="15"/>&nbsp;
		<input type="button" value="중복확인" id="button1" onclick="idCheck()"/> <br>
		패스워드&nbsp;&nbsp;<input type="password" name="passwd1" size="15"/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
		패스워드 확인&nbsp;<input type="password" name="passwd2" size="15" onblur="passNum()"/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;
		성별&nbsp;&nbsp;<input type="radio" name="gender" value="male" />남자&nbsp;&nbsp;
        <input type="radio" name="gender" value="female" />여자
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
        <input type="reset" value="취소" id="button2"/>&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="submit" value="등록" id="button2" >  
  
	</form>
</body>
</html>