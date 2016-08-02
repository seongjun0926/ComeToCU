<?xml version="1.0" encoding="UTF-8" ?>
<!-- 원래 euc-kr 이였음 -->
<%@ page contentType="text/xml; charset=UTF-8" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "Util.Util" %>
<%@ page import = "Util.DB" %>

<%
	request.setCharacterEncoding("utf-8");
	String R_Creator= (String)session.getAttribute("Get_ID");
	String WB_ID = request.getParameter("WB_ID");
	String content = request.getParameter("content");
	String R_Time = request.getParameter("R_Time");

	int R_Num=0;
	
	System.out.println("commentadd.jsp "+"R_Creator : "+R_Creator+"WB_ID : "+WB_ID+"content : "+content+"R_Time : "+R_Time);

	Connection conn = null;
	Statement stmtIdSelect = null;
	PreparedStatement pstmtCommentInsert = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	try {
		conn = DB.getConnection();
		conn.setAutoCommit(false);
		
		stmt = conn.createStatement();
		
		pstmtCommentInsert = conn.prepareStatement(
			"insert into C_reply(R_Contents,R_Creator,WB_ID,R_Time)value (?,?,?,?)");
		pstmtCommentInsert.setString(1, content);
		pstmtCommentInsert.setString(2, R_Creator);
		pstmtCommentInsert.setString(3, WB_ID);
		pstmtCommentInsert.setString(4, R_Time);
		pstmtCommentInsert.executeUpdate();
		
		rs = stmt.executeQuery("select R_Num from C_reply where WB_ID="+WB_ID+" and R_Contents='"+content+"' and R_Creator='"+R_Creator+"' and R_Time='"+R_Time+"';");
		if(rs.next()){
			R_Num=rs.getInt("R_Num");
		}
	
		conn.commit();
%>
<result>
	<code>success</code>
	<data><![CDATA[
	{
		id: <%= R_Num %>,
		name: '<%= Util.toJS(R_Creator) %>',
		content: '<%= Util.toJS(content) %>',
		time:'<%=Util.toJS(R_Time)%>'
	}
	]]></data>
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
