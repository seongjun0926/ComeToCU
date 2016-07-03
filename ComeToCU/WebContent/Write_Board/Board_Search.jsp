<?xml version="1.0" encoding="euc-kr" ?>
<%@ page contentType="text/xml; charset=euc-kr"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="Util.Util"%>
<%@ page import="Util.DB"%>



<% 
   String CS_ID = request.getParameter("id");
	String Get_Class=(String)session.getAttribute("Get_Class");
   
   System.out.println("Board_Search.jsp "+"CS_ID = "+CS_ID);
   
   Connection conn = null;
   Statement stmt = null;
   ResultSet rs = null;
   
   try{
      conn=DB.getConnection();
      stmt = conn.createStatement();
      
      if(Get_Class.equals("1")){
          rs=stmt.executeQuery("select * from category_detail where CS_ID="+CS_ID+" and NOT CD_ID=18 and NOT CD_ID=19;");
      }else{
    	  rs=stmt.executeQuery("select * from category_detail where CS_ID="+CS_ID+" and NOT CD_ID=18 and NOT CD_ID=19 and NOT CD_ID=20;");
      }
      %>
<result> <code>success</code> <data><![CDATA[
         [
         <%
         if(rs.next()){
            do{
               if(rs.getRow()>1){%>
               ,
               <%
                }
               %>
               {
               id : <%= rs.getInt("CD_ID")%>,
               CD_Contents :'<%=Util.toJS(rs.getString("CD_Contents")) %>'
               }
               <%
            }while(rs.next());
         }
         %>
         ]
         ]]></data> </result>
<%}catch(Throwable e){
            out.clearBuffer();
            %>
<result> <code>error</code> <message><![CDATA[<%=e.getMessage()%>]]></message>
</result>
<%}finally{
            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
         }
 %>