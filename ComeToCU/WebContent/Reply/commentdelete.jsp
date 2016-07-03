<?xml version="1.0" encoding="utf-8" ?>
<%@ page contentType="text/xml; charset=utf-8" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "Util.Util" %>
<%@ page import = "Util.DB" %>
<%
	

	request.setCharacterEncoding("utf-8");
	int id = Integer.parseInt(request.getParameter("Delete_R_ID"));
	System.out.println("commentDelet.jsp id:"+id);

	Connection conn = null;
	PreparedStatement pstmt = null;
	try {
		conn = DB.getConnection();
		conn.setAutoCommit(false);
		
		pstmt = conn.prepareStatement(
			"delete from reply where R_Num=?");
		pstmt.setInt(1, id);
		pstmt.executeUpdate();
		
		conn.commit();
%>
<result>
	<code>success</code>
	<id><%= id %></id>
</result>
<%
	} catch(Throwable e) {
		try { conn.rollback(); } catch(SQLException ex) {}
%>
<result>
	<code>error</code>
	<message><![CDATA[<%= e.getMessage() %>]]></message>
</result>
<%
	} finally {
		if (pstmt != null)
			try { pstmt.close(); } catch(SQLException ex) {}
		if (conn != null) try {
			conn.setAutoCommit(true);
			conn.close();
		} catch(SQLException ex) {}
	}
%>