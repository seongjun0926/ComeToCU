<%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=utf-8" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>멤버 등록</title>
</head>
<body>

<%
//db에 입력하기 위한 정보 받아오기

String Write_Add=request.getParameter("InputAdd");
String Write_Edu=request.getParameter("InputEdu");
String Write_Bdate=request.getParameter("InputBdate");
String Write_ID=request.getParameter("InputID");
String Write_Name=request.getParameter("InputName");
String Write_PW=request.getParameter("InputPW");
String Write_Email=request.getParameter("InputEmail");
String Write_Phone=request.getParameter("InputPhone");

//db연결 위한 정보들
String DB_URL = "jdbc:mysql://localhost:3306/seongjun0926";
String DB_USER = "seongjun0926";
String DB_PASSWORD= "wnsduqrud0119";

Class.forName("com.mysql.jdbc.Driver");
Connection conn=null;
PreparedStatement pstmt=null;
Statement stmt=null;

try {
//디비 연결

 conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
 
 pstmt=conn.prepareStatement("insert into userlist(ID,name,password,email,phone,edu,addr,bdate)value(?,?,?,?,?,?,?,?)");
 
 pstmt.setString(1,Write_ID);
 pstmt.setString(2,Write_Name);
 pstmt.setString(3,Write_PW);
 pstmt.setString(4,Write_Email);
 pstmt.setString(5,Write_Phone);
 pstmt.setString(6,Write_Edu);
 pstmt.setString(7,Write_Add);
 pstmt.setString(8,Write_Bdate);
 
 pstmt.executeUpdate();
 

 
 
} catch(Exception e) {
 out.println(e.getMessage());
}
%>
<SCRIPT>
alert("등록되었습니다. 로그인 해주세요!");
history.go(-2);
</SCRIPT>


<%
application.log("write_db.jsp");
%>
</body>
</html>