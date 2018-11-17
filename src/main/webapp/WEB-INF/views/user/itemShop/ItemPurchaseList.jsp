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
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<title>아이템 구매 리스트</title>
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
 
 th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }
#cancelBtn{
    background-color: white;
    width: 34%;
    height: 21pt;
    font-size: 11pt;
    border-radius: 3pt;
    border: none;
    color: #2c3e50;
    font-family: Bareun;
    border: 1px solid #2c3e50;
}
#cancelBtn:hover{
    background: #f1f4f7;
    color: black;
    box-shadow: 0 2px #999;
    border: 2px solid #3a3e42;
    font-weight: bold;
}
#cancelBtn:active {
    background: #f1f4f7;
    color: black;
    box-shadow: 0 2px #666;
    border: 2px solid #3a3e42;
    font-weight: bold;
    transform: translateY(4px);
}
#shopBtn{
    background-color: #b13862;
    width: 34%;
    height: 21pt;
    font-size: 11pt;
    border-radius: 3pt;
    border: none;
    color: white;
    font-family: Bareun;
    margin-right: 4%;
}
#shopBtn:hover{
    background: #772642;
    color: white;
    box-shadow: 0 2px #999;
    font-weight: bold;
    border: 2px solid #3d1322;
}
#shopBtn:active {
    background-color: #772642;
    color: white;
    box-shadow: 0 2px #666;
    transform: translateY(4px);
}
</style>
<body>

    
<jsp:include page="../../login/navigation.jsp" flush="true"/>

<div class="container_t">
    <h3 style="color:#2c3e50;margin-left: 6%;">아이템 구매 내역</h3><br><br><br>
    <form action="/Cash/Purchase" method="post">
        <table style="margin-bottom: 1rem;width:100%;margin: auto;">
            <colgroup>
                <col width = "7%"/>
                <col width = "15%"/>
                <col width = "*"/>
                <col width = "15%"/>
                <col width = "18%"/> 
                <col width = "20%"/>                         
            </colgroup>
            <thead style="text-align: center;font-size: 20px;background-color: #f2f2e8;color: #2c3e50;font-family: TmonTium;">
                <tr>                        
                    <th style="padding-bottom: 1%;padding-top: 1%;">#</th>
                    <th style="padding-bottom: 1%;padding-top: 1%;">구매번호</th>
                    <th style="padding-bottom: 1%;padding-top: 1%;">아이템</th>
                    <th style="padding-bottom: 1%;padding-top: 1%;">캐&nbsp;&nbsp;시</th>
                    <th style="padding-bottom: 1%;padding-top: 1%;">거래일시</th>
                    <th style="padding-bottom: 1%;padding-top: 1%;"></th>
                </tr>
            </thead>
            <tbody style="text-align: center;font-size: 17px;font-family: Bareun;">
                <c:forEach var="item" items="${item}" varStatus="status">   
		            <tr>   
		                <td style="padding-top: 1%;padding-bottom: 1%;">${item.intNum}</td>
		                <td style="padding-top: 1%;padding-bottom: 1%;">${item.intNumber}</td>
		                <td style="padding-top: 1%;padding-bottom: 1%;color: #3e0321;font-weight: bold;">
		                  <c:choose>
		                      <c:when test="${item.strItemName eq '캐시 회수'}">
		                         <span data-toggle="tooltip" data-placement="bottom" data-original-title="${item.strReason}">${item.strItemName}</span>
		                      </c:when>
		                      <c:otherwise>
		                          <c:choose>
		                              <c:when test="${item.intFlag ne 0}">
		                                  <a href="/ItemShop/ItemPurchaseResult?PurchaseNo=${item.intNumber}" style="color: #b13862;;font-weight: bold;">
                                            <span style="color:#5a5a5a;font-weight: normal;">${item.intItemNo}&nbsp;&nbsp;</span>${item.strItemName}</a>
		                              </c:when>
		                              <c:otherwise>
		                                  <span style="font-weight: normal;font-style: italic;text-decoration: line-through;">
		                                  <span style="color:#5a5a5a;font-weight: normal;">${item.intItemNo}</span>&nbsp;&nbsp;${item.strItemName}</span>
		                              </c:otherwise>
		                          </c:choose>
		                      </c:otherwise>
		                  </c:choose>
		                 
		                </td>
		                <td style="padding-top: 1%;padding-bottom: 1%;"><fmt:formatNumber value="${item.intItemTotalPrice}" pattern="#,###" />&nbsp;코인</td>
                        <td style="padding-top: 1%;padding-bottom: 1%;">${item.strPurchaseDate}</td>
		                <td style="padding-top: 1%;padding-bottom: 1%;">
		                  <c:if test="${item.strItemName ne '캐시 회수'}">
		                      <c:choose>
			                      <c:when test="${item.intFlag ne 0}">
			                          <button id="shopBtn" type="button">배송 추적</button>
			                          <button id="cancelBtn" type="button" onclick="location.href='/ItemShop/ItemPurchaseCancelForm?PurchaseNo=${item.intNumber}'">구매 취소</button>
			                      </c:when>
			                      <c:otherwise>구매 취소</c:otherwise>
			                  </c:choose>
		                  </c:if>
		                </td>	
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
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script type="text/javascript">
function fn_paging(curPage) {
    var f = document.frm;
    f.method = "post"
    f.action = "/ItemShop/ItemPurchaseList?curPage="+curPage;
    f.submit();    
}
$(function () {
    $('[data-toggle="tooltip"]').tooltip()
})
</script>
</html>