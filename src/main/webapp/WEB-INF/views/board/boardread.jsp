<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<title>BoardRead</title>
	<style>
  		.session{
			background : #18bc9c;
			padding-top:calc(3rem + 55px);
			font-size:18px;
			line-height:1.6;
			font-family: Tahoma,Arial,sans-serif;
	 	}	
	    .container_t {	    
			padding-right: 15px;
			padding-left: 15px;
			margin-right: auto;
			margin-left: auto;
			width: 70%;
			margin: 0 auto;     /* 가로로 중앙에 배치 */
			padding-top: 3%;   /* 테두리와 내용 사이의 패딩 여백 */
	    }

 		.container_b {	    
			margin: 0 85% 15%;     /* 가로로 중앙에 배치 */
			width: 20%;			
	    }
	    .button{
			background-color : #18bc9c;
			border : thick solid #18bc9c;
		 	border-radius : 5px 5px 5px 5px;
			padding : 1px; margin:1%;
	   		color:white;
			margin-left:50%;
		}
		.color{
			background-color: #f2f2f2;
		}

  </style>
<jsp:include page="../login/navigation.jsp" flush="true"/>

</head>
<body>
	
	<header class="session text-white text-right">
		<div class="container">
			<%= session.getAttribute("userid") %>님 <small>반갑습니다.</small>
		</div>
	</header>
	
	<div class="container_t">
		<h3 style="color:#212529;">게시글</h3>
		<br>
		<span style="float:right; margin-right:2%; font-weight:bold"><a href='boardlist'>목록</a></span>
		<br><br>
		
		<form method="POST" action="boardchange?bno=${board.bno}">
		<table class="table" style="text-align:center">
			<tr>
				<td class="color">제목</td>
				<td colspan="50">${board.title}</td>
			</tr>

			<tr>
				<td class="color">작성자</td>
				<td>${board.uid}</td>
				<td class="color">작성일</td>
				<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.date}"/></td>				
				<td class="color">조회수</td>
				<td>${board.hit}</td>				
				<tr height="250" >
				<td class="color">글내용</td>
				<td colspan="50" style="text-align:left; padding-left:3%" >${board.cnt}</td>	
			</tr>
		</table>
		<div class="container_b">
			<button class="button" type="submit">수정하기</button>
		</div>
		</form>
	</div>
	<jsp:include page="../bottom.jsp" flush="true"/>
</body>

</html>