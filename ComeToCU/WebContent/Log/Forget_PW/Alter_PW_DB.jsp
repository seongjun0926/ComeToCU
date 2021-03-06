<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="Util.DB"%>
<%@page import="Util.Password"%>

<%@ page import="sun.misc.BASE64Decoder"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		BASE64Decoder base64Decoder = new BASE64Decoder();
		String S_Num = request.getParameter("S_Num");

		try {
			S_Num = new String(base64Decoder.decodeBuffer(S_Num));
			
			String S_Password = request.getParameter("S_Password");


			Password PW = new Password();//pw 암호화
			S_Password = PW.createHash(S_Password);

			Connection conn = null;
			Statement stmtIdSelect = null;
			PreparedStatement pstmtCommentInsert = null;

			try {
				conn = DB.getConnection();
				conn.setAutoCommit(false);

				pstmtCommentInsert = conn
						.prepareStatement("update C_students set S_PassWord=? where S_Num=?");
				pstmtCommentInsert.setString(1, S_Password);
				pstmtCommentInsert.setString(2, S_Num);

				pstmtCommentInsert.executeUpdate();

				conn.commit();
	%>
	<script>
		alert("암호가 변경되었습니다. 즐겨주세요!")
		location.href = "/index.jsp";
	</script>
	<%
		} catch (Throwable e) {
			%>
			<script>
			alert("비정상적 접근입니다1.");
			location.href="/index.jsp"
			</script>
			<%
				try {
					conn.rollback();
				} catch (SQLException ex) {
					%>
					<script>
					alert("비정상적 접근입니다2.");
					location.href="/index.jsp"
					</script>
					<%
				}
			} finally {
				if (stmtIdSelect != null)
					try {
						stmtIdSelect.close();
					} catch (SQLException ex) {
					}
				if (pstmtCommentInsert != null)
					try {
						pstmtCommentInsert.close();
					} catch (SQLException ex) {
					}
				if (conn != null)
					try {
						conn.setAutoCommit(true);
						conn.close();
					} catch (SQLException ex) {
					}
			}
		} catch (Exception e) {
			%>
			<script>
			alert("값이 없습니다.");
			location.href="/index.jsp"
			</script>
			 <%
			 e.printStackTrace();
		}
	%>
</body>
</html>