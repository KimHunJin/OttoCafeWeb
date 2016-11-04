<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="Merchandise.Merchandise"%>
<%@ page import="Merchandise.MerchandiseDAO"%>
<%
	request.setCharacterEncoding("utf-8");
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
<%
	MerchandiseDAO mdao = new MerchandiseDAO();
	ArrayList<Merchandise> list = mdao.merchandiseList(managerId,
	pageno);
	int totalRecord = mdao.totalRecord(managerId);
%>
<%
	int total_record = totalRecord;
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

	int merchandiseUniqueKey = 0;
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
	width: 560px;
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
			alert('삭제할 상품을 선택하세요.');
			return;
		}
	}
</script>
</head>
<body>
	<header>
		<br> <img alt="" src="../image/otto4mypage.jpg"
			onClick="location.href='../salesstatus/SalesStatus.jsp'"> <img
			alt="" src="../image/mypage.jpg"
			onClick="location.href='../mypage/MyPageEnrollStock.jsp'">
	</header>

	<nav>
		<img alt="" src="../image/enroll_stock2.jpg"
			onClick="location.href='../mypage/MyPageEnrollStock.jsp'"> <img
			alt="" src="../image/enroll_merchandise1.jpg"
			onClick="location.href='../mypage/MyPageEnrollMerchandise.jsp'">
		<img alt="" src="../image/enroll_store2.jpg"
			onClick="location.href='../mypage/MyPageEnrollStore.jsp'"> <img
			alt="" src="../image/orderhistory2.jpg"
			onClick="location.href='../mypage/MaterialOrderList.jsp'">
	</nav>

	<section>
		<form name="deleteMer" method="post"
			action="../mypage/mypage_control.jsp?action=merchandiseDelete"
			id="delete">
			<table>
				<tr>
					<td><b>선택</b></td>
					<td><b>상품코드</b></td>
					<td><b>상품명</b></td>
					<td><b>이미지</b></td>
					<td><b>상품 가격</b></td>
				</tr>

				<%
					for (Merchandise m : list) {
				%>

				<tr>
					<td><input type="checkbox" name="select"
						value=<%=m.getMerchandiseUniqueKey()%>></td>
					<td><%=m.getMerchandiseUniqueKey()%></td>
					<td><a
						href="../mypage/IncludeMaterial.jsp?uniqueKey=<%=m.getMerchandiseUniqueKey()%>&name=<%=m.getMerchandiseName()%>"><%=m.getMerchandiseName()%></a></td>
					<td><img alt="" src=<%=m.getImage()%> width="80" height="80"></td>
					<td><%=m.getPrice()%></td>
				</tr>

				<%
					}
				%>

			</table>
			<br>

			<%
				for (int i = page_sno; i <= page_eno; i++) {
			%>
			<a href="../mypage/MyPageEnrollMerchandise.jsp?pageno=<%=i%>"> <%
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
			<br> <br> <span> <img src="../image/enrollnew.jpg"
				style='cursor: pointer'
				onclick="location.href='../mypage/NewMerchandise.jsp'"></span> <span>
				<img src="../image/delete.jpg" onclick="checkDel()">
			</span>
		</form>
	</section>

	<footer>
		<img alt="" src="../image/c.jpg">
	</footer>
</body>
</html>