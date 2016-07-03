<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>자격증 취득 저장</title>
</head>
<body>

	<%
		String Session_ID = "";

		try {
			Session_ID = (String) session.getAttribute("Session_ID");

			if (Session_ID == null || Session_ID.equals("")) {
				response.sendRedirect("index.jsp");
			}

		} catch (Exception e) {
			out.println(e);
		}
		String value = request.getParameter("a");
		String Value_str1;
		String Value_str2;
		String Value_str3;

		int Out_count = Integer.parseInt(request.getParameter("C_count"));

		for (int i = 1; i <= Out_count; i++) {
			String str1 = "CActivity" + i;
			String str2 = "C_Period" + i;
			String str3 = "C_Context" + i;

			Value_str1 = request.getParameter(str1);
			Value_str2 = request.getParameter(str2);
			Value_str3 = request.getParameter(str3);

			if (Value_str1 != null && Value_str2 != null && Value_str3 != null) {

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
							"insert into career(c_id,c_value,c_name,c_period,c_content,c_job)value(?,?,?,?,?,?)");

					pstmt.setString(1, Session_ID);
					pstmt.setString(2, value);
					pstmt.setString(3, Value_str1);
					pstmt.setString(4, Value_str2);
					pstmt.setString(5, Value_str3);
					pstmt.setString(6, null);

					pstmt.executeUpdate();

				} catch (Exception e) {
					out.println(e.getMessage());
				}
			}

		}
	%>

	<script>
		alert("자격층취득 등록되었습니다.");
		history.go(-1);
	</script>


</body>
</html>