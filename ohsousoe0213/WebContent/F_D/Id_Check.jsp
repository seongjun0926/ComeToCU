<%@ page contentType="text/plain; charset=utf-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.sql.*;"%>

<%
String id = request.getParameter("id");

int re = 0;

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
	rs = stmt.executeQuery("select * from userlist where ID='" + id + "';");
	
	while (rs.next()) {
		re = 1;
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
%>
<%=re%>