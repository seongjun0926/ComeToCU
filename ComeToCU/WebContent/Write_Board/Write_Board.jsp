<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	//submit 할 때 값을 넘겨주기 위해 전역변수 선언
	var BS = null;
	var BDS = null;

	//두번째 동적으로 할당된 selectbox의 값을 가져옴 
	//this.value로 함수를 호출했기 때문에 별 다른 변형없이바로 사용가능
	function Board_Detail_Select(BDS_Value) {
		BDS = BDS_Value;
	}

	//ajax통신으로 뒤에 selectbox 동적 할당하기 위한 함수
	function Board_Select(BS_Value) {
		BS = BS_Value;

		//첫 카테고리 구분을 한 후 두번 째 카테고리가 초기화 될 수 있게끔 하는 작업
		var Select_BoardList = document.getElementById("BoardList");
		for (i = 0; i < Select_BoardList.options.length; i++)
			Select_BoardList.options[i] = null;
		Select_BoardList.options.length = 0;

		//ajax통신으로 넘기기 위한 작업
		var param = "id=" + encodeURIComponent(BS_Value);
		new ajax.xhr.Request("/Write_Board/Board_Search.jsp", param,
				loadBoardList, 'GET');
	}

	function loadBoardList(req) {
		//연결
		if (req.readyState == 4) {
			//정상이면
			if (req.status == 200) {
				//object 받아옴
				var xmlDoc = req.responseXML;
				var code = xmlDoc.getElementsByTagName('code').item(0).firstChild.nodeValue;
				if (code == 'success') {
					var BoardList = eval("("
							+ xmlDoc.getElementsByTagName('data').item(0).firstChild.nodeValue
							+ ")");

					//select box 초기 값을 바로 불러들이지 못하고 선택을 해야만 값을 받아올 수 있기 disabled된 카테고리하나 추가
					var listDiv = document.getElementById('BoardList');
					var BoardFirst = makeBoardFirst();

					//select box(세부 카테고리)에서 동적으로 자료들 보여주기 위한 코드
					listDiv.appendChild(BoardFirst);
					for (var i = 0; i < BoardList.length; i++) {
						var BoardDiv = makeBoardView(BoardList[i]);
						listDiv.appendChild(BoardDiv);
					}
				} else if (code == 'error') {
					var message = xmlDoc.getElementsByTagName('message')
							.item(0).firstChild.nodeValue;
					alert("에러 발생:" + message);
				}
			} else {
				alert("에러 발생:" + req.status);
			}
		}
	}

	//값을 선택하게끔 하기 위한 함수
	function makeBoardFirst() {
		//<option> </option> 을 만듬
		var BoardFirst = document.createElement('option');

		//<option selected="selected">
		BoardFirst.setAttribute('selected', "selected");
		//<option selected="selected" disabled="true">
		BoardFirst.setAttribute('disabled', "true");

		//<option selected="selected" disabled>세부 카테고리</option>
		var html = "세부 카테고리";
		BoardFirst.innerHTML = html;
		return BoardFirst;

	}

	function makeBoardView(Board) {
		//<option>
		var BoardDiv = document.createElement('option');
		//<option id="~"
		BoardDiv.setAttribute('id', Board.id);
		//<option id="~" value="~">~</option>
		BoardDiv.setAttribute('value', Board.id);
		var html = Board.CD_Contents.replace(/\n/g, '');
		BoardDiv.innerHTML = html;
		BoardDiv.Board = Board;
		BoardDiv.className = "Board";
		return BoardDiv;

	}
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

		if (BS == null || BDS == null) {
			alert("카테고리와 세부카테고리를 정해주세요.")
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

.panel-heading{
background-color: white !important;
color: black !important;
}


</style>

<title>게시판 글 쓰기</title>
</head>
<body style="background-color:#f7f7f7">

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
			String Get_ID = (String) session.getAttribute("Get_ID");
			String CD_ID = request.getParameter("CD_ID");
			String Get_Certification= (String)session.getAttribute("Get_Certification");
			
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

					String URI = (String) session.getAttribute("URI");//전에 있던 페이지로 돌아가기위한 변수
					System.out.println("Write_Board.jsp URI : " + URI + " ID : " + Get_ID);
			%>
		</div>
	</div>
	<div>
		<!-- 색깔 넣어주면댐  -->
		<div class="container">
			<div class="panel panel-default" >
				<div class="panel-heading text-center" style="font-size: 20px;">글
					쓰기</div>
				<div class="panel-body">

					<form name="Board" action="/Write_Board/Write_Board_DB.jsp"
						method="POST">
						<div class="row">
							카테고리 <select name="F_Category" class="form-control"
								onChange="Board_Select(this.value)">
								<option selected="selected" value="" disabled>카테고리 구분</option>
								<option id="Board_Select" value="1">게시판</option>
								<option id="Board_Select" value="2">공유</option>
								<option id="Board_Select" value="3">강의</option>
								<option id="Board_Select" value="4">소식</option>
								<option id="Board_Select" value="5">취업/진로</option>
							</select>

							<!-- 동적으로 할당된 select box를 보여주기 위한 공간 -->
							<select name="S_Category" class="form-control" id="BoardList"
								onChange="Board_Detail_Select(this.value)">
								<option selected="selected" disabled>세부 카테고리</option>
							</select>
						</div>
						<br>
						<div class="row">
							제목 <input type="text" placeholder="제목을 입력해주세요."
								class="form-control" name="WB_Header" id="WB_Header" maxlength="50">
						</div>
						<br>
						<div class="row">

							<textarea maxlength='100' name='ir1' id='ir1' rows='10' cols='100'
								style='width: device-width; min-width: 150px; height: 100px; display: none;' ></textarea>


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