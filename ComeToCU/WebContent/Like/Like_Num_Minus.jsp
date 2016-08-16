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

	String WB_ID= request.getParameter("WB_ID");
	String S_Num=(String)session.getAttribute("Get_ID");
	String S_L_C=request.getParameter("Like_Count");
	int Like_Count=Integer.parseInt(S_L_C);
	System.out.println("Like_Num_Minus.jsp "+"WB_ID="+WB_ID+","+"S_Num:"+S_Num+" Like_Count :"+Like_Count);


	Connection conn = null;
	PreparedStatement pstmt = null;
	PreparedStatement pstmt_Plus=null;
	Statement stmt = null;
	ResultSet rs=null;

	try {
		conn = DB.getConnection();
		conn.setAutoCommit(false);

		pstmt_Plus =conn.prepareStatement("update C_write_board set WB_Like_Num=WB_Like_Num-1 where WB_ID='" + WB_ID + "';");
		
		
		
		pstmt=conn.prepareStatement("delete from C_like_table where L_WB_ID="+WB_ID+" and L_S_Num='"+S_Num+"' ;");
		

		
 		pstmt_Plus.executeUpdate();
		pstmt.executeUpdate();
		conn.commit();
	
	
		%>
<result>
	<code>success</code>
	<data><![CDATA[[
	{
		Like_Num: <%= Like_Count-=1 %>,
		
	}]
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
				if (pstmt_Plus != null) 
					try { pstmt_Plus.close(); } catch(SQLException ex) {}
				if (pstmt != null) 
					try { pstmt.close(); } catch(SQLException ex) {}
				if (conn != null) try {
					conn.setAutoCommit(true);
					conn.close();
				} catch(SQLException ex) {}
			}
		%>
