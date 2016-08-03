<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">


<script type="text/javascript">
var WB_ID = document.getElementById("WB_ID")

	function loadLikeNum() {
		WB_ID = WB_ID.value;
		var params = "WB_ID=" + encodeURIComponent(WB_ID);
		new ajax.xhr.Request("/Like/Like_Num.jsp", params, loadLikeResult,
				'POST');
	}

	function loadLikeResult(req) {
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
					var commentList = eval("("
							+ xmlDoc.getElementsByTagName('data').item(0).firstChild.nodeValue
							+ ")");
					//commentList라고 밑에 <Body>부분에 있는데 아마 여기에 쓰겠단 소리같음
					var listDiv = document.getElementById('commentList');
					//데이터 없을때까지 makeCommentView로 리플 만듦
					var L_CNT = commentList[0].Like_Num;
					L_CNT = Number(L_CNT);

					Like_Count.value = L_CNT;

				} else if (code == 'error') {
					var message = xmlDoc.getElementsByTagName('message')
							.item(0).firstChild.nodeValue;
					alert("에러 발생:" + message);
				}
			} else {
				alert("따봉 갯수 로딩 실패:" + req.status);
			}
		}
	}

	function loadLikeCheck() {
		var params = "WB_ID=" + encodeURIComponent(WB_ID);
		new ajax.xhr.Request("/Like/Like_Check.jsp", params,
				loadLikeCheckResult, 'POST');
	}

	function loadLikeCheckResult(req) {
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
					var commentCheck = eval("("
							+ xmlDoc.getElementsByTagName('data').item(0).firstChild.nodeValue
							+ ")");
					//commentCheck라고 밑에 <Body>부분에 있는데 아마 여기에 쓰겠단 소리같음
					var listDiv = document.getElementById('commentCheck');
					//데이터 없을때까지 makeCommentView로 리플 만듦

					var commentDiv = makeLikeBtn(commentCheck[0]);
					//추가한단 소리같음
					listDiv.appendChild(commentDiv);

				} else if (code == 'error') {
					var message = xmlDoc.getElementsByTagName('message')
							.item(0).firstChild.nodeValue;
					alert("에러 발생:" + message);
				}
			} else {
				alert("댓글 목록 로딩 실패:" + req.status);
			}
		}
	}

	function makeLikeBtn(comment) {
		//<div>
		var commentDiv = document.createElement('div');
		if (comment.Like_Check == 0) {
			var html = '<div>'
					+ '<button id="Like_BTN" onclick="Like();" type="button" class="btn btn-info btn-lg">'
					+ '<span class="glyphicon glyphicon-thumbs-up"></span>'
					+ '</button>'
					+ '<span id="Like_Num" class="label label-default"></span>'
					+ '</div>'

		} else {
			var html = '<div>'
					+ '<button id="Like_BTN" onclick="DisLike();" type="button" class="btn btn-default btn-lg">'
					+ '<span class="glyphicon glyphicon-thumbs-up"></span>'
					+ '</button>'
					+ '<span id="Like_Num" class="label label-default"></span>'
					+ '</div>'
		}

		//뭐 다 추가한단 소리같음
		commentDiv.innerHTML = html;

		return commentDiv;
	}

	function Like() {
		var Get_ID = <%=session.getAttribute("Get_ID")%>;
		
		if(Get_ID==""||Get_ID==null){
			alert("로그인이 필요합니다.")
			$('#login').modal('show')
		}else{
		document.getElementById('Like_BTN').setAttribute('class',
				'btn btn-default btn-lg');
		document.getElementById('Like_BTN').setAttribute('onclick',
				'DisLike();');

		Like_Count = document.getElementById('Like_Count').value;

		var param = "WB_ID=" + encodeURIComponent(WB_ID) + "&" + "Like_Count="
				+ encodeURIComponent(Like_Count);
		new ajax.xhr.Request("/Like/Like_Num_Plus.jsp", param,
				Like_Plus_Result, "post");
		}
	}
	function Like_Plus_Result(req) {

		if (req.readyState == 4) {

			//성공시
			if (req.status == 200) {
				//json을 가져오는데 이게 아직도 뭔소린지 잘모르겠음
				var xmlDoc = req.responseXML;
				//code부분을 가져온다는 소리
				var code = xmlDoc.getElementsByTagName('code').item(0).firstChild.nodeValue;
				//가져온 코드가 success면
				if (code == 'success') {

					var Like_Num = document.getElementById('Like_Count').value;
					Like_Num = Number(Like_Num);
					document.getElementById('Like_Count').value = Like_Num + 1;

				} else if (code == 'error') {
					var message = xmlDoc.getElementsByTagName('message')
							.item(0).firstChild.nodeValue;
					alert("에러 발생:" + message);
				}
			} else {
				alert("댓글 목록 로딩 실패:" + req.status);
			}

		}
	}

	function DisLike() {
var Get_ID = <%=session.getAttribute("Get_ID")%>;
		
		if(Get_ID==""||Get_ID==null){
			alert("로그인이 필요합니다.")
			$('#login').modal('show')
		}else{
		document.getElementById('Like_BTN').setAttribute('onclick', 'Like();');
		document.getElementById('Like_BTN').setAttribute('class',
				'btn btn-info btn-lg')
		Like_Count = document.getElementById('Like_Count').value;

		var param = "WB_ID=" + encodeURIComponent(WB_ID) + "&" + "Like_Count="
				+ encodeURIComponent(Like_Count);
		new ajax.xhr.Request("/Like/Like_Num_Minus.jsp", param,
				Like_Minus_Result, "post");
		}
	}

	function Like_Minus_Result(req) {
		//연결

		if (req.readyState == 4) {

			if (req.status == 200) {
				//json을 가져오는데 이게 아직도 뭔소린지 잘모르겠음
				var xmlDoc = req.responseXML;
				//code부분을 가져온다는 소리
				var code = xmlDoc.getElementsByTagName('code').item(0).firstChild.nodeValue;
				//가져온 코드가 success면
				if (code == 'success') {

					var Like_Num = document.getElementById('Like_Count').value;
					Like_Num = Number(Like_Num);
					document.getElementById('Like_Count').value = Like_Num - 1;

				} else if (code == 'error') {
					var message = xmlDoc.getElementsByTagName('message')
							.item(0).firstChild.nodeValue;
					alert("에러 발생:" + message);
				}
			} else {
				alert("댓글 목록 로딩 실패:" + req.status);
			}

		}

	}
</script>
<style type="text/css">

.like{
background-color:white !important;
color: black !important;

}

}
</style>
</head>
<body>
	<%String WB_ID=request.getParameter("WB_ID"); %>
	
	
	<div id="commentCheck"></div>
	<input class="like btn" type="button" name="Like_Count" id="Like_Count" value="" disabled="true" />
	
	<!-- <input type="button" name="Like_Count" id="Like_Count" value="" /> -->




	<input type="hidden" id="WB_ID" name="WB_ID" value="<%=WB_ID%>" />







</body>
</html>