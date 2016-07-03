<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<% String WB_ID="2"; %>


<jsp:include page="/Like/Like_Method.jsp" flush="false">
										<jsp:param value="<%=WB_ID %>" name="WB_ID"/>								
									</jsp:include>
</body>
</html>