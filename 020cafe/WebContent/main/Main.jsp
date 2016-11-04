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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>오또카페</title>
<link rel="shortcut icon" type="image/x-icon" href="../image/favicon.ico" />
<style type="text/css">
body {
	font-family: "한컴 윤고딕 250";
}

header {
	margin: 0 auto;
	text-align: center;
}

table {
	text-align: center;
	vertical-align: middle;
	margin: 0 auto;
}

footer {
	text-align: center;
}

#s img {
	vertical-align: middle;
}

section {
	text-align: center;
}
</style>

</head>
<body>
	<header>
		<br> <img alt="" src="../image/main_ottocafe.jpg">
	</header>

	<section id="s">
		<img src="../image/main_mypage2.jpg"
			onclick="location.href='../mypage/MyPageEnrollStock.jsp'"> <img
			src="../image/main_stock2.jpg"
			onclick="location.href='../stockstatus/StockStatus.jsp'"> <img
			src="../image/main_sales2.jpg"
			onclick="location.href='../salesstatus/SalesStatus.jsp'"><br>
		<table>
			<tr>
				<td><img src="../image/welcome.jpg"><b><%=managerId%></b>
					<img src="../image/logout.jpg"
					onClick="location.href='../manager/user_control.jsp?action=logout'"></td>
			</tr>
		</table>

	</section>

	<footer>
		<img alt="" src="../image/c.jpg">
	</footer>
</body>
</html>