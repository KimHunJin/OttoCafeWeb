<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="stock" class="Stock.Stock" />
<jsp:setProperty name="stock" property="*" />
<jsp:useBean id="sdao" class="Stock.StockDAO" />
<jsp:useBean id="manager" class="Manager.Manager" />
<jsp:setProperty name="manager" property="*" />
<jsp:useBean id="mdao" class="Manager.ManagerDAO" />

<%
	// 컨트롤러 요청 action 코드값
	String action = request.getParameter("action");
	String managerId = (String) session.getAttribute("managerId");
	String materialUniqueKey = request.getParameter("materialUniqueKey");
	String orderAmount = request.getParameter("orderAmount");
	String putBasketUniqueKey = request.getParameter("putBasketUniqueKey");
	

	//장바구니 취소
	if (action.equals("cancel")) {
		if (sdao.putBasketCancel(Integer.parseInt(putBasketUniqueKey)))
			out.println("<script>alert('취소 되었습니다.');location.href='../stockstatus/MaterialCartList.jsp'</script>");
		else
			out.println("<script>alert('실패하였습니다!!');history.go(-1);</script>");
	}

	if (action.equals("addPutBasket")) {
		if (sdao.addPutBasket(managerId, Integer.parseInt(materialUniqueKey), Integer.parseInt(orderAmount)))
			out.println("<script>alert('주문 되었습니다.');location.href='../stockstatus/MaterialCartList.jsp'</script>");
		else
			out.println("<script>alert('실패하였습니다!!');history.go(-1);</script>");
	}
%>