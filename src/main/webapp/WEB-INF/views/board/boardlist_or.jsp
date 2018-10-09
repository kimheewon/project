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
<meta charset="EUC-KR">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<title>Board List</title>
<style>
	.container_t {
    
		padding-right: 15px;
		padding-left: 15px;
		margin-right: auto;
		margin-left: auto;
		width: 70%;
		margin: 0 auto;     /* 가로로 중앙에 배치 */
		padding-top: 3%;   /* 테두리와 내용 사이의 패딩 여백 */
    }


</style>

<jsp:include page="../login/navigation.jsp" flush="true"/>

</head>

<body>

	

    <div class="container_t">
    
  		<h3 style="color:#2c3e50">게시판</h3>
    	<span style="float:right; margin-right:6%; font-weight:bold">
  			<a href='/board/boardlist'>목록</a>
		</span>
		<br><br>
    	<table class="table table-hover">
    	<colgroup>
    		<col width = "10%"/>
    		<col width = "*"/>
    		<col width = "15%"/>
    		<col width = "15%"/>
    		<col width = "10%"/>
    	</colgroup>
		<tr>
			<td>번호</td>
			<td>글제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>조회수</td>
		</tr>
		
		<c:forEach var="board" items="${boardlist}">

			<tr>
				<td>${board.intBoardNo}</td>
				<td><a href="/board/boardread?intBoardNo=${board.intBoardNo}">${board.strBoardTitle}</a></td>
				<td>${board.strUserId}</td>
				<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.dateBoardDate}"/></td>
				<td><span>${board.intHit}</span></td>
				
			</tr>	
		</c:forEach>
		</table>
		<hr/>
	</div>

	
	<span style="float:right; margin-right:20%; font-weight:bold">
  		<a href='/board/boardwrite'>글쓰기</a>
	</span>
		
	<div class="container_t">
		<ul class="pagination justify-content-center">
			<li class="page-item"><a class="page-link" href="#">Previous</a></li>
			<li class="page-item"><a class="page-link" href="#">1</a></li>
			<li class="page-item"><a class="page-link" href="#">2</a></li>
			<li class="page-item"><a class="page-link" href="#">3</a></li>
			<li class="page-item"><a class="page-link" href="#">4</a></li>
			<li class="page-item"><a class="page-link" href="#">5</a></li>
			<li class="page-item"><a class="page-link" href="#">Next</a></li>		
		</ul>	
	</div>
<br>
	<div style='text-align: center; margin: 1px auto;'>
			 <form action="/board/boardSearch" name="search" method="post">
			 <a style="font-weight:bold; color:#2C3E50; font-size: larger;" >검색&nbsp;&nbsp;&nbsp;&nbsp;</a>
			 <select name="keyField" size="1" style="width:110px;height: 30px;">
	                <option value="UserId" <c:if test="${'UserId'==keyField }"> selected</c:if>> 아이디 </option>
	                <option value="BoardTitle" <c:if test="${'BoardTitle'==keyField }"> selected</c:if>> 제목 </option>
	                <option value="BoardContent" <c:if test="${'BoardContent'==keyField }"> selected</c:if>> 내용 </option>
	            </select>
	                 <input type="text" size="16" name="keyWord" value="${keyWord}">
	                 <input type="button" value="검색" onClick="check();">
	                 <input type="hidden" name="page" value="0">
	    
	   		</form>    	
	</div>

<br><br>

</body>
<jsp:include page="../bottom.jsp" flush="true"/>
<script type="text/javascript">
	function check() {
	    if (document.search.keyWord.value == "") {
	        alert("검색어를 입력하세요.");
	        document.search.keyWord.focus();
	        return;
	    }
	    document.search.submit();
	}

</script>
</html>