<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	String managerId = "";
	try {
		managerId = (String) session.getAttribute("managerId");
	} catch (Exception e) {

	}
	if (managerId == null || managerId.equals("")) {
		response.sendRedirect("../manager/Login.jsp");
	}
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
	font-family: "한컴 윤고딕 250";
}

table {
	margin: 0 auto;
	text-aling: center;
}

button {
	width: 170px;
}
</style>

</head>
<body>
	<header>
		<br>
		<h3>거래처 신규 등록</h3>
		<br>
	</header>

	<section>
		<form name="enrollStore"
			action="../mypage/mypage_control.jsp?action=newStore" method="post">

			<table>
				<tr>
					<td>거래처명</td>
					<td colspan="2"><input type="text" name="storeName" autofocus
						required></td>
				</tr>
				<tr>
					<td>거래처 홈페이지</td>
					<td colspan="2"><input type="text" name="storeHomepage"
						autofocus required></td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td colspan="2"><input type="text" name="storeTel" required></td>
				</tr>
				<tr>
					<td>대표자명</td>
					<td colspan="2"><input type="text" name="storeRepresentative"
						required></td>
				</tr>

			</table>
			<br> <input type="image" src="../image/ok_small.jpg" id="거래처 등록">
			<img src="../image/cancle_small.jpg"
				onClick="location.href='../mypage/MyPageEnrollStore.jsp'">
		</form>
	</section>

	<footer>
		<img alt="" src="../image/c.jpg">
	</footer>
</body>
</html>