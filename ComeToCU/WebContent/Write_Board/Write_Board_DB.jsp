<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "Util.DB" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

	request.setCharacterEncoding("UTF-8");
	String WB_Contents= request.getParameter("ir1");
	String F_Category=request.getParameter("F_Category");
	String CD_ID=request.getParameter("S_Category");
	String WB_Header=request.getParameter("WB_Header");
	String WB_Creator=(String)session.getAttribute("Get_ID");
	Date from = new Date();
	SimpleDateFormat transFormat = new SimpleDateFormat("yy-MM-dd HH:mm");
	String WB_Time = transFormat.format(from);
	String URI = (String)session.getAttribute("URI");//전에 있던 페이지로 돌아가기위한 변수
	
	
	System.out.println("Write_Board_DB.jsp "+"CS_ID : "+F_Category+
			" CD_ID : "+CD_ID+" WB_Header : "+WB_Header+
			" WB_Contents : "+WB_Contents+" WB_Time : "+WB_Time+" URI : "+URI);
	
	
	Connection conn = null;
	Statement stmtIdSelect = null;
	PreparedStatement pstmtCommentInsert = null;
	
	try {
		conn = DB.getConnection();
		conn.setAutoCommit(false);
		
		pstmtCommentInsert = conn.prepareStatement(
			"insert into C_write_board(CD_ID,WB_Header,WB_Contents,WB_Creator,WB_Time)value (?,?,?,?,?)");
		pstmtCommentInsert.setString(1, CD_ID);
		pstmtCommentInsert.setString(2, WB_Header);
		pstmtCommentInsert.setString(3, WB_Contents);
		pstmtCommentInsert.setString(4, WB_Creator);
		pstmtCommentInsert.setString(5, WB_Time);
		pstmtCommentInsert.executeUpdate();
		
		conn.commit();
		
		 response.sendRedirect(URI);
		
	} catch(Throwable e) {
		try { conn.rollback(); } catch(SQLException ex) {}
	} finally {
		if (stmtIdSelect != null) 
			try { stmtIdSelect.close(); } catch(SQLException ex) {}
		if (pstmtCommentInsert != null) 
			try { pstmtCommentInsert.close(); } catch(SQLException ex) {}
		if (conn != null) try {
			conn.setAutoCommit(true);
			conn.close();
		} catch(SQLException ex) {}
	}
	
%>
</body>
</html>