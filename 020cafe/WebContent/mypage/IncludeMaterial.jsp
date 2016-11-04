<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	int uniqueKey = Integer.parseInt(request.getParameter("uniqueKey"));
	String name = request.getParameter("name");

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
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;

	String Query1 = "";
	String Query2 = "";
	String encoded_key = " ";

	int TotalRecords = 0;
	int CurrentPage = 0;
	int Number = 0;
	int TotalPage = 0;
	int TotalpageSets = 0;
	int CurrentPageset = 0;
	int PageRecords = 10;
	int PageSets = 10;

	try {
		String jdbcUrl = "jdbc:mysql://14.63.196.255/020cafe";
		String jdbcId = "user";
		String jdbcPw = "020cafe";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, jdbcId, jdbcPw);

		Query1 = "SELECT count(*) FROM MATERIAL_STORE";

		Query2 = "SELECT mtr.MATERIAL_UNIQUE_KEY, mtr.MATERIAL_NAME, c.CATEGORY_NAME, i.AMOUNT, u.MATERIAL_UNIT_NAME, mtr.IMAGE FROM MATERIAL_UNIT u, MATERIAL mtr, MATERIAL_CATEGORY c, MERCHANDISE mcds, INCLUDE_MATERIAL i WHERE mcds.MERCHANDISE_UNIQUE_KEY = ? AND mcds.MERCHANDISE_UNIQUE_KEY = i.MERCHANDISE_UNIQUE_KEY AND i.MATERIAL_UNIQUE_KEY = mtr.MATERIAL_UNIQUE_KEY AND u.MATERIAL_UNIT_UNIQUE_KEY = i.MATERIAL_UNIT_UNIQUE_KEY AND mtr.MATERIAL_CATEGORY_UNIQUE_KEY = c.MATERIAL_CATEGORY_UNIQUE_KEY;";

		pstmt = conn.prepareStatement(Query1);
		rs1 = pstmt.executeQuery();
		pstmt = conn.prepareStatement(Query2);
		pstmt.setInt(1, uniqueKey);
		rs2 = pstmt.executeQuery();

		rs1.next();
		TotalRecords = rs1.getInt(1);

		Number = TotalRecords - (CurrentPage - 1) * PageRecords;
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
		<br> <img alt="" src="../image/includematerial.jpg">
	</header>
	<section>
		상품코드 :
		<%=uniqueKey%>
		상품명 :
		<b><%=name%></b>
		<br> <br>
		<table>
			<tr>
				<td><b>재료코드</b></td>
				<td><b>재료명</b></td>
				<td><b>카테고리</b></td>
				<td><b>필요량</b></td>
				<td><b>단위</b></td>
				<td><b>재료이미지</b></td>
			</tr>

			<%
				while (rs2.next()) {
						int mUniqueKey = rs2.getInt("mtr.MATERIAL_UNIQUE_KEY");
						String mName = rs2.getString("mtr.MATERIAL_NAME");
						String cName = rs2.getString("c.CATEGORY_NAME");
						String amount = rs2.getString("i.AMOUNT");
						String uName = rs2.getString("u.MATERIAL_UNIT_NAME");
						String image = rs2.getString("mtr.IMAGE");
			%>

			<tr>
				<td><%=mUniqueKey%></td>
				<td><%=mName%></td>
				<td><%=cName%></td>
				<td><%=amount%></td>
				<td><%=uName%></td>
				<td><img src=<%=image%> width="80" height="80"></td>
			</tr>
			<%
				TotalRecords--;

					}
			%>
		</table>
		<%
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				rs2.close();
				rs1.close();
				pstmt.close();
				conn.close();
			}
		%>
		<img src="../image/edit1.jpg" onclick="location.href=''"> <img
			src="../image/ok_small.jpg" onClick="history.back()">
	</section>
	<footer>
		<img alt="" src="../image/c.jpg">
	</footer>
</body>
</html>