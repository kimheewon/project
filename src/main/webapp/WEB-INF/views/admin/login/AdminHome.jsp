<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
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
        <div class="right_col" role="main">
         

          <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
              <div class="dashboard_graph">

               

                

			
              </div>
            </div>
          </div>
        </div>
        <!-- /page content -->

        <jsp:include page="../bottomAdmin.jsp" flush="true"/>
      </div>
    </div>

   
  </body>
</html>
