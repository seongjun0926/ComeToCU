<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title></title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script type="text/javascript">
	function Delete_Self(frm) {
		if (confirm("삭제하시겠습니까?") == true) {
			frm.action = "/S_D/SELF/Self_Question/Delete_Self.jsp"
			var frm_ = frm.submit();
		} else {
			return;
		}
	}

	function Chan_Self(frm) {

		frm.action = "/S_D/SELF/Self_Question/Self_Question_Chan.jsp"
		var frm_ = frm.submit();

	}
</script>
<body>
	<jsp:include page="/S_D/NavBar.jsp" flush="false" />
	<br>
	<br>
	<br>
	<%
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
					rs = stmt.executeQuery(
							"select Q.qnum,Q.qlist,I.I_answer from Introduce I LEFT OUTER JOIN question Q ON I.I_num=Q.qnum where I_ID='"
									+ Session_ID + "';");

					while (rs.next()) {
	%>
	<div class="container">
		<form name="SQA"
			action="/S_D/SELF/Self_Question/Self_Question_Chan.jsp" method="post">
			<div class="panel panel-info">


				<div class="panel-heading text-center">
					<h3>
						<strong><%=rs.getString("Q.qlist")%></strong>
					</h3>
				</div>
				<input type="hidden" name="qlist"
					value="<%=rs.getString("Q.qnum")%>/<%=rs.getString("Q.qlist")%>">
				<input type="hidden" name="qlist_Answer"
					value="<%=rs.getString("I_answer")%>">
				<div class="panel-body text-center">
					<h4>
						<%=rs.getString("I_answer")%>
					</h4>
				</div>

			</div>
			<div class="text-right">
				<button type="button" class="btn btn-default"
					onClick="Delete_Self(this.form)">
					<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
				</button>
				<button type="button" class="btn btn-default"
					onClick="Chan_Self(this.form)">
					<span class="glyphicon glyphicon-wrench" aria-hidden="true"></span>
				</button>

			</div>

		</form>

		<hr>
	</div>
	<%
		}

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