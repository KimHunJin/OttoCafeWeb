<%@page import="jdk.management.resource.internal.TotalResourceContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
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

	int pageno = toInt(request.getParameter("pageno"));
	if (pageno < 1) {
		pageno = 1;
	}
%>
<%!public Integer toInt(String x) {
		int a = 0;
		try {
			a = Integer.parseInt(x);
		} catch (Exception e) {
		}
		return a;
	}%>
<%
	StockDAO sdao = new StockDAO();
	ArrayList<Stock> list = sdao.stockList(pageno);
	int totalRecord = sdao.totalRecord();
%>
<%
	int total_record = totalRecord; //데이터베이스에서 가져온 값으로 변경해야됨
	int page_per_record_cnt = 5;
	int group_per_page_cnt = 5;

	int record_end_no = pageno * page_per_record_cnt;
	int record_start_no = record_end_no - (page_per_record_cnt - 1);
	if (record_end_no > total_record) {
		record_end_no = total_record;
	}

	int total_page = total_record / page_per_record_cnt
			+ (total_record % page_per_record_cnt > 0 ? 1 : 0);
	if (pageno > total_page) {
		pageno = total_page;
	}

	int group_no = pageno / group_per_page_cnt
			+ (pageno % group_per_page_cnt > 0 ? 1 : 0);
	int page_eno = group_no * group_per_page_cnt;
	int page_sno = page_eno - (group_per_page_cnt - 1);

	if (page_eno > total_page) {
		page_eno = total_page;
	}

	int prev_pageno = page_sno - group_per_page_cnt;
	int next_pageno = page_sno + group_per_page_cnt;

	if (prev_pageno < 1) {
		prev_pageno = 1;
	}
	if (next_pageno > total_page) {
		next_pageno = total_page / group_per_page_cnt
				* group_per_page_cnt + 1;
	}
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
	function checkDel() {
		var chkFirList = document.getElementsByName('select');
		var arrFir = new Array();
		var cnt = 0;
		for (var idx = chkFirList.length - 1; 0 <= idx; idx--) {
			if (chkFirList[idx].checked) {
				arrFir[cnt] = chkFirList[idx].value;
				cnt++;
			}
		}
		if (arrFir.length != 0) {
			document.deleteMer.submit();
		} else {
			alert('삭제할 재고를 선택하세요.');
			return;
		}
	}
</script>
</head>
<body>
	<header>
		<br> <img alt="" src="../image/otto4mypage.jpg"
			onClick="location.href='../salesstatus/SalesStatus.jsp'"> <img
			src="../image/mypage.jpg"
			onClick="location.href='../mypage/MyPageEnrollStock.jsp'">
	</header>

	<nav>
		<img src="../image/enroll_stock1.jpg"
			onClick="location.href='../mypage/MyPageEnrollStock.jsp'"> <img
			src="../image/enroll_merchandise2.jpg"
			onClick="location.href='../mypage/MyPageEnrollMerchandise.jsp'">
		<img src="../image/enroll_store2.jpg"
			onClick="location.href='../mypage/MyPageEnrollStore.jsp'"> <img
			src="../image/orderhistory2.jpg"
			onClick="location.href='../mypage/MaterialOrderList.jsp'">
	</nav>

	<section>
	<form name="deleteMer" method="post"
			action="../mypage/mypage_control.jsp?action=materialDelete"
			id="delete">
		<table>
			<tr>
				<td><b>선택</b></td>
				<td><b>재료코드</b></td>
				<td><b>카테고리</b></td>
				<td><b>거래처</b></td>
				<td><b>제품명</b></td>
				<td><b>제품 이미지</b></td>
				<td><b>입고단가</b></td>
				<td><b>용량</b></td>
				<td><b>단위</b></td>
			</tr>

			<%
				for (Stock s : list) {
			%>
			<tr>
				<td><input type="checkbox" name="select"
					value=<%=s.getMaterialUniqueKey()%>></td>
				<td><%=s.getMaterialUniqueKey()%></td>
				<td><%=s.getCategoryName()%></td>
				<td><%=s.getMaterialStoreName()%></td>
				<td><%=s.getMaterialName()%></td>
				<td><img src=<%=s.getImage()%> width="80px" height="80px"></td>
				<td><%=s.getPrice()%></td>
				<td><%=s.getVolume()%></td>
				<td><%=s.getMaterialUnitName()%></td>
			</tr>
			<%
				}
			%>
		</table>
		
		<%
			for (int i = page_sno; i <= page_eno; i++) {
		%>
		<a href="../mypage/MyPageEnrollStock.jsp?pageno=<%=i%>"> <%
 	if (pageno == i) {
 %><span> [<%=i%>]
		</span> <%
 	} else {
 %> <%=i%> <%
 	}
 %>
		</a>
		<%--	콤마	 --%>
		<%
			if (i < page_eno) {
		%>

		<%
			}
		%>
		<%
			}
		%>
		
		<br> <br>
		<table>
			<tr>
				<td><span> <img src="../image/enrollnew.jpg"
						onclick="location.href='../mypage/NewMaterial.jsp'">
				</span> <span> <img src="../image/delete.jpg"
						onclick="checkDel()">
				</span></td>

			</tr>
		</table>
		</form>
	</section>

	<footer>
		<img alt="" src="../image/c.jpg">
	</footer>
</body>
</html>