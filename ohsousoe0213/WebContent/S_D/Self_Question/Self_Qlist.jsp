<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>자기소개 추가 작성란</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script>

function Check() {
    var i, sum=0, tag=[], str="";
    var chk = document.getElementsByName("Check_Question");
    var tot = chk.length;
    for (i = 0; i < tot; i++) {
        if (chk[i].checked == true) {
            sum++;
        }
    }

    if(sum==0){
    	alert("항목을 선택하세요");
    	return false;
    }
    else
    	document.qlist.submit();
    	return true;
    
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

				String DB_URL = "jdbc:mysql://localhost:3306/seongjun0926";
				String DB_USER = "seongjun0926";
				String DB_PASSWORD = "wnsduqrud0119";

				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = null;
				Statement stmt = null;
				Statement stmt_QResult = null;
				ResultSet rs = null;
				ResultSet rs_QResult = null;
				try {
					conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
					stmt = conn.createStatement();
					rs = stmt.executeQuery(
							"select * from question where qnum NOT IN(select qnum from question,Introduce where I_ID='"
									+ Session_ID + "' AND I_num=qnum);");
	%>
	<div class="container">
		<form name="qlist"
			action="/S_D/SELF/Self_Question/Self_Question_Add.jsp" method="post">
			<div class="panel panel-info">


				<div class="panel-heading text-center">
					<h1>
						<strong>질문 사항 선택</strong>
					</h1>
					<div class="text-right">
						<h5 class="text-success">자신을 가장 잘 나타낼 수 있는 질문을 골라 작성해주세요</h5>
					</div>
				</div>

				<table class="table table-bordered">

					<%
						while (rs.next()) {
					%>
					<tr>

						<td class="text-center col-xs-1"><input type="checkbox"
							name="Check_Question"
							value="<%=rs.getString("qnum")%>/<%=rs.getString("qlist")%>">
						</td> &nbsp&nbsp&nbsp&nbsp
						<td><%=rs.getString("qlist")%></td>
					</tr>
					<%
						}
					%>

				</table>
			</div>
			<div class="text-right">
				<button type="button" class="btn btn-default" onclick="Check()">
					<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
				</button>
			</div>
		</form>
	</div>

	<%
		} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					if (rs != null)
						try {
							rs.close();

						} catch (SQLException e) {
						}
					if (stmt != null)
						try {
							stmt.close();

						} catch (SQLException e) {
						}
					if (conn != null)
						try {
							conn.close();
						} catch (SQLException e) {
						}
				}

			}
		} catch (Exception e) {
			out.println(e);
		}
	%>

</body>
</html>