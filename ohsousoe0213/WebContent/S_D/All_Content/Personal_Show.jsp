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


</head>

<body>
	<jsp:include page="/S_D/NavBar.jsp" flush="false" />
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
		<div class="text-center">
			<h1>
				<strong>자기소개서</strong>
			</h1>
		</div>
		<div class="text-left">
			<hr style="border: solid 1px;">

			<h3>인적사항</h3>

		</div>
		<table class="table table-bordered">

			<tr>
				<td rowspan="6" class="text-center">
					<%
						if (GetFaceIMG == null) {
					%>
					<form method="post" enctype="multipart/form-data" action="/DB/IMG/ImgUp.jsp">
						사진 <input type="file" name="filename1" size=40> 
						<input type="submit" value="등록"><br> <br>
					</form> <%
 	} else {
 %> <img class="text-center" src="<%=GetFaceIMG%>"></img> 
 <%
 	}
 %>



				</td>
				<th class="text-center">이름</th>
				<td class="text-center"><%=GetName%></td>
			</tr>
			<tr>
				<th class="text-center"><strong>생년월일</strong></th>
				<td class="text-center"><%=GetBdate%></td>
			</tr>
			<tr>
				<th class="text-center"><strong>연락처</strong></th>
				<td class="text-center"><%=GetPhone%></td>
			</tr>
			<tr>
				<th class="text-center"><strong>주소</strong></th>
				<td class="text-center"><%=GetAddr%></td>
			</tr>
			<tr>
				<th class="text-center"><strong>E-mail</strong></th>
				<td class="text-center"><%=GetEmail%></td>
			</tr>
			<tr>
				<th class="text-center"><strong>최종 학력</strong></th>
				<td class="text-center"><%=GetEdu%></td>
			</tr>

		</table>
		<div class="text-right">
			<button type="Button" class="btn btn-default"
				onClick="location.href='/S_D/SELF/Self_Chan.jsp'">
				<span class="glyphicon glyphicon-wrench" aria-hidden="true"></span>
			</button>
		</div>
		<hr style="border: solid 1px;">


	</div>


	<br>

		<jsp:include page="/S_D/All_Content/Personal_INF.jsp" flush="false" />

	<br>
		<jsp:include page="/S_D/All_Content/Personal_Career.jsp" flush="false" />



</body>
</html>
