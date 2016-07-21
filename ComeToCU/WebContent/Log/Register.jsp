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
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style type="text/css">

.panel-heading{
background-color: black !important;
color: #123478 !important;
}


</style>
<title>회원 가입</title>

<script type="text/javascript" src="/Log/httpRequest.js"></script>
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

	var keyword = document.Register_Member.S_Num.value;
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

function displayResult() {

	if (httpRequest.readyState == 4) {
		if (httpRequest.status == 200) {
			var resultText = httpRequest.responseText;
	

			var listView = document.getElementById('checkMsg');
			if (resultText == 0) {
				listView.innerHTML = "사용 할 수 있는 학번 입니다.";
				listView.style.color = "blue";
				IDCheck = true;
			} else {
				
				listView.innerHTML = "이미 등록된 학번 입니다.";
				listView.style.color = "red";
				IDCheck = false;

			}
		} else {
			alert("에러 발생: " + httpRequest.status);
		}
	}
}
function digit_check(evt){
	var code = evt.which?evt.which:event.keyCode;
	if(code < 48 || code > 57){
	return false;
	}
}
function blank_check(evt){
	var code = evt.which?evt.which:event.keyCode;
	if((code < 65 || code>=91)&(code<97||code>=123)){
	return false;
	}
}
function pw_blank_check(evt){
	var code = evt.which?evt.which:event.keyCode;
	if(code == 32){
	return false;
	}
}
function checkPwd() {
	var f1 = document.forms[0];
	var pw1 = f1.S_Password.value;
	var pw2 = f1.S_Password_Check.value;
	if (pw1 != pw2 || pw2!=pw1) {
		document.getElementById('checkPwd').style.color = "red";
		document.getElementById('checkPwd').innerHTML = "동일한 암호를 입력하세요.";
		PWCheck = false;
	} 
	if(pw1==pw2) {
		pw1=pw1.trim();
		pw2=pw2.trim();
		if(pw1==null||pw1=="")
			{
			if(pw2==null||pw2==""){
				document.getElementById('checkPwd').style.color = "black";
				document.getElementById('checkPwd').innerHTML = "암호를 입력해주세요.";
			}
			
			}
		else{
		document.getElementById('checkPwd').style.color = "blue";
		document.getElementById('checkPwd').innerHTML = "암호가 확인 되었습니다.";
		}
		PWCheck = true;
		
	}
}
function Check() {
	if (IDCheck == false) {
		alert("학번을 확인하세요.");
		return false;
	}
	
	if (PWCheck == false) {
		alert("암호를 확인하세요.");
		return false;
	}

	
	Register_Member.submit();
}



function trim(str) {
	    str = input.replace(/(^\s*)|(\s*$)/, "");
	    return str;
	} 



</script>


</head>
<body>

	<form name="Register_Member" action="/Log/Register_DB.jsp"
		method="Post">
		<div class="container">
			<div class="panel panel-default">
				<div class="panel-heading text-center">회원 가입</div>
				<table class="table">
					<tr>
						<div class="input-group">

							<span class="input-group-addon" id="S_Name">이름</span> <input
								type="text" name="S_Name" maxlength="10" class="form-control"
								placeholder="이름을 입력해주세요." aria-describedby="basic-addon1"
								required autofocus onkeypress="return blank_check(event)">
						</div>
						<div class="input-group">

							<!-- 나중에 라디오 버튼으로 단대/학과 나열 -->
							<span class="input-group-addon">학과</span> <input type="text"
								name="S_Major" maxlength="10" class="form-control"
								placeholder="학과를 입력해주세요." aria-describedby="basic-addon1"
								required autofocus onkeypress="return blank_check(event)">
						</div>
						<div class="input-group">

							<span class="input-group-addon">학번</span> <input type="text"
								id="S_Num" name="S_Num" maxlength="8" onkeydown="checkId()"
								class="form-control" style="ime-mode: disabled"
								placeholder="학번을 입력해주세요." aria-describedby="basic-addon1"
								required onkeypress="return digit_check(event)">
						</div>
						<div id="checkMsg">학번을 입력하세요.</div>

						<div class="input-group">

							<span class="input-group-addon">암호</span> <input type="password"
								name="S_Password" id="S_Password" maxlength="20"
								class="form-control" placeholder="암호를 입력해주세요."
								aria-describedby="basic-addon1" required onkeyup="checkPwd()"
								onkeypress="return pw_blank_check(event)">
						</div>
						<div class="input-group">

							<span class="input-group-addon">암호 확인</span> <input
								type="password" name="S_Password_Check" id="S_Password_Check"
								maxlength="20" class="form-control" placeholder="암호를 확인해주세요."
								aria-describedby="basic-addon1" required onkeyup="checkPwd()"
								onkeypress="return pw_blank_check(event)">
						</div>
						<div id="checkPwd">동일한 암호를 입력하세요.</div>


					</tr>
				</table>

			</div>
			<div class="text-center">
				<div class="btn-group " role="group">
					<button type="button" class="btn btn-default" onclick="return Check();" >등록</button>
				</div>
			</div>
		</div>

	</form>

</body>
</html>