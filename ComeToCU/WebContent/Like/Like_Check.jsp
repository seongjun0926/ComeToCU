<%@ page contentType="text/xml; charset=euc-kr"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="Util.Util"%>
<%@ page import="Util.DB"%>
<%
	String WB_ID=request.getParameter("WB_ID");
	String S_Num=(String)session.getAttribute("Get_ID");
	System.out.println("Like_Check.jsp"+"WB_ID="+WB_ID+","+"S_Num:"+S_Num);

	int re=0;
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	try {
		conn = DB.getConnection();
		conn.setAutoCommit(false);

		stmt = conn.createStatement();
		rs = stmt.executeQuery("select * from C_like_table where L_WB_ID="+WB_ID+" and L_S_Num="+S_Num+";");
	%>
<result> <code>success</code> <data><![CDATA[
	[
<%
		if (rs.next()) {
			re = 1;
		}
		%>
		{
			Like_Check: <%=re%>
		}
	<%
		
		
%>
	]
	]]></data> </result>
<%	} catch(Throwable e) {
		out.clearBuffer();
 %>
<result> <code>error</code> <message><![CDATA[<%= e.getMessage() %>]]></message>
</result>
<%	} finally {
		if (rs != null) try { rs.close(); } catch(SQLException ex) {}
		if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
%>
