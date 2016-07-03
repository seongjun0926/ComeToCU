<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">


<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>어.서.오.세.요</title>

<script type="text/javascript" src="/F_D/httpRequest.js"></script>
<script type="text/javascript">
	var checkFirst = false;
	var lastKeyword = '';
	var loopSendKeyword = false;

	var IDCheck = true;
	var PWCheck = true;

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

		var keyword = document.register_member.InputID.value;
		if (keyword == '') {
			lastKeyword = '';
			document.getElementById('checkMsg').style.color = "black";
			document.getElementById('checkMsg').innerHTML = "아이디를 입력하세요.";
		} else if (keyword != lastKeyword) {
			lastKeyword = keyword;

			if (keyword != '') {
				var params = "id=" + encodeURIComponent(keyword);

				sendRequest("/F_D/Id_Check.jsp", params, displayResult, 'POST');
			} else {
			}
		}
		setTimeout("sendId();", 500);
	}

	function displayResult() {

		if (httpRequest.readyState == 4) {
			if (httpRequest.status == 200) {
				var resultText = httpRequest.responseText;
				var listView = document.getElementById('checkMsg');
				if (resultText == 0) {
					listView.innerHTML = "사용 할 수 있는 ID 입니다.";
					listView.style.color = "blue";
					IDCheck = true;
				} else {
					listView.innerHTML = "이미 등록된 ID 입니다.";
					listView.style.color = "red";
					IDCheck = false;

				}
			} else {
				alert("에러 발생: " + httpRequest.status);
			}
		}
	}

	function checkPwd() {
		var f1 = document.forms[0];
		var pw1 = f1.InputPW.value;
		var pw2 = f1.CheckPW.value;
		if (pw1 != pw2 || pw2!=pw1) {
			document.getElementById('checkPwd').style.color = "red";
			document.getElementById('checkPwd').innerHTML = "동일한 암호를 입력하세요.";
			PWCheck = false;
		} 
		else {
			document.getElementById('checkPwd').style.color = "black";
			document.getElementById('checkPwd').innerHTML = "암호가 확인 되었습니다.";
			PWCheck = true;
		}
	}

	function Check() {
		if (IDCheck == false) {
			alert("ID를 확인하세요.");
			return false;
		}
		
		if (PWCheck == false) {
			alert("암호를 확인하세요.");
			return false;
		}

		
		register_member.submit();
	}
	
	function digit_check(evt){
		var code = evt.which?evt.which:event.keyCode;
		if(code < 48 || code > 57){
		return false;
		}
	}
	
	function digit_check2(evt){
		var code = evt.which?evt.which:event.keyCode;
		if(code!=45){
			if(code < 48 || code > 57){
			return false;
			}
		}
	}
</script>


</head>
<body>


	<div class="container">
		<p class="text-center ">
			<strong><h1>회원 가입</h1></strong>
		</p>
		<br>

		<table class="table table-condensed">

			<form name="register_member" action="/DB/Write_DB.jsp" method="post"
				class="form-signin" OnSubmit="return Check()">
				<!-- action="write_db.jsp" method="post" -->

				<div class="form-group">
					<label for="InputId">ID</label> <input type="text" maxlength="15"
						class="form-control" name="InputID" placeholder="ID를 입력해 주세요"
						onkeydown="checkId()" style="ime-mode: disabled" required autofocus>
					<div id="checkMsg">아이디를 입력하세요.</div>


				</div>
				<div class="form-group">
					<label for="InputPass">비밀 번호</label> <input type="password"
						maxlength="20" class="form-control" name="InputPW"
						placeholder="비밀번호를 입력해 주세요" onkeyup="checkPwd()"
						style="ime-mode: disabled" required>
				</div>
				<div class="form-group">
					<label for="CheckPass">비밀 번호 확인</label> <input type="password"
						maxlength="20" class="form-control" name="CheckPW"
						placeholder="비밀 번호를 확인해 주세요." onkeyup="checkPwd()"
						style="ime-mode: disabled" required>
					<div id="checkPwd">동일한 암호를 입력하세요.</div>
				</div>

				<div class="form-group">
					<label for="InputName">이름</label> <input type="text" maxlength="10"
						class="form-control" name="InputName" placeholder="이름을 입력해 주세요"
						required>
				</div>

				<div class="form-group">
					<label for="InputBdate">생년 월 일</label> 
					<input type="text" maxlength="10" class="form-control" name="InputBdate" placeholder="1992-09-26" onkeypress="return digit_check2(event)"
						required>
				</div>

				<div class="form-group">
					<label for="InputEdu">최종 학력</label> <input type="text"
						maxlength="35" class="form-control" name="InputEdu"
						placeholder="OOO학교 OO학과  대재" required>
				</div>

				<div class="form-group">
					<label for="InputAdd">주소</label> <input type="text" maxlength="50"
						class="form-control" name="InputAdd" placeholder="주소를 입력해주세요"
						required>
				</div>

				<div class="form-group">
					<label for="INputEmail">이 메일</label> <input type="email"
						maxlength="30" class="form-control" name="InputEmail"
						placeholder="이메일을 입력해 주세요." style="ime-mode: disabled" required>
				</div>

				<div class="form-group">
					<label for="INputPhone">전화 번호</label> <input type="text"
						maxlength="11" class="form-control" name="InputPhone"
						placeholder="휴대전화 번호 -(하이픈)제외하고 입력해 주세요."
						style="ime-mode: disabled" onkeypress="return digit_check(event)"
						required />
				</div>



				<div class="text-right">
					<button type="submit" class="btn btn-default ">제출</button>
				</div>
			</form>
		</table>
	</div>

	<%
		application.log("Member_Add.jsp");
	%>
	<!-- jQuery (ë¶í¸ì¤í¸ë©ì ìë°ì¤í¬ë¦½í¸ íë¬ê·¸ì¸ì ìí´ íìí©ëë¤) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<!-- ëª¨ë  ì»´íì¼ë íë¬ê·¸ì¸ì í¬í¨í©ëë¤ (ìë), ìíì§ ìëë¤ë©´ íìí ê°ê°ì íì¼ì í¬í¨íì¸ì -->
	<script src="js/bootstrap.min.js"></script>
</body>
</html>