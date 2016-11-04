<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="sales.Sales"%>
<%@ page import="sales.SalesDAO"%>
<%!public Integer toInt(String x) {
		int a = 0;
		try {
			a = Integer.parseInt(x);
		} catch (Exception e) {
		}
		return a;
	}%>
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
<%
	SalesDAO sdao = new SalesDAO();
	ArrayList<Sales> list = sdao.getAll(managerId, "1990-01-01","2016-11-01");
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>오또카페</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" type="image/x-icon" href="../image/favicon.ico" />
<style type="text/css">
body {
	font-family: "한컴 윤고딕 230";
}

table {
	text-align: center;
	border: 1;
	border-collapse: collapse;
	margin: 0 auto;
}
a {
	color: black;
	text-decoration: none;
}

span {
	font-weight: bold;
	color: #0097A7;
}
</style>
<script type="text/javascript">
	
</script>
</head>
<body>
	<header>
		<br> <img alt="" src="../image/otto.jpg"
			onClick="location.href='../salesstatus/SalesStatus.jsp'"> <img alt=""
			src="../image/salesstatus.jpg">
	</header>

	

	<section>
		<table>
			<tr>
				<td><b>상품코드</b></td>
				<td><b>상품명</b></td>
				<td><b>판매량</b></td>
			</tr>
			<%
				for (Sales s : list) {
			%>
			<tr>

				<td><%=s.getMerchandiseUniqueKey()%></td>
				<td><%=s.getMerchandiseName()%></td>
				<td><%=s.getCount()%></td>

			</tr>
			<%
				}
			%>
		</table>
<br>

		<br> <br>

	</section>

	<footer>
		<img alt="" src="../image/c.jpg">
	</footer>
</body>
</html>