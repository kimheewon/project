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
		<h1 id="form_up">ȸ������</h1>
		�̸�&nbsp;&nbsp;<input type="text" name="name" size="15"/><br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		���̵�&nbsp;&nbsp;&nbsp;
		<input type="text" name="id" size="15"/>&nbsp;
		<input type="button" value="�ߺ�Ȯ��" id="button1" onclick="idCheck()"/> <br>
		�н�����&nbsp;&nbsp;<input type="password" name="passwd1" size="15"/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
		�н����� Ȯ��&nbsp;<input type="password" name="passwd2" size="15" onblur="passNum()"/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;
		����&nbsp;&nbsp;<input type="radio" name="gender" value="male" />����&nbsp;&nbsp;
        <input type="radio" name="gender" value="female" />����
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
        <input type="reset" value="���" id="button2"/>&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="submit" value="���" id="button2" >  
  
	</form>
</body>
</html>