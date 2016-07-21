<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	

 <style type="text/css">

/*네비게이션 바 기본 색상 지정*/
.navbar-default{

    background-image: linear-gradient(to bottom, #002266 0, #002266 100%) !important;
}
/*네비게이션 바 글자 색깔*/
.navbar-nav>li>a {
    color: #BDBDBD !important;
}
/*네비게이션 클릭 했을 때*/
.navbar-default .navbar-nav>.active>a, .navbar-default .navbar-nav>.open>a{
    background-image: linear-gradient(to bottom,#123478 0,#123478 100%) !important;
    
    }

/*마우스가 위로 지나갈 때 */

.navbar-default .navbar-nav>li>a:focus, .navbar-default .navbar-nav>li>a:hover
	{
	color: white  !important; 
	background-color: #123478  !important;
}

/*토글 기본 색상*/
.navbar-default .navbar-toggle {
	border: 0px;
}
/*토글 클릭 및 위로 지나갈 때 */
.navbar-default .navbar-toggle:focus, .navbar-default .navbar-toggle:hover
	{
	background-color: white !important;
}

/*화면이 작아졌을 때 드롭다운 버튼을 눌렀을 시 글자 색*/
@media ( max-width :767px) {
	.navbar-default .navbar-nav .open .dropdown-menu>li>a {
		color: black !important;
	}

/*화면이 작아졌을 때 드롭다운 버튼을 누르고 마우스 오버됬을 때 글자 색*/
	.navbar-default .navbar-nav .open .dropdown-menu>li>a:focus,
		.navbar-default .navbar-nav .open .dropdown-menu>li>a:hover {
		color: #123478 !important;
		background-color: white !important;
	}


/*드롭다운 배경 색깔*/
.dropdown-menu>li>a {
  		background-color: white !important;
}
</style>





	<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container">
		<div class="navbar-header text-center">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#navbar" aria-expanded="false"
				aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/index.jsp">
				<img alt="Brand" src="/img/brand.png">
			</a>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false">게시판
						<span class="caret"></span>
				</a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="/Board/Show_Board.jsp?CD_ID=19&CS_ID=1">모든 글 게시판</a></li>
						<li><a href="/Board/Show_Board.jsp?CD_ID=18&CS_ID=1">베스트 게시판</a></li>
						<li><a href="/Board/Show_Board.jsp?CD_ID=1&CS_ID=1">자유 게시판</a></li>
						<li><a href="/Board/Show_Board.jsp?CD_ID=2&CS_ID=1">익명 게시판</a></li>
						<li><a href="/Board/Show_Board.jsp?CD_ID=3&CS_ID=1">CU 지식인</a></li>
						<li><a href="/Board/Show_Board.jsp?CD_ID=4&CS_ID=1">과팅</a></li>
						<li><a href="/Board/Show_Board.jsp?CD_ID=5&CS_ID=1">분실물 신고</a></li>
					</ul></li>


				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false">공유<span
						class="caret"></span>
				</a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="/Board/Show_Board.jsp?CD_ID=6&CS_ID=2">맛집 공유</a></li>
						<li><a href="/Board/Show_Board.jsp?CD_ID=7&CS_ID=2">꿀팁 공유</a></li>
						<li><a href="/Board/Show_Board.jsp?CD_ID=8&CS_ID=2">기타 공유</a></li>
					</ul></li>

				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false">강의 <span
						class="caret"></span>
				</a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="/Board/Show_Board.jsp?CD_ID=9&CS_ID=3">강의 정보</a></li>
						<li><a href="/Board/Show_Board.jsp?CD_ID=10&CS_ID=3">강의 QnA</a></li>
						<li><a href="/Board/Show_Board.jsp?CD_ID=11&CS_ID=3">중고 책방</a></li>
						<li><a href="/Board/Show_Board.jsp?CD_ID=12&CS_ID=3">스터디</a></li>
					</ul></li>

				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false">소식 <span
						class="caret"></span>
				</a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="/Board/Show_Board.jsp?CD_ID=13&CS_ID=4">총학 소식</a></li>
						<li><a href="/Board/Show_Board.jsp?CD_ID=14&CS_ID=4">총동 소식</a></li>
						<li><a href="/Board/Show_Board.jsp?CD_ID=15&CS_ID=4">단대별 소식</a></li>
					</ul></li>

				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false">취업/진로
						<span class="caret"></span>
				</a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="/Board/Show_Board.jsp?CD_ID=16&CS_ID=5">취업 게시판</a></li>
						<li><a href="/Board/Show_Board.jsp?CD_ID=17&CS_ID=5">진로 게시판</a></li>
					</ul></li>

				<%
					//로그인 여부
					Object a = session.getAttribute("Get_Name");
					if (a == null) {
				%>
				<!-- 로그인 안되있으면 -->
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false">계정 <span
						class="caret"></span>
				</a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="/Log/Register.jsp">회원가입</a></li>
						<li><a href="#"
							onclick="window.open('/Log/Login_Ready.jsp','blank','width=350,height=150');return false">로그인</a></li>
						<li><a href="/S_D/Portfolio/Portfolio_Show.jsp">암호 분실</a></li>
					</ul></li>

				<%
					} else {
				%>
				<!-- 로그인 되있으면 -->
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false">내 정보
						<span class="caret"></span>
				</a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="/S_D/Portfolio/Portfolio.jsp">개인정보 수정</a></li>
						<li><a href="/S_D/Portfolio/Portfolio_Show.jsp">내 글 보기</a></li>
						<li><a href="/S_D/Portfolio/Portfolio_Show.jsp">내 댓글 보기</a></li>
						<li><a href="/Log/LogOut.jsp">로그아웃</a></li>
					</ul></li>
					
					
					
				<%
					}
				%>
			
			</ul>
		</div>
	</div>

	</nav>