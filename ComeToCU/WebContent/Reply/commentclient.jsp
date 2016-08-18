<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<script type="text/javascript" src="/Reply/ajax.js"></script>
<script type="text/javascript">
	var GET_ID="<%=(String) session.getAttribute("Get_ID")%>"	
	var Get_Class="<%=(String) session.getAttribute("Get_Class")%>"
	
		//ajax 통신. WB_ID값을 가져와서 아래 경로로 보내줌
	function loadCommentList() {
		var WB_ID=document.addForm.WB_ID.value;
		var params="id=" + encodeURIComponent(WB_ID);
		new ajax.xhr.Request("/Reply/commentlist.jsp",params, loadCommentResult, 'GET');
	}
	function loadCommentResult(req) {
		//연결
		if (req.readyState == 4) {
			//성공시
			if (req.status == 200) {
				//json을 가져오는데 이게 아직도 뭔소린지 잘모르겠음
				var xmlDoc = req.responseXML;
				//code부분을 가져온다는 소리
				var code = xmlDoc.getElementsByTagName('code').item(0).firstChild.nodeValue;
				//가져온 코드가 success면
				if (code == 'success') {
					//eval부터 뒤에 childe 다 먼소린지 정확히 잘모르겠음.찾아서알려주면 고맙겠다
					var commentList = eval( "(" + xmlDoc.getElementsByTagName('data').item(0).firstChild.nodeValue+")" );
					//commentList라고 밑에 <Body>부분에 있는데 아마 여기에 쓰겠단 소리같음
					var listDiv = document.getElementById('commentList');
					//데이터 없을때까지 makeCommentView로 리플 만듦
					for (var i = 0 ; i < commentList.length ; i++) {
						var commentDiv = makeCommentView(commentList[i]);
						
						//추가한단 소리같음
						listDiv.appendChild(commentDiv);
					}
				} else if (code == 'error') {
					var message = xmlDoc.getElementsByTagName('message').item(0).firstChild.nodeValue;
					alert("에러 발생5:"+message);
				}
			} else {
				alert("댓글 목록 로딩 실패:"+req.status);
			}
		}
	} 
	 function makeCommentView(comment) {

	
		 //<div>
		var commentDiv = document.createElement('div');
		//<div id=c~
		commentDiv.setAttribute('id', 'c'+comment.id);
		//<div id=c~ ~~~~~~~이후 표현식

		if(GET_ID==comment.name||Get_Class==1){
			var html = 
					'<div class="visible-md visible-lg">'+
						'<div class="col-xs-8 text-center" style="font-size:15px;">'+comment.content.replace(/\n/g,'')+'</div>'+
						'<div class="col-xs-1 text-center" style="font-size:10px; font-weight: bold;">'+comment.name+'</div>'+
						'<div class="col-xs-2 text-center" style="color: gray; font-size: 10px; opacity: 0.7;">'+comment.time+'</div>'+
						'<div class="col-xs-1 text-center">'+
							'<button type="button" class="btn btn-default btn-sm" onclick="confirmDeletion('+comment.id+');">'+
								'<span class="glyphicon glyphicon-trash" aria-hidden="true">'+
								'</span>'+
							'</button>'+
						'</div>'+
					'</div>'+
					
					'<div class="row visible-sm visible-xs">'+
					'<div class="row">'+
					'<div class="col-xs-6 text-left" style="font-size:9px; font-weight: bold;">'+comment.name+'</div>'+
					'<div class="col-xs-6 text-right" style="color:gray; font-size:6px; opacity:0.7;">'+comment.time+'</div>'+
					'</div>'+
					
					'<div class="col-xs-10 text-left" style="font-size:15px;">-'+comment.content.replace(/\n/g,'')+'</div>'+
					'<div class="col-xs-2 text-right">'+
					'<button type="button" class="btn btn-default btn-sm" onclick="confirmDeletion('+comment.id+')">'+
					'<span class="glyphicon glyphicon-trash" aria-hidden="true">'+
					'</span>'+
					'</button>'+
					
					'</div>'+
					
					'<hr>'+
					'</div>';
					
		}else{
			var html = 
					'<div class="row visible-md visible-lg">'+
					'<div class="col-xs-6 text-center" style="font-size:15px;">'+comment.content.replace(/\n/g,'')+'</div>'+
					'<div class="col-xs-2 text-center" style="font-size:10px; font-weight: bold;">'+comment.name+'</div>'+
					'<div class="col-xs-3 text-center" style="color: gray; font-size: 10px; opacity: 0.7;">'+comment.time+'</div>'+
					'</div>'+
					
					'<div class="row visible-sm visible-xs">'+
					'<div class="row">'+
					'<div class="col-xs-6 text-left" style="font-size:9px; font-weight: bold;">'+comment.name+'</div>'+
					'<div class="col-xs-6 text-right" style="color:gray; font-size:6px; opacity:0.7;">'+comment.time+'</div>'+
					'</div>'+
					'<div class="row">'+
					'<div class="col-xs-6 text-left" style="font-size:15px;">-'+comment.content.replace(/\n/g,'')+'</div>'+
					'</div>'+
					'<hr>'+
					'</div>';
					
		}	
		//뭐 다 추가한단 소리같음
		commentDiv.innerHTML = html;
		
		commentDiv.comment = comment;
		commentDiv.className = "comment";
		return commentDiv;
	} 
	
	<!-- -->
	
	
	
	//trim이 제공이 안되길래 내가 직접 만듦
	function trim(str) {
	    str = input.replace(/(^\s*)|(\s*$)/, "");
	    return str;
	} 
	
	//댓글 추가
	function addComment() {
		var Get_ID = "<%=session.getAttribute("Get_ID")%>";

		 //댓글에 넣기 위한 변수들
		if(Get_ID==""||Get_ID=="null"){
			alert("로그인이 필요합니다.")
			$('#login').modal('show')
		}else{
		var CD_ID = document.addForm.CD_ID.value;
		var CS_ID = document.addForm.CS_ID.value;
		 
		var WB_ID = document.addForm.WB_ID.value;
		var content = document.addForm.content.value;
		var R_Time=document.addForm.R_Time.value;
		//스페이스만 쳐서 입력할 수 도 있으니까 미연에 방지
		content=content.trim();
		console.log(content);
		if(content==null||content=="")
			{
			alert("내용을 입력해주세요.");
			return false;
			}
		var params = "CD_ID="+encodeURIComponent(CD_ID)+"&"+"CS_ID="+encodeURIComponent(CS_ID)+"&"+"WB_ID="+encodeURIComponent(WB_ID)+"&"+
		             "content="+encodeURIComponent(content)+"&"+"R_Time="+encodeURIComponent(R_Time);
		new ajax.xhr.Request('/Reply/commentadd.jsp', params, addResult, 'POST');
		}
	}
	//상기 동일
	function addResult(req) {
		if (req.readyState == 4) {
			if (req.status == 200) {
				var xmlDoc = req.responseXML;
				var code = xmlDoc.getElementsByTagName('code').item(0)
				                 .firstChild.nodeValue;
				if (code == 'success') {
					var comment = eval( "(" + xmlDoc.getElementsByTagName('data').item(0).firstChild.nodeValue + ")" );
					var listDiv = document.getElementById('commentList');
					var commentDiv = makeCommentView(comment);
					listDiv.appendChild(commentDiv);

					document.addForm.content.value = '';
	
					
				} else if (code == 'fail') {
					var message = xmlDoc.getElementsByTagName('message')
					                    .item(0).firstChild.nodeValue;
					alert("에러 발생1:"+message);
				}
			} else {
				alert("서버 에러 발생: " + req.status+"\n 다시 작성해주세요.");
				
				console.log(req.status);
			}
		}
	}
	 function confirmDeletion(comment_id) {
		  if (confirm("삭제하시겠습니까?")) {
		   //삭제 댓글 ID 서버에 전송
		   var params = "Delete_R_ID="+encodeURIComponent(comment_id);

		   new ajax.xhr.Request(
		    '/Reply/commentdelete.jsp', params, removeResult, 'POST');
		  }
		 }
		 function removeResult(req) {
		  if (req.readyState == 4) {
		   if (req.status == 200) {
		    var xmlDoc = req.responseXML;
		    var code = xmlDoc.getElementsByTagName('code').item(0)
		                     .firstChild.nodeValue;
		    if (code == 'success') {
		     //삭제된 댓글 ID를 구함
		     var deletedId = 
		      xmlDoc.getElementsByTagName('id').item(0)
		            .firstChild.nodeValue;
		     //삭제된 댓글의 DIV를 부모 노드에서 제거
		     var commentDiv = document.getElementById("c"+deletedId);
		     commentDiv.parentNode.removeChild(commentDiv);
		 
		    } else if (code == 'fail') {
		     var message = xmlDoc.getElementsByTagName('message')
		                         .item(0).firstChild.nodeValue;
		     alert("에러 발생13:"+message);
		    }
		   } else {
		    alert("서버 에러 발생: " + req.status);
		   }
		  }
		 }
	
	</script>

</head>
<body>
	<%
		String WB_ID = request.getParameter("WB_ID");
		String CD_ID = request.getParameter("CD_ID");
		String CS_ID = request.getParameter("CS_ID");
		
		System.out.println("commentclient.jsp " + "WB_ID : " + WB_ID);
		Date from = new Date();
		SimpleDateFormat transFormat = new SimpleDateFormat("yy-MM-dd HH:mm");
		String Date = transFormat.format(from);
	%>
	<div id="commentList"></div>

	<div id="commentAdd">
		<form action="" name="addForm">
			<div class="row">
				<div class="col-xs-12">
					<div class="input-group">
						<input type="hidden" id="WB_ID" name="WB_ID" value="<%=WB_ID%>">
						<input type="hidden" id="R_Time" name="R_Time" Value="<%=Date%>">
						<input type="hidden" id="CD_ID" name="CD_ID" value="<%=CD_ID %>">
						<input type="hidden" id="CS_ID" name="CS_ID" value="<%=CS_ID %>">
						
						<input maxlength="999" type="text" class="form-control" id="content" name="content" onKeydown="javascript:if(event.keyCode == 13){addComment();}" required/> 
						<span class="input-group-btn"> 
						<input class="btn btn-default" type="button" value="입력" onClick="addComment();"/>
						</span>
						
						<!-- 키가 스페이스 바인지 확인하고, 추가하기 -->
					</div>
					
					
			
				</div>
			</div>
		</form>
	</div>



</body>
</html>