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

<script type="text/javascript">


var PWCheck = true;


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
<%String S_Num=request.getParameter("S_Num"); 
%>

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
		<div class="col-lg-offset-3 col-lg-5">

			<form name="Register_Member" action="/Log/Forget_PW/Alter_PW_DB.jsp" method="Post">
				<input type="hidden" name="S_Num" id="S_Num" value="<%=S_Num%>">

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
							onclick="return Check();">변경</button>
					</div>
				</div>

			</form>
		</div>
	</div>




</body>


</html>