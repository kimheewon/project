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
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>

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
       <h3 style="color:#2c3e50;margin-left: 1%;">아이템샵</h3>
        
       
        <br><br>
        
        <div class="row">
            <c:forEach var="items" items="${items}" varStatus="status">
                <div class="col-md-6 col-lg-3" style="    padding-top: 15px;   padding-bottom: 15px;">
                    <table style="  border: 1px solid #cecece;">
		                <tr style=" border: 1px solid #cecece">
			                <td>
			                     <img class="img-fluid" src="/uploadFiles/${items.strfileName}" alt=""></td>
			            </tr>
			            <tr>
		                    <td>${items.intItemNo}</td>
		                </tr>
		                <tr>
		                    <td style="text-align: center;">${items.strItemName}</td>
		                </tr>
		                <tr style="float: right;">
		                    <td>${items.intItemPrice}</td>
		                </tr>
		                <tr  style="border: 1px solid #cecece;">
		                    <td>구매하기</td>
		 	            </tr>
                    </table>             
                </div>
            </c:forEach>
          
          
        </div>
      </div>

    
    <span style="float:right; font-weight:bold; width:5.5%;margin-right: 18%;">
      
    </span>
    <br>
        <div style='text-align: center; margin: 1px auto;margin-left: 20%;'>
             <form action="/board/boardlist?intBoardCateNo=${intBoardCateNo}" name="search" method="post">
            
             <select name="keyField" size="1" style="width:110px;height: 30px;">
                    <option value="UserId" <c:if test="${'UserId'==keyField }"> selected</c:if>> 아이디 </option>
                    <option value="BoardTitle" <c:if test="${'BoardTitle'==keyField }"> selected</c:if>> 제목 </option>
                    <option value="BoardContent" <c:if test="${'BoardContent'==keyField }"> selected</c:if>> 내용 </option>
                </select>
                     <input type="text" size="40" name="keyWord" value="${keyWord}">
                     
                     <button class="btn" id="btn" onclick="check();" 
                        style="background-color: #2c3e50;color:white;  border: 1px solid #2c3e50;padding: 3px; padding-left: 0; width:6%; font-family: 'Lato';    margin-bottom: 4px;" >
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
        f.action = "/board/boardlist?curPage="+curPage+"&&intBoardCateNo="+${intBoardCateNo};
        f.submit();
        
       
    }


</script>
</html>