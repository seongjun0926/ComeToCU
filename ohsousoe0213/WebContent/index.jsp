<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>오.소.서</title>


<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>

	<div class="container">
		<!--배경화면 사진-->
		<img src="img/Main_Page/Main_BG.jpg"
			class="img-responsive" alt="오소서 배경화면" align="middle">
	</div>
	<br>



	<div class="container">

		<form name="Enter_signin" class="form-signin" action="/DB/LoginProcess.jsp" method="post">
			<h2 class="form-signin-heading">Please sign in</h2>
			
			<label for="inputID" class="sr-only">ID</label> 
			
			<input type="text" id="EnterID" name="EnterID" class="form-control" placeholder="ID" maxlength="15" style="ime-mode:disabled" required  autofocus> 
			
			<label for="inputPassword" class="sr-only">Password</label> 
			
			<input type="password" id="EnterPW" name="EnterPW" class="form-control" placeholder="Password" maxlength="20" style="ime-mode:disabled" required>
			
			<div class="checkbox">
			
				<label> <input type="checkbox" value="remember-me">Remember me</label>
		
			</div>
			
			
			
			
			<div class="btn-group btn-group-justified" role="group" aria-label="...">
  				<div class="btn-group" role="group">
   					 <button type=submit class="btn btn-lg btn-primary">로그인</button>
  				</div>
  			
  				<div class="btn-group" role="group">
   					 <button type="button" class="btn btn-lg btn-info" onClick="location.href='/F_D/Member_Add.jsp'">회원가입</button>
  				</div>
			</div>


		</form>

	</div>
	<!-- /container -->

<%
application.log("index.jsp");
%>
	<!-- jQuery (ë¶í¸ì¤í¸ë©ì ìë°ì¤í¬ë¦½í¸ íë¬ê·¸ì¸ì ìí´ íìí©ëë¤) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<!-- ëª¨ë  ì»´íì¼ë íë¬ê·¸ì¸ì í¬í¨í©ëë¤ (ìë), ìíì§ ìëë¤ë©´ íìí ê°ê°ì íì¼ì í¬í¨íì¸ì -->
	<script src="js/bootstrap.min.js"></script>
</body>
</html>