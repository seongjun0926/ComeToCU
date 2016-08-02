<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="Util.DB"%>
<%!public Integer toInt(String x) {
		int a = 0;
		try {
			a = Integer.parseInt(x);
		} catch (Exception e) {
		}
		return a;
	}%>
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
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js">
	
</script>

<style type="text/css">
.alert {
	background-color: white !important;
	color: black !important;
}

a.list-group-item {
	background-color: white !important;
	color: black !important;
}

a.list-group-item:hover {
	background-color: white !important;
	border: 2px solid #0D3FA5 !important;
	color: #00096F !important;
}
</style>

<title>자유 게시판</title>



</head>
<body style="background-color: #f7f7f7">
	<%
		request.setCharacterEncoding("utf-8");
	%>
	<br>
	<br>
	<br>

	<div>
		<!-- 색깔 넣어주면댐 -->
		<div id="header" class="container">

			<!-- 상단 네비게이션 바 -->
			<jsp:include page="/NavBar.jsp" flush="false" />


			<!-- 세션으로 로그인이 되어있는지 안되어있는지 확인. 나중에 페이지 하나 새로 만들어서 include하고 싶은데 할줄몰라서 그냥 이렇게함. -->
			<%
				String CD_ID = request.getParameter("CD_ID");

				String Get_ID = (String) session.getAttribute("Get_ID");

				if ((Get_ID == null || Get_ID == "") && CD_ID.equals("20") == false) {
					//로그인을 안했고, CD_ID가 20이 아니다(true) T&T 라면 로그인 ㄱ
					//로그인을 안했고, CD_ID가 20이다 -> else
			%>
			<!-- <script>
				alert("로그인이 필요합니다.")
				window.open('/Log/Login_Ready.jsp', 'blank',
						'width=350,height=150');
			</script> -->
			<!-- 모달을 추가해서 모달을 띄움 -->
			<script type="text/javascript">
				alert("로그인이 필요합니다.")
				$('#login').modal('show')
			</script>


			<%
				} else {
					String URI = request.getRequestURL().toString();
					if (request.getQueryString() != null)
						URI = URI + "?" + request.getQueryString();
					session.setAttribute("URI", URI);
					//Sub_Board에서 get방식으로 받은 CD_ID,CS_ID로 화면을 표시함.
					String CS_ID = request.getParameter("CS_ID");
					Date from = new Date();
					SimpleDateFormat transFormat = new SimpleDateFormat(
							"yy-MM-dd HH:mm");
					String Date = transFormat.format(from);

					String Search_Content = request.getParameter("Search_Content");

					System.out.println("Show_Board.jsp CD_ID : " + CD_ID
							+ " CS_ID : " + CS_ID + " URI : " + URI
							+ " Search_Content : " + Search_Content);

					int total = 0;
					int R_total = 0;

					//데이터의 확장성을 이용하기위해 CD_Contents는  게시판 이름, CD_Notice는 게시판 성격, 공지글
					String CD_Contents = null;
					String CD_Notice = null;

					//글을 새로쓰면 N 라는 사진이 옆에 뜨게 하기위해 비교하기위한 변수.
					String Compare_Date = null;
					String Compare_WB_Time = null;

					Connection conn = null;
					Statement stmt = null;
					Statement R_stmt = null;
					ResultSet rs = null;
					ResultSet Reply_Count = null;

					try {
						conn = DB.getConnection();
						stmt = conn.createStatement();
						R_stmt = conn.createStatement();

						//게시판 이름 및 게시판 공지글을 가져옴.
						rs = stmt
								.executeQuery("select CD_Contents,CD_Notice from C_category_detail where CD_ID="
										+ CD_ID + ";");
						if (rs.next()) {
							CD_Contents = rs.getString("CD_Contents");
							CD_Notice = rs.getString("CD_Notice");
							rs.close();
						}
						if (CD_ID.equals("22")) {//내가 쓴 글
							rs = stmt
									.executeQuery("select COUNT(*) from C_write_board where WB_Creator="
											+ Get_ID + ";");

						} else if (CD_ID.equals("19")) {//모든글
							rs = stmt
									.executeQuery("select COUNT(*) from C_write_board where not CD_ID=20;");//공지사항 빼고
							if (Search_Content != null) {//검색을 위한 쿼리
								rs = stmt
										.executeQuery("select COUNT(*) from C_write_board where WB_Header like '%"
												+ Search_Content
												+ "%' or WB_Contents like '%"
												+ Search_Content + "%';");
							}
						} else if (CD_ID.equals("18")) {//베스트글
							rs = stmt
									.executeQuery("select COUNT(*) from C_write_board where (not CD_ID=20) and (WB_Like_Num > 50);");
							if (Search_Content != null) {
								rs = stmt
										.executeQuery("select COUNT(*) from C_write_board where (WB_Like_Num > 50) and (WB_Header like '%"
												+ Search_Content
												+ "%' or WB_Contents like '%"
												+ Search_Content + "%');");
							}
						} else {
							//글이 있나 없나 확인하고 있으면 보여주고 없으면 등록된 글이 없다고 표시
							rs = stmt
									.executeQuery("select COUNT(*) from C_write_board where CD_ID="
											+ CD_ID + ";");
							if (Search_Content != null) {
								rs = stmt
										.executeQuery("select COUNT(*) from C_write_board where (CD_ID="
												+ CD_ID
												+ ") and (WB_Header like '%"
												+ Search_Content
												+ "%' or WB_Contents like '%"
												+ Search_Content + "%');");
							}
						}

						if (rs.next()) {
							total = rs.getInt(1);
						}
			%>

		</div>
	</div>
	<div>
		<!-- 색깔 넣어주면댐  -->
		<div class="container">

			<!-- 게시판 header부분, 머리부분, 틀을 구성 -->
			<div class="panel" style="border: 2px solid #EAEAEA">
				<div class="panel-heading">
					<div class="panel-title text-center"
						style="font-weight: bold; color: #002266;"><%=CD_Contents%></div>
				</div>

				<div class="alert  text-center" role="alert"
					style="background-color: #002266">

					<%=CD_Notice%>
				</div>
				<div class="panel-body">

					<jsp:include page="/Board/Sub_Board.jsp" flush="false" />

					<div class="col-md-10 col-xs-12">
						<table class="table">
							<thead>
								<tr>
									<td>
										<div class="row visible-md visible-lg">
											<div class="col-xs-1 text-center">
												<font color="#0D3FA5"><b>번호</b></font>
											</div>
											<div class="col-xs-6 text-left">
												<font color="#0D3FA5"><b>제목</b></font>
											</div>
											<div class="col-xs-1 text-center">
												<font color="#0D3FA5"><b>따봉</b></font>
											</div>
											<div class="col-xs-1 text-center">
												<font color="#0D3FA5"><b>작성자</b></font>
											</div>
											<div class="col-xs-2 text-center">
												<font color="#0D3FA5"><b>날짜</b></font>
											</div>
											<div class="col-xs-1 text-center">
												<font color="#0D3FA5"><b>조회수 </b></font>
											</div>
										</div>
									</td>
								</tr>
							</thead>
							<%
								if (total == 0) {
							%>
							<thead>
								<tr>
									<td>
										<div class="row">
											<div class="well text-center">등록된 글이 없습니다.</div>
										</div> <jsp:include page="/Search/Search_Bar.jsp" flush="false" />

									</td>
								</tr>
								<tr>

								</tr>
								<tr class="visible-sm visible-xs">
									<td style="border: 0px">
										<div class="list-group">
											<a href="/Write_Board/Write_Board.jsp"
												class="list-group-item list-group-item-success">-글 쓰기</a>
										</div>
									</td>
								</tr>
							</thead>
							<%
								} else {

											int pageno = toInt(request.getParameter("pageno"));
											if (pageno < 1) {//현재 페이지
												pageno = 1;
											}
											int total_record = total; //총 레코드 수
											int page_per_record_cnt = 10; //페이지 당 레코드 수
											int group_per_page_cnt = 5; //페이지 당 보여줄 번호 수[1],[2],[3],[4],[5]
											//                                                       [6],[7],[8],[9],[10]                                 

											int record_end_no = pageno * page_per_record_cnt;
											int record_start_no = record_end_no
													- (page_per_record_cnt - 1);
											if (record_end_no > total_record) {
												record_end_no = total_record;
											}

											int total_page = total_record
													/ page_per_record_cnt
													+ (total_record % page_per_record_cnt > 0 ? 1
															: 0);
											if (pageno > total_page) {
												pageno = total_page;
											}

											//             현재 페이지(정수) / 한페이지 당 보여줄 페지 번호 수(정수) + (그룹 번호는 현제 페이지(정수) % 한페이지 당 보여줄 페지 번호 수(정수)>0 ? 1 : 0)
											int group_no = pageno / group_per_page_cnt
													+ (pageno % group_per_page_cnt > 0 ? 1 : 0);
											//               현재 그룹번호 = 현재페이지 / 페이지당 보여줄 번호수 (현재 페이지 % 페이지당 보여줄 번호 수 >0 ? 1:0)   
											//            ex)    14      =   13(몫)      =    (66 / 5)      1   (1(나머지) =66 % 5)           

											int page_eno = group_no * group_per_page_cnt;
											//               현재 그룹 끝 번호 = 현재 그룹번호 * 페이지당 보여줄 번호 
											//            ex)    70      =   14   *   5
											int page_sno = page_eno - (group_per_page_cnt - 1);
											//                현재 그룹 시작 번호 = 현재 그룹 끝 번호 - (페이지당 보여줄 번호 수 -1)
											//            ex)    66   =   70 -    4 (5 -1)

											if (page_eno > total_page) {
												//               현재 그룹 끝 번호가 전체페이지 수 보다 클 경우      
												page_eno = total_page;
												//               현재 그룹 끝 번호와 = 전체페이지 수를 같게
											}

											int prev_pageno = page_sno - group_per_page_cnt; // <<  *[이전]* [21],[22],[23]... [30] [다음]  >>
											//               이전 페이지 번호   = 현재 그룹 시작 번호 - 페이지당 보여줄 번호수   
											//            ex)      46      =   51 - 5            
											int next_pageno = page_sno + group_per_page_cnt; // <<  [이전] [21],[22],[23]... [30] *[다음]*  >>
											//               다음 페이지 번호 = 현재 그룹 시작 번호 + 페이지당 보여줄 번호수
											//            ex)      56      =   51 - 5
											if (prev_pageno < 1) {
												//               이전 페이지 번호가 1보다 작을 경우      
												prev_pageno = 1;
												//               이전 페이지를 1로
											}
											if (next_pageno > total_page) {
												//               다음 페이지보다 전체페이지 수보가 클경우      
												next_pageno = total_page / group_per_page_cnt
														* group_per_page_cnt + 1;
												//               next_pageno=total_page
												//               다음 페이지 = 전체페이지수 / 페이지당 보여줄 번호수 * 페이지당 보여줄 번호수 + 1 
												//            ex)            =    76 / 5 * 5 + 1   ????????       
											}

											// [1][2][3].[10]
											// [11][12]
											if (CD_ID.equals("22")) {//모든글 
												rs = stmt
														.executeQuery("select * from C_write_board where WB_Creator='"
																+ Get_ID
																+ "' order by WB_ID desc limit "
																+ ((pageno - 1) * page_per_record_cnt)
																+ "," + page_per_record_cnt + ";");

											} else if (CD_ID.equals("19")) {//모든글 
												rs = stmt
														.executeQuery("select * from C_write_board where not CD_ID=20 order by WB_ID desc limit "
																+ ((pageno - 1) * page_per_record_cnt)
																+ "," + page_per_record_cnt + ";");
												if (Search_Content != null) {
													rs = stmt
															.executeQuery("select * from C_write_board where WB_Header like '%"
																	+ Search_Content
																	+ "%' or WB_Contents like '%"
																	+ Search_Content
																	+ "%' order by WB_ID desc limit "
																	+ ((pageno - 1) * page_per_record_cnt)
																	+ ","
																	+ page_per_record_cnt
																	+ ";");
												}
											} else if (CD_ID.equals("18")) { //베스트글
												rs = stmt
														.executeQuery("select * from C_write_board where (not CD_ID=20)and (WB_Like_Num > 50) order by WB_ID desc limit "
																+ ((pageno - 1) * page_per_record_cnt)
																+ "," + page_per_record_cnt + ";");
												if (Search_Content != null) {
													rs = stmt
															.executeQuery("select * from C_write_board where (WB_Like_Num > 50) and (WB_Header like '%"
																	+ Search_Content
																	+ "%' or WB_Contents like '%"
																	+ Search_Content
																	+ "%') order by WB_ID desc limit "
																	+ ((pageno - 1) * page_per_record_cnt)
																	+ ","
																	+ page_per_record_cnt
																	+ ";");
												}
											} else {
												//CD_ID 즉 게시판 성격에 맞는 저장된 글의 모든 것을 가져옴
												rs = stmt
														.executeQuery("select * from C_write_board where CD_ID="
																+ CD_ID
																+ " order by WB_ID desc limit "
																+ ((pageno - 1) * page_per_record_cnt)
																+ "," + page_per_record_cnt + ";");
												if (Search_Content != null) {
													rs = stmt
															.executeQuery("select * from C_write_board where (CD_ID="
																	+ CD_ID
																	+ ") and (WB_Header like '%"
																	+ Search_Content
																	+ "%' or WB_Contents like '%"
																	+ Search_Content
																	+ "%') order by WB_ID desc limit "
																	+ ((pageno - 1) * page_per_record_cnt)
																	+ ","
																	+ page_per_record_cnt
																	+ ";");
												}
											}
											//이제부터 게시판 본체, 몸부분 시작
											while (rs.next()) {
												String ID = rs.getString("WB_ID");
												String Header = rs.getString("WB_Header");
												String Like_Num = rs.getString("WB_Like_Num");
												String WB_Creator = rs.getString("WB_Creator");
												String WB_Time = rs.getString("WB_Time");
												String Compare_CD_ID = rs.getString("CD_ID");
												String View_CNT = rs.getString("View_CNT");
												//익명을 나타내기위한 변수
												//리플 갯수를 가져와서 게시글 이름에 표시
												Reply_Count = R_stmt
														.executeQuery("select count(*) from C_write_board inner join C_reply on C_write_board.WB_ID = C_reply.WB_ID where C_write_board.WB_ID="
																+ ID + ";");
												if (Reply_Count.next()) {
													R_total = Reply_Count.getInt(1);
												}
							%>
							<!-- 투명 버튼형식으로 표현되며 클릭하면 아래 주소로 값과 함께 화면이 변경됨 -->
							<form action="/Board/Show_Detail_Board.jsp" method="GET">
								<tbody>
									<!-- 꽉 찬 화면일 때 -->
									<tr class="visible-md visible-lg">

										<td>
											<button class="btn btn-link btn-block" type="submit"
												style="padding-top: 0px; padding-bottom: 0px; border-top: 0px; border-bottom: 0px;">
												<input type="hidden" name="CS_ID" value="<%=CS_ID%>">
												<input type="hidden" name="CD_ID" value="<%=CD_ID%>">
												<input type="hidden" name="WB_ID" value="<%=ID%>">
												<div class="row">
													<div class="col-xs-1 text-center">
														<font color="#353535"><%=ID%></font>
													</div>
													<div class="col-xs-6 text-left">
														<font color="#353535"><%=Header%></font> [<%=R_total%>]
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

													<div class="col-xs-1 text-center">
														<font color="#353535"><%=Like_Num%></font>
													</div>
													<%
														if (Compare_CD_ID.equals("20")) {
													%><div class="col-xs-1 text-center">
														<font color="#353535">관리자</font>
													</div>
													<%
														}
														else if (Compare_CD_ID.equals("2")) {
													%><div class="col-xs-1 text-center">
														<font color="#353535">익명</font>
													</div>
													<%
														} else {
													%>
													<div class="col-xs-1 text-center">
														<font color="#353535"><%=WB_Creator%></font>
													</div>
													<%
														}
													%>
													<div class="col-xs-2 text-center">
														<font color="#353535"><%=WB_Time%></font>
													</div>
													<div class="col-xs-1 text-center">
														<font color="#353535"><%=View_CNT%></font>
													</div>


												</div>
											</button>
										</td>
									</tr>
									<!-- 꽉 찬 화면이 아닐 때 -->
									<tr class="visible-sm visible-xs">
										<td class="text-left">
											<button class="btn btn-link btn-block" type="submit"
												style="margin-top: 0px; margin-bottom: 0px; padding-top: 5px; padding-bottom: 0px; border-top: 0px; border-bottom: px;">

												<div class="row text-left">
													<div class="text-left" style="font-size: 16px;">
										
														<%
															if (Header.length() > 17) { //공지사항 글이 아니고 글자 제목의 길이가 13자리를  넘을 경우
																				String Header_ = Header.substring(0, 16);
														%>
														<font color="black"><%=Header_ + "..."%></font>
														<%
															} else {//아닌경우
														%>
														<font color="black"><%=Header%></font>
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
														 [<%=R_total%>]
													</div>
													<div class="text-left"
														style="color: gray; font-size: 14px; opacity: 0.7;">
														<img src="/img/creator.png" />
														<%
															if (CD_ID.equals("20")) {
														%><font color="black">관리자</font>
														<%
															}
															else if (CD_ID.equals("2")) {
														%><font color="black">익명</font>
														<%
															} else {
														%>
														<font color="black"><%=WB_Creator%></font>
														<%
															}
														%>
														&nbsp;&nbsp;
														<%
															String Show_date = WB_Time;
																			Show_date = Show_date.substring(3, 8);
														%>
														<img src="/img/date.png" /> <font color="black"><%=Show_date%></font>&nbsp;&nbsp;
														<img src="/img/like.png" /> <font color="black"><%=Like_Num%></font>&nbsp;&nbsp;
														<img src="/img/see.png" /> <font color="black"><%=View_CNT%></font>

													</div>
												</div>

											</button>
										</td>

									</tr>
								</tbody>
							</form>


							<%
								}
							%>

							<tr>

								<td class="text-center"><br> <br> <a
									href="Show_Board.jsp?CD_ID=<%=CD_ID%>&CS_ID=<%=CS_ID%>&pageno=1">[맨앞으로]</a>
									<a
									href="Show_Board.jsp?CD_ID=<%=CD_ID%>&CS_ID=<%=CS_ID%>&pageno=<%=prev_pageno%>">[이전]</a>
									<%
										for (int i = page_sno; i <= page_eno; i++) {
									%> <a
									href="Show_Board.jsp?CD_ID=<%=CD_ID%>&CS_ID=<%=CS_ID%>&pageno=<%=i%>">
										<%
											if (pageno == i) {
										%> [<%=i%>] <%
											} else {
										%> <%=i%> <%
 	}
 %>
								</a> <%--   콤마    --%> <%
 	if (i < page_eno) {
 %> , <%
 	}
 %> <%
 	}
 %> <a
									href="Show_Board.jsp?CD_ID=<%=CD_ID%>&CS_ID=<%=CS_ID%>&pageno=<%=next_pageno%>">[다음]</a>
									<a
									href="Show_Board.jsp?CD_ID=<%=CD_ID%>&CS_ID=<%=CS_ID%>&pageno=<%=total_page%>">[맨뒤로]</a>





								</td>


							</tr>

							<tr>
								<td class="text-center" style="border: 0px"><jsp:include
										page="/Search/Search_Bar.jsp" flush="false" /></td>
							</tr>

							<tr class="visible-sm visible-xs">
								<td style="border: 0px">
									<div class="list-group">
										<a href="/Write_Board/Write_Board.jsp"
											class="list-group-item list-group-item-success">-글 쓰기</a>
									</div>
								</td>
							</tr>




							<%
								}
							%>
						</table>
						<%
							} catch (SQLException e) {
									e.printStackTrace();
								} finally {
									if (Reply_Count != null)
										Reply_Count.close();
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


	</div>


	<jsp:include page="/footer.jsp" flush="false" />
</body>
</html>