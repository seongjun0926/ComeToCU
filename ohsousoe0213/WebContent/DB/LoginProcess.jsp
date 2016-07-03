<%@ page language="java" pageEncoding="utf-8"
	contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>로그인 중입니다.</title>
</head>
<body>

	<%
		String Enter_ID = request.getParameter("EnterID");
		String Enter_PW = request.getParameter("EnterPW");
		
		String DB_URL = "jdbc:mysql://localhost:3306/seongjun0926";
		String DB_USER = "seongjun0926";
		String DB_PASSWORD = "wnsduqrud0119";
		
		String Get_ID = "";
		String Get_PW = "";

		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			//디비 연결
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select ID,password from userlist where ID='" + Enter_ID + "';");

			if (rs.next()) {

				Get_ID = rs.getString("ID");
				Get_PW = rs.getString("password");

				
				
				if(Get_PW.equals(Enter_PW)){
					
					session.setAttribute("Session_ID", Enter_ID);
					response.sendRedirect("../S_D/Main.jsp");
				}
				else{
					%>
					<SCRIPT>
					alert("비밀번호가 잘못되었습니다.");
					history.go(-1);
					</SCRIPT>
					<%
				
				}
			}
			else{
					%>
					<SCRIPT>
					alert("ID가 잘못되었습니다.");
					history.go(-1);
					</SCRIPT>
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
	%>


</body>
</html>