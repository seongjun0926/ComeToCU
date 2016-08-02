<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="Util.DB"%>

<%
String M_C_Num = request.getParameter("M_C_Num");
//json을 만드는 부분인데,, 설명을 못쓰겠습니다. 고수님들 도와주세요.~
    Connection conn = null;
	PreparedStatement pstmt = null;


 try{
	 conn = DB.getConnection();
		pstmt = conn.prepareStatement("delete from M_Create where M_C_Num=?");
		pstmt.setString(1, M_C_Num);
		pstmt.executeUpdate();

		conn.commit();
       //쿼리를 실행합니다. 
 } catch (Throwable e) {
		try {
			conn.rollback();
		} catch (SQLException ex) {
		}
	} finally {
		if (pstmt != null)
			try {
				pstmt.close();
			} catch (SQLException ex) {
			}
		if (conn != null)
			try {
				conn.setAutoCommit(true);
				conn.close();
			} catch (SQLException ex) {
			}
	}
%>