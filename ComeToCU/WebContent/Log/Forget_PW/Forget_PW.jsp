<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<title>암호 찾기</title>

<script type="text/javascript" src="/Log/httpRequest.js"></script>
<script type="text/javascript">
	var checkFirst = false;
	var lastKeyword = '';
	var loopSendKeyword = false;

	var IDCheck = true;

	function checkId() {
		if (checkFirst == false) {
			setTimeout("sendId();", 500);
			loopSendKeyword = true;
		}
		checkFirst = true;
	}

	function sendId() {
		if (loopSendKeyword == false)
			return;

		var keyword = document.Forget_PW.S_Num.value;
		if (keyword == '') {
			lastKeyword = '';
			document.getElementById('checkMsg').style.color = "black";
			document.getElementById('checkMsg').innerHTML = "학번를 입력하세요.";
		} else if (keyword != lastKeyword) {
			lastKeyword = keyword;

			if (keyword != '') {
				var params = "id=" + encodeURIComponent(keyword);

				sendRequest("/Log/Id_Check.jsp", params, displayResult, 'POST');
			} else {
			}
		}
		setTimeout("sendId();", 500);
	}
	function isNull(elm) {
		//Null 체크 함수
		var elm;
		return (elm == null || elm == "" || elm == "undefined" || elm == " ") ? true
				: false
	}

	function displayResult() {

		if (httpRequest.readyState == 4) {
			if (httpRequest.status == 200) {
				var resultText = httpRequest.responseText;

				var listView = document.getElementById('checkMsg');
				var keyword = document.Forget_PW.S_Num.value;

				if (resultText == 0) {
					if (keyword.length != 8) {
						listView.innerHTML = "전체 학번을 입력해주세요.";
						listView.style.color = "red";
						IDCheck = false;
					} else {
						listView.innerHTML = "등록되지 않은 학번입니다.";
						listView.style.color = "red";
						IDCheck = false;
					}
				} else {

					listView.innerHTML = "등록된 학번입니다.";
					listView.style.color = "blue";
					IDCheck = true;

				}
			} else {
				alert("에러 발생: " + httpRequest.status);
			}
		}
	}
	function onlyNumber(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ((keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105)
				|| keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39)
			return;
		else
			return false;
	}
	function removeChar(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if (keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39)
			return;
		else
			event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}

	function Check() {

		var thisform = document.Forget_PW;

		if (isNull(thisform.S_Num.value)) {
			alert("필수항목을 입력해 주세요.");
			return false;
		}
		if (isNull(thisform.receiver.value)) {
			alert("필수항목을 입력해 주세요.");
			return false;
		}

		if (IDCheck == false) {
			alert("학번을 확인하세요.");
			return false;
		}

		Forget_PW.submit();
	}
</script>



</head>
<body style="background-color: #F6F6F6; color: #002266">
	<br>
	<br>
	<br>
	<div style="background-color: #F6F6F6;">
		<!-- 색깔 넣어주면댐 -->
		<div id="header" class="container">

			<!-- 상단 네비게이션 바 -->

			<jsp:include page="/NavBar.jsp" flush="false" />

			<br>

		</div>

	</div>
	<br>
	<br>
	<!-- 색깔 넣어주면댐  -->
	<div class="container">
		<div class="col-xs-offset-3 col-xs-5">

			<form name="Forget_PW"
				action="/Log/Forget_PW/Forget_PW_Email_Send.jsp" method="POST">



				<div class="input-group">

					<span class="input-group-addon">학번</span> <input type="text"
						id="S_Num" name="S_Num" maxlength="8" onkeydown="checkId()"
						class="form-control" style="ime-mode: disabled"
						placeholder="학번을 입력해주세요." aria-describedby="basic-addon1" required
						onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)">
				</div>
				<div class="text-right" id="checkMsg">학번을 입력하세요.</div>
				<br />
				<div class="input-group">

					<span class="input-group-addon" id="receiver">대가대 ID</span> <input
						name="receiver" type="text" class="form-control"
						placeholder="대가대 메일 ID를 @앞 부분만 입력해주세요."
						aria-describedby="basic-addon1" required maxlength="15">


				</div>
					
				<div class="text-right">~@cu.ac.kr 로 메일이 전송됩니다.</div>
				
				<br>
				<div class="text-right">
					<button type="button" class="btn btn-primary"
						onclick="return Check();">암호 찾기</button>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="/footer.jsp" flush="false" />


</body>
</html>