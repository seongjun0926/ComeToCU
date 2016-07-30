<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="Util.DB"%>
<%!public Integer toInt(String x) {
		int a = 0;
		try {
			a = Integer.parseInt(x);
		} catch (Exception e) {
		}
		return a;
	}%>
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
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js">
	
</script>

<style type="text/css">
.alert {
	background-color: white !important;
	color: black !important;
}

a.list-group-item {
	background-color: white !important;
	color: black !important;
}

a.list-group-item:hover {
	background-color: white !important;
	border: 2px solid #0D3FA5 !important;
	color: #00096F !important;
}
</style>

<title>자유 게시판</title>



</head>
<body style="background-color: #f7f7f7">
	<%
		request.setCharacterEncoding("utf-8");
	%>
	<br>
	<br>
	<br>


<script type="text/javascript">
$(window).load(function(){
    $('#myModal').modal('show');
});
</script>



	<a href="/Log/Login_Ready.jsp" data-toggle="modal"
							data-target="#login">로그인</a>
							<!-- 로그인 모달 창 띄우기 -->
				<div class="modal fade" id="login" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel">
					<div class="modal-dialog modal-sm" role="document">
						<div class="modal-content"></div>
					</div>
				</div>	
			
	<jsp:include page="/footer.jsp" flush="false" />
</body>
</html>