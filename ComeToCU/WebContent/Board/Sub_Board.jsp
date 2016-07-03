<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="Util.DB"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style type="text/css">
a.one{
   background-color: #89b7c2;
   color:white;
   
}
a.two{
  background-color:#76b191;
   color:white;
}
a.one:hover, a.one:active {
  background-color:white;
   border:2px solid #d9edf7;
   color:#7aaec7;
}
a.two:hover{
   background-color:white;
   border:2px solid #83cd8f;
   color:#83cd8f;
   }
</style>

</head>
<body>

<!-- 크건 작건 사이즈는 2로 , 꽉찬 화면에서만 보임 -->
   <div class="col-md-2 col-xs-2 visible-md visible-lg">
      <div class="list-group">
         <%
            String CS_ID = request.getParameter("CS_ID");
            
            System.out.println("Sub_Board.jsp "+"CS_ID : "+CS_ID);
            
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
               conn = DB.getConnection();
               stmt = conn.createStatement();
               rs = stmt.executeQuery("select * from category_detail where CS_ID=" + CS_ID + ";");

               while (rs.next()) {
                  String CD_ID = rs.getString("CD_ID");
                  String CD_Contents = rs.getString("CD_Contents");
         
         
         %>
         <!-- get방식으로 정보 전송해서 sub_Board에 표시되는 항목들을 적용-->
         <a href="/Board/Show_Board.jsp?CD_ID=<%=CD_ID%>&CS_ID=<%=CS_ID%>" class="one list-group-item list-group-item-default">-<%=CD_Contents%></a>

         <%
            }
            } catch (SQLException e) {
               e.printStackTrace();
            } finally {
               if (rs != null)
                  rs.close();
               if (stmt != null)
                  stmt.close();
               if (conn != null)
                  conn.close();
            }
         %>
      </div>
      <br>
      <div class="list-group">
         <a href="/Write_Board/Write_Board.jsp" class="two list-group-item list-group-item-default">-글 쓰기</a>
      </div>
   </div>
</body>
</html>