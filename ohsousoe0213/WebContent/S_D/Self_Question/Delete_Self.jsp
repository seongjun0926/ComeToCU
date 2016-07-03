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

<title>선택 질문 삭제</title>
</head>
<body>
	<%
		String Session_ID = "";

		try {
			Session_ID = (String) session.getAttribute("Session_ID");

			if (Session_ID == null || Session_ID.equals("")) {

				response.sendRedirect("/");
			} else {
				String Qlist = request.getParameter("qlist");
				String[] Qnum = Qlist.split("/");

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

					pstmt = conn.prepareStatement("DELETE FROM Introduce WHERE I_ID=? AND I_num=?");

					pstmt.setString(1, Session_ID);
					pstmt.setString(2, Qnum[0]);


					pstmt.executeUpdate();
				} catch (Exception e) {
					out.println(e.getMessage());
				}
			}
		} catch (Exception e) {

			out.println(e);
		}
	%>
	
<% response.sendRedirect("/S_D/SELF/Self_Show.jsp") ;%>




</body>
</html>