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
<title>자기소개서 수정</title>
</head>
<body>

	<%
		//db에 입력하기 위한 정보 받아오기
		String Session_ID = "";

		String UpDate_Name = request.getParameter("UpDateName");
		String UpDate_Bdate = request.getParameter("UpDateBdate");
		String UpDate_Phone = request.getParameter("UpDatePhone");
		String UpDate_Add = request.getParameter("UpDateAddr");
		String UpDate_Email = request.getParameter("UpDateEmail");
		String UpDate_Edu = request.getParameter("UpDateEdu");
	
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
				PreparedStatement pstmt = null;

				try {
					conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

					pstmt = conn.prepareStatement("update userlist set name=?,email=?,phone=?,edu=?,addr=?,bdate=? where ID=?;");
					
					pstmt.setString(1, UpDate_Name);
					pstmt.setString(2, UpDate_Email);
					pstmt.setString(3, UpDate_Phone);
					pstmt.setString(4, UpDate_Edu);
					pstmt.setString(5, UpDate_Add);
					pstmt.setString(6, UpDate_Bdate);
					pstmt.setString(7, Session_ID);
					
					pstmt.executeUpdate();

				} catch (Exception e) {
					out.println(e.getMessage());
				}
			}
		} catch (Exception e) {
			out.println(e);
		}
		
	response.sendRedirect("/S_D/SELF/Self_Show.jsp");
	%>
	
	



</body>
</html>