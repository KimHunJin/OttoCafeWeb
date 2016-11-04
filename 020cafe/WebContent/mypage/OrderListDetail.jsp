<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="Stock.Stock"%>
<%@ page import="Stock.StockDAO"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	int basketUniqueKey = Integer.parseInt(request
			.getParameter("basketUniqueKey"));
	int totalPrice = Integer.parseInt(request
			.getParameter("totalPrice"));

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
	StockDAO sdao = new StockDAO();
	ArrayList<Stock> list = sdao.orderHistoryDetail(basketUniqueKey,
			managerId);
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
</style>
</head>
<body>
	<header>
		<br> <img src="../image/orderlistdetail.jpg">
	</header>
	<section>
		주문 코드 :
		<%=basketUniqueKey%>
		총 가격 :
		<%=totalPrice%>
		<br> <br>
		<table>
			<tr>
				<td><b>재료코드</b></td>
				<td><b>재료명</b></td>
				<td><b>이미지</b></td>
				<td><b>가격</b></td>
				<td><b>수량</b></td>
			</tr>

			<%
				for (Stock s : list) {
			%>

			<tr>
				<td><%=s.getMaterialUniqueKey()%></td>
				<td><%=s.getMaterialName()%></td>
				<td><img src="<%=s.getImage()%>" width="80" height="80"></td>
				<td><%=s.getPrice()%></td>
				<td><%=s.getTotal()%></td>
			</tr>
			<%
				}
			%>
		</table>
		<img src="../image/ok_small.jpg" onClick="history.back()">
	</section>
	<footer>
		<img src="../image/c.jpg">
	</footer>
</body>
</html>