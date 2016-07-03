<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.List"%>
<%@ page import = "Util.DB" %>

<%
String id = request.getParameter("id");

int re = 0;




Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

try {
	conn = DB.getConnection();
	stmt = conn.createStatement();
	rs = stmt.executeQuery("select * from students where S_Num='" + id + "';");
	
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