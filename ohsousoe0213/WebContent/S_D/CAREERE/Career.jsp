<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">




<title>이력 등록</title>
</head>


<script language="javascript">
	var Out_count = 1;
	var Vol_count = 1;
	var Intern_count = 1;
	var In_count = 1;
	var Group_count = 1;
	var C_count = 1;
	var Win_count = 1;
	var Job_count = 1;
	var Lan_count = 1;

	var addCount_Out;
	var addCount_Vol;
	var addCount_Intern;
	var addCount_In;
	var addCount_Group;
	var addCount_C;
	var addCount_Win;
	var addCount_Job;
	var addCount_Lan;

	//행추가
	function addInputBox_Out() {
		for (var i = 1; i <= Out_count; i++) {
			if (!document.getElementsByName("Out_Context" + i)[0]) {
				addCount_Out = i;
				break;
			} else
				addCount_Out = Out_count;
		}
		var addStr = "<input type=hidden name=out>"
				+ "<tr>"
				+ "<div class=col-xs-1>"
				+ addCount_Out
				+ "</div>"
				+ "<div class=col-xs-3>"
				+ "<input type=text maxlength=16 class=form-control name=OutActivity"+addCount_Out+" required>"
				+ "</div>"
				+ "<div class=col-xs-2>"
				+ "<input type=text maxlength=26 class=form-control name=Out_Period"+addCount_Out+" required>"
				+ "</div>"
				+ "<div class=col-xs-5>"
				+ "<input type=text maxlength=40 class=form-control name=Out_Context"+addCount_Out+" required>"
				+ "</div>" 
				+ "<td>"
				+ "<input type=checkbox name=checkList value="+addCount_Out+">"
				+ "</td>" 
				+ "</tr>";
		var table = document.getElementById("OutActivity_table");
		var newRow = table.insertRow();
		var newCell = newRow.insertCell();
		newCell.innerHTML = addStr;
		Out_count++;
	}

	//행삭제
	function subtractInputBox_Out() {
		var table = document.getElementById("OutActivity_table");
		//var max = document.gForm.checkList.length;
		//alert(max);
		var rows = OutActivity_table.rows.length;
		var chk = 0;
		if (rows > 1) {
			for (var i = 0; i < document.R_Career.checkList.length; i++) {
				if (document.R_Career.checkList[i].checked == true) {
					table.deleteRow(i);
					i--;
					Out_count--;
					chk++;
				}
			}
			if (chk <= 0) {
				alert("삭제할 행을 체크해 주세요.");
			}
		} else {
			alert("더이상 삭제할 수 없습니다.");
		}
	}

	//행추가
	function addInputBox_Vol() {
		for (var i = 1; i <= Vol_count; i++) {
			if (!document.getElementsByName("Vol_Context" + i)[0]) {
				addCount_Vol = i;
				break;
			} else
				addCount_Vol = Vol_count;
		}
		var addStr = "<input type=hidden name=vol>"
				+ "<tr>"
				+ "<div class=col-xs-1>"
				+ addCount_Vol
				+ "</div>"
				+ "<div class=col-xs-3>"
				+ "<input type=text class=form-control maxlength=16 name=VolActivity"+addCount_Vol+" required>"
				+ "</div>"
				+ "<div class=col-xs-2>"
				+ "<input type=text class=form-control maxlength=26 name=Vol_Period"+addCount_Vol+" required>"
				+ "</div>"
				+ "<div class=col-xs-5>"
				+ "<input type=text class=form-control maxlength=40 name=Vol_Context"+addCount_Vol+" required>"
				+ "</div>" + "<td>"
				+ "<input type=checkbox name=checkList value="+addCount_Vol+">"
				+ "</td>" 
				+ "</tr>";
		var table = document.getElementById("VolActivity_table");
		var newRow = table.insertRow();
		var newCell = newRow.insertCell();
		newCell.innerHTML = addStr;
		Vol_count++;
	}

	//행삭제
	function subtractInputBox_Vol() {
		var table = document.getElementById("VolActivity_table");
		//var max = document.gForm.checkList.length;
		//alert(max);
		var rows = VolActivity_table.rows.length;
		var chk = 0;
		if (rows > 1) {
			for (var i = 0; i < document.V_Career.checkList.length; i++) {
				if (document.V_Career.checkList[i].checked == true) {
					table.deleteRow(i);
					i--;
					Vol_count--;
					chk++;
				}
			}
			if (chk <= 0) {
				alert("삭제할 행을 체크해 주세요.");
			}
		} else {
			alert("더이상 삭제할 수 없습니다.");
		}
	}

	//행추가
	function addInputBox_Intern() {
		for (var i = 1; i <= Intern_count; i++) {
			if (!document.getElementsByName("Intern_Context" + i)[0]) {
				addCount_Intern = i;
				break;
			} else
				addCount_Intern = Intern_count;
		}
		var addStr = "<input type=hidden name=intern><tr><div class=col-xs-1>"
				+ addCount_Intern
				+ "</div><div class=col-xs-3><input type=text class=form-control maxlength=16 name=InternActivity"+addCount_Intern+" required></div><div class=col-xs-2><input type=text class=form-control maxlength=26 name=Intern_Period"+addCount_Intern+" required></div><div class=col-xs-5><input type=text class=form-control maxlength=40 name=Intern_Context"+addCount_Intern+" required></div><td><input type=checkbox name=checkList value="+addCount_Intern+"></td></tr>";
		var table = document.getElementById("InternActivity_table");
		var newRow = table.insertRow();
		var newCell = newRow.insertCell();
		newCell.innerHTML = addStr;
		Intern_count++;
	}

	//행삭제
	function subtractInputBox_Intern() {
		var table = document.getElementById("InternActivity_table");
		//var max = document.gForm.checkList.length;
		//alert(max);
		var rows = InternActivity_table.rows.length;
		var chk = 0;
		if (rows > 1) {
			for (var i = 0; i < document.I_Career.checkList.length; i++) {
				if (document.I_Career.checkList[i].checked == true) {
					table.deleteRow(i);
					i--;
					Intern_count--;
					chk++;
				}
			}
			if (chk <= 0) {
				alert("삭제할 행을 체크해 주세요.");
			}
		} else {
			alert("더이상 삭제할 수 없습니다.");
		}
	}

	//행추가
	function addInputBox_In() {
		for (var i = 1; i <= In_count; i++) {
			if (!document.getElementsByName("In_Context" + i)[0]) {
				addCount_In = i;
				break;
			} else
				addCount_In = In_count;
		}
		var addStr = "<input type=hidden name=in><tr><div class=col-xs-1>"
				+ addCount_In
				+ "</div><div class=col-xs-3><input type=text class=form-control maxlength=16 name=InActivity"+addCount_In+" required></div><div class=col-xs-2><input type=text class=form-control maxlength=26 name=In_Period"+addCount_In+" required></div><div class=col-xs-5><input type=text maxlength=40 class=form-control name=In_Context"+addCount_In+" required></div><td><input type=checkbox name=checkList value="+addCount_In+"></td></tr>";
		var table = document.getElementById("InActivity_table");
		var newRow = table.insertRow();
		var newCell = newRow.insertCell();
		newCell.innerHTML = addStr;
		In_count++;
	}

	//행삭제
	function subtractInputBox_In() {
		var table = document.getElementById("InActivity_table");
		//var max = document.gForm.checkList.length;
		//alert(max);
		var rows = InActivity_table.rows.length;
		var chk = 0;
		if (rows > 1) {
			for (var i = 0; i < document.In_Career.checkList.length; i++) {
				if (document.In_Career.checkList[i].checked == true) {
					table.deleteRow(i);
					i--;
					In_count--;
					chk++;
				}
			}
			if (chk <= 0) {
				alert("삭제할 행을 체크해 주세요.");
			}
		} else {
			alert("더이상 삭제할 수 없습니다.");
		}
	}

	//행추가
	function addInputBox_Group() {
		for (var i = 1; i <= Group_count; i++) {
			if (!document.getElementsByName("Group_Context" + i)[0]) {
				addCount_Group = i;
				break;
			} else
				addCount_Group = Group_count;
		}
		var addStr = "<input type=hidden name=group><tr><div class=col-xs-1>"
				+ addCount_Group
				+ "</div><div class=col-xs-2><input type=text class=form-control maxlength=16 name=GroupActivity"+addCount_Group+" required ></div><div class=col-xs-2><input type=text class=form-control maxlength=26 name=Group_Period"+addCount_Group+" required></div><div class=col-xs-2><input type=text maxlength=16 class=form-control name=Group_job"+addCount_Group+" required></div><div class=col-xs-4><input type=text class=form-control maxlength=40 name=Group_Context"+addCount_Group+" required></div><td><input type=checkbox name=checkList value="+addCount_Group+"></td></tr>";
		var table = document.getElementById("GroupActivity_table");
		var newRow = table.insertRow();
		var newCell = newRow.insertCell();
		newCell.innerHTML = addStr;
		Group_count++;
	}

	//행삭제
	function subtractInputBox_Group() {
		var table = document.getElementById("GroupActivity_table");
		//var max = document.gForm.checkList.length;
		//alert(max);
		var rows = GroupActivity_table.rows.length;
		var chk = 0;
		if (rows > 1) {
			for (var i = 0; i < document.G_Career.checkList.length; i++) {
				if (document.G_Career.checkList[i].checked == true) {
					table.deleteRow(i);
					i--;
					Group_count--;
					chk++;
				}
			}
			if (chk <= 0) {
				alert("삭제할 행을 체크해 주세요.");
			}
		} else {
			alert("더이상 삭제할 수 없습니다.");
		}
	}

	//행추가
	function addInputBox_Win() {
		for (var i = 1; i <= Win_count; i++) {
			if (!document.getElementsByName("Win_Context" + i)[0]) {
				addCount_Win = i;
				break;
			} else
				addCount_Win = Win_count;
		}
		var addStr = "<input type=hidden name=win><tr><div class=col-xs-1>"
				+ addCount_Win
				+ "</div><div class=col-xs-3><input type=text maxlength=16 class=form-control name=WinActivity"+addCount_Win+" required></div><div class=col-xs-2><input type=text class=form-control maxlength=26 name=Win_Period"+addCount_Win+" required></div><div class=col-xs-5><input type=text class=form-control maxlength=40 name=Win_Context"+addCount_Win+" required></div><td><input type=checkbox name=checkList value="+addCount_Win+"></td></tr>";
		var table = document.getElementById("WinActivity_table");
		var newRow = table.insertRow();
		var newCell = newRow.insertCell();
		newCell.innerHTML = addStr;
		Win_count++;
	}

	//행삭제
	function subtractInputBox_Win() {
		var table = document.getElementById("WinActivity_table");
		//var max = document.gForm.checkList.length;
		//alert(max);
		var rows = WinActivity_table.rows.length;
		var chk = 0;
		if (rows > 1) {
			for (var i = 0; i < document.Win_Career.checkList.length; i++) {
				if (document.Win_Career.checkList[i].checked == true) {
					table.deleteRow(i);
					i--;
					Win_count--;
					chk++;
				}
			}
			if (chk <= 0) {
				alert("삭제할 행을 체크해 주세요.");
			}
		} else {
			alert("더이상 삭제할 수 없습니다.");
		}
	}

	//행추가
	function addInputBox_C() {
		for (var i = 1; i <= C_count; i++) {
			if (!document.getElementsByName("C_Context" + i)[0]) {
				addCount_C = i;
				break;
			} else
				addCount_C = C_count;
		}
		var addStr = "<input type=hidden name=c><tr><div class=col-xs-1>"
				+ addCount_C
				+ "</div><div class=col-xs-3><input type=text class=form-control maxlength=16 name=CActivity"+addCount_C+" required></div><div class=col-xs-2><input type=text class=form-control maxlength=26 name=C_Period"+addCount_C+" required></div><div class=col-xs-5><input type=text maxlength=40 class=form-control name=C_Context"+addCount_C+" required></div><td><input type=checkbox name=checkList value="+addCount_C+"></td></tr>";
		var table = document.getElementById("CActivity_table");
		var newRow = table.insertRow();
		var newCell = newRow.insertCell();
		newCell.innerHTML = addStr;
		C_count++;
	}

	//행삭제
	function subtractInputBox_C() {
		var table = document.getElementById("CActivity_table");
		//var max = document.gForm.checkList.length;
		//alert(max);
		var rows = CActivity_table.rows.length;
		var chk = 0;
		if (rows > 1) {
			for (var i = 0; i < document.C_Career.checkList.length; i++) {
				if (document.C_Career.checkList[i].checked == true) {
					table.deleteRow(i);
					i--;
					C_count--;
					chk++;
				}
			}
			if (chk <= 0) {
				alert("삭제할 행을 체크해 주세요.");
			}
		} else {
			alert("더이상 삭제할 수 없습니다.");
		}
	}

	//행추가
	function addInputBox_Job() {
		for (var i = 1; i <= Job_count; i++) {
			if (!document.getElementsByName("Job_Context" + i)[0]) {
				addCount_Job = i;
				break;
			} else
				addCount_Job = Job_count;
		}
		var addStr = "<input type=hidden name=Job><tr><div class=col-xs-1>"
				+ addCount_Job
				+ "</div><div class=col-xs-3><input type=text class=form-control maxlength=16 name=JobActivity"+addCount_Job+" required></div><div class=col-xs-2><input type=text class=form-control maxlength=26 name=Job_Period"+addCount_Job+" required></div><div class=col-xs-5><input type=text maxlength=40 class=form-control name=Job_Context"+addCount_Job+" required></div><td><input type=checkbox name=checkList value="+addCount_Job+"></td></tr>";
		var table = document.getElementById("JobActivity_table");
		var newRow = table.insertRow();
		var newCell = newRow.insertCell();
		newCell.innerHTML = addStr;
		Job_count++;
	}

	//행삭제
	function subtractInputBox_Job() {
		var table = document.getElementById("JobActivity_table");
		//var max = document.gForm.checkList.length;
		//alert(max);
		var rows = JobActivity_table.rows.length;
		var chk = 0;
		if (rows > 1) {
			for (var i = 0; i < document.Job_Career.checkList.length; i++) {
				if (document.Job_Career.checkList[i].checked == true) {
					table.deleteRow(i);
					i--;
					Job_count--;
					chk++;
				}
			}
			if (chk <= 0) {
				alert("삭제할 행을 체크해 주세요.");
			}
		} else {
			alert("더이상 삭제할 수 없습니다.");
		}
	}

	//행추가
	function addInputBox_Lan() {
		for (var i = 1; i <= Lan_count; i++) {
			if (!document.getElementsByName("Lan_Context" + i)[0]) {
				addCount_Lan = i;
				break;
			} else
				addCount_Lan = Lan_count;
		}
		var addStr = "<input type=hidden name=Lan><tr><div class=col-xs-1>"
				+ addCount_Lan
				+ "</div><div class=col-xs-3><input type=text class=form-control maxlength=16 name=LanActivity"+addCount_Lan+" required></div><div class=col-xs-2><input type=text class=form-control maxlength=26 name=Lan_Period"+addCount_Lan+" required></div><div class=col-xs-5><input type=text maxlength=40 class=form-control name=Lan_Context"+addCount_Lan+" required></div><td><input type=checkbox name=checkList value="+addCount_Lan+"></td></tr>";
		var table = document.getElementById("LanActivity_table");
		var newRow = table.insertRow();
		var newCell = newRow.insertCell();
		newCell.innerHTML = addStr;
		Lan_count++;
	}

	//행삭제
	function subtractInputBox_Lan() {
		var table = document.getElementById("LanActivity_table");
		//var max = document.gForm.checkList.length;
		//alert(max);
		var rows = LanActivity_table.rows.length;
		var chk = 0;
		if (rows > 1) {
			for (var i = 0; i < document.Lan_Career.checkList.length; i++) {
				if (document.Lan_Career.checkList[i].checked == true) {
					table.deleteRow(i);
					i--;
					Lan_count--;
					chk++;
				}
			}
			if (chk <= 0) {
				alert("삭제할 행을 체크해 주세요.");
			}
		} else {
			alert("더이상 삭제할 수 없습니다.");
		}
	}

	function submitbutton_Out() {
		var R_career = document.R_Career;
		R_career.Out_count.value = Out_count;
		R_Career.submit();
		return;
	}

	function submitbutton_Vol() {
		var V_career = document.V_Career;
		V_career.Vol_count.value = Vol_count;
		V_Career.submit();
		return;
	}

	function submitbutton_Intern() {
		var I_career = document.I_Career;
		I_career.Intern_count.value = Intern_count;
		I_Career.submit();
		return;
	}

	function submitbutton_In() {
		var In_career = document.In_Career;
		In_career.In_count.value = In_count;
		In_Career.submit();
		return;
	}

	function submitbutton_Group() {
		var G_career = document.G_Career;
		G_career.Group_count.value = Group_count;
		G_Career.submit();
		return;
	}

	function submitbutton_Win() {
		var Win_career = document.Win_Career;
		Win_career.Win_count.value = Win_count;
		Win_Career.submit();
		return;
	}

	function submitbutton_C() {
		var C_career = document.C_Career;
		C_career.C_count.value = C_count;
		C_Career.submit();
		return;
	}

	function submitbutton_Job() {
		var Job_career = document.Job_Career;
		Job_career.Job_count.value = Job_count;
		Job_Career.submit();
		return;
	}

	function submitbutton_Lan() {
		var Lan_career = document.Lan_Career;
		Lan_career.Lan_count.value = Lan_count;
		Lan_Career.submit();
		return;
	}
</script>
<!-- required 꼭 써야하는 칸임. -->

<body
	OnLoad="addInputBox_Out(), addInputBox_Vol(), addInputBox_Intern(), addInputBox_In(), addInputBox_Group(), addInputBox_Win(), addInputBox_C(), addInputBox_Job(), addInputBox_Lan()">
	<%
		String Session_ID = "";

		try {
			Session_ID = (String) session.getAttribute("Session_ID");

			if (Session_ID == null || Session_ID.equals("")) {

				response.sendRedirect("/");

			} else {
	%>
	<jsp:include page="/S_D/NavBar.jsp" flush="false" />
	<br>
	<br>
	<br>

	<div class="container">

		<form name="R_Career" action="/DB/DB_Career/R_Career.jsp"
			method="post" class="form-signin">
			<input type="hidden" name="Out_count">


			<div class="panel panel-success">
				<div class="panel-heading text-center">
					<h1>
						<strong>대외 활동</strong>
					</h1>
				</div>


				<table class="table" id="OutActivity">
					<tr>
						<th class="col-xs-1 text-center">번호</th>
						<th class="col-xs-3 text-center">기관 및 프로그램 명</th>
						<th class="col-xs-2 text-center">기간</th>
						<th class="col-xs-4 text-center">내용</th>
						<th class="col-xs-1 text-center">
							<div class="btn-group" role="group">
								<button type="button" class="btn btn-default"
									onclick="javascript:addInputBox_Out();">
									<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
								</button>

								<button type="button" class="btn btn-default"
									onclick="javascript:subtractInputBox_Out();">
									<span class="glyphicon glyphicon-minus" aria-hidden="true"></span>
								</button>
							</div>
						</th>
					</tr>
					<tr>
						<table class="table table-striped" id="OutActivity_table">
						</table>
					</tr>
				</table>
			</div>


			<input type=hidden name=a value=Out>
			<div class=text-right>
				<button type="submit" class="btn btn-default"
					onclick="javascript:submitbutton_Out();">
					<span class="glyphicon glyphicon-floppy-saved" aria-hidden="true"></span>
				</button>
			</div>
		</form>

		<hr>

		<form name="V_Career" action="/DB/DB_Career/V_Career.jsp"
			method="post">
			<input type="hidden" name="Vol_count">

			<div class="panel panel-success">
				<div class="panel-heading text-center">
					<h1>
						<strong>봉사 활동</strong>
					</h1>
				</div>

				<table class="table" id="VolActivity">
					<tr>
						<th class="col-xs-1 text-center">번호</th>
						<th class="col-xs-3 text-center">기관 및 프로그램 명</th>
						<th class="col-xs-2 text-center">기간</th>
						<th class="col-xs-4 text-center">내용</th>
						<th class="col-xs-1 text-center">
							<div class="btn-group" role="group">
								<button type="button" class="btn btn-default"
									onclick="javascript:addInputBox_Vol();">
									<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
								</button>

								<button type="button" class="btn btn-default"
									onclick="javascript:subtractInputBox_Vol();">
									<span class="glyphicon glyphicon-minus" aria-hidden="true"></span>
								</button>
							</div>
						</th>
					</tr>
					<tr>

						<table class="table table-striped" id="VolActivity_table">
						</table>
					</tr>
				</table>
			</div>
			<input type=hidden name=a value=Vol>
			<div class=text-right>
				<button type="submit" class="btn btn-default"
					onclick="javascript:submitbutton_Vol();">
					<span class="glyphicon glyphicon-floppy-saved" aria-hidden="true"></span>
				</button>
			</div>

		</form>

		<hr>

		<form name="I_Career" action="/DB/DB_Career/I_Career.jsp"
			method="post">
			<input type="hidden" name="Intern_count">

			<div class="panel panel-success">
				<div class="panel-heading text-center">
					<h1>
						<strong>인턴 활동</strong>
					</h1>
				</div>
				<table class="table" id="InternActivity">

					<tr>
						<th class="col-xs-1 text-center">번호</th>
						<th class="col-xs-3 text-center">기관 및 프로그램 명</th>
						<th class="col-xs-2 text-center">기간</th>
						<th class="col-xs-4 text-center">내용</th>
						<th class="col-xs-1 text-center">
							<div class="btn-group" role="group">
								<button type="button" class="btn btn-default"
									onclick="javascript:addInputBox_Intern();">
									<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
								</button>

								<button type="button" class="btn btn-default"
									onclick="javascript:subtractInputBox_Intern();">
									<span class="glyphicon glyphicon-minus" aria-hidden="true"></span>
								</button>
							</div>
						</th>
					</tr>
					<tr>
						<table class="table table-striped" id="InternActivity_table">
						</table>
					</tr>
				</table>
				<input type=hidden name=a value=Intern>
				<div class=text-right>
					<button type="submit" class="btn btn-default"
						onclick="javascript:submitbutton_Intern();">
						<span class="glyphicon glyphicon-floppy-saved" aria-hidden="true"></span>
					</button>
				</div>
		</form>

		<hr>


		<form name="In_Career" action="/DB/DB_Career/In_Career.jsp"
			method="post">
			<input type="hidden" name="In_count">

			<div class="panel panel-success">
				<div class="panel-heading text-center">
					<h1>
						<strong>교내 활동</strong>
					</h1>
				</div>

				<table class="table" id="InActivity">

					<tr>
						<th class="col-xs-1 text-center">번호</th>
						<th class="col-xs-3 text-center">프로그램 명</th>
						<th class="col-xs-2 text-center">기간</th>
						<th class="col-xs-4 text-center">내용</th>
						<th class="col-xs-1 text-center">
							<div class="btn-group" role="group">
								<button type="button" class="btn btn-default"
									onclick="javascript:addInputBox_In();">
									<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
								</button>

								<button type="button" class="btn btn-default"
									onclick="javascript:subtractInputBox_In();">
									<span class="glyphicon glyphicon-minus" aria-hidden="true"></span>
								</button>
							</div>
						</th>
					</tr>
					<tr>
						<table class="table table-striped table-responsive"
							id="InActivity_table">
						</table>
					</tr>
				</table>
			</div>

			<input type=hidden name=a value=In>
			<div class=text-right>
				<button type="submit" class="btn btn-default"
					onclick="javascript:submitbutton_In();">
					<span class="glyphicon glyphicon-floppy-saved" aria-hidden="true"></span>
				</button>
			</div>


		</form>

		<hr>

		<form name="G_Career" action="/DB/DB_Career/G_Career.jsp"
			method="post">
			<input type="hidden" name="Group_count">

			<div class="panel panel-success">
				<div class="panel-heading text-center">
					<h1>
						<strong>동아리 활동</strong>
					</h1>
				</div>


				<table class="table" id="GroupActivity">

					<tr>
						<th class="col-xs-1 text-center">번호</th>
						<th class="col-xs-2 text-center">동아리명</th>
						<th class="col-xs-2 text-center">기간</th>
						<th class="col-xs-2 text-center">담당 직무</th>
						<th class="col-xs-4 text-center">내용</th>
						<th class="col-xs-1 text-center">
							<div class="btn-group" role="group">
								<button type="button" class="btn btn-default"
									onclick="javascript:addInputBox_Group();">
									<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
								</button>

								<button type="button" class="btn btn-default"
									onclick="javascript:subtractInputBox_Group();">
									<span class="glyphicon glyphicon-minus" aria-hidden="true"></span>
								</button>
							</div>
						</th>
					</tr>
					<tr>
						<table class="table table-striped table-responsive"
							id="GroupActivity_table">
						</table>
					</tr>
				</table>
			</div>
			<input type=hidden name=a value=Group>
			<div class=text-right>
				<button type="submit" class="btn btn-default"
					onclick="javascript:submitbutton_Group();">
					<span class="glyphicon glyphicon-floppy-saved" aria-hidden="true"></span>
				</button>
			</div>


		</form>

		<hr>


		<form name="Win_Career" action="/DB/DB_Career/Win_Career.jsp"
			method="post">
			<input type="hidden" name="Win_count">


			<div class="panel panel-success">
				<div class="panel-heading text-center">
					<h1>
						<strong>수상 활동</strong>
					</h1>
				</div>


				<table class="table" id="WinActivity">

					<tr>
						<th class="col-xs-1 text-center">번호</th>
						<th class="col-xs-3 text-center">수상 기관</th>
						<th class="col-xs-2 text-center">수상 일</th>
						<th class="col-xs-4 text-center">내용</th>
						<th class="col-xs-1 text-center">
							<div class="btn-group" role="group">
								<button type="button" class="btn btn-default"
									onclick="javascript:addInputBox_Win();">
									<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
								</button>

								<button type="button" class="btn btn-default"
									onclick="javascript:subtractInputBox_Win();">
									<span class="glyphicon glyphicon-minus" aria-hidden="true"></span>
								</button>
							</div>
						</th>
					</tr>
					<tr>
						<table class="table table-striped table-responsive"
							id="WinActivity_table">
						</table>
					</tr>
				</table>
			</div>
			<input type=hidden name=a value=Win>
			<div class=text-right>
				<button type="submit" class="btn btn-default"
					onclick="javascript:submitbutton_Win();">
					<span class="glyphicon glyphicon-floppy-saved" aria-hidden="true"></span>
				</button>
			</div>

		</form>

		<hr>


		<form name="C_Career" action="/DB/DB_Career/C_Career.jsp"
			method="post">
			<input type="hidden" name="C_count">


			<div class="panel panel-success">
				<div class="panel-heading text-center">
					<h1>
						<strong>자격증</strong>
					</h1>
				</div>


				<table class="table" id="CActivity">

					<tr>
						<th class="col-xs-1 text-center">번호</th>
						<th class="col-xs-3 text-center">자격증 명</th>
						<th class="col-xs-2 text-center">취득 날짜</th>
						<th class="col-xs-4 text-center">취득 기관</th>
						<th class="col-xs-1 text-center">
							<div class="btn-group" role="group">
								<button type="button" class="btn btn-default"
									onclick="javascript:addInputBox_C();">
									<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
								</button>

								<button type="button" class="btn btn-default"
									onclick="javascript:subtractInputBox_C();">
									<span class="glyphicon glyphicon-minus" aria-hidden="true"></span>
								</button>
							</div>
						</th>
					</tr>
					<tr>
						<table class="table table-striped table-responsive"
							id="CActivity_table">
						</table>
					</tr>
				</table>
			</div>
			<input type=hidden name=a value=C>
			<div class=text-right>
				<button type="submit" class="btn btn-default"
					onclick="javascript:submitbutton_C();">
					<span class="glyphicon glyphicon-floppy-saved" aria-hidden="true"></span>
				</button>
			</div>
		</form>

		<hr>
		<form name="Job_Career" action="/DB/DB_Career/Job_Career.jsp"
			method="post">
			<input type="hidden" name="Job_count">


			<div class="panel panel-success">
				<div class="panel-heading text-center">
					<h1>
						<strong>직장 경력</strong>
					</h1>
				</div>


				<table class="table table-striped table-responsive" id="JobActivity">

					<tr>
						<th class="col-xs-1 text-center">번호</th>
						<th class="col-xs-3 text-center">직장 명</th>
						<th class="col-xs-2 text-center">기간</th>
						<th class="col-xs-4 text-center">내용</th>
						<th class="col-xs-1 text-center">
							<div class="btn-group" role="group">
								<button type="button" class="btn btn-default"
									onclick="javascript:addInputBox_Job();">
									<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
								</button>

								<button type="button" class="btn btn-default"
									onclick="javascript:subtractInputBox_Job();">
									<span class="glyphicon glyphicon-minus" aria-hidden="true"></span>
								</button>
							</div>
						</th>
					</tr>
					<tr>
						<table class="table table-striped table-responsive"
							id="JobActivity_table">
						</table>
					</tr>

				</table>
			</div>
			<input type=hidden name=a value=Job>
			<div class=text-right>
				<button type="submit" class="btn btn-default"
					onclick="javascript:submitbutton_Job();">
					<span class="glyphicon glyphicon-floppy-saved" aria-hidden="true"></span>
				</button>
			</div>

		</form>

		<hr>

		<form name="Lan_Career" action="/DB/DB_Career/Lan_Career.jsp"
			method="post">
			<input type="hidden" name="Lan_count">


			<div class="panel panel-success">
				<div class="panel-heading text-center">
					<h1>
						<strong>외국어 능력</strong>
					</h1>
				</div>

				<table class="table table-striped table-responsive" id="LanActivity">

					<tr>
						<th class="col-xs-1 text-center">번호</th>
						<th class="col-xs-3 text-center">언어</th>
						<th class="col-xs-2 text-center">종류</th>
						<th class="col-xs-4 text-center">점수</th>
						<th class="col-xs-1 text-center">
							<div class="btn-group" role="group">
								<button type="button" class="btn btn-default"
									onclick="javascript:addInputBox_Lan();">
									<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
								</button>

								<button type="button" class="btn btn-default"
									onclick="javascript:subtractInputBox_Lan();">
									<span class="glyphicon glyphicon-minus" aria-hidden="true"></span>
								</button>
							</div>
						</th>
					</tr>
					<tr>
						<table class="table table-striped table-responsive"
							id="LanActivity_table">
						</table>
					</tr>

				</table>
			</div>
			<input type=hidden name=a value=Lan>
			<div class=text-right>
				<button type="submit" class="btn btn-default"
					onclick="javascript:submitbutton_Lan();">
					<span class="glyphicon glyphicon-floppy-saved" aria-hidden="true"></span>
				</button>
			</div>
		</form>




	</div>

	<%
		}

		} catch (Exception e) {
			response.sendRedirect("/");
		}
	%>



	<!-- jQuery (ë¶í¸ì¤í¸ë©ì ìë°ì¤í¬ë¦½í¸ íë¬ê·¸ì¸ì ìí´ íìí©ëë¤) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<!-- ëª¨ë  ì»´íì¼ë íë¬ê·¸ì¸ì í¬í¨í©ëë¤ (ìë), ìíì§ ìëë¤ë©´ íìí ê°ê°ì íì¼ì í¬í¨íì¸ì -->
	<script src="js/bootstrap.min.js"></script>
</body>
</html>