<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="Util.DB"%>

<%
	request.setCharacterEncoding("utf-8");
    String Name = request.getParameter("Name");
	String Email = request.getParameter("Email");
	String PW = request.getParameter("PW");
	String PW_Question = request.getParameter("PW_Question");
	String PW_Answer = request.getParameter("PW_Answer");
	
    Connection conn = null;
    Statement stmt = null;
    
    try{
   	 conn = DB.getConnection();
if (conn == null)
            throw new Exception("데이터베이스에 연결할 수 없습니다.");
        stmt = conn.createStatement();
        String command = String.format("insert into M_Register (M_Name, M_Email, M_PW, M_PW_Question, M_PW_Answer) values ('%s', '%s', '%s', '%s', '%s');",Name,Email,PW,PW_Question,PW_Answer);        
        int rowNum = stmt.executeUpdate(command);
        if (rowNum < 1)
            throw new Exception("데이터를 DB에 입력할 수 없습니다.");
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