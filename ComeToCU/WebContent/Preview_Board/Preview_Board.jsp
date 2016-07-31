<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="Util.DB"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">


<title>Insert title here</title>

<style type="text/css">
a.three {
	color: black;
	font-size: 15px;
	"
}

a.three:hover, a.three:active {
	color: #123478;
}
</style>


</head>
<body>
	<%
		String Color = null; //프리뷰 보드에서 보더 색상을 나타내기 위함.
		String Header = null;
		String Like_Num = null;
		String WB_Time = null;
		String CD_ID = request.getParameter("CD_ID");
		String CS_ID = request.getParameter("CS_ID");
		String CD_Contents = null;
		String WB_ID = null;

		String Compare_Date = null;
		String Compare_WB_Time = null;

		Date from = new Date();
		SimpleDateFormat transFormat = new SimpleDateFormat(
				"yy-MM-dd HH:mm");
		String Date = transFormat.format(from);
		int R_total = 0;

		System.out.println("Preview_Board.jsp CD_ID : " + CD_ID
				+ " CS_ID: " + CS_ID);

		if (CD_ID.equals("20")) {
			Color = "#1F50B5";
		} else {
			Color = "#EAEAEA";
		}
	%>


	<div class="panel" style="border: 1px solid <%=Color%>;">




		<%
			Connection conn = null;
			Statement stmt = null;
			Statement R_stmt = null;
			ResultSet rs = null;
			ResultSet Reply_Count = null;
			try {
				conn = DB.getConnection();
				stmt = conn.createStatement();
				R_stmt = conn.createStatement();

				rs = stmt
						.executeQuery("select CD_Contents from category_detail where CD_ID="
								+ CD_ID + ";");
				if (rs.next()) {
					CD_Contents = rs.getString("CD_Contents");
					rs.close();
				}
		%>
		<div class="panel-heading" style="border-bottom:1px solid <%=Color%>">
			<div class="row">
				<div class=" text-center col-xs-10" style="font-size: 17px;">
					<b><%=CD_Contents%></b>
				</div>
				<div class="col-xs-1 text-right">
					<a href="/Board/Show_Board.jsp?CD_ID=<%=CD_ID%>&CS_ID=<%=CS_ID%>">
						<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
					</a>
				</div>
			</div>
			<div class="row">
				<br>
				<div class="col-xs-8 text-left">
					<img src="/img/contents.png" />
				</div>
				<div class="col-xs-2 text-right">
					<img src="/img/reply.png" />
				</div>
				<div class="col-xs-2 text-right">
					<img src="/img/like.png" />
				</div>

			</div>
		</div>
		<div class="panel-body">

			<%
				//모든글 나중에 DB구조 바꿔야할 필요성이있기도하지만 일단은 이대로
					if (CD_ID.equals("19")) {
						rs = stmt
								.executeQuery("select * from write_board where not CD_ID=20 order by WB_ID desc limit 6;");
						//베스트글
					} else if (CD_ID.equals("18")) {
						rs = stmt
								.executeQuery("select * from write_board where (not CD_ID=20) and (WB_Like_Num > 50) order by WB_ID desc limit 6;");
					} else {
						//CD_ID 즉 게시판 성격에 맞는 저장된 글의 모든 것을 가져옴
						rs = stmt
								.executeQuery("select * from write_board where CD_ID="
										+ CD_ID + " order by WB_ID desc limit 6;");
					}

					while (rs.next()) {
						Header = rs.getString("WB_Header");
						String View_CNT = rs.getString("View_CNT");
						Like_Num = rs.getString("WB_Like_Num");
						WB_ID = rs.getString("WB_ID");
						WB_Time = rs.getString("WB_Time");

						Reply_Count = R_stmt
								.executeQuery("select count(*) from write_board inner join reply on write_board.WB_ID = reply.WB_ID where write_board.WB_ID="
										+ WB_ID + ";");
						if (Reply_Count.next()) {
							R_total = Reply_Count.getInt(1);
						}
			%>

			<div class="row" style="border: 5px solid white;">
				<a class="three"
					href="/Board/Show_Detail_Board.jsp?CD_ID=<%=CD_ID%>&CS_ID=<%=CS_ID%>&WB_ID=<%=WB_ID%>">

					<div class="col-xs-8 text-left">

						<%
							if (Header.length() > 13 && CD_ID.equals("20")==false) { //공지사항 글이 아니고 글자 제목의 길이가 13자리를  넘을 경우
										String Header_ = Header.substring(0, 12);
						%>
						<%=Header_ + "..."%>
						<%
							} else {//아닌경우
						%>
						<%=Header%>
						<%
							}
						%>
						<%
							Compare_Date = Date.substring(0, 10);
									Compare_WB_Time = WB_Time.substring(0, 10);
									if (Compare_Date.equals(Compare_WB_Time)) {
						%>
						<img src="/img/new.jpg" />
						<%
							}
						%>

					</div>
					<div class="col-xs-2 text-right">

						<%=R_total%></div>
					<div class="col-xs-2 text-right">

						<%=Like_Num%></div>
				</a>
			</div>


			<%
				}

				} catch (Throwable e) {
					out.clearBuffer();
			%><scirpt> alert(e.getMessage()); </scirpt>
			<%
				} finally {
					if (rs != null)
						try {
							rs.close();
						} catch (SQLException ex) {
						}
					if (stmt != null)
						try {
							stmt.close();
						} catch (SQLException ex) {
						}
					if (conn != null)
						try {
							conn.close();
						} catch (SQLException ex) {
						}
				}
			%>
		</div>
	</div>

</body>
</html>