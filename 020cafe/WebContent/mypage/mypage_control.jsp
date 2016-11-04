<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="stock" class="Stock.Stock" />
<jsp:setProperty name="stock" property="*" />
<jsp:useBean id="sdao" class="Stock.StockDAO" />
<jsp:useBean id="merchandise" class="Merchandise.Merchandise" />
<jsp:setProperty name="merchandise" property="*" />
<jsp:useBean id="merdao" class="Merchandise.MerchandiseDAO" />
<jsp:useBean id="store" class="Store.Store" />
<jsp:setProperty name="store" property="*" />
<jsp:useBean id="storedao" class="Store.StoreDAO" />
<%
	// 컨트롤러 요청 action 코드값
	String action = request.getParameter("action");
	String[] merchandiseUniqueKey = request
			.getParameterValues("select");
	String[] materialUniqueKey = request.getParameterValues("select");
	String[] materialStoreUniqueKey1 = request.getParameterValues("select");
	String managerId = (String) session.getAttribute("managerId");

	// 신규 재료 등록
	if (action.equals("newMaterial")) {
		String saveFolder = "/usr/local/server/tomcat8/webapps/020cafe/image";
		String encType = "utf-8";
		int sizeLimit = 10 * 1024 * 1024;

		MultipartRequest multi = new MultipartRequest(request,
				saveFolder, sizeLimit, encType,
				new DefaultFileRenamePolicy());
		int materialCategoryUniqueKey = Integer.parseInt(multi
				.getParameter("materialCategoryUniqueKey"));
		int materialStoreUniqueKey = Integer.parseInt(multi
				.getParameter("materialStoreUniqueKey"));
		String materialName = multi.getParameter("materialName");
		int price = Integer.parseInt(multi.getParameter("price"));
		int volume = Integer.parseInt(multi.getParameter("volume"));
		int materialUnitUniqueKey = Integer.parseInt(multi
				.getParameter("materialUnitUniqueKey"));
		String url = multi.getParameter("url");
		String image = "../image/" + multi.getFilesystemName("image");
		//Enumeration params = multi.getParameterNames();

		ServletContext context = getServletContext();

		if (image != null) {
			Enumeration files = multi.getFileNames();
			String fname = (String) files.nextElement();
			File file = multi.getFile(fname);
		}

		if (sdao.addMaterial(materialCategoryUniqueKey,
				materialStoreUniqueKey, materialName, price, volume,
				materialUnitUniqueKey, url, image))
			out.println("<script>alert('정상적으로 등록 되었습니다.');location.href='../mypage/NewMaterial.jsp'</script>");
		else
			out.println("<script>alert('실패하였습니다!!');history.go(-1);</script>");
	}

	// 신규 상품 등록
	if (action.equals("newMerchandise")) {

		String filename = null;
		String saveFolder = "/usr/local/server/tomcat8/webapps/020cafe/image";
		String encType = "utf-8";
		int sizeLimit = 10 * 1024 * 1024;

		MultipartRequest multi = new MultipartRequest(request,
				saveFolder, sizeLimit, encType,
				new DefaultFileRenamePolicy());
		String merchandiseName = multi.getParameter("merchandiseName");
		int price = Integer.parseInt(multi.getParameter("price"));
		String image = "../image/" + multi.getFilesystemName("image");
		Enumeration params = multi.getParameterNames();

		ServletContext context = getServletContext();

		filename = multi.getFilesystemName("image");

		if (filename == null) {
			out.print("파일이 업로드되지 않았습니다!");
		}

		if (filename != null) {
			Enumeration files = multi.getFileNames();
			String fname = (String) files.nextElement();
			File file = multi.getFile(fname);
		}

		if (merdao.addMerchandise(merchandiseName, price, image,
				managerId))
			out.println("<script>alert('정상적으로 등록 되었습니다.');location.href='../mypage/NewMerchandise.jsp'</script>");
		else
			out.println("<script>alert('실패하였습니다!!');history.go(-1);</script>");
	}

	// 신규 거래처 등록
	if (action.equals("newStore")) {
		if (storedao.addStore(store))
			out.println("<script>alert('정상적으로 등록 되었습니다.');location.href='../mypage/NewStore.jsp'</script>");
		else
			out.println("<script>alert('실패하였습니다!!');history.go(-1);</script>");
	}

	//상품 삭제 
	if (action.equals("merchandiseDelete")) {
		if (merdao.merchandiseDelete(managerId, merchandiseUniqueKey))
			out.println("<script>alert('삭제 되었습니다.');location.href='../mypage/MyPageEnrollMerchandise.jsp'</script>");
		else
			out.println("<script>alert('실패하였습니다!');location.href='../mypage/MyPageEnrollMerchandise.jsp'</script>");
	}

	//재고 삭제  
	if (action.equals("materialDelete")) {
		if (sdao.materialDelete(materialUniqueKey))
			out.println("<script>alert('삭제 되었습니다.');location.href='../mypage/MyPageEnrollStock.jsp'</script>");
		else
			out.println("<script>alert('실패하였습니다!');location.href='../mypage/MyPageEnrollStock.jsp'</script>");
	}

	//거래처 삭제  
	if (action.equals("materialStoreDelete")) { 
		if (storedao.materialStoreDelete(materialStoreUniqueKey1))
			out.println("<script>alert('삭제 되었습니다.');location.href='../mypage/MyPageEnrollStore.jsp'</script>");
		else
			out.println("<script>alert('실패하였습니다!');location.href='../mypage/MyPageEnrollStore.jsp'</script>");
	}
%>