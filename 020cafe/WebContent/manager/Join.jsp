<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Manager.Manager"%>
<%@ page import="Manager.ManagerDAO"%>
<%@ page import="java.util.ArrayList"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	ManagerDAO mdao = new ManagerDAO();
	ArrayList<Manager> list = mdao.cafeList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오또카페</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" type="image/x-icon" href="../image/favicon.ico" />
<style>
body {
	color: #0097A7;
	margin-top: 100px;
	font-family: "한컴 윤고딕 250";
}

table {
	margin: 0 auto;
	text-aling: center;
	vertical-align: middle;
}

.button {
	border: 0;
	font-size: 15px;
	height: 35px;
	background-color: #0097A7;
	color: #E4DDDE;
	font-family: "한컴 윤고딕 250";
}

.text {
	height: 90%;
	width: 406px;
}
</style>
<script>
	function showKeyCode(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ((keyID >= 65 && keyID <= 90) || (keyID >= 97 && keyID <= 122)
				|| (keyID >= 48 && keyID <= 57) || (keyID == 8)
				|| (keyID >= 37 && keyID <= 40)) {
			return;
		} else {
			return false;
		}
	}

	function idCheck() {
		location.href = '../manager/user_control.jsp?action=idcheck&managerId='
				+ join.managerId.value + '';
	}

	function checkPwd() {
		var pw1 = join.managerPW.value;
		var pw2 = join.manager_pw_check.value;
		if (pw1 == pw2) {
			document.getElementById('checkPwd').style.color = "black";
			document.getElementById('checkPwd').innerHTML = "암호가 확인 되었습니다.";
			return true;
		} else {
			document.getElementById('checkPwd').style.color = "red";
			document.getElementById('checkPwd').innerHTML = "동일한 암호를 입력하세요.";
			join.manager_pw_check.focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<header>
		<h1>오또카페 회원가입</h1>
		<br>
	</header>

	<section>
		<form name="join" action="../manager/user_control.jsp?action=new"
			method="post" onSubmit="javascript:return checkPwd();">
			<table>
				<tr>
					<td style="height: 35px;"><input type="text" name="managerId"
						placeholder="아이디" autofocus required
						style="height: 90%; width: 320px;"
						onkeydown="return showKeyCode(event)"> <input
						type="button" onClick="idCheck()" value="중복확인" style="width: 80px"
						class="button"></td>
				</tr>
				<tr>
					<td style="height: 35px;"><input type="password"
						name="managerPW" placeholder="비밀번호" required class="text"></td>
				</tr>
				<tr>
					<td style="height: 35px;"><input type="password"
						name="manager_pw_check" placeholder="비밀번호 확인" class="text"
						required></td>
				</tr>
				<tr>
					<td><div id="checkPwd" style="font-size: 13px"></div></td>
				</tr>
				<tr>
					<td style="height: 35px;"><input type="text"
						name="managerName" placeholder="이름" required class="text"></td>
				</tr>
				<tr>
					<td style="height: 35px;"><select id="cafeUniqueKey"
						name="cafeUniqueKey" style="height: 90%; width: 410px">

							<%
								for (Manager m : list) {
							%>
							<option value="<%=m.getCafeUniqueKey()%>"><%=m.getCafeName()%></option>
							<%
								}
							%>
					</select></td>
				</tr>
			</table>
			<br> <br> <input type="submit" id="가입" value="회원가입"
				class="button" style="width: 80px" onclick="checkPwd()"> <input
				type="button" value="취소" class="button"
				style="width: 80px; border: 0; font-size: 15px; height: 35px; background-color: #E4DDDE; color: #0097A7; font-family:"
				한컴 윤고딕 250";"
				onClick="location.href='../manager/Login.jsp'">
		</form>
	</section>
</body>
</html>