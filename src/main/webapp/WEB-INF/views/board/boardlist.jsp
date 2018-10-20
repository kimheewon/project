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

<script src="/js/jquery-1.12.3.min.js"></script>
<script src="/js/jquery-ui.min.js"></script>

</head>

<body>

	
<jsp:include page="../login/navigation.jsp" flush="true"/>

    <div class="container_t">
    
  		<h3 style="color:#2c3e50;margin-left: 1%;">게시판</h3>
  		
    	<span style="float:right; margin-right:4%; font-weight:bold;">    			
  			<a href='/board/boardlist' style="color:#18bc9c;">목록</a>
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
    	<thead>
		<tr>
			<th style="text-align: center;">#</th>
			<th style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</th>
			<th style="text-align: center;">작성자</th>
			<th style="text-align: center;">작성&nbsp;일시</th>
			<th style="text-align: center;">조회수</th>
		</tr>
		</thead>
		<c:forEach var="board" items="${boardlist}" varStatus="status">

			<tr>
				<td style="text-align: center; color:#3b5976;">${board.intBoardNo}</td>
				<c:choose>
					<c:when test="${board.inttotalComment eq 0}">
					<td style="padding-left: 2%; color:#3b5976;"><a href="/board/boardreadHit?intBoardNo=${board.intBoardNo}">${board.strBoardTitle}</a>
					<c:choose>
						<c:when test="${board.intNewCheck eq 1}">
							<img src="/img/new.png" alt="..." style="height: 20px;"class="img-circle profile_img">
						</c:when>
					</c:choose>
					</td>
				</c:when>
				<c:otherwise>
					<td style="padding-left: 2%; color:#3b5976;"><a href="/board/boardreadHit?intBoardNo=${board.intBoardNo}">${board.strBoardTitle}</a>&nbsp;&nbsp;[${board.inttotalComment}]
					<c:choose>
						<c:when test="${board.intNewCheck eq 1}">
							<img src="/img/new.png" alt="..." style="height: 20px;">
						</c:when>
					</c:choose>
					</td>
				</c:otherwise>
				</c:choose>
				<td style="text-align: center; color:#3b5976;">${board.strUserId}</td>
				<td style="text-align: center; color:#3b5976;">${board.strBoardDate}</td>
				<td style="text-align: center; color:#3b5976;"><span>${board.intHit}</span></td>
				
			</tr>	
		</c:forEach>
		</table>
		<hr/>
	</div>

	
	<span style="float:right; font-weight:bold; width:5.5%;margin-right: 18%;">
	<button class="btn" id="btn" onclick="location.href='/board/boardwrite'" style="background-color: white;color:#2c3e50; 
		border: 1px solid #2c3e50;padding: 3px; padding-left: 0;" >
	<img class="btn-img" src="/img/pen.png" style=" width: 30%;">&nbsp;글쓰기</button> 		
	</span>
	<br>
		<div style='text-align: center; margin: 1px auto;margin-left: 20%;'>
			 <form action="/board/boardlist" name="search" method="post">
			
			 <select name="keyField" size="1" style="width:110px;height: 30px;">
	                <option value="UserId" <c:if test="${'UserId'==keyField }"> selected</c:if>> 아이디 </option>
	                <option value="BoardTitle" <c:if test="${'BoardTitle'==keyField }"> selected</c:if>> 제목 </option>
	                <option value="BoardContent" <c:if test="${'BoardContent'==keyField }"> selected</c:if>> 내용 </option>
	            </select>
	                 <input type="text" size="40" name="keyWord" value="${keyWord}">
	                 
	                 <button class="btn" id="btn" onclick="check();" 
	                 	style="background-color: #2c3e50;color:white;  border: 1px solid #2c3e50;padding: 3px; padding-left: 0; width:5%; font-family: 'Lato';    margin-bottom: 4px;" >
	                 <img class="btn-img" src="/img/search.png" style=" width: 25%;font-weight:bold;margin-bottom: 4px;">&nbsp;검 색</button>
	                 <input type="hidden" name="page" value="0">
	    
	   		</form>    	
	</div>
	
	<!-- page -->
   <form name="frm">
        <div class="container_t">
 			<ul class="pagination justify-content-center">
                    <c:if test="${pagination.curRange ne 1 }">
                        <li class="page-item"><a class="page-link" href="#" style="color:#2c3e50;" onClick="fn_paging(1)">[처음]</a></li>
                    </c:if>
                    <c:if test="${pagination.curPage ne 1}">
                        <li class="page-item"><a href="#" class="page-link" style="color:#2c3e50;" onClick="fn_paging('${pagination.prevPage }')">[이전]</a></li>
                    </c:if>
                    <c:forEach var="pageNum" begin="${pagination.startPage }" end="${pagination.endPage }">
                        <c:choose>
                            <c:when test="${pageNum eq  pagination.curPage}">
                                <li class="page-item"><span style="font-weight: bold;"><a href="#" class="page-link"  style="color:#2c3e50;" onClick="fn_paging('${pageNum }')">${pageNum }</a></span></li> 
                            </c:when>
                            <c:otherwise>
                                <li class="page-item"><a href="#" class="page-link" style="color:#2c3e50;" onClick="fn_paging('${pageNum }')">${pageNum }</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${pagination.curPage ne pagination.pageCnt and pagination.pageCnt > 0}">
                        <li class="page-item"><a href="#" class="page-link"  style="color:#2c3e50;"onClick="fn_paging('${pagination.nextPage }')">[다음]</a></li> 
                    </c:if>
                    <c:if test="${pagination.curRange ne pagination.rangeCnt and pagination.rangeCnt > 0}">
                        <li class="page-item"><a href="#" class="page-link" style="color:#2c3e50;" onClick="fn_paging('${pagination.pageCnt }')">[끝]</a></li>
                    </c:if>
                    </ul>
         </div>
                
 </form>

<br>
	

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
	function fn_paging(curPage) {

        var f = document.frm;
        f.method = "post"
        f.action = "/board/boardlist?curPage="+curPage;
        f.submit();
        
       
    }


</script>
</html>