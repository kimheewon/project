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

<title>Cash Purchase</title>
<script src="/js/jquery-1.12.3.min.js"></script>
<script src="/js/jquery-ui.min.js"></script>

</head>
<style>
@font-face{font-family:'Bareun'; src:url('/font/BareunDotumOTF1.otf')}
@font-face{font-family:'candy'; src:url('/font/THE_candybar.ttf')}
@font-face{font-family:'TmonTium'; src:url('/font/TmonTium.ttf')}
.container_t {    
        padding-right: 15px;
        padding-left: 15px;
        margin-right: auto;
        margin-left: auto;
        width: 70%;
        margin: 0 auto;     /* 가로로 중앙에 배치 */
        padding-top: 3%;   /* 테두리와 내용 사이의 패딩 여백 */
    }
  #cashChoosStyle{  
        padding-top: 1%;
    font-size: 18px;
    padding-left: 2%;
}
 th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }
</style>
<body>

    
<jsp:include page="../../login/navigation.jsp" flush="true"/>

<div class="container_t">
    <h3 style="color:#2c3e50;margin-left: 6%;">캐시 내역</h3><br><br><br>
    <form action="/Cash/Purchase" method="post">
        <table style="margin-bottom: 1rem;width:100%;margin: auto;">
            <colgroup>
                <col width = "5%"/>
                <col width = "20%"/>
                <col width = "*"/>
                <col width = "15%"/>
                <col width = "15%"/> 
                <col width = "15%"/>
                <col width = "15%"/>                           
            </colgroup>
            <thead style="text-align: center;font-size: 20px;background-color: #f2f2e8;color: #2c3e50;font-family: TmonTium;">
                <tr>                        
                    <th style="padding-bottom: 1%;padding-top: 1%;">#</th>
                    <th style="padding-bottom: 1%;padding-top: 1%;">일&nbsp;&nbsp;시</th>
                    <th style="padding-bottom: 1%;padding-top: 1%;">번&nbsp;&nbsp;호</th>
                    <th style="padding-bottom: 1%;padding-top: 1%;">내&nbsp;&nbsp;역</th>
                    <th style="padding-bottom: 1%;padding-top: 1%;">금&nbsp;&nbsp;액</th>
                    <th style="padding-bottom: 1%;padding-top: 1%;">캐&nbsp;&nbsp;시</th>
                    <th style="padding-bottom: 1%;padding-top: 1%;">결제수단</th>
                </tr>
            </thead>
            <tbody style="text-align: center;font-size: 17px;font-family: Bareun;">
                <c:forEach var="cash" items="${cashList}" varStatus="status">   
		            <tr>   
		                <td style="padding-top: 1%;padding-bottom: 1%;">${cash.intNum}</td>
                        <td style="padding-top: 1%;padding-bottom: 1%;">${cash.transaction_date}</td>
		                <td style="padding-top: 1%;padding-bottom: 1%;">${cash.intCashNo}</td>
		                <td style="padding-top: 1%;padding-bottom: 1%;">${cash.strPurchaseState}</td>
		                <td style="padding-top: 1%;padding-bottom: 1%;"><fmt:formatNumber value="${cash.amount}" pattern="#,###" />&nbsp;원</td>
		                <td style="padding-top: 1%;padding-bottom: 1%;"><fmt:formatNumber value="${cash.intCashAmt}" pattern="#,###" />&nbsp;코인</td>
		                <td style="padding-top: 1%;padding-bottom: 1%;">${cash.strPurchasekind}</td>	
		            </tr>   
	            </c:forEach>
            </tbody>     
        </table>
        <br><br><br><br>
        
                 
    </form>
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
                <c:forEach var="pageNum" begin="${pagination.startPage}" end="${pagination.endPage}">
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
        <br><br><br><br>
</div>        
</body>
<jsp:include page="../../bottom.jsp" flush="true"/>
<script type="text/javascript">
function fn_paging(curPage) {
    var f = document.frm;
    f.method = "post"
    f.action = "/Cash/CashList?curPage="+curPage;
    f.submit();    
}
       
</script>
</html>