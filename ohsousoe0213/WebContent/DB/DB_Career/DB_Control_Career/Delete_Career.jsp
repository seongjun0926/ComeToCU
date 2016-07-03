<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>삭제</title>

</head>

<body>

	<%
		String Session_ID = "";

		try {
			Session_ID = (String) session.getAttribute("Session_ID");

			if (Session_ID == null || Session_ID.equals("")) {
	%>
	<script>
		alert("세션이 만료되었습니다. 다시 로그인 해주세요.");
	</script>
	<%
	response.sendRedirect("/");
	
			}else{
				%>
	<jsp:include page="/S_D/NavBar.jsp" flush="false">

		<jsp:param name="param" value="value1" />

	</jsp:include>

	<br>
	<br>
	<br>



	<%
	String Delete_Number=request.getParameter("del_num");
	String Delete_Activity = request.getParameter("activity");
	String Delete_Name = request.getParameter("del_name");
    String Delete_Period = request.getParameter("del_period");
    String Delete_Content = request.getParameter("del_content");
	
	//db연결 위한 정보들
	String DB_URL = "jdbc:mysql://localhost:3306/seongjun0926";
	String DB_USER = "seongjun0926";
	String DB_PASSWORD= "wnsduqrud0119";

	Class.forName("com.mysql.jdbc.Driver");
	Connection conn=null;
	PreparedStatement pstmt=null;
	Statement stmt=null;

	try {
	//디비 연결

	 conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	 
	 pstmt=conn.prepareStatement("delete from career where num=? and c_id=? and c_value=? and c_name=? and c_period=? and c_content=?");
	 pstmt.setString(1,Delete_Number);
	 pstmt.setString(2,Session_ID);
	 pstmt.setString(3,Delete_Activity);
	 pstmt.setString(4,Delete_Name);
	 pstmt.setString(5,Delete_Period);
	 pstmt.setString(6,Delete_Content);

	 
	 pstmt.executeUpdate();
	 

	
	 response.sendRedirect("/DB/DB_Career/DB_Control_Career/Show_Career.jsp");
	} catch(Exception e) {
	 out.println(e.getMessage());
	}
	
	
	
	
			}

		} catch (Exception e) {
			out.println(e);
		}
	%>



</body>
</html>