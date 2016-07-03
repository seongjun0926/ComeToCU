<?xml version="1.0" encoding="euc-kr" ?>
<%@ page contentType="text/xml; charset=euc-kr" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "Util.Util" %>
<%@ page import = "Util.DB" %>
<%
	String WB_ID = request.getParameter("WB_ID");
	System.out.println("Like_Num.jsp "+"WB_ID : "+WB_ID);

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	try {
		conn = DB.getConnection();
		conn.setAutoCommit(false);
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select WB_ID, WB_Like_Num from write_board where WB_ID="+WB_ID+";");
%>
<result>
	<code>success</code>
	<data><![CDATA[
	[
<%
		if (rs.next()) {
			do {
				if (rs.getRow() > 1) { %>
		,
<%
				}
%>
		{
			Like_Num: <%=rs.getInt("WB_Like_Num") %>
	
		}
<%
			} while(rs.next());
		}
%>
	]
	]]></data>
</result>
<%	} catch(Throwable e) {
		out.clearBuffer();
 %>
<result>
	<code>error</code>
	<message><![CDATA[<%= e.getMessage() %>]]></message>
</result>
<%	} finally {
		if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
%>
