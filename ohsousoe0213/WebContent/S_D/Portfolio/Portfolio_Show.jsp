<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<% request.setCharacterEncoding("UTF-8"); %>
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
<title>재능 보기</title>

<script type="text/javascript">
	function Delete_Portfolio(frm) {
		if (confirm("삭제하시겠습니까?") == true) {
			frm.action = "/S_D/Portfolio/Portfolio_Delete.jsp"
			var frm_ = frm.submit();
		} else {
			return;
		}
	}

	function Chan_Portfolio(frm) {

		frm.action = "/S_D/Portfolio/Portfolio_Chan.jsp"
		var frm_ = frm.submit();

	}
</script>

</head>
<body>
		<jsp:include page="/S_D/NavBar.jsp" flush="false" />
	<br>
	<br>
	<br>
	<%
		String num="";
		String Subject = "";
		String Work_IMG = "";
		String Title = "";
		String Period = "";
		String Explanation = "";
		String Session_ID = "";
		try {
			Session_ID = (String) session.getAttribute("Session_ID");

			if (Session_ID == null || Session_ID.equals("")) {

				response.sendRedirect("/");

			} else {
				String DB_URL = "jdbc:mysql://localhost:3306/seongjun0926";
				String DB_USER = "seongjun0926";
				String DB_PASSWORD = "wnsduqrud0119";

				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = null;
				Statement stmt = null;
				ResultSet rs = null;
				try {
					conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
					stmt = conn.createStatement();
					rs = stmt.executeQuery("select * from Portfolio where P_ID='" + Session_ID + "';");

					while (rs.next()) {
						num=rs.getString("P_Num");
						Work_IMG = rs.getString("P_WorkIMG");
						Subject = rs.getString("P_Subject");
						Title = rs.getString("P_Title");
						Period = rs.getString("P_Period");
						Explanation = rs.getString("P_Explanation");
	%>


	<div class="container">
		<hr style="border: solid 1px;">
		<div class="page-header">
			<h1>
				재능 <small>PORTFOLIO</small>
			</h1>

		</div>

			<div class="panel panel-default">
				<div class="panel-heading text-center">
					<h1>
						<strong>대표 사진</strong>
					</h1>
				</div>
				<div class="panel-body text-center">
					<img class="text-center img-thumbnail" src="<%=Work_IMG%>"></img>
				</div>
			</div>


		<hr>

		<form name="Portfoilo_Content" method="post" action="#">
			<div class="panel panel-default">
				<div class="panel-heading text-center">
					<h1>
						<strong>주제</strong>
					</h1>
				</div>
				<div class="panel-body text-center">
					<%=Subject%>
				</div>
				<input type="hidden" name="Num" value="<%=num %>"> <input
					type="hidden" name="IMG" value="<%=Work_IMG%>"> <input
					type="hidden" name="Subject" value="<%=Subject%>">
			</div>
			<hr>

			<div class="panel panel-default">
				<div class="panel-heading text-center">
					<h1>
						<strong>작품 명</strong>
					</h1>
				</div>
				<div class="panel-body text-center">
					<%=Title%>
				</div>
				<input type="hidden" name="Title" value="<%=Title%>">

			</div>
			<hr>

			<div class="panel panel-default">
				<div class="panel-heading text-center">
					<h1>
						<strong>기간</strong>
					</h1>
				</div>
				<div class="panel-body text-center">
					<%=Period%>
				</div>
				<input type="hidden" name="Period" value="<%=Period%>">
			</div>
			<hr>


			<div class="panel panel-default">
				<div class="panel-heading text-center">
					<h1>
						<strong>작품 소개</strong>
					</h1>
				</div>
				<div class="panel-body text-center">
					<%=Explanation%>
				</div>
				<input type="hidden" name="Explanation" value="<%=Explanation%>">
			</div>
			<hr>

			<div class="text-right">
				<button type="button" class="btn btn-default"
					onClick="Delete_Portfolio(this.form)">
					<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
				</button>
				<button type="button" class="btn btn-default"
					onClick="Chan_Portfolio(this.form)">
					<span class="glyphicon glyphicon-wrench" aria-hidden="true"></span>
				</button>

			</div>
		</form>
	</div>
	<%
		}%>
	<div class="container">
		<hr style="border: solid 1px;">
	</div>
	<%
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					if (rs != null)
						try {
							rs.close();

						} catch (SQLException e) {
						}
					if (stmt != null)
						try {
							stmt.close();
						} catch (SQLException e) {
						}
					if (conn != null)
						try {
							conn.close();
						} catch (SQLException e) {
						}
				}

			}
		} catch (Exception e) {
			out.println(e);
		}
	%>
</body>
</html>