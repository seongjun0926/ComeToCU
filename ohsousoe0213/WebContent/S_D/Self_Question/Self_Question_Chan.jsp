<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>선택 질문 수정란</title>


<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">



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
		String Get_Qlist = request.getParameter("qlist");
		String[] Qnum=Get_Qlist.split("/");
		String Answer = request.getParameter("qlist_Answer");
		
	%>
	<form name="SQA"
		action="/S_D/SELF/Self_Question/Self_Question_Chan_Process.jsp"
		method="post">
		<br>
		<div class="container">
			<input type="hidden" name="Qnum" value="<%=Qnum[0] %>">

			<table class="table">
				<th class="text-center info"><strong><h3><%=Qnum[1]%></h3></strong>
				</th>
				<tr>
					<td><textarea name="Answer" class="form-control" rows="8"
							style="resize: none;" maxlength="500"
							onKeyup="len_chk(this.form)" required><%=Answer%></textarea></td>
				</tr>

			</table>
			<div class="text-right">
				<input type="text" name="Show_Byte" value="0" size="1" readonly>/500byte
			</div>
			<br>
			<div class="text-right">
				<button type="submit" class="btn btn-default">
					<span class="glyphicon glyphicon-floppy-saved" aria-hidden="true"></span>
				</button>
				<hr style="border: solid 1px;">
			</div>
		</div>


	</form>
</body>
</html>