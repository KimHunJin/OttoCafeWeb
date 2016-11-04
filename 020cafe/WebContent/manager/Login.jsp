<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("utf-8");
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
	margin-top: 100px;
	font-family: "한컴 윤고딕 250";
	color: #0097A7;
}

table {
	margin: 0 auto;
	text-aling: center;
}

a {
	font-size: 14px;
	text-decoration: none;
	color: #0097A7;
}

.button {
	border:0;
	font-size: 15px;
	width: 400px;
	height: 35px;
	background-color: #0097A7;
	color: #E4DDDE;
	font-family: "한컴 윤고딕 250";
}

footer {
	margin-top: 40px;
}
</style>
</head>
<body>

	<header>
		<br>
		<h1>오또카페 재고관리 프로그램</h1>
	</header>

	<section>
		<form name="login" action="../manager/user_control.jsp?action=login"
			method="post">
			<br>
			<table>
				<tr>
					<td style="height: 35px;"><input type="text" name="managerId"
						placeholder="아이디" autofocus style="height: 90%; width: 400px;"></td>
				</tr>
				<tr>
					<td style="height: 35px;"><input type="password"
						name="managerPW" placeholder="비밀번호" required
						style="height: 90%; width: 400px;"></td>
				</tr>
			</table>
			<br>
			<div>
				<input type="submit" value="로그인" class="button">
			</div>
			<a href=''>아이디 찾기</a>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=''>비밀번호
				찾기</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
				href='../manager/Join.jsp'>회원가입</a>
		</form>
	</section>

	<br>
	<footer>
		<img alt="" src="../image/c.jpg">
	</footer>

</body>
</html>