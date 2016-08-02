<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="Util.DB"%>

<%
response.setCharacterEncoding("UTF-8");
String PW_Answer = request.getParameter("PW_Answer");
JSONObject jsonMain = new JSONObject();
JSONArray jArray = new JSONArray();

JSONObject jObject = new JSONObject();

//json을 만드는 부분인데,, 설명을 못쓰겠습니다. 고수님들 도와주세요.~
    Connection conn = null;

 try{
	 conn = DB.getConnection();
  Statement stmt = conn.createStatement();
  //스테이트먼트 객체를 생성합니다.
  String query = "select * from M_Register Where M_PW_Answer='"+PW_Answer+"'";
//db에 날릴 쿼리문을 생성합니다. 

ResultSet rs = stmt.executeQuery(query);
       //쿼리를 실행합니다. 
  int i =0;
  if(rs.next())
  {
//쿼리문 중 id와 pw를 비교해서 일치하는 게 있는경우 첫번째 메시지에 succed를 담습니다.
//두세번째는 그냥 아무거나 상관없습니다.
   String M_PW_Answer = rs.getString("M_PW_Answer");
    i =1;
    jObject.put("Check", "succed");
   
  }
//없는 경우에는 succed 담습니다.
  if(i==0){
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