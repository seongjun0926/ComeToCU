<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="Util.DB"%>

<%
	request.setCharacterEncoding("utf-8");
	String Email = request.getParameter("Email");
	String PW = request.getParameter("Change_PW");
	
	
    Connection conn = null;
    Statement stmt = null;
    
    try{
    	conn = DB.getConnection();
    	if (conn == null)
            throw new Exception("데이터베이스에 연결할 수 없습니다.");
        stmt = conn.createStatement();
        String command = String.format("update M_Register set M_PW='"+PW+"' Where M_Email='"+Email+"'");        
        int rowNum = stmt.executeUpdate(command);
       
    }
    finally{
        try{
            stmt.close();
        }
        catch(Exception ignored){
        }
        try{
            conn.close();
        }
        catch(Exception ignored){
        }
    }
    //response.sendRedirect("DBInputResult.jsp");
%>  

