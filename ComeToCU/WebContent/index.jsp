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

<meta name="naver-site-verification" content="a48d55e49fcb4a061159f2e7efd50d5dfa6d7972"/>
<meta name="google-site-verification" content="g5mR01G6S6zzdylSyZz6ABKTIBjyPfcF_sZDJrKh29Q" />
<link rel="canonical" href="http://cometocu.com/index.jsp">

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<title>컴투씨유</title>

<script type="text/javascript">

function change(form)
{
if (form.url.selectedIndex !=0)
parent.location = form.url.options[form.url.selectedIndex].value
}
function setCookie( name, value, expiredays )
{
var todayDate = new Date();
todayDate.setDate( todayDate.getDate() + expiredays );
document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}
function getCookie( name )
{
var nameOfCookie = name + "=";
var x = 0;
while ( x <= document.cookie.length )
{
var y = (x+nameOfCookie.length);
if ( document.cookie.substring( x, y ) == nameOfCookie ) {
if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
endOfCookie = document.cookie.length;
return unescape( document.cookie.substring( y, endOfCookie ) );
}
x = document.cookie.indexOf( " ", x ) + 1;
if ( x == 0 )
break;
}
return "";
} 
if ( getCookie( "Notice1" ) != "done" )
{
noticeWindow = window.open('/event/banner_event.html','Notice','top=0,left=0,toolbar=no,location=no,directories=no,status=no, menubar=no,scrollbars=no, resizable=no,width=346,height=392');

//winddow.open의 ()의 것은 한줄에 계속 붙여써야 오류가 안남, 줄바뀌면 오류남
noticeWindow.opener = self;

}
if ( getCookie( "Notice2" ) != "done" )
{

noticeWindow2 = window.open('/event/best_event.html','Notice2','top=0,left=500,toolbar=no,location=no,directories=no,status=no, menubar=no,scrollbars=no, resizable=no,width=346,height=392');

noticeWindow2.opener = self;

}

</script>


<meta name="description" content="대구가톨릭대학교 커뮤니티 사이트">
</head>
<body style="background-color:#F6F6F6; color:#002266">
	<br>
	<br>
	<br>
	<div style="background-color: #F6F6F6;">
		<!-- 색깔 넣어주면댐 -->
		<div id="header" class="container">

			<!-- 상단 네비게이션 바 -->
			
			<jsp:include page="/NavBar.jsp" flush="false" />
             
<br>
			<div class="row">
				<!-- 학교 로고가 들어갈 자리 -->

				<img class="col-xs-12 col-md-12" src="/img/1.jpg" height="145" alt="사과" />

			</div>
		</div>
		
	</div>

	<div>
		<!-- 색깔 넣어주면댐  -->
		<div class="container">
			
			<!-- 검색창 -->

			<br>
			<div class="row">
				<div class="col-md-12">
					<jsp:include page="/Preview_Board/Preview_Board.jsp" flush="false">
						<jsp:param name="CS_ID" value="1" />
						<jsp:param name="CD_ID" value="20" />
					</jsp:include>
				</div>

			</div>
			<br>
			<div class="row">

				<div class="col-md-4">
					<jsp:include page="/Preview_Board/Preview_Board.jsp" flush="false">
						<jsp:param name="CS_ID" value="1" />
						<jsp:param name="CD_ID" value="19" />
					</jsp:include>
				</div>

				<div class="col-md-4">
					<jsp:include page="/Preview_Board/Preview_Board.jsp" flush="false">
						<jsp:param name="CS_ID" value="1" />
						<jsp:param name="CD_ID" value="18" />
					</jsp:include>
				</div>


				<div class="col-md-4">
					<jsp:include page="/Preview_Board/Preview_Board.jsp" flush="false">
						<jsp:param name="CS_ID" value="1" />
						<jsp:param name="CD_ID" value="1" />
					</jsp:include>
				</div>

				<div class="col-md-4">
					<jsp:include page="/Preview_Board/Preview_Board.jsp" flush="false">
						<jsp:param name="CS_ID" value="1" />
						<jsp:param name="CD_ID" value="2" />
					</jsp:include>
				</div>

				<div class="col-md-4">
					<jsp:include page="/Preview_Board/Preview_Board.jsp" flush="false">
						<jsp:param name="CS_ID" value="1" />
						<jsp:param name="CD_ID" value="3" />
					</jsp:include>
				</div>

				<br>

				<div class="col-md-4">
					<jsp:include page="/Preview_Board/Preview_Board.jsp" flush="false">
						<jsp:param name="CS_ID" value="1" />
						<jsp:param name="CD_ID" value="4" />
					</jsp:include>
				</div>

				<div class="col-md-4">
					<jsp:include page="/Preview_Board/Preview_Board.jsp" flush="false">
						<jsp:param name="CS_ID" value="1" />
						<jsp:param name="CD_ID" value="5" />
					</jsp:include>
				</div>

				<div class="col-md-4">
					<jsp:include page="/Preview_Board/Preview_Board.jsp" flush="false">
						<jsp:param name="CS_ID" value="2" />
						<jsp:param name="CD_ID" value="6" />
					</jsp:include>
				</div>

				<div class="col-md-4">
					<jsp:include page="/Preview_Board/Preview_Board.jsp" flush="false">
						<jsp:param name="CS_ID" value="2" />
						<jsp:param name="CD_ID" value="7" />
					</jsp:include>
				</div>

				<div class="col-md-4">
					<jsp:include page="/Preview_Board/Preview_Board.jsp" flush="false">
						<jsp:param name="CS_ID" value="2" />
						<jsp:param name="CD_ID" value="8" />
					</jsp:include>
				</div>

				<div class="col-md-4">
					<jsp:include page="/Preview_Board/Preview_Board.jsp" flush="false">
						<jsp:param name="CS_ID" value="3" />
						<jsp:param name="CD_ID" value="9" />
					</jsp:include>
				</div>

				<div class="col-md-4">
					<jsp:include page="/Preview_Board/Preview_Board.jsp" flush="false">
						<jsp:param name="CS_ID" value="3" />
						<jsp:param name="CD_ID" value="10" />
					</jsp:include>
				</div>

				<div class="col-md-4">
					<jsp:include page="/Preview_Board/Preview_Board.jsp" flush="false">
						<jsp:param name="CS_ID" value="3" />
						<jsp:param name="CD_ID" value="11" />
					</jsp:include>
				</div>

				<div class="col-md-4">
					<jsp:include page="/Preview_Board/Preview_Board.jsp" flush="false">
						<jsp:param name="CS_ID" value="3" />
						<jsp:param name="CD_ID" value="12" />
					</jsp:include>
				</div>

				<div class="col-md-4">
					<jsp:include page="/Preview_Board/Preview_Board.jsp" flush="false">
						<jsp:param name="CS_ID" value="4" />
						<jsp:param name="CD_ID" value="13" />
					</jsp:include>
				</div>

				<div class="col-md-4">
					<jsp:include page="/Preview_Board/Preview_Board.jsp" flush="false">
						<jsp:param name="CS_ID" value="4" />
						<jsp:param name="CD_ID" value="14" />
					</jsp:include>
				</div>

				<div class="col-md-4">
					<jsp:include page="/Preview_Board/Preview_Board.jsp" flush="false">
						<jsp:param name="CS_ID" value="4" />
						<jsp:param name="CD_ID" value="15" />
					</jsp:include>
				</div>

				<div class="col-md-4">
					<jsp:include page="/Preview_Board/Preview_Board.jsp" flush="false">
						<jsp:param name="CS_ID" value="5" />
						<jsp:param name="CD_ID" value="16" />
					</jsp:include>
				</div>

				<div class="col-md-4">
					<jsp:include page="/Preview_Board/Preview_Board.jsp" flush="false">
						<jsp:param name="CS_ID" value="5" />
						<jsp:param name="CD_ID" value="17" />
					</jsp:include>
				</div>
			</div>
		</div>
	</div>


	<jsp:include page="/footer.jsp" flush="false" />




</body>


</html>