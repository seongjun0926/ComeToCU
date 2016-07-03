<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		String Session_ID = "";
		String Num=request.getParameter("Num");
		String ChanSubject = request.getParameter("ChanSubject");
		String ChanTitle = request.getParameter("ChanTitle");
		String ChanPeriod = request.getParameter("ChanPeriod");
		String ChanExplanation = request.getParameter("ChanExplanation");
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

					pstmt = conn.prepareStatement("update Portfolio set P_Subject=?,P_Title=?,P_Period=?,P_Explanation=? where P_ID=? AND P_Num=?");

					pstmt.setString(1, ChanSubject);
					pstmt.setString(2, ChanTitle);
					pstmt.setString(3, ChanPeriod);
					pstmt.setString(4, ChanExplanation);
					pstmt.setString(5, Session_ID);
					pstmt.setString(6, Num);

					pstmt.executeUpdate();
	%>
	<%
		response.sendRedirect("/S_D/Portfolio/Portfolio_Show.jsp");
	%>
	<%
		} catch (Exception e) {
					out.println(e.getMessage());
	%>
	<script>
		alert("오류가 있습니다. 관리자에게 문의하세요.")
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