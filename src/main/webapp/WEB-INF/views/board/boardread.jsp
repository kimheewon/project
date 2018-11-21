<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%  // 인증된 세션이 없는경우, 해당페이지를 볼 수 없게 함.
    if (session.getAttribute("id")  == null) {
        response.sendRedirect("/login/logout");
    }
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>

<script src="/js/jquery-1.12.3.min.js"></script>
<script src="/js/jquery-ui.min.js"></script>
<title>BoardRead</title>
<style>
	.session {
		background: #18bc9c;
		padding-top: calc(3rem + 55px);
		font-size: 18px;
		line-height: 1.6;
		font-family: Tahoma, Arial, sans-serif;
	}
	
	.container_t {
		padding-right: 15px;
		padding-left: 15px;
		margin-right: auto;
		margin-left: auto;
		width: 70%;
		margin: 0 auto; /* 가로로 중앙에 배치 */
		padding-top: 3%; /* 테두리와 내용 사이의 패딩 여백 */
	}
	
	.container_b {
		margin: 0 85%; /* 가로로 중앙에 배치 */
		width: 20%;
	}
	
	.button {
		background-color: #2c3e50;
		border: thick solid #2c3e50;
		border-radius: 5px 5px 5px 5px;
		padding: 1px;
		margin: 1%;
		color: white;
	}
	
	.color {
		background-color: #f2f2f2;
	}
	
	.hr {
		margin-top: 0.5rem;
		margin-bottom: 0.5rem;
	}
	
	.container_c {
		background-color: #f7f7f7;
		padding-right: 15px;
		padding-left: 15px;
		margin-right: auto;
		margin-left: auto;
	}
	
	.container_d {
		background-color: #f7f7f7;
		margin-right: auto;
		margin-left: auto;
		line-height: 70px;
		width: 100%;
	}
	
	#comment1 {
		background-color: white;
		border: ridge solid #FFEAEA;
		border-radius: 5px 5px 5px 5px;
		padding: 4px;
		margin: 7;
	}
</style>

<jsp:include page="../login/navigation.jsp" flush="true" />

</head>
<body>


	<div class="container_t">
		<h3 style="color: #2c3e50;">게시글</h3>
		<br> <span
			style="float: right; margin-right: 2%; font-weight: bold">
			<a href='/board/boardlist?intBoardCateNo=${intBoardCateNo}'>목록</a></span> <br>
		<br>

	
		<form method="POST" action="/board/boardchange?intBoardNo=${board.intBoardNo}" autocomplete="off">
		<div style="border:1px solid #c1c1c1; padding : 1.5%">
			<input type="hidden" id="bno" value="${board.intBoardNo}">
			<table class="" style="text-align: center;  ">
				<tr style="    border-bottom: 1px dashed  #c1c1c1;">
					
					<td style="width: 40%;font-weight: bold;font-size: 20px;color: #2c3e50;text-align: left;padding-left: 3%;    padding-bottom: 1%;">${board.strBoardTitle}</td>
					<td style="width: 80%;  text-align: right;  font-size: 15px;  padding-right: 2%;    color: #7f7f7f; ">
					<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.dateBoardDate}" /></td>
				</tr>
				<tr>
					<c:choose>
						<c:when test="${board.strGrade eq '일반'}">
							<td style="width: 7%;text-align: left;padding-left: 3.1%;font-weight: bold;color: #4d4d4d;  font-size: 18px;  padding-top: 1%;"><img class="btn-img" src="/img/lego.png" style=" width: 7%; ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${board.strUserId}</td>
						</c:when>
						<c:otherwise>
							<td style="width: 7%;text-align: left;padding-left: 3.1%;font-weight: bold;color: #18bc9c;  font-size: 18px;  padding-top: 1%;"><img class="btn-img" src="/img/vip.png" style=" width: 7%; ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${board.strUserId}</td>
						</c:otherwise>
					</c:choose>
					<td style="width:25%; text-align:right;padding-right: 2%; border-bottom:hidden">조회수&nbsp;&nbsp;&nbsp;${board.intHit}</td>
				<tr height="250">					
					<td colspan="50" style="text-align: left; padding-left: 3%;  padding-bottom: 18%;  padding-top: 4%;">${board.strBoardContent}</td>
				</tr>
			</table>
		</div >
			<c:if test="${id eq board.strUserId}">
				<div class="container_b" style="margin-top: 1%; margin-left: 84.5%; ">
					<button type="button" class="button btn btn-md" style="width: 80px;" onclick="checkDelete(${board.intBoardNo})">
						<img class="btn-img" src="/img/delete.png" style="width: 40%;padding-bottom:5%">&nbsp;삭제</button>			
					<button class="button btn btn-md" type="submit" style=" width: 80px;">
						<img class="btn-img" src="/img/edit.png" style="width: 40%;">&nbsp;수정</button>
				</div>
			</c:if>
		</form>
	</div>
	
	<div class="container_t">
		<form method="POST"	action="/board/commentsave?intBoardNo=${board.intBoardNo}" id="comment">
			<a style="font-weight: bold; color: #2c3e50;">댓글&nbsp;&nbsp;${cmmlistCount}</a> <br>
			<div class="container_c">
				<hr class="hr">
				<c:forEach var="comment" items="${commentlist}">
					<a style="color: #2C3E50; font-size: large; font-weight: bold">${comment.strUserId}
						&nbsp;&nbsp;&nbsp;</a>
					<a style="font-size: small; color: gray;"><fmt:formatDate
							pattern="yyyy-MM-dd HH:mm" value="${comment.dateCmmtDate}" /></a>
					<div style="text-align: right;" class="beforeUpd"
						id="beforeUpd${comment.intCmmtNo}">
						<c:if test="${id eq comment.strUserId}">							
							<span style="float: right; margin-right: 2%; font-weight: bold; color:#2c3e50"><a style="color:#2c3e50;"
								href="javascript:updateComment(${comment.intCmmtNo});">수정</a></span>
							<span style="float: right; margin-right: 1%; font-weight: bold; color:#2c3e50" ><a style="color:#2c3e50;"
								href="/board/commentDelete?intCmmtNo=${comment.intCmmtNo}">삭제</a></span>
						</c:if>
					</div>
					<div>
						<p class="cContentAll" id="cContentAll${comment.intCmmtNo}">${comment.strCmmtComment}</p>
					</div>
					<div class='forUpd' id='forUpd${comment.intCmmtNo}'
						style='text-align: right;'></div>


					<hr class="hr">
				</c:forEach>
				<table class="container_d">
					<colgroup>
						<col width="*" />
						<col width="10%" />
					</colgroup>
					<tr align="center">
						<td><textarea class="form-control" id="commentContent"
								name="comment" rows="3" style="    resize: none;" required></textarea>
						<td><input type="submit"
							style="width: 75pt; height: 60pt; box-shadow:none; border:1px solid #c4c4c4; boarder-color: #ededed; outline: 0; background-color: white"
							value="등 록">
					</tr>

				</table>
				<br>
			</div>
		</form>

	</div>
	

	<br>
	<br>
	<jsp:include page="../bottom.jsp" flush="true" />

</body>
<script type="text/javascript">


(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

	ga('create', 'UA-23581568-13', 'auto');
	ga('send', 'pageview');

	//댓글 수정 폼으로 이동
	function updateComment(intCmmtNo){
		 //기존 바뀌었었던 버튼,textarea 원상복구
		 
		
        $(".updBtn").hide();
        $(".beforeUpd").show();
        $(".cContentAll").show();
        $(".contentAll").remove();
        
		
        var cId = "cContentAll" + intCmmtNo;

        var html = "";
        html += "<table class='container_d' >";
        html += "<colgroup>";
        html += "<col width = '*'/>";
        html += "<col width = '5%'/>";
        html += "<col width = '5%'/>";
        html += "</colgroup>";
        html += "<tr align='center' >";
        html += "<td><textarea rows='1' class='form-control contentAll' id='commentContent' required='required'>"+document.getElementById(cId).innerHTML+"</textarea></td>";       
        html += "<td><span class='btn btn-sm btn-default updBtn' style='float:right; padding:1%; font-size:16px; font-weight:bold'><a style='color:#2c3e50' href='javascript:commentReset("+ intCmmtNo +");'>취소</a></span></td>";
        html += "<td><span class='btn btn-sm btn-default updBtn' style='float:right; font-size:16px; font-weight:bold'><a style='color:#2c3e50' href='javascript:commentUpd("+ intCmmtNo +");'>수정</a></span></td>";
        html += "</tr>";
	
		html += "</table>";
        
      //  html += "<a class='btn btn-link updBtn' style='float:right; margin-right:2%; font-weight:bold' href='javascript:commentUpd("+ intCmmtNo +");'>수정</a>	";
      //댓글내용 textarea에 띄워주고 수정버튼 생성
      //	html += "<span class='btn btn-sm btn-default updBtn' style='float:right; margin-right:2%; font-weight:bold'><a href='javascript:commentUpd("+ intCmmtNo +");'>수정</a></span>";	
      //  html += "<textarea rows='1' cols='30' class='form-control contentAll' id='commentContent'>"+document.getElementById(cId).innerHTML+"</textarea>";
      //  html += "<input type='button' class='btn btn-link updBtn' onClick='commentUpd("+ intCmmtNo +")' value='수정' />   ";
        

        $("#forUpd"+intCmmtNo).html(html);                
        $("#beforeUpd"+intCmmtNo).hide(); //원래 수정삭제버튼 숨기기
        $("#cContentAll"+intCmmtNo).hide();
        
    }

	 //댓글 수정 - 수정
    function commentUpd(intCmmtNo){
		
		 var c = document.getElementById("commentContent");
			 if (c.value == ""){
				 alert("내용을 입력하세요.");
				 c.focus();
				 return false;
			 }
				
		 
		 
		 var commnet;
		 
    	$.ajax({
            type: "POST",
            async: false,
            url: "/board/commentUpdate",            
            dataType:"html",// JSON/html
            data:{
            	"intCmmtNo":intCmmtNo, "strCmmtContent":$("#commentContent").val()            	
            },
            error: function (request, status, error) {
                alert("Ajax Error - code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            },
            success: function () {
              //  alert("수정되었습니다.");
                location.href = "/board/boardread?intBoardNo=" + $("#bno").val();
            
              
            }
        })    
    }
	 
	 //수정 취소
	 function commentReset(intCmmtNo){
		 	$(".updBtn").hide();
	        $(".beforeUpd").show();
	        $(".cContentAll").show();
	        $(".contentAll").remove();
		 
	 }
	 
	
	 	
	//글 삭제 확인
	function checkDelete(bno){
		if((confirm("정말 삭제 하시겠습니까?") == true)){
			location.href="/board/boardDelete?intBoardNo="+bno;
		}
			
		else
			return;
		
	}
	


				
</script>
</html>