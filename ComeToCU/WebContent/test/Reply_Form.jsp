<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">



</head>
<body>
	<%
		String WB_ID ="1";
		//request.getParameter("WB_ID");
	%>
	<form id="addForm">
		<div class="row">
			<div class="col-xs-12">
				<div class="input-group">
					<input type="hidden" id="WB_ID" name="WB_ID" value="<%=WB_ID%>">
					<input type="text" class="form-control" id="content"
						name="content"> <span class="input-group-btn">
						<input class="btn btn-default" type="button" value="입력" onClick="addComment();">
					</span>
				</div>
			</div>
		</div>
	</form>
</body>

</html>