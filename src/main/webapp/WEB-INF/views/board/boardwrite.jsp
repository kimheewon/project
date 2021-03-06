<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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


<script src="/js/jquery-1.12.3.min.js"></script>
<script src="/js/jquery-ui.min.js"></script>

<title>BoardWrite</title>
	<style>
  		.session{
			background : #18bc9c;
			padding-top:calc(3rem + 55px);
			font-size:18px;
			line-height:1.6;
			font-family: Tahoma,Arial,sans-serif;
	 	}	
	    .container_t {	    
			padding-right: 15px;
			padding-left: 15px;
			margin-right: auto;
			margin-left: auto;
			width: 70%;
			margin: 0 auto;     /* 가로로 중앙에 배치 */
			padding-top: 3%;   /* 테두리와 내용 사이의 패딩 여백 */
	    }

 		.container_b {	    
			margin: 0 85% 15%;     /* 가로로 중앙에 배치 */
			width: 20%;		
	    }

	    .button{
			background-color : #2c3e50;
			border : thick solid #2c3e50;
		 	border-radius : 5px 5px 5px 5px;
			padding : 1px; margin:1%;
	   		color:white;

		}

  </style>
<jsp:include page="../login/navigation.jsp" flush="true"/>
<!-- 스마트 에디터 -->
<script type="text/javascript" src="/smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
</head>
<body>
	
	<div class="container_t">
		<h3 style="color:#2c3e50;">게시글 작성</h3>
		<br>
		<span style="float:right; margin-right:2%; font-weight:bold"><a href='/board/boardlist?intBoardCateNo=${intBoardCateNo}' >목록</a></span>
		<br><br>
		<form method="POST" action="/board/boardsave?intBoardCateNo=${intBoardCateNo}" name="info" autocomplete="off">
		<table class="table">
			<tr>
				<td style="width: 10%; text-align: center; padding-top: 1.5%;font-weight: bold;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
				<td><input type="text" class="form-control" name="title" id="title" required="required" autofocus></td>
			</tr>
			<tr>
				<td colspan="2"><textarea rows="10" cols="50" class="form-control" style="width: 100%;"  name="contents" id="ir1" required="required"  autofocus></textarea></td>
			</tr>
		</table>
		<div class="container_b" style="text-align: right;  margin-left: 79.2%;">	
			<button class="button" type="reset" style="width: 80px; height: 35px;">다시작성</button>
			<button class="button" name="writebtn" id="writebtn" style="width: 80px; height: 35px;"><img class="btn-img" src="/img/check.png" style=" width: 34%;">&nbsp;저장</button>			
		</div>
		</form>
	</div>
	<jsp:include page="../bottom.jsp" flush="true"/>
</body>



<script type="text/javascript">
var oEditors = [];

// Editor Setting
nhn.husky.EZCreator.createInIFrame({
	oAppRef : oEditors,
    elPlaceHolder : "ir1", // 에디터를 적용할 textarea ID에 맞게 변경
    sSkinURI : "/smarteditor/SmartEditor2Skin.html", // Editor HTML파일 위치로 변경
    fCreator : "createSEditor2", // SE2BasicCreator.js 메소드명으로 변경하면 안된다.
    htParams : { // 툴바 사용 여부 (true/false)
        bUseToolbar : true, // 입력창 크기 조절바 사용 여부 (true/false)
        bUseVerticalResizer : true, // 모드 탭(Editor|HTML|TEXT) 사용 여부 (true/false)
        bUseModeChanger : true,// 전송버튼 클릭이벤트
        fOnBeforeUnload : function(){
        	
        }
    },
    fOnAppLoad : function(){
 
    }
});

window.onload = function(){
	var btn = document.getElementById("writebtn");
	btn.onclick = function(){
		submitContents(btn);	
			
	}
	
};
function submitContents(btn) {
    // 에디터의 내용이 textarea에 적용
    oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
  
		var str = document.info;
		var title = str.title;
		var content = document.getElementById("ir1");
		
		if(title.value == ""){
			alert("제목을 입력해 주세요");
			title.focus();
			return false;
		}
		if(content.value == ""){
			alert("내용을 입력해 주세요");
			return false;
		}
	
    try{
    	
    	btn.form.submit();
    	
    }catch(e){}
};


</script>
</html>