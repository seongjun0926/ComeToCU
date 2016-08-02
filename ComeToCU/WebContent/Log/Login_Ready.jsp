<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>로그인</title>
<script type="text/javascript" src="/Log/httpRequest.js"></script>
<script type="text/javascript">

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
		event.target.value = event.target.value.replace(/[^0-9]/g, "");
}
function end() {
	location.replace("/index.jsp");
	}
	 
</script>



</head>
<body>

	<!-- 로그인 모달 창 띄우기 -->
	<!-- 모달창으로 구현 -->
	<div class="modal fade" id="login" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">

				<div class="modal-header">
					<!-- 닫기(x) 버튼 -->
					<button type="button" onclick="end()" class="close"
						data-dismiss="modal">×</button>
					<!-- header title -->
					<h4 class="modal-title">로그인</h4>
				</div>
				<!-- body -->
				<div class="modal-body">
					<br>

					<form action="/Log/LoginProcess.jsp" method="POST">

						<%String URI2 = request.getRequestURL().toString();
						if(request.getQueryString()!=null)
							URI2=URI2+"?"+request.getQueryString();
	        	 %>
	        	 <input type="hidden" name="redirectURI" value=<%=URI2 %>>
	        	 
						<div class="input-group">

							<span class="input-group-addon" id="S_Num">학번</span> <input
								name="S_Num" type="text" class="form-control"
								placeholder="학번을 입력해주세요." aria-describedby="basic-addon1"
								required autofocus onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)"
								maxlength="8">
						</div>




						<div class="input-group">

							<span class="input-group-addon" id="S_PW">암호</span> <input
								name="S_PW" type="password" class="form-control"
								placeholder="암호를 입력해주세요." aria-describedby="basic-addon1"
								required maxlength="20">
						</div>
						<br />
						<button class="btn btn-default btn-info btn-block" type="submit">로그인</button>
						<div class="text-right">
							<a href="#"><u>암호를 잊었습니다</u></a>
						</div>







					</form>
				</div>

			</div>
		</div>
	</div>
</body>
</html>