<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="Util.DB"%>

<%
String E_Mail = request.getParameter("E_Mail");
String PW = request.getParameter("PW");

JSONObject jsonMain = new JSONObject();
JSONArray jArray = new JSONArray();

JSONObject jObject = new JSONObject();

//json을 만드는 부분인데,, 설명을 못쓰겠습니다. 고수님들 도와주세요.~
    Connection conn = null;

 try{
	 conn = DB.getConnection();
  Statement stmt = conn.createStatement();
  //스테이트먼트 객체를 생성합니다.
 String query = "select COUNT(*) from M_Register where M_Email='"+E_Mail+"' and M_PW='"+PW+"'";
//db에 날릴 쿼리문을 생성합니다. 

ResultSet rs = stmt.executeQuery(query);
       //쿼리를 실행합니다. 
  int total =0;
  if(rs.next())
  {
	 total = rs.getInt(1);
  }
   
   
  
//없는 경우에는 succed 담습니다.
  if(total==1){
   jObject.put("Check", "succed");
   
  }else{
	jObject.put("Check", "failed");
  }
  
  stmt.close();
  conn.close();
//stmt와 conn객체를 닫습니다.
  jArray.add(0,jObject);
//담은 데이터를 배열로 만듭니다.
  jsonMain.put("results",jArray);
//안드로이드로 데이터를 날립니다.
  out.println(jsonMain.toJSONString());
 }catch(Exception e){
 }
%>