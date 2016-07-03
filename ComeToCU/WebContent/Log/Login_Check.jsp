<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>세션 확인</title>
</head>
<body>
	<%
	String Get_ID = (String)session.getAttribute("Get_ID");
	
	
	if(Get_ID==null||Get_ID==""){
		%>
		<script>
		alert("로그인이 필요합니다.")
		window.open('/Log/Login_Ready.jsp','blank','width=350,height=150');
		</script>
		<%
		

	}else{
		response.sendRedirect("/index.jsp");
	}
	
	%>

	
</body>
</html>