<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.io.BufferedReader"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

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
		document.getElementById('checkMsg').innerHTML = "ID를 입력하세요.";
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
function isNull(elm)
{ 
        //Null 체크 함수
        var elm;
        return (elm == null || elm == "" || elm == "undefined" || elm == " ") ? true : false
}

function displayResult() {

	if (httpRequest.readyState == 4) {
		if (httpRequest.status == 200) {
			var resultText = httpRequest.responseText;
	

			var listView = document.getElementById('checkMsg');
			var keyword = document.Register_Member.S_Num.value;
			
			if (resultText == 0) {
				if(keyword.length<=5){
					listView.innerHTML = "5자리 이상 입력해주세요.";
					listView.style.color = "red";
					IDCheck = false;
				}else{
				listView.innerHTML = "사용 할 수 있는 ID 입니다.";
				listView.style.color = "blue";
				IDCheck = true;
				}
			} else {
				
				listView.innerHTML = "이미 등록된 ID 입니다.";
				listView.style.color = "red";
				IDCheck = false;

			}
		} else {
			alert("에러 발생13: " + httpRequest.status);
		}
	}
}
function onlyNumber(event){
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		return;
	else
		return false;
}
function removeChar(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		return;
	else
		event.target.value = event.target.value.replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, "");
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

	var pw1 = document.Register_Member.S_Password.value;
	var pw2 = document.Register_Member.S_Password_Check.value;
	
	
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
				document.getElementById('checkPwd').style.color = "green";
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

function end() {
	location.replace("/index.jsp");
	}
	 

function Check() {

      var thisform = document.Register_Member;
      
      if (document.Register_Member.check.checked !=true) {
  		alert("이용약관과 개인정보 수집 및 이용에 대한 안내를 읽고 동의해주세요.");
  		return false;
  	}
	if(isNull(thisform.S_Name.value)){
              alert("필수항목을 입력해 주세요.");
              return false;
      }
	if(isNull(thisform.S_Num.value)){
        alert("필수항목을 입력해 주세요.");
        return false;
	}
	if(isNull(thisform.S_Password.value)){
        alert("필수항목을 입력해 주세요.");
        return false;
	}
	if(isNull(thisform.receiver.value)){
        alert("필수항목을 입력해 주세요.");
        return false;
	}
	if (IDCheck == false) {
		alert("ID를 확인하세요.");
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

function end() {
	location.replace("/index.jsp");
	}
	 


</script>


</head>
<body>
	<!-- header -->
	<div class="modal-header">
		<!-- 닫기(x) 버튼 -->
		<button type="button" onclick="end()" class="close"
			data-dismiss="modal">×</button>
		<!-- header title -->
		<h4 class="modal-title">회원가입</h4>
	</div>
	<!-- body -->
	<div class="modal-body">
		<br>
		<form name="Register_Member" action="/Log/Register/Register_DB.jsp"
			method="Post">
			<textarea class="form-control" rows="5" readonly>
				<%
					BufferedReader reader = null;
					try {
						String filePath = application
								.getRealPath("/WEB-INF/cometocu.txt");
						reader = new BufferedReader(new FileReader(filePath));
						while (true) {
							String str = reader.readLine();
							if (str == null)
								break;
							out.print(str + "\n");
						}
					} catch (FileNotFoundException fnfe) {
						out.print("파일이 존재 하지 않습니다.");
					} catch (IOException ioe) {
						out.print("파일을 읽을수 없습니다.");
					}

					finally {
						try {
							reader.close();
						} catch (Exception e) {

						}
					}
				%>
			</textarea>

			<input type=checkbox name="check" value="1"> 약관에 동의합니다.

			<div class="input-group">

				<span class="input-group-addon" id="S_Name">이름</span> <input
					type="text" name="S_Name" maxlength="10" class="form-control"
					placeholder="이름을 입력해주세요." aria-describedby="basic-addon1" required
					autofocus>
				<!-- onkeypress="return blank_check(event)" -->
			</div>

			<div class="input-group">

				<span class="input-group-addon">ID</span> <input type="text"
					id="S_Num" name="S_Num" maxlength="20" onkeydown="checkId()"
					class="form-control" style="ime-mode: disabled"
					placeholder="ID를 입력해주세요." aria-describedby="basic-addon1" required onkeyup="removeChar(event)">
					<!-- 
					onkeydown="return onlyNumber(event)"  -->
			</div>
			<div id="checkMsg">ID를 입력하세요.</div>
			<br>
			<div class="input-group">
					<span class="input-group-addon">대가인 인증</span> 
					
					<input type="text" required id="receiver" name="receiver" maxlength="15" class="form-control col-xs-5" style="ime-mode: disabled" placeholder="대가대 로그인 ID를 입력해주세요."
						aria-describedby="basic-addon1" required />
				<span class="input-group-addon">@cu.ac.kr</span> 
			</div>
			<br>
			<div class="input-group">

				<span class="input-group-addon">암호</span> <input type="password"
					name="S_Password" id="S_Password" maxlength="20"
					class="form-control" placeholder="암호를 입력해주세요."
					aria-describedby="basic-addon1" required onkeyup="checkPwd()"
					onkeypress="return pw_blank_check(event)">
			</div>
			<div class="input-group">

				<span class="input-group-addon">암호 확인</span> <input type="password"
					name="S_Password_Check" id="S_Password_Check" maxlength="20"
					class="form-control" placeholder="암호를 확인해주세요."
					aria-describedby="basic-addon1" required onkeyup="checkPwd()"
					onkeypress="return pw_blank_check(event)">
			</div>
			<div id="checkPwd">동일한 암호를 입력하세요.</div>

			<div class="text-center">
				<div class="btn-group " role="group">
					<button type="button" class="btn btn-primary"
						onclick="return Check();">등록</button>
				</div>
			</div>
	
			</form>
	</div>



</body>
</html>