<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
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
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript" src="/Reply/ajax.js"></script>
<script type="text/javascript">
	//WB_ID에 맞는 댓글을 보여주기 위해 윈도우가 로드되면서 WB_ID의 값을 가져와서 진행

	var WB_ID = document.getElementById("WB_ID")

	window.onload = function() {

		var Like_Count = document.getElementById.Like_Count;

		loadLikeNum();// 좋아요 수 불러오기 함수
		loadLikeCheck();
		loadCommentList();
	}
	function Alter_confirm() {
		if (confirm("게시글을 수정하시겠습니까??")) { //확인
			document.Choose_Action.submit();
		} else { //취소
			return false;
		}
	}
	function delete_confirm() {

	}
	function changeImageSize() {
		var a = document.body.clientWidth;
		var pWidth = a / 2;
		var r, re;
		testImg = new Image();

		re = "/UpLoad/ComeToCU_UpLoad"; // 이부분이 이미지가 저장된 폴더입니다.
		for (var i = 0; i < document.images.length; i++) {
			r = (document.images[i].src).search(re);
			if (r > -1 && document.images[i].src != "") {
				testImg.src = document.images[i].src;
				if (testImg.width > pWidth) {
					document.images[i].width = pWidth;
					document.images[i].height = testImg.height * pWidth
							/ testImg.width;
				}
			}
		}
	}
	function choose_action(str) {
		var CA = document.Choose_Action;

		switch (str) {

		case 0:
			CA.action = "/Board/Delete_Board.jsp"

			if (confirm("정말 삭제하시겠습니까??")) { //확인
				document.Choose_Action.submit();
			} else { //취소
				return false;
			}
			break;

		case 1:
			CA.action = "/Board/Alter_Board.jsp"

			if (confirm("정말 수정하시겠습니까??")) { //확인
				document.Choose_Action.submit();
			} else { //취소
				return false;
			}

			break;
		case 2:

			if (confirm("공유하시겠습니까??")) { //확인

			} else { //취소
				return false;
			}
			break;
		}
	}
	
	
</script>
<style type="text/css">
.alert {
	background-color: white !important;
	color: #123478 !important;
}

.panel-title {
	background-color: white 1important;
	color: #123478 !important;
}
</style>
<title>자유 게시판 글 보기</title>
</head>
<body style="background-color: #f7f7f7">
	<br>
	<br>
	<br>

	<!-- 색깔 넣어주면댐 -->
	<div id="header" class="container">


		<!-- 상단 네비게이션 바 -->
		<jsp:include page="/NavBar.jsp" flush="false" />

		<!-- 세션으로 로그인이 되어있는지 안되어있는지 확인. 나중에 페이지 하나 새로 만들어서 include하고 싶은데 할줄몰라서 그냥 이렇게함. -->
		<%
			String Get_ID = (String) session.getAttribute("Get_ID");
			String CD_ID = request.getParameter("CD_ID");
			String Get_Certification = (String) session
					.getAttribute("Get_Certification");
			String Get_Class = (String) session.getAttribute("Get_Class");

			System.out.println(Get_Certification);

			if ((Get_ID == null || Get_ID == "") && CD_ID.equals("20") == false) {
				//로그인을 안했고, CD_ID가 20이 아니다(true) T&T 라면 로그인 ㄱ
				//로그인을 안했고, CD_ID가 20이다 -> false
		%>

		<!-- 모달을 추가해서 모달을 띄움 -->
		<script>
			alert("로그인이 필요합니다.")
			$('#login').modal('show')
		</script>

		<%
			} else if ((Get_Certification == null || Get_Certification
					.equals("0")) && CD_ID.equals("20") == false) {
				//로그인을 안했거나 회원인증을 안했는데, 공지사항 볼때,
		%>
		<script>
			alert("회원가입시 작성한 본교 홈페이지 메일에서 인증을 해주세요!");
			location.href = "/index.jsp";
		</script>
		<%
			} else {
				String URI = request.getRequestURL().toString();
				if (request.getQueryString() != null)
					URI = URI + "?" + request.getQueryString();
				session.setAttribute("URI", URI);
				//전 페이지로 돌아가기위한 URI 받음. getRequestURL은 get방식을 가져오기 못하기때문에 getQueryString()을 통해 ~.jsp? 이후 부분을 다 가져옴

				String CS_ID = request.getParameter("CS_ID");
				String WB_ID = request.getParameter("WB_ID");
		
				
				String CD_Contents = null;
				String CD_Notice = null;

				Connection conn = null;
				Statement stmt = null;
				Statement stmt_reply = null;
				ResultSet rs = null;
				ResultSet rs_reply = null;
				PreparedStatement pstmt = null;
				try {
					conn = DB.getConnection();
					conn.setAutoCommit(false);
					stmt = conn.createStatement();
					rs = stmt
							.executeQuery("select CD_Contents,CD_Notice from C_category_detail where CD_ID="
									+ CD_ID + ";");
					if (rs.next()) {
						CD_Contents = rs.getString("CD_Contents");
						CD_Notice = rs.getString("CD_Notice");
						rs.close();
					}
		%>
	</div>
	<div>
		<!-- 색깔 넣어주면댐  -->
		<div class="container">
			<input type="hidden" id="WB_ID" name="WB_ID" value="<%=WB_ID%>" />
			<div class="panel" style="border: 4px solid #EAEAEA">
				<div class="panel-heading">
					<div class="panel-title text-center"
						style="font-weight: bold; color: #002266;">
						<a href="/Board/Show_Board.jsp?CD_ID=<%=CD_ID%>&CS_ID=<%=CS_ID%>">
							<%=CD_Contents%>
						</a>
					</div>
				</div>

				<div class="alert  text-center" role="alert"
					style="background-color: #c9dee3">
					<%=CD_Notice%>
				</div>

				<div class="panel-body"
					style="padding-top: 0px; padding-left: 0px; padding-right: 0px; padding-bottom: 0px;">


					<!-- 서브보드 포함 -->
					<jsp:include page="/Board/Sub_Board.jsp" flush="false" />


					<div class="col-md-10 col-xs-12">
						<%
							rs = stmt
											.executeQuery("select * from C_write_board where WB_ID='"
													+ WB_ID + "';");

									while (rs.next()) {
										String ID = rs.getString("WB_ID");
										String Header = rs.getString("WB_Header");
										String Contents = rs.getString("WB_Contents");
										String Creator = rs.getString("WB_Creator");
										String Time = rs.getString("WB_Time");
										String Like_Num = rs.getString("WB_Like_Num");
										String Compare_CD_ID = rs.getString("CD_ID");
										String View_CNT = rs.getString("View_CNT");
						%>


						<div class="panel" style="border: 2px solid #EAEAEA;">
							<div class="panel-heading">
								<div class="row">
									<p class="panel-title text-center"
										style="font-size: 20px; font-weghit: bold"><%=Header%></p>

									<hr style="border: solid 1.5px #EAEAEA;">
								</div>
								<div class="row">
									<div class="panel-heading" style="padding: 0px 15px">

										<div class="text-right">
											<img src="/img/creator.png" />
											<%
												if (Compare_CD_ID.equals("20")) { //20이면 관리자로 표현
											%><span class="label label-default">관리자</span>
											<%
												} else if (Compare_CD_ID.equals("2")) {//2면 익명으로
											%><span class="label label-default">익명</span>
											<%
												} else {//암것도 아니면 그냥 게시자
											%>

											<span class="label label-default"><%=Creator%></span>&nbsp;&nbsp;
											<%
												}
											%><img src="/img/date.png" /> <span
												class="label label-default"><%=Time%></span>&nbsp;&nbsp; <img
												src="/img/see.png" /> <span class="label label-default"><%=View_CNT%></span>
										</div>
									</div>
									<hr>
								</div>
							</div>

							<div class="panel-body">

								<div class="row">
									<div class="panel-body" style="font-size: 17px;">
										<%=Contents%>

									</div>
									<hr>
									<div class="text-right">
										<div class="panel-body" style="padding: 0px 15px">
											<div class="btn-group dropup">
												<%
													if (Get_ID != null) { //로그인을 했을 경우에!
												%>
												<form name="Choose_Action" action="#" method="post">
													<%
														if (Get_ID.equals(Creator) || Get_Class.equals("1")) {
																			//관리자이거나 작성자 본인일 경우
													%>




													<input name="WB_ID" type="hidden" value=<%=WB_ID%>>
													<input name="WB_Creator" type="hidden" value=<%=Creator%>>

													<button type="button" class="btn btn-default"
														aria-label="Left Align" onclick="choose_action(0)">
														<!-- delete_confirm() -->
														<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
													</button>

													<button type="button" class="btn btn-default"
														aria-label="Left Align" onclick="choose_action(1)">
														<!-- Alter_confirm() -->
														<span class="glyphicon glyphicon-wrench"
															aria-hidden="true"></span>
													</button>





													<%
														}
													%>
												<!-- 	<button type="button" class="btn btn-default"
														aria-label="Left Align" onclick="choose_action(2)">
														<span class="glyphicon glyphicon-share" aria-hidden="true"></span>
													</button> -->
												</form>
												<%
													}
												%>

											</div>

										</div>
									</div>
									<hr>

								</div>
								<div class="text-center">
									<h6>좋아요</h6>

									<jsp:include page="/Like/Like_Method.jsp" flush="false">
										<jsp:param value="<%=WB_ID%>" name="WB_ID" />
									</jsp:include>

								</div>

							</div>




							<div class="panel-footer">
								<jsp:include page="/Reply/commentclient.jsp" flush="false">
									<jsp:param value="<%=CD_ID%>" name="CD_ID" />
									<jsp:param value="<%=CS_ID%>" name="CS_ID" />
								</jsp:include>
							</div>
						</div>









						<%
							}
									pstmt = conn
											.prepareStatement("update C_write_board set View_CNT=View_CNT+1 where WB_ID='"
													+ WB_ID + "';");
									pstmt.executeUpdate();
									conn.commit();
								} catch (

								SQLException e) {
									e.printStackTrace();
								} finally {
									if (pstmt != null)
										pstmt.close();
									if (rs != null)
										rs.close();
									if (stmt != null)
										stmt.close();
									if (conn != null)
										conn.close();
								}
						%>
					</div>
				</div>
			</div>
		</div>
		<%
			}
		%>
		<script>
			changeImageSize();
		</script>

	</div>



	<jsp:include page="/footer.jsp" flush="false" />
</body>
</html>