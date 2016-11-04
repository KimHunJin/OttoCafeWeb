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
	ArrayList<Stock> list = sdao.cartList(managerId);
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
<script type="text/javascript">
	function cancel_click(putBasketUniqueKey) {
		location.href='../stockstatus/stockstatus_control.jsp?action=cancel&putBasketUniqueKey='+putBasketUniqueKey+'';
	}
</script>
</head>
<body>
	<header>
		<br> <img src="../image/otto.jpg"
			onClick="location.href='../salesstatus/SalesStatus.jsp'"> <img
			src="../image/stockstatus.jpg">
	</header>

	<nav>
		<img src="../image/stockstatus2_img.jpg"
			onClick="location.href='../stockstatus/StockStatus.jsp'"> <img
			src="../image/cart1_img.jpg"
			onClick="location.href='../stockstatus/NewFile.jsp'">
	</nav>

	<section>
		<table>
			<tr>
				<td><b>제품코드</b></td>
				<td><b>제품명</b></td>
				<td><b>제품 이미지</b></td>
				<td><b>입고단가</b></td>
				<td><b>주문수량</b></td>
				<td><b>총 가격</b></td>
				<td><b>주문</b></td>
			</tr>
			<%
				for (Stock s : list) {
			%>
			<tr>
				<td><%=s.getMaterialUniqueKey()%></td>
				<td><%=s.getMaterialName()%></td>
				<td><img src=<%=s.getImage()%> width="80" height="80"></td>
				<td><%=s.getPrice()%></td>
				<td><%=s.getAmount()%></td>
				<td><%=s.getTotal()%></td>
				<td><input type="button" id="<%=s.getMaterialUniqueKey()%>"
					onclick="cancel_click(<%=s.getPutBasketUniqueKey()%>);" value="취소" /></td>
			</tr>
			<%
				}
			%>
		</table>
	</section>

	<footer>
		<img src="../image/c.jpg">
	</footer>
</body>
</html>