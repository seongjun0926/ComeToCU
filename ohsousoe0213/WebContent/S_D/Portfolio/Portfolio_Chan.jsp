<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<html>
<head>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>재능</title>


</head>
<body>

	<jsp:include page="/S_D/NavBar.jsp" flush="false" />
	<br>
	<br>
	<br>
	<%
		String Session_ID = "";
		String Num = request.getParameter("Num");
		String Subject = request.getParameter("Subject");
		String IMG = request.getParameter("IMG");
		String Title = request.getParameter("Title");
		String Period = request.getParameter("Period");
		String Explanation = request.getParameter("Explanation");

		try {
			Session_ID = (String) session.getAttribute("Session_ID");

			if (Session_ID == null || Session_ID.equals("")) {

				response.sendRedirect("/");

			} else {
	%>


	<div class="container">
		<div class="page-header">
			<h1>
				재능 <small>PORTFOLIO</small>
			</h1>

		</div>

		<form name="Portfoilo_Content" method="post"
			action="/S_D/Portfolio/Portfolio_Chan_Process.jsp">
			<div class="panel panel-default">
				<div class="panel-heading text-center">
					<h1>
						<strong>주제</strong>
					</h1>
				</div>
				<div class="panel-body">
					<input type="hidden" name="Num" value="<%=Num%>"> <input
						type="text" name="ChanSubject" class="form-control"
						value="<%=Subject%>" maxlength="50" required="required" />

				</div>
			</div>
			<hr>

			<div class="panel panel-default">
				<div class="panel-heading text-center">
					<h1>
						<strong>작품 명</strong>
					</h1>
				</div>
				<div class="panel-body">
					<input type="text" name="ChanTitle" class="form-control"
						value="<%=Title%>" maxlength="50" required="required" />
				</div>
			</div>
			<hr>

			<div class="panel panel-default">
				<div class="panel-heading text-center">
					<h1>
						<strong>기간</strong>
					</h1>
				</div>
				<div class="panel-body">
					<input type="text" name="ChanPeriod" class="form-control"
						value="<%=Period%>" maxlength="50" required="required" />
				</div>
			</div>
			<hr>


			<div class="panel panel-default">
				<div class="panel-heading text-center">
					<h1>
						<strong>작품 소개</strong>
					</h1>
				</div>
				<div class="panel-body">
					<textarea name="ChanExplanation" class="form-control" rows="8"
						required><%=Explanation%></textarea>
				</div>

			</div>
			<hr>

			<div class="text-right">
				<button type="submit" class="btn btn-default">
					<span class="glyphicon glyphicon-floppy-saved" aria-hidden="true"></span>
				</button>
				<hr style="border: solid 1px;">
			</div>
		</form>
	</div>

	<%
		}

		} catch (Exception e) {
			response.sendRedirect("/");
		}
	%>
</body>
</html>