<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">


<title>오소서 메인</title>



</head>
<body>
<jsp:include page="/S_D/NavBar.jsp" flush="false"/>
	<br>
	<br>
	<br>
	<%
		String Session_ID = "";
		String Show_ID = "";

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
				Statement stmt_Show_Content = null;
				ResultSet rs = null;
				ResultSet rs_Show_Content = null;

				try {
					conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
					stmt = conn.createStatement();
					stmt_Show_Content = conn.createStatement();
					rs = stmt.executeQuery("select DISTINCT I_ID from Introduce");

					while (rs.next()) {
						Show_ID = rs.getString("I_ID");
						rs_Show_Content = stmt_Show_Content.executeQuery(
								"Select qlist, I_answer from Introduce I LEFT OUTER JOIN question Q ON I.I_num=Q.qnum where I_ID='"
										+ Show_ID + "';");
	%>
	<form name="Detail" action="/S_D/Detail_Show.jsp" method="post">
		<div class="container">
			<div class="panel panel-info">
				<!-- Default panel contents -->
				<div class="panel-heading text-center ">
				<input type="hidden" name="Show_ID" value=<%=Show_ID %>>
					<button type="submit" class="btn btn-link"><strong><%=Show_ID%></strong></button>
				</div>
				<table class="table table-hover">

					<%
						while (rs_Show_Content.next()) {
											String Show_Qlist = rs_Show_Content.getString("qlist");
											if (Show_Qlist.length() > 10) {
												Show_Qlist = Show_Qlist.substring(0, 10) + "...";
											}
											String Show_Answer = rs_Show_Content.getString("I_answer");
											if (Show_Answer.length() > 10) {
												Show_Answer = Show_Answer.substring(0, 10) + "...";
											}
					%>
					<!-- Table -->
					<tr>
						<td><%=Show_Qlist%></td>
						<td><%=Show_Answer%></td>
						
					</tr>

					<%
						}
					%>

				</table>
			</div>
		</div>
	</form>


	<%
		}
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					if (rs != null)
						try {
							rs.close();
							rs_Show_Content.close();
						} catch (SQLException e) {
						}
					if (stmt != null)
						try {
							stmt.close();
							stmt_Show_Content.close();
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
			response.sendRedirect("/");
		}
	%>








</body>
</html>