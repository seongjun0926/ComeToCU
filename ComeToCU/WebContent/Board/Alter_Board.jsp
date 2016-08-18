<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
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

<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js"
	charset="utf-8"></script>

<script type="text/javascript" src="/Reply/ajax.js"></script>
<script type="text/javascript">

	function submitContents(elClickedObj) {
		// 에디터의 내용이 textarea에 적용된다.
		oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);

		//var a=document.getElementById("WB_Header").value;
		//이 둘의 차이는 그냥 ID로 가져오나 name으로 가져오나 차이인듯 하다
		//var a =document.Board.WB_Header.value;

		var Header = document.getElementById("WB_Header").value;
		if (Header == null || Header == "") {
			alert("제목을 입력하세요.")
			return false;
		}

		var Text = document.getElementById("ir1").value;
		var length = Text.length;

		Text = Text.replace(/&nbsp;/gi, "");
		Text = Text.replace(/<br>/gi, "");
		Text = Text.replace(/ /gi, "");

		if (length >10000) {
			alert("10000자 이내로 작성해주세요.")
			return false;
		}
		
		
		if (Text == "<p><\/p>" || Text == "" || Text==null) {
			alert("내용을 입력하세요.")
			return false;
		}

		// 에디터의 내용에 대한 값 검증은 이곳에서
		// document.getElementById("ir1").value를 이용해서 처리한다.

		try {
			elClickedObj.form.submit();
		} catch (e) {
		}
	}
</script>
<style type="text/css">
.panel-heading {
	background-color: white !important;
	color: black !important;
}
</style>

<title>게시판 글 쓰기</title>
</head>
<body style="background-color: #f7f7f7">

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
			/* String CS_ID=request.getParameter("CS_ID");
			String CD_ID = request.getParameter("CD_ID"); */
			String Get_ID = (String) session.getAttribute("Get_ID");
			String Get_Certification= (String)session.getAttribute("Get_Certification");
			String WB_Header="";
			String WB_Contents="";
			if (Get_ID == null) {
				//로그인을 안했고, CD_ID가 20이 아니다(true) T&T 라면 로그인 ㄱ
				//로그인을 안했고, CD_ID가 20이다 -> false
		%>

			<!-- 모달을 추가해서 모달을 띄움 -->
			<script>
				alert("로그인이 필요합니다.")
				$('#login').modal('show')
			</script>

			<%
			}else if(Get_Certification==null||Get_Certification.equals("0")){
				//로그인을 안했거나 회원인증을 안했는데, 공지사항 볼때,
				%>
			<script>
				alert("회원가입시 작성한 본교 홈페이지 메일에서 인증을 해주세요!");
				location.href="/index.jsp";

			</script>
			<%
			}else {
					request.setCharacterEncoding("UTF-8");
					String URI = (String) session.getAttribute("URI");//전에 있던 페이지로 돌아가기위한 변수
					String WB_ID=request.getParameter("WB_ID");
					String WB_Creator=request.getParameter("WB_Creator");
					Connection conn=null;
					Statement stmt = null;
					ResultSet rs=null;
					
					try{
						conn=DB.getConnection();
						conn.setAutoCommit(false);
						stmt = conn.createStatement();
						rs = stmt.executeQuery("select WB_Header,WB_Contents from C_write_board where WB_ID="+WB_ID+" and WB_Creator='"+ WB_Creator + "';");
						
						if(rs.next()){
							WB_Header=rs.getString("WB_Header");
							WB_Contents=rs.getString("WB_Contents");
						}
						
						
						
					}catch(Throwable e){
						try { conn.rollback(); } catch(SQLException ex) {}
					}finally {
						if (rs != null) 
							try { rs.close(); } catch(SQLException ex) {}
						if (conn != null) try {
							conn.setAutoCommit(true);
							conn.close();
						} catch(SQLException ex) {}
					}
					
					
					
					
					
					
			%>
		</div>
	</div>
	<div>
		<!-- 색깔 넣어주면댐  -->
		<div class="container">
			<div class="panel panel-default">
				<div class="panel-heading text-center" style="font-size: 20px;">글 수정</div>
				<div class="panel-body">

					<form name="Board" action="/Board/Alter_Board_DB.jsp"
						method="POST">
						<input type="hidden" name="WB_ID" id="WB_ID" value="<%=WB_ID %>">
						<!-- <div class="row">
							카테고리 <select name="F_Category" class="form-control"
								onChange="Board_Select(this.value)">
								<option selected="selected" value="" disabled>카테고리 구분</option>
								<option id="Board_Select" value="1">게시판</option>
								<option id="Board_Select" value="2">공유</option>
								<option id="Board_Select" value="3">강의</option>
								<option id="Board_Select" value="4">소식</option>
								<option id="Board_Select" value="5">취업/진로</option>
							</select>

							동적으로 할당된 select box를 보여주기 위한 공간
							<select name="S_Category" class="form-control" id="BoardList"
								onChange="Board_Detail_Select(this.value)">
								<option selected="selected" disabled>세부 카테고리</option>
							</select>
						</div> -->
						<br>
						<div class="row">
							제목 <input type="text" placeholder="제목을 입력해주세요."
								class="form-control" name="WB_Header" id="WB_Header"
								maxlength="50" value="<%=WB_Header%>">
						</div>
						<br>
						<div class="row">

							<textarea maxlength='10000' name='ir1' id='ir1' rows='10'
								cols='100'
								style='width: device-width; min-width: 150px; height: 100px; display: none;'><%=WB_Contents %></textarea>


						</div>
						<div class="row text-right">
							<br> <input type="button" value="등록"
								onClick="submitContents(this)">

						</div>
					</form>
				</div>
			</div>
		</div>

		<script type="text/javascript">
			var oEditors = [];
			nhn.husky.EZCreator.createInIFrame({
				oAppRef : oEditors,
				elPlaceHolder : "ir1",
				sSkinURI : "/smarteditor/SmartEditor2Skin2_m.html",
				fCreator : "createSEditor2"
			});
		</script>

		<%
			}
		%>

	</div>


	<jsp:include page="/footer.jsp" flush="ture" />
</body>
</html>