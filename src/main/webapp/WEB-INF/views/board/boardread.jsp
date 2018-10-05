<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%  // 인증된 세션이 없는경우, 해당페이지를 볼 수 없게 함.
    if (session.getAttribute("id")  == null) {
        response.sendRedirect("/login/logout");
    }
%>
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
			margin: 0 85%;     /* 가로로 중앙에 배치 */
			width: 20%;			
	    }
	    .button{
			background-color : #18bc9c;
			border : thick solid #18bc9c;
		 	border-radius : 5px 5px 5px 5px;
			padding : 1px; margin:1%;
	   		color:white;
		}
		.color{
			background-color: #f2f2f2;
		}
		.hr{
   			margin-top: 0.5rem;
 			margin-bottom: 0.5rem;
		}
		.container_c{
			background-color:#f7f7f7;
			padding-right: 15px;
			padding-left: 15px;
			margin-right: auto;
			margin-left: auto;
		}
		.container_d{
			background-color:#f7f7f7;
			margin-right: auto;
			margin-left: auto;
			line-height:70px;
			width: 100%;
		}
		#comment1{
     		background-color : white;
      		border : ridge solid #FFEAEA;
       		border-radius : 5px 5px 5px 5px;
       		padding : 4px;
       		margin:7;   
   		}

  </style>
<jsp:include page="../login/navigation.jsp" flush="true"/>

</head>
<body>
	
	
	<div class="container_t">
		<h3 style="color:#2c3e50;">게시글</h3>
		<br>
		<span style="float:right; margin-right:2%; font-weight:bold"><a href='/board/boardlist'>목록</a></span>
		<br><br>
		
		<form method="POST" action="/board/boardchange?intBoardNo=${board.intBoardNo}">
		<table class="table" style="text-align:center">
			<tr>
				<td class="color">제목</td>
				<td colspan="50">${board.strBoardTitle}</td>
			</tr>

			<tr>
				<td class="color">작성자</td>
				<td>${board.strUserId}</td>
				<td class="color">작성일</td>
				<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.dateBoardDate}"/></td>				
				<td class="color">조회수</td>
				<td>${board.intHit}</td>				
			<tr height="250" >
				<td class="color">글내용</td>
				<td colspan="50" style="text-align:left; padding-left:3%; word-break:break-all;" >${board.strBoardContent}</td>	
			</tr>
		</table>
		<c:if test="${id eq board.strUserId}">

		<div class="container_b">
			<button class="button" type="submit">수정하기</button>
			<button class="button" >삭제하기</button>			
		</div>
		</c:if>
		</form>
	</div>
	<div class="container_t">		
		<form method="POST" action="/board/commentsave?intBoardNo=${board.intBoardNo}">
		<a style="font-weight:bold; color:#2c3e50;">댓글</a>
		<br>
		<div class="container_c" >
		<hr class="hr">			
		<c:forEach var="comment" items="${commentlist}">
			<a style="color:#2C3E50; font-size: large; font-weight:bold">${comment.strUserId} &nbsp;&nbsp;&nbsp;</a>
			<a style="font-size:small;color:gray;"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${comment.dateCmmtDate}"/></a>
			<div style="text-align:right;">	
			<c:if test="${id eq comment.strUserId}">
				<span style="float:right; margin-right:2%; font-weight:bold"><a href=''>삭제</a></span>
				<span style="float:right; margin-right:2%; font-weight:bold"><a href='/boardcommentchange?intCmmtNo=${comment.intCmmtNo}'>수정</a></span>
			</c:if>
			</div>
			&nbsp;&nbsp;&nbsp;&nbsp;${comment.strCmmtComment}
			<hr class="hr">
		</c:forEach>
		<table class="container_d" >
			<colgroup>
     		<col width = "*"/>
    		<col width = "10%"/>
    		</colgroup>
			<tr align="center" >
				<td><textarea class="form-control" name="comment" rows="3" required autofocus ></textarea>
   				<td><input type="submit" style="width: 75pt; height: 60pt; boarder-color:#ededed;outline:0;background-color:#ededed" value="등록">
   			</tr>
		
		</table>
		<br>
		</div>
		</form>
	
	</div>
	<br><br>
	<jsp:include page="../bottom.jsp" flush="true"/>
</body>

</html>