<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="utf-8"%>
<%@ page
	import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*"%>
<%@ page import="java.sql.*"%>

<%
	String Session_ID = "";
	try {
		Session_ID = (String) session.getAttribute("Session_ID");

		if (Session_ID == null || Session_ID.equals("")) {

			response.sendRedirect("/");
		} else {

			request.setCharacterEncoding("utf-8");
			String realFolder = "";
			String filename1 = "";
			int maxSize = 1024 * 1024 * 5;
			String encType = "utf-8";
			String savefile = "img/Face_IMG";
			ServletContext scontext = getServletContext();
			realFolder = scontext.getRealPath(savefile);

			try {
				MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType,
						new DefaultFileRenamePolicy());

				Enumeration<?> files = multi.getFileNames();
				String file1 = (String) files.nextElement();
				filename1 = multi.getFilesystemName(file1);
			} catch (Exception e) {
				e.printStackTrace();
			}

			String fullpath = "/img/Face_IMG/" + filename1;

			//db연결 위한 정보들
			String DB_URL = "jdbc:mysql://localhost:3306/seongjun0926";
			String DB_USER = "seongjun0926";
			String DB_PASSWORD = "wnsduqrud0119";

			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = null;
			PreparedStatement pstmt = null;

			try {
				//디비 연결

				conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

				pstmt = conn.prepareStatement("update userlist set face_img=? where ID=?;");

				pstmt.setString(1, fullpath);
				pstmt.setString(2, Session_ID);
				pstmt.executeUpdate();

			} catch (Exception e) {
				out.println(e.getMessage());
			}
		}
	} catch (Exception e) {
		out.println(e);
	}
	
response.sendRedirect("/S_D/All_Content/Personal_Show.jsp");
%>


<title>이미지 저장중</title>
</head>
<body>


</body>
</html>