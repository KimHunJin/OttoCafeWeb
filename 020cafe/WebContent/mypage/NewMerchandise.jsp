<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Stock.Stock"%>
<%@ page import="Stock.StockDAO"%>
<%@ page import="java.util.ArrayList"%>
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
<%
	StockDAO sdao = new StockDAO();
	ArrayList<Stock> list1 = sdao.categoryList();
	
	StockDAO stockdao = new StockDAO();
	ArrayList<Stock> list3 = stockdao.unitList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오또카페</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" type="image/x-icon"
	href="../image/favicon.ico" />
<style>
body {
	font-family: "한컴 윤고딕 250";
}

table {
	margin: 0 auto;
	text-aling: center;
}

b {
	color: red;
}
</style>
<script>
	function showKeyCode(event) { //숫자만 입력
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ((keyID >= 48 && keyID <= 57) || (keyID == 8)
				|| (keyID >= 37 && keyID <= 40)) {
			return;
		} else {
			return false;
		}
	}

	function insRow() { //재료 입력 추가
		oTbl = document.getElementById("addTable");
		var oRow = oTbl.insertRow();
		oRow.onmouseover = function() {
			oTbl.clickedRowIndex = this.rowIndex
		}; //clickedRowIndex - 클릭한 Row의 위치를 확인;
		var oCell = oRow.insertCell();

		//삽입될 Form Tag
		var frmTag = "<input type=text name=addText style=width:350px; height:20px;> ";
		frmTag += "<input type=button value='삭제' onClick='removeRow()' style='cursor:hand'>";
		oCell.innerHTML = frmTag;
	}

	function removeRow() { //삭제
		oTbl.deleteRow(oTbl.clickedRowIndex);
	}

	function materialList(fr) { //재료 불러오기
		StockDAO
		stdao = new StockDAO();
		ArrayList<Stock>
		list2 = stdao.selectMaterial(categoryUniqueKey);

		if (fr == 1) {
			//뿌려줄값을 배열로정렬
			num = new Array("1)첫번째목록", "1)두번째목록", "1)세번째목록");
			vnum = new Array("1", "2", "3");
		} else if (fr == 2) {
			num = new Array("2)첫번째목록", "2)두번째목록", "2)세번째목록");
			vnum = new Array("1", "2", "3");
		}
		// 셀렉트안의 리스트를 기본값으로 한다..
		for (i = 0; i < form.test2.length; i++) {
			form.test2.options[0] = null;
		}
		//포문을 이용하여 두번째(test2)셀렉트 박스에 값을 뿌려줍니당)
		for (i = 0; i < num.length; i++) {
			document.form.test2.options[i] = new Option(num[i], vnum[i]);

		}
	}
</script>
</head>
<body>
	<header>
		<br>
		<h3>상품 신규 등록</h3>
		<br>
	</header>

	<section>
		<form name="enrollMerchandise" enctype="multipart/form-data"
			action="../mypage/mypage_control.jsp?action=newMerchandise&managerId=<%=managerId%>"
			method="post">

			<table>
				<tr>
					<td>상품명</td>
					<td><input type="text" name="merchandiseName" autofocus
						required></td>
				</tr>
				<tr>
					<td><b>*</b> 가격</td>
					<td><input type="text" name="price"
						onkeydown="return showKeyCode(event)" autofocus required></td>
				</tr>
				<tr>
					<td>상품이미지</td>
					<td><input type="file" name="image" required></td>
				</tr>
			</table>
			<br> <br> 재료 선택
			<table>
				<tr>
					<td>카테고리</td>
					<td><select id="materialCategoryUniqueKey"
						name="materialCategoryUniqueKey"
						onchange="materialList(document.enrollMerchandise.select.value)">
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
					<td>상품명</td>
					<td>카테고리에 따라 관련 상품명 출력되게</td>
				</tr>
				<tr>
					<td><b>*</b> 필요량</td>
					<td><input type="text" name="amount"
						onkeydown="return showKeyCode(event)" autofocus required></td>
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
			</table>
			<br> <b>*</b> 숫자만 입력하세요. <br> <br> <input type="image"
				src="../image/ok_small.jpg" id="상품 등록"> <img
				src="../image/cancle_small.jpg"
				onClick="location.href='../mypage/MyPageEnrollMerchandise.jsp'">

		</form>
	</section>

	<footer>
		<img alt="" src="../image/c.jpg">
	</footer>
</body>
</html>