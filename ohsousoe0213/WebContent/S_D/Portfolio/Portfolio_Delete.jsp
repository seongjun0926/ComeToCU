<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>재능 삭제</title>
</head>
<body>
	<%
		String Num = "";

		String Session_ID = "";
		try {
			Session_ID = (String) session.getAttribute("Session_ID");

			if (Session_ID == null || Session_ID.equals("")) {

				response.sendRedirect("/");

			} else {
				
				Num=request.getParameter("Num");
				
				String DB_URL = "jdbc:mysql://localhost:3306/seongjun0926";
				String DB_USER = "seongjun0926";
				String DB_PASSWORD = "wnsduqrud0119";

				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = null;
				PreparedStatement pstmt = null;
				Statement stmt = null;

				try {
					//디비 연결

					conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

					pstmt = conn.prepareStatement("DELETE FROM Portfolio WHERE P_ID=? AND P_Num=?");

					pstmt.setString(1, Session_ID);
					pstmt.setString(2, Num);


					pstmt.executeUpdate();
				} catch (Exception e) {
					out.println(e.getMessage());
				}
				
				
				
				
				
				
			}
		} catch (Exception e) {

			out.println(e);
		}
	%>
	
<% response.sendRedirect("/S_D/Portfolio/Portfolio_Show.jsp") ;%>
</body>
</html>