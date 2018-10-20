<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%  // 인증된 세션이 없는경우, 해당페이지를 볼 수 없게 함.
    if (session.getAttribute("AdminId")  == null) {
        response.sendRedirect("/loginAdmin/logout");
    }
%>
<!DOCTYPE html>
<html lang="UTF-8">
  <body class="nav-md">
    <div class="container body">
      <div class="main_container">

<jsp:include page="../navigationAdmin.jsp" flush="true"/>
        <!-- page content -->
        <div class="right_col" role="main" style="min-height: 900px;">
        <!-- top tiles -->
          <div class="row tile_count" style="margin-bottom: 0px;">
            <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count" style="margin-left: 2%;margin-top:1%">
              <span class="count_top" ><i class="fa fa-user"></i> 오늘의 가입자 수</span>
              <div class="count green" style="margin-top:2%">${enrollCount}&nbsp;<small style="font-size: 20px;">명</small></div>
            </div>
            <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count" style="margin-top:1%">
              <span class="count_top" ><i class="fa fa-book"></i> 오늘의 게시물 수</span>
              <div class="count" style="margin-top:2%">${boardCount}&nbsp;<small style="font-size: 20px;">글</small></div>
            </div>
            
          </div>
          <!-- /top tiles -->
        
         <div class="">

            
		   <div class="clearfix"></div>
		   
          <div class="row">
            <div class="col-md-3 col-xs-12 widget widget_tally_box" style="margin-left: 1%;">
            
                <div class="x_panel fixed_height_500">
                  <div class="x_title">
                    <h2 style="font-weight:bold; color:#34495e">성별 가입률</h2>
  
                     <div class="clearfix"></div>
                  </div>
                  <div class="clearfix"></div>
                
                         <div class="x_content">

                            <div style="text-align: center; margin-top:20px; margin-bottom: 60px">
                              <ul class="verticle_bars list-inline" style="height: 200px;">
                                <li>
                                  <div class="progress vertical progress_wide bottom" style="width: 100%; height: 200px">
                                    <div class="progress-bar progress-bar-dark" role="progressbar" data-transitiongoal="${menP}">
                                    <div>${men}명</div>
                                    </div>
                                  	 
                                  </div>
                                </li>
                                <li style="width:10%">
                                <div ></div>
                                </li>
                                <li>
                                  <div class="progress vertical progress_wide bottom" style="width: 100%; height: 200px">
                                    <div class="progress-bar progress-bar-info" role="progressbar" data-transitiongoal="${womenP}">
                                    <div>${women}명</</div>
                                    </div>
                                  </div>
                                </li>
                                
                              </ul>
                            </div>
                            <div class="divider"></div>

                            <ul class="legend list-unstyled" >
                              <li style="margin-top: 15%;">
                                <p>
                                  <span class="icon" >
                                  <i class="fa fa-square dark" style="margin-top: 60%;"></i></span> <span class="name" style="font-size: 18px; font-weight: bold;color:#4f6f8f">남  성</span>
                                </p>
                              </li>
                              
                              <li style="margin-top: 8%;margin-bottom: 11%;">
                                <p>
                                  <span class="icon" >
                                  <i class="fa fa-square blue" style="margin-top: 60%;"></i></span> <span class="name" style="font-size: 18px; font-weight: bold; color:#4f6f8f">여  성</span>
                                </p>
                              </li>                              
                            </ul>
                          </div>
          				</div>
					</div>
					<div class="col-md-12 col-sm-12 col-xs-12" style="width:75%; margin-left: 20px;">
            			<div class="x_panel" >
	           				<div class="x_title">
                    			<h2 style="font-weight:bold; color:#34495e">게시글 Top 10</h2>	  
                    		 <div class="clearfix"></div>
                  			</div>
	             		<div class="clearfix"></div>
	             		<div class="x_content">
							<table class="table table-striped table-bordered" >
		                    <colgroup>
					    		<col width = "6%"/>
					    		<col width = "*"/>
					    		<col width = "12%"/>
					    		<col width = "15%"/>
					    		<col width = "7%"/>			    		
					    	</colgroup>
		                      <thead>
		                        <tr>
		                          <th style="text-align: center; color:#00003f; font-size: 15px;">#</th>
		                          <th style="text-align: center; color:#00003f; font-size: 15px;">제   목</th>
		                          <th style="text-align: center; color:#00003f; font-size: 15px;">작성자</th>
		                          <th style="text-align: center; color:#00003f; font-size: 15px;">작성일시</th>
		                          <th style="text-align: center; color:#00003f; font-size: 15px;">조회수</th>
		                        </tr>
		                      </thead>
		                      <tbody>
		                        <c:forEach var="list" items="${boardlist}" varStatus="status">
		
									<tr>
										<td style="text-align: center; color:#3b5976;font-size: 15px;">${status.count}</td>
										<td style="padding-left: 3%; color:#3b5976;font-size: 15px;">${list.strBoardTitle}
										<c:choose>
											<c:when test="${list.intNewCheck eq 1}">
												<img src="/img/new.png" alt="..." style="height: 20px;">
											</c:when>
										</c:choose>										
										</td>
										<td style="text-align: center; color:#3b5976;font-size: 15px;">${list.strUserId}</td>
										<td style="text-align: center; color:#3b5976;font-size: 15px;">${list.strBoardDate}</td>										
										<td style="text-align: center; color:#3b5976;font-size: 15px;">${list.intHit}</td>
									</tr>	
								</c:forEach>
		                      </tbody>
		                    </table>	
	           		 	</div>
	            	</div>
              	</div>
					
                </div>

                
              </div>
            </div>
            
            
            
          
          
          
            
            </div>
          </div>
      
        <!-- /page content -->
  
   
    <!-- Datatables -->
    <script src="/vendors/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="/vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <script src="/vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
    <script src="/vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
    <script src="/vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
    <script src="/vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
    <script src="/vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
    <script src="/vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
    <script src="/vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
    <script src="/vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
    <script src="/vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
    <script src="/vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
    <script src="/vendors/jszip/dist/jszip.min.js"></script>
    <script src="/vendors/pdfmake/build/pdfmake.min.js"></script>
    <script src="/vendors/pdfmake/build/vfs_fonts.js"></script>

    <!-- Custom Theme Scripts -->
    <script src="/build/js/custom.min.js"></script>
        <jsp:include page="../bottomAdmin.jsp" flush="true"/>

<script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-23581568-13', 'auto');
ga('send', 'pageview');

</script>
   
  </body>
</html>