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
<link type="text/css" rel="stylesheet" href="/css/itemShopStyle.css" />

<title>Item Shop List</title>
<script src="/js/jquery-1.12.3.min.js"></script>
<script src="/js/jquery-ui.min.js"></script>
<style>
.text-box {
position: absolute;
    height: 24px;
    text-align: center;
    width: 51px;
    /* margin: auto; */
    top: 25px;
    bottom: 0;
    right: 0;
    left: 255px;
    font-size: 13px;
    color: white;
    font-family: Bareun;
    /* float: right; */
    vertical-align: middle;
    background-color: #1c6ab0;
    /* padding-bottom: 0; */
    padding: 0.5%;
    border: 1px solid #12426e;
    border-radius: 4pt;
}

.img-fluid {
  display: block;
  max-width: 100%;
  height: 120px;
  margin: auto;
  padding: auto;
}


.blinking{
    -webkit-animation:blink 0.5s ease-in-out infinite alternate;
    -moz-animation:blink 0.5s ease-in-out infinite alternate;
    animation:blink 0.5s ease-in-out infinite alternate;
}
@-webkit-keyframes blink{
    0% {opacity:0;}
    100% {opacity:1;}
}
@-moz-keyframes blink{
    0% {opacity:0;}
    100% {opacity:1;}
}
@keyframes blink{
    0% {opacity:0;}
    100% {opacity:1;}
}


</style>
</head>

<body>
    <jsp:include page="../../login/navigation.jsp" flush="true"/>

    <c:if test="${!empty sessionScope.url}">
    <div style="position: relative;float: left;;margin-left: 50px;margin-top: 200px;">  
        <div id="right_section" style="position:absolute;top:0px;left:0px;background-color: #ececec;">  
           <div style="width: 200px;height: 285px;text-align: center;padding-top: 10px;">               
                <span style="font-family: Bareun;">최근 본 상품</span>
                <table style="margin: auto;background-color: white;margin-top: 7px;border: 1px solid #cecece;">
                    <tr>
                        <td style="border-bottom: 1px solid #cecece;"><img src="<%=session.getAttribute("url")%>" style="width: 166px;height: 124px;"></td>
                    </tr>
                    <tr>
                        <td style="text-align: left;padding-left: 12px;font-size: 8pt;padding-top: 4pt;font-family: candy;color: #696969;"><%=session.getAttribute("itemNumber")%></td>
                    </tr>
                    <tr>
                        <td style="font-family: Bareun;color: #2c3e50;font-size: 11pt;"><%=session.getAttribute("itemName")%></td>
                    </tr>
                    <tr style="border-bottom: 1px solid #cecece;">
                        <td style="color: #731d48;font-weight: bold;font-size: 12pt;text-align: right;padding-right: 10px;font-family: candy;"><fmt:formatNumber value='<%=session.getAttribute("price")%>' pattern="#,###" /> 코인</td>
                    </tr>
                    <tr>
                        <td><p id="pbtn"><button type="button" id="purchaseBtn" onclick="location.href='/ItemShop/ItemPurchaseForm?itemNo=<%=session.getAttribute("itemNumber")%>'">구매하기</button></p></td>
                    </tr>
                </table>
                
                
                         
           </div>  
        </div>  
    </div>  
    </c:if>
    <div class="container_t" style="min-height: 592px;">
    <h3 style="color:#2c3e50;margin-left: 1%;">아이템샵</h3>    
    <br><br>
    
    
    <div class="row">            
    <c:if test="${empty items}">
               <div style="text-align: center;margin: auto;font-size: 16pt;font-family: Bareun;word-spacing: 2px;letter-spacing: 1px;color: #4d4b51;">
                       <img src="/img/search2.png" style="margin-bottom: 9%;width: 200px;">
                       <br>
                       <span style="font-weight: bold;">' ${keyWord} '</span> 에 대해 검색된 상품이 없습니다.
                       <br>
                       <small style="font-size: 12pt;">다른 검색어를 입력하시거나 철자와 띄어쓰기를 확인해 보세요.</small><br> 
                       <small style="font-size: 12pt;"><a href="/ItemShop/ItemShopList" style="font-style: italic;color: #663399;text-decoration-line: underline;">아이템샵 바로가기</a></small> 
                    </div>  
                   
                </c:if>          
            <c:forEach var="items" items="${items}" varStatus="status">
                <div class="col-md-6 col-lg-3" style="    padding-top: 15px;   padding-bottom: 15px;">
                    <table style="  border: 1px solid #cecece;">
		                <tr style=" border: 1px solid #cecece">
			                <td>
			                     <img class="img-fluid" src="${items.strfileUrl}" style=" width: 300px; height: 200px;">
			                     <c:if test="${items.strdate eq today}">
			                         <div class='text-box'><p class="blinking">신제품</p></div>     
			                     </c:if>
			                </td>
			            </tr>
			            <tr>
		                    <td id="noStyle">${items.intItemNo}</td>
		                </tr>
		                <tr>
		                    <td id="nameStyle">${items.strItemName}</td>
		                </tr>
		                <tr>
		                    <td id="priceStyle"><fmt:formatNumber value="${items.intItemPrice}" pattern="#,###" /> 코인</td>
		                </tr>
		                <tr style="border: 1px solid #cecece;">
		                    <td><p id="pbtn"><button type="button" id="purchaseBtn" onclick="location.href='/ItemShop/ItemPurchaseForm?itemNo=${items.intItemNo}'">구매하기</button></p></td>
		 	            </tr>
                    </table>             
                </div>
            </c:forEach>
          
          
        </div>
      </div>

    
    <span style="float:right; font-weight:bold; width:5.5%;margin-right: 18%;">
      
    </span>
    <br>
        <div style='text-align: center; margin: 1px auto;'>
             <form action="/ItemShop/ItemShopList" name="search" method="post">
            
             <select name="keyField" id="keyField" size="1" style="width:110px;height: 30px;">
                    <option value="ItemNo" <c:if test="${'ItemNo'==keyField }"> selected</c:if>> 상품번호 </option>
                    <option value="ItemName" <c:if test="${'ItemName'==keyField }"> selected</c:if>> 상품명 </option>
                </select>
                     <input type="text" size="40" name="keyWord" id="keyWord" value="${keyWord}">                     
                     <button class="btn" id="btn" onclick="check();" 
                        style="background-color: #2c3e50;color:white;width: 70px;border: 1px solid #2c3e50;padding: 3px; padding-left: 0; font-family: 'Lato';    margin-bottom: 4px;" >
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

<br>
    

<br><br>
</body>
<jsp:include page="../../bottom.jsp" flush="true"/>
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
    	var keyword = document.search.keyWord.value;
    	var keyfield = $("#keyField option:selected").val();
    	
    	if(keyword == ""){
	        var f = document.frm;
	        f.method = "post"
	        f.action = "/ItemShop/ItemShopList?curPage="+curPage;
	        f.submit();        
    	}
    	else{
    		 var f = document.frm;
             f.method = "post"
             f.action = "/ItemShop/ItemShopList?curPage="+curPage+"&&keyField="+keyfield+"&&keyWord="+keyword;
             f.submit();   
    	}
    }
    
    $("document").ready(function() {  
    	  
        var currentPosition = parseInt($("#right_section").css("top"));  
      
        $(window).scroll(function() {  
                var position = $(window).scrollTop(); // 현재 스크롤바의 위치값을 반환합니다.  
                $("#right_section").stop().animate({"top":position+currentPosition+"px"},500);  
        });  
          
    });  


</script>
</html>