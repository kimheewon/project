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
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
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
		background-color: #18bc9c;
		border: thick solid #18bc9c;
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
			style="float: right; margin-right: 2%; font-weight: bold"><a
			href='/board/boardlist'>목록</a></span> <br>
		<br>

		<form method="POST"
			action="/board/boardchange?intBoardNo=${board.intBoardNo}">
			<input type="hidden" id="bno" value="${board.intBoardNo}">
			<table class="table" style="text-align: center">
				<tr>
					<td class="color">제목</td>
					<td colspan="50">${board.strBoardTitle}</td>
				</tr>

				<tr>
					<td class="color">작성자</td>
					<td>${board.strUserId}</td>
					<td class="color">작성일</td>
					<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
							value="${board.dateBoardDate}" /></td>
					<td class="color">조회수</td>
					<td>${board.intHit}</td>
				<tr height="250">
					<td class="color">글내용</td>
					<td colspan="50" style="text-align: left; padding-left: 3%;">${board.strBoardContent}</td>
				</tr>
			</table>
			<c:if test="${id eq board.strUserId}">
				<div class="container_b">
					<button class="button" type="submit">수정하기</button>
					<input type="button" class="button"
						onclick="location.href='/board/boardDelete?intBoardNo=${board.intBoardNo}'"
						value="삭제하기">
				</div>
			</c:if>
		</form>
	</div>
	<div class="container_t">
		<form method="POST"
			action="/board/commentsave?intBoardNo=${board.intBoardNo}"
			id="comment">
			<a style="font-weight: bold; color: #2c3e50;">댓글</a> <br>
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
							<span style="float: right; margin-right: 2%; font-weight: bold"><a
								href="/board/commentDelete?intCmmtNo=${comment.intCmmtNo}&intBoardNo=${board.intBoardNo}">삭제</a></span>
							<span style="float: right; margin-right: 2%; font-weight: bold"><a
								href="javascript:updateComment(${comment.intCmmtNo});">수정</a></span>
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
								name="comment" rows="3" required></textarea>
						<td><input type="submit"
							style="width: 75pt; height: 60pt; boarder-color: #ededed; outline: 0; background-color: #ededed"
							value="등록">
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
        html += "<td><textarea rows='1' class='form-control contentAll' id='commentContent'>"+document.getElementById(cId).innerHTML+"</textarea></td>";
        html += "<td><span class='btn btn-sm btn-default updBtn' style='float:right; padding:1%; font-size:16px; font-weight:bold'><a href='javascript:commentUpd("+ intCmmtNo +");'>수정</a></span></td>";
        html += "<td><span class='btn btn-sm btn-default updBtn' style='float:right; padding:1%; font-size:16px; font-weight:bold'><a href='javascript:commentReset("+ intCmmtNo +");'>취소</a></span></td>";
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
		 
		 var commnet
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
				
</script>
</html>