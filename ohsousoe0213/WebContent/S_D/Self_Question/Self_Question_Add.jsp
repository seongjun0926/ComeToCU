<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge" charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>선택 질문 작성란</title>


<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script language="javascript">
	function len_chk(frm) {

		var frm_ = frm.Answer;
		var length = frm_.value.length;

		if (length > 500) {
			alert("글자 수는 500자로 제한됩니다!");
			frm_.value.subString(0, 500);
			frm_.focus();
		}

		frm.Show_Byte.value = length;

	}
</script>

</head>
<body>
<jsp:include page="/S_D/NavBar.jsp" flush="false"/>
	<br>
	<br>
	<br>
	<%
		String Session_ID = "";

		try {
			Session_ID = (String) session.getAttribute("Session_ID");

			if (Session_ID == null || Session_ID.equals("")) {

				response.sendRedirect("/");
			} else {
	%>
	<div class="container">
		<br>
		<div class="text-center">
			<h1>
				<strong>선택 질문 작성란</strong>
			</h1>
		</div>
		<%
			String[] Question = request.getParameterValues("Check_Question");
					for (int i = 0; i < Question.length; i++) {
						String[] Qnum = Question[i].split("/");
		%>
		<th>
			<%
				
			%>
			<form name="SQA"
				action="/S_D/SELF/Self_Question/Self_Question_Add_Process.jsp"
				method="post">
				<br>
				<div class="container">
					<input type="hidden" name="qnum" value="<%=Qnum[0]%>">
					<div class="panel panel-info">


						<div class="panel-heading text-center">
							<h2>
								<strong><%=Qnum[1]%></strong>
							</h2>
						</div>
						<div class="panel-body">
							<textarea name="Answer" class="form-control" rows="8"
								style="resize: none;" maxlength="500"
								onKeyup="len_chk(this.form)" required></textarea>
						</div>


						<div class="text-right">
							<input type="text" name="Show_Byte" value="0" size="1" readonly>/500byte
						</div>
					</div>
					<br>
					<div class="text-right">
						<button type="submit" class="btn btn-default">
							<span class="glyphicon glyphicon-floppy-saved" aria-hidden="true"></span>
						</button>
						<hr style="border: solid 1px;">
					</div>
				</div>
			</form> <%
 	}
 		}
 	} catch (Exception e) {
 		out.println(e);
 	}
 %>
		
	</div>

</body>
</html>