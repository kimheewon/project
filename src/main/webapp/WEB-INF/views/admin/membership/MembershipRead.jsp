<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%  // 인증된 세션이 없는경우, 해당페이지를 볼 수 없게 함.
    if (session.getAttribute("AdminId")  == null) {
        response.sendRedirect("/loginAdmin/logout");
    }
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <title>회원정보 상세보기 </title>

 <!-- Bootstrap -->
    <link href="/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- Datatables -->
    <link href="/vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="/vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="/vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="/vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="/vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="/build/css/custom.min.css" rel="stylesheet">
<script src="/js/jquery-1.12.3.min.js"></script>
<script src="/js/jquery-ui.min.js"></script>
<style>
@font-face{font-family:'Bareun'; src:url('/font/BareunDotumOTF1.otf')}
@font-face{font-family:'candy'; src:url('/font/THE_candybar.ttf')}
@font-face{font-family:'TmonTium'; src:url('/font/TmonTium.ttf')}

#btnTop{
    background-color: white;
    color: #2c3e50;
    font-family: Bareun;
    border: 1px solid #415b76;
}

#btnTop:hover{
    background-color: #2c3e50;
    color: white;
    box-shadow: 0 2px #999;
    border: 1px solid #415b76;
}
#btnTop:active {
    background-color: #2c3e50;
    color: white;
    box-shadow: 0 2px #666;
    transform: translateY(4px);
    
}
#accountBtn{
    padding: 0px;
    margin: 0;
    padding-bottom: 25px;
    border: none;
    background-color: white;
    min-width: 32px;
    height: 22px;
    vertical-align: middle;
    font-size: 17px;
}
#purchaseTop{
    background-color: white;
    color: #772642;
    font-family: Bareun;
    border: 1px solid #d11d53;
}
#purchaseTop:hover{
 background: #772642;
    color: white;
    box-shadow: 0 2px #999;

    font-weight: bold;
}
#purchaseTop:active {
 background: #772642;
    color: white;
    box-shadow: 0 2px #999;

    font-weight: bold;
    transform: translateY(4px);
}
#recallTop{
    background-color: white;
    color: #003b00;
    font-family: Bareun;
    border: 1px solid #007600;
}
#recallTop:hover{
    background: #003b00;
    color: white;
    box-shadow: 0 2px #999;
    
    font-weight: bold;
}
#recallTop:active {
    background: #003b00;
    color: white;
    box-shadow: 0 2px #999;

    font-weight: bold;
    transform: translateY(4px);
}
</style>
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
		<jsp:include page="../navigationAdmin.jsp" flush="true"/>

        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3></h3>
              </div>

              <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    
                  </div>
                </div>
              </div>
            </div>
          
            <div class="row">              
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                  <h2 style="font-family: Bareun;font-weight: bold;">회원정보 상세보기</h2>           
                    <div style="float:right">
	                    <button class="btn btn-primary" type="button" id="btnTop" onclick="location.href='/AdminCash/AdminCashList?userNo=${intUserNo}'">캐시 충전 내역</button>
	                    <button class="btn btn-primary" type="button" id="btnTop" onclick="location.href='/Product/MemberPurchaseList?userNo=${intUserNo}'">아이템 구매 내역</button>
	                    <button class="btn btn-primary" type="button" id="purchaseTop" onclick="location.href='/AdminCash/AdminCashPaymentForm?userNo=${intUserNo}'">캐시 지급</button>
	                    <button class="btn btn-primary" type="button" id="recallTop" onclick="location.href='/AdminCash/AdminCashRecallForm?userNo=${intUserNo}'">캐시 회수</button>     
                    </div>
                    <div class="clearfix"></div>
                  </div>
                   <div class="x_content">
                    <br/>
                    <form id="enrollInfo" style="font-size: 15px;"name="enrollInfo" style="width: 80%;margin: auto;" data-parsley-validate class="form-horizontal form-label-left" action="/Membership/MembershipUpdateForm?intUserNo=${intUserNo}" method="POST">
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="id" style="font-size: 15px; color: #00003f;">아이디
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12" >
                            <span class="input-group-btn"><input type="text" class="form-control" id="id" name="id" style="background-color: white;border: none; box-shadow: none;" value="${member.strUserId}" readonly>
                           </span>
                       </div>
                      </div>                                        
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="name" style="font-size: 15px; color: #00003f;">이름 
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input id="name" readonly class="form-control col-md-7 col-xs-12" style="font-size: 15px;background-color: white;border: none; box-shadow: none;" type="text" name="name"value="${member.strUserName}">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="phone" style="font-size: 15px; color: #00003f;">전화번호 
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input id="phone" readonly class="form-control col-md-7 col-xs-12" style="font-size: 15px;background-color: white;border: none; box-shadow: none;" type="tel" name="phone"value="${member.strUserPhone}">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="email" style="font-size: 15px; color: #00003f;">이메일 
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input id="email" readonly class="form-control col-md-7 col-xs-12" style="font-size: 15px;background-color: white;border: none; box-shadow: none;" type="email" name="email"value="${member.strUserEmail}">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="sex" style="font-size: 15px; color: #00003f;">성별
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input id="sex" readonly class="form-control col-md-7 col-xs-12" style="font-size: 15px;background-color: white;border: none; box-shadow: none;" type="text" name="sex" value="${member.strUserSex}">
                        </div>
                      </div>                     
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="date" style="font-size: 15px; color: #00003f;">가입일시
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                        <a class="form-control col-md-7 col-xs-12" style="font-size: 15px;background-color: white;border: none; box-shadow: none;"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${member.dateUserDate}"/></a>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" style="font-size: 15px; color: #00003f;">등급 </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                                               
                        <input id="grade" readonly class="form-control col-md-7 col-xs-12" style="font-size: 15px;background-color: white;border: none; box-shadow: none;" type="text" name="grade" value="${member.strUserGrade} 회원">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" style="font-size: 15px; color: #00003f;">주소</label>
                        <div class="col-md-6 col-sm-6 col-xs-12">                                               
                        <c:choose>
                            <c:when test ="${! empty member.strPostCode}">
                                <input id="adress" readonly class="form-control col-md-7 col-xs-12" style="background-color: white;border: none; box-shadow: none;font-size: 15px;" type="text" name="adress" value="(${member.strPostCode}) ${member.strAdress} ${member.strAdress2}">
                            </c:when>
                            <c:otherwise>
                                <input id="adress" readonly class="form-control col-md-7 col-xs-12" style="background-color: white;border: none; box-shadow: none;font-size: 15px;" type="text" name="adress" value="">                                
                            </c:otherwise>
                        </c:choose>                        
                        </div>
                      </div>
                       <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" style="font-size: 15px; color: #d11d53;">보유 캐시</label>
                        <div class="col-md-6 col-sm-6 col-xs-12" style="padding-top: 6px;padding-left: 20px;color: #d11d53;font-weight: bold;font-size: 15px;">                                               
                            <fmt:formatNumber value="${member.intTotalCashAmt}" pattern="#,###" />&nbsp;코인
                            <button class="" id="accountBtn" type="button" data-placement="top" data-toggle="tooltip" data-original-title="계좌 정보 보기" >                                                       
                                <i id="accountI" class="fa fa-sort-desc" style="color: #a55663;"></i>
                            </button>                       
                        </div>
                      </div>
                      <div class="form-group" id="accountDiv" hidden="">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" style="font-size: 13px;"></label>  
                        <div class="col-md-6 col-sm-6 col-xs-12" style="padding-top: 8px;padding-left: 20px;font-weight: bold;">                                               
                        
                                       
                      <table style="width: 500px; height: 55px; border: 1px solid;text-align: center;">
                            <colgroup>
				                <col width = "33%"/>
				                <col width = "33%"/>
				                <col width = "*"/>                        
				            </colgroup>                            
                                <tr style="border-bottom: 2px solid;">
                                    <td style="border-right: 1px solid;">총 적립 캐시</td>
                                    <td style="border-right: 1px solid;">총 사용 캐시</td>
                                    <td style="border-right: 1px solid;">보유 캐시</td>
                                </tr>                            
                                <tr>
                                    <td style="text-align: right;border-right: 1px solid;padding-right: 13px;"><fmt:formatNumber value="${account.intTotalInCashAmt}" pattern="#,###" />&nbsp;코인</td>
                                    <td style="text-align: right;border-right: 1px solid;padding-right: 13px;"><fmt:formatNumber value="${account.intTotalOutCashAmt}" pattern="#,###" />&nbsp;코인</td>
                                    <td style="text-align: right;border-right: 1px solid;padding-right: 13px;"><fmt:formatNumber value="${account.intTotalCashAmt}" pattern="#,###" />&nbsp;코인</td>
                                </tr>
                        </table>
                        </div>
                        </div>
                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3" style="margin-left: 43%;">
                          <button class="btn btn-primary" style="font-family: Bareun;" type="button" onclick="location.href='/Membership/MembershipList'">목록</button>
                          <button type="submit" style="font-family: Bareun;" class="btn btn-success" id="adminEnroll">수정</button>
                        </div>
                      </div>                        
                    </form>
                  </div>
                </div>
              </div>


            </div>
          </div>
        </div>
        <!-- /page content -->

      
      </div>
    </div>
<jsp:include page="../bottomAdmin.jsp" flush="true"/>
    
<!-- bootstrap-progressbar -->
<script src="/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
<!-- iCheck -->
<script src="/vendors/iCheck/icheck.min.js"></script>
<!-- bootstrap-daterangepicker -->
<script src="/vendors/moment/min/moment.min.js"></script>
<script src="/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
<!-- bootstrap-wysiwyg -->
<script src="/vendors/bootstrap-wysiwyg/js/bootstrap-wysiwyg.min.js"></script>
<script src="/vendors/jquery.hotkeys/jquery.hotkeys.js"></script>
<script src="/vendors/google-code-prettify/src/prettify.js"></script>
<!-- jQuery Tags Input -->
<script src="/vendors/jquery.tagsinput/src/jquery.tagsinput.js"></script>
<!-- Switchery -->
<script src="/vendors/switchery/dist/switchery.min.js"></script>
<!-- Select2 -->
<script src="/vendors/select2/dist/js/select2.full.min.js"></script>
<!-- Parsley -->
<script src="/vendors/parsleyjs/dist/parsley.min.js"></script>
<!-- Autosize -->
<script src="/vendors/autosize/dist/autosize.min.js"></script>
<!-- jQuery autocomplete -->
<script src="/vendors/devbridge-autocomplete/dist/jquery.autocomplete.min.js"></script>
<!-- starrr -->
<script src="/vendors/starrr/dist/starrr.js"></script>
<!-- Custom Theme Scripts -->
<script src="/build/js/custom.min.js"></script>
<!-- Google Analytics -->
<script type="text/javascript" >
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-23581568-13', 'auto');
ga('send', 'pageview');

$("#accountBtn").click(function() {
	
	var check = $("#accountI").attr("class");
		
	if(check == "fa fa-sort-asc"){
		$("#accountDiv").fadeOut();
	    $("#accountI").prop("class","fa fa-sort-desc");		
	}
	else{
		$("#accountDiv").fadeIn();
	    $("#accountI").prop("class","fa fa-sort-asc");
	}
	
});

</script>
	
  </body>
</html>
