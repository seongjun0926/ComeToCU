<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
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
<title>재능 작성</title>


</head>
<body>
	<%
		String Session_ID = "";
		String Work_IMG="";
		try {
			Session_ID = (String) session.getAttribute("Session_ID");

			if (Session_ID == null || Session_ID.equals("")) {

				response.sendRedirect("/");

			} else {
	%>
	<div>
		<jsp:include page="/S_D/NavBar.jsp" flush="false" />
	</div>
	<br>
	<br>
	<br>

	<div class="container">
		<div class="page-header">
			<h1>
				재능 <small>PORTFOLIO</small>
			</h1>

		</div>

		<form name="Img" method="post" enctype="multipart/form-data"
			action="/DB/IMG/ImgUp_Portfolio.jsp">

			<div class="panel panel-default">
				<div class="panel-heading text-center">
					<h1>
						<strong>대표 사진</strong>
					</h1>
				</div>
				<div class="panel-body text-center">
				
			
					<strong>사진을 고른 후 등록 버튼을 눌러야 저장이 됩니다.<br> 또한 사진은 수정이 되지 않으니 신중히 작업해주세요.</strong>

					
					<input  type="file" name="filename1" size=40>
					<input  type="submit" value="등록"><br>
					파일 이름 : <%=request.getAttribute("fullpath")%>
					
				</div>
			</div>
		</form>
		<hr>
		<form name="Portfoilo_Content" method="post" action="/S_D/Portfolio/Portfolio_DB.jsp">
		<div class="panel panel-default">
			<div class="panel-heading text-center">
					<h1>
						<strong>주제</strong>
					</h1>
				</div>
			<div class="panel-body">
				<input name="InputSubject" class="form-control"
					placeholder="주제을 입력하세요." type="text" maxlength="50"
					required="required" />
				<input type="hidden" name="Work_IMG" value="<%=request.getAttribute("fullpath")%>">
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
				<input name="InputTitle" class="form-control"
					placeholder="작품명을 입력하세요." type="text" maxlength="50"
					required="required" />
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
				<input name="InputPeriod" class="form-control"
					placeholder="2016-01-01 ~ 2016-02-01" type="text" maxlength="50"
					required="required" />
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
				<textarea name="InputExplanation" class="form-control"
					placeholder="작품에 대한 설명을 입력하세요" rows="8" required></textarea>
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