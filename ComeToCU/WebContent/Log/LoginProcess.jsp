<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import = "Util.DB" %>

	<%
	
	
		String Enter_ID = request.getParameter("S_Num");


		String Enter_PW = request.getParameter("S_PW");
		String redirectURI=request.getParameter("redirectURI");
		String Get_Class=""; //관리자 인지, 일반 회원인지 알기 위한 객체
		System.out.println(";"+redirectURI);
		String Get_ID = "";
		String Get_PW = "";
		String Get_Name = "";
		String Get_Certification="0"; //이메일 인증 여부를 위한 값 0이면 안함, 1이면 함

		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			conn = DB.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from C_students where S_Num='" + Enter_ID + "';");

			if (rs.next()) {
				Get_ID = rs.getString("S_Num");
				Get_PW = rs.getString("S_PassWord");
				Get_Name = rs.getString("S_Name");
				Get_Class = rs.getString("S_Class");
				Get_Certification = rs.getString("S_Certification");
				
				if (Get_PW.equals(Enter_PW)) {
					session.setAttribute("Get_Name", Get_Name);
					session.setAttribute("Get_ID",Get_ID);
					session.setAttribute("Get_Class",Get_Class);
					session.setAttribute("Get_Certification",Get_Certification);
					
					response.sendRedirect(redirectURI);
					
				} else {
				%>
				<SCRIPT>
					alert("암호가 잘못되었습니다.");
					history.go(-1);
				</SCRIPT>
				<%
		}
			}
			else{
				%>
				<SCRIPT>
				alert("학번이 잘못되었습니다.")
				history.go(-1);
				</SCRIPT>
				<%
			}

		} catch (SQLException e) {
			e.printStackTrace();
			%>
			<script>
			alert("에러 발생 : "+e.getMessage()+"관리자에게 문의해주세요.");
			</script>
			<%
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
