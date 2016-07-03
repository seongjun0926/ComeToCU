<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.List"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="Util.DB"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		String Wrtie_Name = request.getParameter("S_Name");
		String Wrtie_Major = request.getParameter("S_Major");
		String Write_Num_Parse = request.getParameter("S_Num");
		int Write_Num=Integer.parseInt(Write_Num_Parse);
		String Write_PassWord = request.getParameter("S_Password");

		System.out.println(Wrtie_Name+","+Wrtie_Major+","+Write_Num+","+Write_PassWord);
		
		Connection conn = null;
		PreparedStatement pstmt = null;


		try {
			//디비 연결

			conn = DB.getConnection();
			conn.setAutoCommit(false);

			pstmt = conn.prepareStatement("insert into students(S_Name,S_Major,S_Num,S_PassWord,S_Question,S_Answer)value(?,?,?,?,?,?)");

			pstmt.setString(1, Wrtie_Name);
			pstmt.setString(2, Wrtie_Major);
			pstmt.setInt(3, Write_Num);
			pstmt.setString(4, Write_PassWord);
			pstmt.setInt(5, 1);
			pstmt.setString(6, "대구");

			
		
			
			pstmt.executeUpdate();
			conn.commit();
			pstmt.close();
			conn.close();
			
			%>
			<script>
			alert("회원 가입이 완료되었습니다. 로그인해주세요!")
			</script>
			<%
			response.sendRedirect("/index.jsp");

		} catch (Exception e) {
			out.println(e.getMessage());
			%>
			<script>
			alert("에러 발생 : "+e.getMessage()+"관리자에게 문의해주세요.");
			</script>
			<%
		}
	%>






</body>
</html>