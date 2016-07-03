<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="utf-8"%>
<%@ page
	import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>


<title>재능 저장</title>
</head>
<body>
	<%
		String Subject = request.getParameter("InputSubject");
		String Work_IMG = request.getParameter("Work_IMG");
		String Title = request.getParameter("InputTitle");
		String Period = request.getParameter("InputPeriod");
		String Explanation = request.getParameter("InputExplanation");

		String Session_ID = "";
		try {
			Session_ID = (String) session.getAttribute("Session_ID");

			if (Session_ID == null || Session_ID.equals("")) {

				response.sendRedirect("/");
			} else {

				//db연결 위한 정보들
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

					pstmt = conn.prepareStatement(
							"insert into Portfolio(P_ID,P_WorkIMG,P_Subject,P_Title,P_Period,P_Explanation)value(?,?,?,?,?,?)");

					pstmt.setString(1, Session_ID);
					pstmt.setString(2, Work_IMG);
					pstmt.setString(3, Subject);
					pstmt.setString(4, Title);
					pstmt.setString(5, Period);
					pstmt.setString(6, Explanation);


					pstmt.executeUpdate();

				} catch (Exception e) {
					out.println(e.getMessage());
				}

			}
		} catch (Exception e) {
			out.println(e);
		}
	%>
<%response.sendRedirect("/S_D/Portfolio/Portfolio_Show.jsp");%>
</body>
</html>