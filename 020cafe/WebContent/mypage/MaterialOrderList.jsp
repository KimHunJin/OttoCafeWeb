<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="Stock.Stock"%>
<%@ page import="Stock.StockDAO"%>
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
	StockDAO sdao = new StockDAO();
	ArrayList<Stock> list = sdao.orderHistoryList(managerId);
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
		<br> <img src="../image/otto4mypage.jpg"
			onClick="location.href='../salesstatus/SalesStatus.jsp'"> <img
			src="../image/mypage.jpg"
			onClick="location.href='../mypage/MyPageEnrollStock.jsp'">
	</header>

	<nav>
		<img alt="" src="../image/enroll_stock2.jpg"
			onClick="location.href='../mypage/MyPageEnrollStock.jsp'"> <img
			alt="" src="../image/enroll_merchandise2.jpg"
			onClick="location.href='../mypage/MyPageEnrollMerchandise.jsp'">
		<img alt="" src="../image/enroll_store2.jpg"
			onClick="location.href='../mypage/MyPageEnrollStore.jsp'"> <img
			alt="" src="../image/orderhistory1.jpg"
			onClick="location.href='../mypage/MaterialOrderList.jsp'">
	</nav>

	<section>
		<table>
			<tr>
				<td><b>주문코드</b></td>
				<td><b>주문내역</b></td>
				<td><b>총 가격</b></td>
				<td><b>주문 날짜</b></td>
			</tr>

			<%
				for (Stock s : list) {
			%>

			<tr>
				<td><%=s.getBasketUniqueKey()%></td>
				<td><a
					href="../mypage/OrderListDetail.jsp?basketUniqueKey=<%=s.getBasketUniqueKey()%>&totalPrice=<%=s.getTotalPrice()%>"><%=s.getMaterialName()%>
						포함 총 <%=s.getCount()%>개 상품</a></td>
				<td><%=s.getTotalPrice()%></td>
				<td><%=s.getDate()%></td>
			</tr>
			<%
				}
			%>
		</table>
		<br>
	</section>

	<footer>
		<img src="../image/c.jpg">
	</footer>
</body>
</html>