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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String Session_ID = "";
	
		String Qnum = request.getParameter("qnum");
		String Answer = request.getParameter("Answer");
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
				Statement stmt = null;

				try {
					//디비 연결

					conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

					pstmt = conn.prepareStatement("Insert Into Introduce (I_answer,I_ID,I_num) value(?,?,?)");

					pstmt.setString(1, Answer);
					pstmt.setString(2, Session_ID);
					pstmt.setString(3, Qnum);


					pstmt.executeUpdate();
					%>
	<script>
					alert("등록 되었습니다.")
					history.go(-1);
				</script>
	<%
				} catch (Exception e) {
					out.println(e.getMessage());
					%>

	<script>
					alert("오류가 있습니다. 관리자에게 문의해주세요.");
					</script>
	<%
				}
			}
		} catch (Exception e) {
			out.println(e);
			
		}
	%>





</body>
</html>