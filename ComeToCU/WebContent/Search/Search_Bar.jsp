<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">
input::-webkit-input-placeholder{color:red !important;}
</style>
</head>
<body>
<%
String CD_ID = request.getParameter("CD_ID");
String CS_ID = request.getParameter("CS_ID");


%>
	<form action="/Board/Show_Board.jsp" method="post">
		<div class="row">
			<div class="input-group input-group-lg">
				<input type="hidden" name="CS_ID" value="<%=CS_ID%>">
				<input type="hidden" name="CD_ID" value="<%=CD_ID%>"> 
				<input name="Search_Content" type="text" class="form-control" placeholder="v무적v 대가대!" required style="border:1px solid #bce8f1;">
				<span class="input-group-btn">
					<button type="submit" class="btn btn-default" style="border:1px solid #bce8f1;">
						<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
					</button>
				</span>
			</div>
			<!-- /input-group -->
		</div>
	</form>
</body>
</html>

