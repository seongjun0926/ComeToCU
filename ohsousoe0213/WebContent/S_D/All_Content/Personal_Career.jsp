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
</head>

<body>

	<div class="container text-left">
		<h2>이력 사항</h2>
	</div>
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
				Statement stmt_value = null;
				Statement stmt_value_detail = null;

				ResultSet rs = null;
				ResultSet rs_value = null;
				ResultSet rs_value_detail = null;

				try {
					conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
					stmt = conn.createStatement();
					stmt_value_detail = conn.createStatement();
					rs = stmt.executeQuery(
							"select DISTINCT(a_name),c_value from career LEFT OUTER JOIN activity ON a_value=c_value where c_id='"
									+ Session_ID + "';");

					while (rs.next()) {

						String C_Value = rs.getString("c_value");
	%>
	<div class="container">
		<div class="panel panel-success">


			<div class="panel-heading text-center">
				<h1>
					<strong><%=rs.getString("a_name")%></strong>
				</h1>
			</div>
			<table class="table table-striped">
				<tr>
					<th class="col-xs-1 text-center">번호</th>
					<th class="col-xs-3 text-center">기관 및 프로그램 명</th>
					<th class="col-xs-2 text-center">기간</th>
					<th class="col-xs-5 text-center">내용</th>
				</tr>
				<%
					rs_value_detail = stmt_value_detail.executeQuery("SELECT * from career where c_id='"
											+ Session_ID + "' and c_value='" + C_Value + "';");

									while (rs_value_detail.next()) {
										int count = rs_value_detail.getRow();
				%>

				<tr>
					<td class="col-xs-1 text-center"><%=count%></td>
					<td class="col-xs-3 text-center"><%=rs_value_detail.getString("c_name")%></td>
					<td class="col-xs-2 text-center"><%=rs_value_detail.getString("c_period")%></td>
					<td class="col-xs-4 text-center"><%=rs_value_detail.getString("c_content")%></td>
				</tr>

				<%
					}
				%>

			</table>

			
		</div>
		<hr>
	</div>

	<%
		}
					%>
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
		}

		catch (Exception e) {
			out.println(e);
		}
	%>

</body>
</html>