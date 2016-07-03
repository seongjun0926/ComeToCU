<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko">
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="utf-8"%>
<%@ page
	import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
				String realFolder = "";
				String filename1 = "";
				int maxSize = 1024 * 1024 * 5;
				String encType = "utf-8";
				String savefile = "img/Work_IMG";
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

				String fullpath = "/img/Work_IMG/" + filename1;
				request.setAttribute("fullpath", fullpath);
%>

<title>이미지 저장중</title>
</head>
<body>

<jsp:forward page="/S_D/Portfolio/Portfolio.jsp"/>



</body>
</html>