<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>이력 보기</title>


<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
	function delete_Career(frm) {
		if (confirm("삭제하시겠습니까?") == true) {
			var frm_ = frm.submit();
		} else {
			return;
		}
	}
</script>




</head>
<body>
	<jsp:include page="/S_D/NavBar.jsp" flush="false">

		<jsp:param name="param" value="value1" />

	</jsp:include>
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
				Statement stmt_out = null;
				Statement stmt_vol = null;
				Statement stmt_in = null;
				Statement stmt_intern = null;
				Statement stmt_group = null;
				Statement stmt_c = null;
				Statement stmt_win = null;
				Statement stmt_job = null;
				Statement stmt_lan = null;

				ResultSet rs_out = null;
				ResultSet rs_vol = null;
				ResultSet rs_in = null;
				ResultSet rs_intern = null;
				ResultSet rs_group = null;
				ResultSet rs_c = null;
				ResultSet rs_win = null;
				ResultSet rs_job = null;
				ResultSet rs_lan = null;

				try {
					conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
					stmt_out = conn.createStatement();
					rs_out = stmt_out.executeQuery(
							"select * from career where c_id='" + Session_ID + "' and c_value='Out';");
					stmt_vol = conn.createStatement();
					rs_vol = stmt_vol.executeQuery(
							"select * from career where c_id='" + Session_ID + "' and c_value='Vol';");
					stmt_in = conn.createStatement();
					rs_in = stmt_in
							.executeQuery("select * from career where c_id='" + Session_ID + "' and c_value='In';");
					stmt_intern = conn.createStatement();
					rs_intern = stmt_intern.executeQuery(
							"select * from career where c_id='" + Session_ID + "' and c_value='Intern';");
					stmt_win = conn.createStatement();
					rs_win = stmt_win.executeQuery(
							"select * from career where c_id='" + Session_ID + "' and c_value='Win';");
					stmt_group = conn.createStatement();
					rs_group = stmt_group.executeQuery(
							"select * from career where c_id='" + Session_ID + "' and c_value='Group';");
					stmt_c = conn.createStatement();
					rs_c = stmt_c
							.executeQuery("select * from career where c_id='" + Session_ID + "' and c_value='C';");

					stmt_job = conn.createStatement();
					rs_job = stmt_job.executeQuery(
							"select * from career where c_id='" + Session_ID + "' and c_value='Job';");
					stmt_lan = conn.createStatement();
					rs_lan = stmt_lan.executeQuery(
							"select * from career where c_id='" + Session_ID + "' and c_value='Lan';");
	%>

	<div class="container">
		<div class="panel panel-success">


			<div class="panel-heading text-center">
				<h1>
					<strong>대외 활동</strong>
				</h1>
			</div>
			<table class="table">

				<tr>
					<th class="col-xs-1 text-center">번호</th>
					<th class="col-xs-3 text-center">기관 및 프로그램 명</th>
					<th class="col-xs-2 text-center">기간</th>
					<th class="col-xs-4 text-center">내용</th>
					<th class="col-xs-1 text-center"></th>
				</tr>
			</table>

			<%
				while (rs_out.next()) {
								int count = rs_out.getRow();
			%>
			

			<form name="Out" method="post"
				action="/DB/DB_Career/DB_Control_Career/Delete_Career.jsp">

				<input type=hidden name=activity value=Out> <input
					type="hidden" name="del_num" value="<%=rs_out.getString("num")%>">
				<input type="hidden" name="del_name"
					value="<%=rs_out.getString("c_name")%>"> <input
					type="hidden" name="del_period"
					value="<%=rs_out.getString("c_period")%>"> <input
					type="hidden" name="del_content"
					value="<%=rs_out.getString("c_content")%>">


				<table class="table table-striped">
					<td class="text-center col-xs-1"><%=count%></td>
					<td class="text-center col-xs-3"><%=rs_out.getString("c_name")%></td>
					<td class="text-center col-xs-2"><%=rs_out.getString("c_period")%></td>
					<td class="text-center col-xs-4"><%=rs_out.getString("c_content")%></td>
					<td class="text-center col-xs-1">
						<button type="button" class="btn btn-default"
							onclick="delete_Career(this.form);">
							<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
						</button>
					</td>
				</table>
			</form>

			<%
				}
			%>
		</div>
		<hr>

	</div>

	<div class="container">
		<div class="panel panel-success">
			<div class="panel-heading text-center">
				<h1>
					<strong>봉사 활동</strong>
				</h1>
			</div>

			<table class="table">

				<tr>
					<th class="col-xs-1 text-center">번호</th>
					<th class="col-xs-3 text-center">기관 및 프로그램 명</th>
					<th class="col-xs-2 text-center">기간</th>
					<th class="col-xs-4 text-center">내용</th>
					<th class="col-xs-1 text-center"></th>
				</tr>
			</table>


			<%
				while (rs_vol.next()) {
								int count = rs_vol.getRow();
			%>

			<form name="Vol" method="post"
				action="/DB/DB_Career/DB_Control_Career/Delete_Career.jsp">
				<input type="hidden" name="del_num"
					value="<%=rs_vol.getString("num")%>"> <input type=hidden
					name=activity value=Vol> <input type="hidden"
					name="del_name" value="<%=rs_vol.getString("c_name")%>"> <input
					type="hidden" name="del_period"
					value="<%=rs_vol.getString("c_period")%>"> <input
					type="hidden" name="del_content"
					value="<%=rs_vol.getString("c_content")%>">

				<table class="table table-striped">
					<td class="col-xs-1 text-center"><%=count%></td>
					<td class="col-xs-3 text-center"><%=rs_vol.getString("c_name")%></td>
					<td class="col-xs-2 text-center"><%=rs_vol.getString("c_period")%></td>
					<td class="col-xs-4 text-center"><%=rs_vol.getString("c_content")%></td>
					<td class="text-center col-xs-1">
						<button type="submit" class="btn btn-default">
							<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
						</button>
					</td>
				</table>
			</form>


			<%
				}
			%>
		</div>
		<hr>

	</div>



	<div class="container">
		<div class="panel panel-success">


			<div class="panel-heading text-center">
				<h1>
					<strong>인턴 활동</strong>
				</h1>
			</div>
				<table class="table">

				<tr>
					<th class="col-xs-1 text-center">번호</th>
					<th class="col-xs-3 text-center">기관 및 프로그램 명</th>
					<th class="col-xs-2 text-center">기간</th>
					<th class="col-xs-4 text-center">내용</th>
					<th class="col-xs-1 text-center"></th>
				</tr>
			</table>

			<%
				while (rs_intern.next()) {
								int count = rs_intern.getRow();
			%>
			<form name="Intern" method="post"
				action="/DB/DB_Career/DB_Control_Career/Delete_Career.jsp">
				<input type="hidden" name="del_num"
					value="<%=rs_intern.getString("num")%>"> <input type=hidden
					name=activity value=Intern> <input type="hidden"
					name="del_name" value="<%=rs_intern.getString("c_name")%>">
				<input type="hidden" name="del_period"
					value="<%=rs_intern.getString("c_period")%>"> <input
					type="hidden" name="del_content"
					value="<%=rs_intern.getString("c_content")%>">

				<table class="table table-striped">
					<td class="col-xs-1 text-center"><%=count%></td>
					<td class="col-xs-3 text-center"><%=rs_intern.getString("c_name")%></td>
					<td class="col-xs-2 text-center"><%=rs_intern.getString("c_period")%></td>
					<td class="col-xs-4 text-center"><%=rs_intern.getString("c_content")%></td>
					<td class="text-center col-xs-1">
						<button type="Button" class="btn btn-default"
							onclick="delete_Career(this.form);">
							<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
						</button>
					</td>
				</table>
			</form>

			<%
				}
			%>
		</div>	<hr>
		
	</div>




	<div class="container">
		<div class="panel panel-success">


			<div class="panel-heading text-center">
				<h1>
					<strong>교내 활동</strong>
				</h1>
			</div>
				<table class="table">

				<tr>
					<th class="col-xs-1 text-center">번호</th>
					<th class="col-xs-3 text-center">프로그램 명</th>
					<th class="col-xs-2 text-center">기간</th>
					<th class="col-xs-4 text-center">내용</th>
					<th class="col-xs-1 text-center"></th>
				</tr>
			</table>

			<%
				while (rs_in.next()) {
								int count = rs_in.getRow();
			%>
			<form name="In" method="post"
				action="/DB/DB_Career/DB_Control_Career/Delete_Career.jsp">
				<input type="hidden" name="del_num"
					value="<%=rs_in.getString("num")%>"> <input type=hidden
					name=activity value=In> <input type="hidden"
					name="del_name" value="<%=rs_in.getString("c_name")%>"> <input
					type="hidden" name="del_period"
					value="<%=rs_in.getString("c_period")%>"> <input
					type="hidden" name="del_content"
					value="<%=rs_in.getString("c_content")%>">
				<table class="table table-striped">
					<td class="col-xs-1 text-center"><%=count%></td>
					<td class="col-xs-3 text-center"><%=rs_in.getString("c_name")%></td>
					<td class="col-xs-2 text-center"><%=rs_in.getString("c_period")%></td>
					<td class="col-xs-4 text-center"><%=rs_in.getString("c_content")%></td>
					<td class="text-center col-xs-1">
						<button type="Button" class="btn btn-default"
							onclick="delete_Career(this.form);">
							<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
						</button>
					</td>
				</table>
			</form>

			<%
				}
			%>
		</div>	<hr>
		
	</div>



	<div class="container">
		<div class="panel panel-success">


			<div class="panel-heading text-center">
				<h1>
					<strong>동아리 활동</strong>
				</h1>
			</div>
			<table class="table">

				<tr>
					<th class="col-xs-1 text-center">번호</th>
					<th class="col-xs-2 text-center">동아리명</th>
					<th class="col-xs-2 text-center">기간</th>
					<th class="col-xs-2 text-center">담당 직무</th>
					<th class="col-xs-4 text-center">내용</th>
					<th class="col-xs-1 text-center"></th>
				</tr>
			</table>
			<%
				while (rs_group.next()) {
								int count = rs_group.getRow();
			%>
			<form name="Group" method="post"
				action="/DB/DB_Career/DB_Control_Career/Delete_Career.jsp">
				<input type="hidden" name="del_num"
					value="<%=rs_group.getString("num")%>"> <input type=hidden
					name=activity value=Group> <input type="hidden"
					name="del_name" value="<%=rs_group.getString("c_name")%>">
				<input type="hidden" name="del_period"
					value="<%=rs_group.getString("c_period")%>"> <input
					type="hidden" name="del_job"
					value="<%=rs_group.getString("c_job")%>"> <input
					type="hidden" name="del_content"
					value="<%=rs_group.getString("c_content")%>">
				<table class="table table-striped">
					<td class="col-xs-1 text-center"><%=count%></td>
					<td class="col-xs-2 text-center"><%=rs_group.getString("c_name")%></td>
					<td class="col-xs-2 text-center"><%=rs_group.getString("c_period")%></td>
					<td class="col-xs-2 text-center"><%=rs_group.getString("c_job")%></td>
					<td class="col-xs-4 text-center"><%=rs_group.getString("c_content")%></td>
					<td class="text-center col-xs-1">
						<button type="Button" class="btn btn-default"
							onclick="delete_Career(this.form);">
							<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
						</button>
					</td>
				</table>
			</form>

			<%
				}
			%>
		</div>	<hr>
		
	</div>


	<div class="container">
		<div class="panel panel-success">


			<div class="panel-heading text-center">
				<h1>
					<strong>수상 활동</strong>
				</h1>
			</div>
				<table class="table">

				<tr>
					<th class="col-xs-1 text-center">번호</th>
					<th class="col-xs-3 text-center">수상 기관</th>
					<th class="col-xs-2 text-center">수상 일</th>
					<th class="col-xs-4 text-center">내용</th>
					<th class="col-xs-1 text-center"></th>
				</tr>
			</table>
		
			<%
				while (rs_win.next()) {
								int count = rs_win.getRow();
			%>
			<form name="Win" method="post"
				action="/DB/DB_Career/DB_Control_Career/Delete_Career.jsp">
				<table class="table table-striped">
					<input type="hidden" name="del_num"
						value="<%=rs_win.getString("num")%>">
					<input type=hidden name=activity value=Win>
					<input type="hidden" name="del_name"
						value="<%=rs_win.getString("c_name")%>">
					<input type="hidden" name="del_period"
						value="<%=rs_win.getString("c_period")%>">
					<input type="hidden" name="del_content"
						value="<%=rs_win.getString("c_content")%>">

					<td class="col-xs-1 text-center"><%=count%></td>
					<td class="col-xs-3 text-center"><%=rs_win.getString("c_name")%></td>
					<td class="col-xs-2 text-center"><%=rs_win.getString("c_period")%></td>
					<td class="col-xs-4 text-center"><%=rs_win.getString("c_content")%></td>
					<td class="text-center col-xs-1">
						<button type="Button" class="btn btn-default"
							onclick="delete_Career(this.form);">
							<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
						</button>
					</td>
				</table>
			</form>

			<%
				}
			%>
		</div>	<hr>
		
	</div>


	<div class="container">
		<div class="panel panel-success">


			<div class="panel-heading text-center">
				<h1>
					<strong>자격증 취득</strong>
				</h1>
			</div>
			<table class="table">

				<tr>
					<th class="col-xs-1 text-center">번호</th>
					<th class="col-xs-3 text-center">자격증 명</th>
					<th class="col-xs-2 text-center">취득 날짜</th>
					<th class="col-xs-4 text-center">취득 기관</th>
					<th class="col-xs-1 text-center"></th>
				</tr>
			</table>
			
			<%
				while (rs_c.next()) {
								int count = rs_c.getRow();
			%>
			<form name="C" method="post"
				action="/DB/DB_Career/DB_Control_Career/Delete_Career.jsp">
				<table class="table table-striped">
					<input type="hidden" name="del_num"
						value="<%=rs_c.getString("num")%>">
					<input type=hidden name=activity value=C>
					<input type="hidden" name="del_name"
						value="<%=rs_c.getString("c_name")%>">
					<input type="hidden" name="del_period"
						value="<%=rs_c.getString("c_period")%>">
					<input type="hidden" name="del_content"
						value="<%=rs_c.getString("c_content")%>">

					<td class="col-xs-1 text-center"><%=count%></td>
					<td class="col-xs-3 text-center"><%=rs_c.getString("c_name")%></td>
					<td class="col-xs-2 text-center"><%=rs_c.getString("c_period")%></td>
					<td class="col-xs-4 text-center"><%=rs_c.getString("c_content")%></td>
					<td class="text-center col-xs-1">
						<button type="Button" class="btn btn-default"
							onclick="delete_Career(this.form);">
							<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
						</button>
					</td>
				</table>
			</form>

			<%
				}
			%>
		</div>	<hr>
		
	</div>


	<div class="container">
		<div class="panel panel-success">


			<div class="panel-heading text-center">
				<h1>
					<strong>직장 경력</strong>
				</h1>
			</div>
			<table class="table">

				<tr>
					<th class="col-xs-1 text-center">번호</th>
					<th class="col-xs-3 text-center">직장 명</th>
					<th class="col-xs-2 text-center">기간</th>
					<th class="col-xs-4 text-center">내용</th>
					<th class="col-xs-1 text-center"></th>
				</tr>
			</table>
		<%
			while (rs_job.next()) {
							int count = rs_job.getRow();
		%>
			<form name="Job" method="post"
				action="/DB/DB_Career/DB_Control_Career/Delete_Career.jsp">
				<table class="table table-striped">
					<input type="hidden" name="del_num"
						value="<%=rs_job.getString("num")%>">
					<input type=hidden name=activity value=Job>
					<input type="hidden" name="del_name"
						value="<%=rs_job.getString("c_name")%>">
					<input type="hidden" name="del_period"
						value="<%=rs_job.getString("c_period")%>">
					<input type="hidden" name="del_content"
						value="<%=rs_job.getString("c_content")%>">

					<td class="col-xs-1 text-center"><%=count%></td>
					<td class="col-xs-3 text-center"><%=rs_job.getString("c_name")%></td>
					<td class="col-xs-2 text-center"><%=rs_job.getString("c_period")%></td>
					<td class="col-xs-4 text-center"><%=rs_job.getString("c_content")%></td>
					<td class="text-center col-xs-1">
						<button type="Button" class="btn btn-default"
							onclick="delete_Career(this.form);">
							<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
						</button>
					</td>
				</table>
			</form>

			<%
				}
			%>
		</div>	<hr>
		
	</div>


	<div class="container">
		<div class="panel panel-success">


			<div class="panel-heading text-center">
				<h1>
					<strong>외국어 능력</strong>
				</h1>
			</div>
				<table class="table">

				<tr>
					<th class="col-xs-1 text-center">번호</th>
					<th class="col-xs-3 text-center">언어</th>
					<th class="col-xs-2 text-center">종류</th>
					<th class="col-xs-4 text-center">점수</th>
					<th class="col-xs-1 text-center"></th>
				</tr>
			</table>
		

			<%
				while (rs_lan.next()) {
								int count = rs_lan.getRow();
			%>

			<form name="Lan" method="post"
				action="/DB/DB_Career/DB_Control_Career/Delete_Career.jsp">
				<table class="table table-striped">
					<input type="hidden" name="del_num"
						value="<%=rs_lan.getString("num")%>">
					<input type=hidden name=activity value=Lan>
					<input type="hidden" name="del_name"
						value="<%=rs_lan.getString("c_name")%>">
					<input type="hidden" name="del_period"
						value="<%=rs_lan.getString("c_period")%>">
					<input type="hidden" name="del_content"
						value="<%=rs_lan.getString("c_content")%>">

					<td class="col-xs-1 text-center"><%=count%></td>
					<td class="col-xs-3 text-center"><%=rs_lan.getString("c_name")%></td>
					<td class="col-xs-2 text-center"><%=rs_lan.getString("c_period")%></td>
					<td class="col-xs-4 text-center"><%=rs_lan.getString("c_content")%></td>
					<td class="text-center col-xs-1">
						<button type="Button" class="btn btn-default"
							onclick="delete_Career(this.form);">
							<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
						</button>
					</td>
				</table>
			</form>

			<%
				}
			%>
		</div>
		<hr>
	</div>
	<%
		} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					if (rs_lan != null)
						try {
							rs_out.close();
							rs_vol.close();
							rs_in.close();
							rs_intern.close();
							rs_group.close();
							rs_c.close();
							rs_win.close();
							rs_job.close();
							rs_lan.close();

						} catch (SQLException e) {
						}
					if (stmt_lan != null)
						try {
							stmt_out.close();
							stmt_vol.close();
							stmt_in.close();
							stmt_intern.close();
							stmt_group.close();
							stmt_c.close();
							stmt_win.close();
							stmt_job.close();
							stmt_lan.close();
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

