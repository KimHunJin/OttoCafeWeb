<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="Stock.Stock"%>
<%@ page import="Stock.StockDAO"%>
<%@ page import="Store.Store"%>
<%@ page import="Store.StoreDAO"%>
<%@ page import="java.util.ArrayList"%>
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
	ArrayList<Stock> list1 = sdao.categoryList();
	
	StoreDAO storedao = new StoreDAO();
	ArrayList<Store> list2 = storedao.materialStoreList();
	
	StockDAO stockdao = new StockDAO();
	ArrayList<Stock> list3 = stockdao.unitList();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../css/style.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" type="image/x-icon" href="../image/favicon.ico" />
<title>오또카페</title>
<style>
body {
	font-family: "한컴 윤고딕 230";
}

table {
	margin: 0 auto;
	text-align: center;
	border: 1;
	border-collapse: collapse;
}

select {
	width: 175px;
}

b {
	color: red;
}
</style>
<script>
	function showKeyCode(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ((keyID >= 48 && keyID <= 57) || (keyID == 8) || (keyID >= 37 && keyID <= 40)) {
			return;
		} else {
			return false;
		}
	}
</script>
</head>
<body>
	<header>
		<br> <img alt="" src="../image/enroll_material.jpg"> <br>
		<br>
	</header>
	<section>
		<form name="addMaterial" enctype="multipart/form-data"
			action="../mypage/mypage_control.jsp?action=newMaterial&managerId=<%=managerId%>"
			method="post">
			<table>
				<tr>
					<td>카테고리</td>
					<td><select id="materialCategoryUniqueKey"
						name="materialCategoryUniqueKey">

							<%
								for (Stock s : list1) {
							%>
							<option value="<%=s.getMaterialCategoryUniqueKey()%>"><%=s.getCategoryName()%></option>
							<%
								}
							%>
					</select></td>
				</tr>
				<tr>
					<td>거래처</td>
					<td><select id="materialStoreUniqueKey"
						name="materialStoreUniqueKey">

							<%
								for (Store s : list2) {
							%>
							<option value="<%=s.getStoreUniqueKey()%>"><%=s.getStoreName()%></option>
							<%
								}
							%>
					</select></td>
				</tr>
				<tr>
					<td>제품명</td>
					<td><input type="text" name="materialName" required></td>
				</tr>
				<tr>
					<td><b>*</b> 입고단가</td>
					<td><input type="text" name="price"
						onkeydown="return showKeyCode(event)" required></td>
				</tr>
				<tr>
					<td><b>*</b> 용량</td>
					<td><input type="text" name="volume"
						onkeydown="return showKeyCode(event)" required></td>
				</tr>
				<tr>
					<td>단위</td>
					<td><select id="materialUnitUniqueKey"
						name="materialUnitUniqueKey">

							<%
								for (Stock s : list3) {
							%>
							<option value="<%=s.getMaterialUnitUniqueKey()%>"><%=s.getMaterialUnitName()%></option>
							<%
								}
							%>
					</select></td>
				</tr>
				<tr>
					<td>URL</td>
					<td><input type="text" name="url" required></td>
				</tr>
				<tr>
					<td>제품 이미지</td>
					<td><input type="file" name="image" required></td>
				</tr>
			</table> <br>
			<b>*</b> 숫자만 입력하세요. <br> <br> <input type="image"
				src="../image/ok_small.jpg" id="재료 등록"> <img
				src="../image/cancle_small.jpg"
				onClick="location.href='../mypage/MyPageEnrollStock.jsp'">
		</form>
	</section>

	<footer>
		<img alt="" src="../image/c.jpg">
	</footer>
</body>
</html>