<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>자기소개서 작성</title>


<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
	function digit_check(evt){
		var code = evt.which?evt.which:event.keyCode;
		if(code < 48 || code > 57){
		return false;
		}
	}
	
	function digit_check2(evt){
		var code = evt.which?evt.which:event.keyCode;
		if(code!=45){
			if(code < 48 || code > 57){
			return false;
			}
		}
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
		String GetName = "";
		String GetEmail = "";
		String GetPhone = "";
		String GetEdu = "";
		String GetAddr = "";
		String GetBdate = "";
		String GetFaceIMG = "";

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
				ResultSet rs = null;
				try {
					conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
					stmt = conn.createStatement();
					rs = stmt
							.executeQuery("select name,email,phone,edu,addr,bdate,face_img from userlist where ID='"
									+ Session_ID + "';");

					while (rs.next()) {
						GetName = rs.getString("name");
						GetEmail = rs.getString("email");
						GetPhone = rs.getString("phone");
						GetEdu = rs.getString("edu");
						GetAddr = rs.getString("addr");
						GetBdate = rs.getString("bdate");
						GetFaceIMG = rs.getString("face_img");

					}
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

	<div class="container">
		<div class="row">
			<div class="col-sm-12" align="center">
				<h1>
					<strong>자기소개서 수정</strong>
				</h1>
			</div>
		</div>
		<form name="Self_Chan" action="/S_D/SELF/Update_Self.jsp"
			method="post">
			<table class="table table-bordered">

				<tr>
					<td rowspan="6" width="180" align="center">
						<form method="post" enctype="multipart/form-data"
							action="/DB/IMG/ImgUp.jsp">
							사진 <hr><input type="file" name="filename1" size=40> <input
								type="submit" value="등록"><br> <br>
						</form> <img class="text-center" src="<%=GetFaceIMG%>" width=128
						height=180></img>
					</td>
					<td align="center"><strong>이름</strong></td>
					<td><input type="text" maxlength="10" class="form-control"
						name="UpDateName" value="<%=GetName%>" required></td>
				</tr>
				<tr>
					<td align="center"><strong>생년월일</strong></td>
					<td><input type="text" maxlength="10" class="form-control"
						name="UpDateBdate" value="<%=GetBdate%>"
						onkeypress="return digit_check2(event)" required></td>
				</tr>
				<tr>
					<td align="center"><strong>연락처</strong></td>
					<td><input type="text" maxlength="11" class="form-control"
						name="UpDatePhone" value="<%=GetPhone%>"
						style="ime-mode: disabled" onkeypress="return digit_check(event)"
						required /></td>
				</tr>
				<tr>
					<td align="center"><strong>주소</strong></td>
					<td><input type="text" maxlength="50" class="form-control"
						name="UpDateAddr" value="<%=GetAddr%>" required></td>
				</tr>
				<tr>
					<td align="center"><strong>E-mail</strong></td>
					<td><input type="email" maxlength="30" class="form-control"
						name="UpDateEmail" style="ime-mode: disabled"
						value="<%=GetEmail%>" required></td>
				</tr>
				<tr>
					<td align="center"><strong>최종 학력</strong></td>
					<td><input type="text" maxlength="35" class="form-control"
						name="UpDateEdu" value="<%=GetEdu%>" required></td>
				</tr>
			</table>
			<div class="text-right">
				<button type="submit" class="btn btn-default">
					<span class="glyphicon glyphicon-floppy-saved" aria-hidden="true"></span>
				</button>
			</div>

		</form>
		<hr>



	</div>

</body>
</html>