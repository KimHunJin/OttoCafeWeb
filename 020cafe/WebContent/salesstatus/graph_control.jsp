<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="sales" class="sales.Sales" />
<jsp:setProperty name="sales" property="*" />
<jsp:useBean id="sdao" class="sales.SalesDAO" />
<%
	String type = request.getParameter("type");
	String date1 = request.getParameter("s");
	String date2 = request.getParameter("s");
	String managerId = (String) session.getAttribute("managerId");
%>