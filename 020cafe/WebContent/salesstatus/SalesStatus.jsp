<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="sales.Sales"%>
<%@ page import="sales.SalesDAO"%>
<%@ page import="Stock.Stock"%>
<%@ page import="Stock.StockDAO"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%
	String managerId = "";
	try {
		managerId = (String) session.getAttribute("managerId");
	} catch (Exception e) {

	}
	if (managerId == null || managerId.equals("")) {
		response.sendRedirect("../manager/Login.jsp");
	}
	
	Date d = new Date();
	String clock = d.toString();

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String today = sdf.format(d);
    
    Calendar cal = Calendar.getInstance ( );//오늘 날짜를 기준으루..

	String date1 = request.getParameter("date1");
	String date2 = request.getParameter("date2");
	
	if (date1 == null || date1.equals("")) {
		date1 = today;
	} else if (date1.equals("mon1")) {
		cal.add(Calendar.MONTH, -1);
	} else if (date1.equals("mon3")) {
		cal.add(Calendar.MONTH, -3);
	} else if (date1.equals("mon6")) {
		cal.add(Calendar.MONTH, -6);
	} else if (date1.equals("total")) {
		cal.add(Calendar.YEAR, -6);
	}

    date1 = sdf.format(cal.getTime());
%>
<%
	SalesDAO sdao = new SalesDAO();
	ArrayList<Sales> list = sdao.getAll(managerId, date1, today);
%>
<%
	StockDAO stockdao = new StockDAO();
	ArrayList<Stock> list2 = stockdao.stockList(managerId);
	int i = 0;
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>오또카페</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" type="image/x-icon"
	href="../image/favicon.ico" />
<style>
body {
	margin: 0px auto;
}

header {
	margin: 0 auto;
	text-align: center;
}

table {
	text-align: center;
	vertical-align: middle;
	margin: 0 auto;
}

footer {
	text-align: center;
}

#s img {
	vertical-align: middle;
}

section {
	text-align: center;
}

path {
	stroke: #fff;
}

path:hover {
	opacity: 0.9;
}

rect:hover {
	fill: blue;
}

.axis {
	font-size: 10px;
}

.legend tr {
	border-bottom: 1px solid grey;
}

.legend tr:first-child {
	border-top: 1px solid grey;
}

.axis path, .axis line {
	fill: none;
	stroke: #000;
	shape-rendering: crispEdges;
}

.x.axis path {
	display: none;
}

.legend {
	margin: 0px auto;
	margin-bottom: 200px;
	display: inline-block;
	border-collapse: collapse;
	border-spacing: 0px;
	opacity: 0.8;
}

.legend td {
	padding: 4px 5px;
	vertical-align: bottom;
}

.legendFreq, .legendPerc {
	align: bottom;
	width: 50px;
}

.axis path, .axis line {
	fill: none;
	stroke: black;
	shape-rendering: crispEdges;
}

.axis text {
	font-size: 10px;
}

a {
	text-decoration: none;
}
</style>
<script type="text/javascript">
	setTimeout("history.go(0)", 50000);
</script>

</head>
<body>
	<br>
	<header>
		<img src="../image/main_ottocafe.jpg"
			onclick="location.href='../salesstatus/SalesStatus.jsp'">
	</header>
	<br>

	<div></div>
	<table>
		<tr>
			<td><a
				href="../salesstatus/SalesStatus.jsp?date1=<%=today%>&date2=<%=today%>">당일</a>
				<a href="../salesstatus/SalesStatus.jsp?date1=mon1&date2=<%=today%>">한달</a>
				<a href="../salesstatus/SalesStatus.jsp?date1=mon3&date2=<%=today%>">3개월</a>
				<a href="../salesstatus/SalesStatus.jsp?date1=mon6&date2=<%=today%>">6개월</a>
				<a
				href="../salesstatus/SalesStatus.jsp?date1=total&date2=<%=today%>">전체</a></td>
		</tr>
		<tr>
			<td>판매현황</td>
			<td>재고현황</td>
		</tr>
		<tr>
			<td><span id='dashboard'></span></td>
			<td><span id='div'></span></td>
		</tr>
	</table>


	<script src="http://d3js.org/d3.v3.min.js"></script>
	<script>
	function dashboard(id, fData){
	    var barColor = d3.scale.ordinal().range(["#EA2E49", "#F6F792", "#DAEDE2", "#77C4D3", "#FF8598", "#046380", "#98abc5", "#8a89a6"]);
	    function segColor(c){ return {total:"#41ab5d"}[c]; }
	    
	    // compute total for each state.
	    fData.forEach(function(d){d.total=d.freq.total;});
	    
	    // function to handle histogram.
	    function histoGram(fD){
	        var hG={},    hGDim = {t: 60, r: 0, b: 30, l: 0};
	        hGDim.w = 400 - hGDim.l - hGDim.r, 
	        hGDim.h = 300 - hGDim.t - hGDim.b;
	            
	        //create svg for histogram. id:dashboard
	        var hGsvg = d3.select(id).append("svg")
	            .attr("width", hGDim.w + hGDim.l + hGDim.r)
	            .attr("height", hGDim.h + hGDim.t + hGDim.b).append("g")
	            .attr("transform", "translate(" + hGDim.l + "," + hGDim.t + ")");

	        // create function for x-axis mapping.
	        var x = d3.scale.ordinal().rangeRoundBands([0, hGDim.w], 0.1)
	                .domain(fD.map(function(d) { return d[0]; }));

	        // Add x-axis to the histogram svg.
	        hGsvg.append("g").attr("class", "x axis")
	            .attr("transform", "translate(0," + hGDim.h + ")")
	            .call(d3.svg.axis().scale(x).orient("bottom"));

	        // Create function for y-axis map.
	        var y = d3.scale.linear().range([hGDim.h, 0])
	                .domain([0, d3.max(fD, function(d) { return d[1]; })]);

	        // Create bars for histogram to contain rectangles and freq labels.
	        var bars = hGsvg.selectAll(".bar").data(fD).enter()
	                .append("g").attr("class", "bar");
	        
	        //create the rectangles.
	        bars.append("rect")
	            .attr("x", function(d) { return x(d[0]); })
	            .attr("y", function(d) { return y(d[1]); })
	            .attr("width", x.rangeBand())
	            .attr("height", function(d) { return hGDim.h - y(d[1]); })
	            .attr('fill',barColor)
	            
	        //Create the frequency labels above the rectangles. 각 음료당 판매 개수 출력
	        bars.append("text").text(function(d){ return d3.format(",")(d[1])})
	            .attr("x", function(d) { return x(d[0])+x.rangeBand()/2; })
	            .attr("y", function(d) { return y(d[1])-5; })
	            .attr("text-anchor", "middle");
	    }	    
	    
	    // calculate total frequency by state for all segment.
	    var sF = fData.map(function(d){return [d.State,d.total];});

	    var hG = histoGram(sF)
	}
	</script>

	<script>
		var freqData = [ <%for (Sales s : list) {%> {
			State : '<%=s.getMerchandiseName()%>',
			freq : {
				total : <%=s.getCount()%>,
				mid : 0, 
				high : 0
			}
		},
		<%}%>];

		dashboard('#dashboard', freqData);
	</script>


	<!-- 재고 그래프 -->
	<script>
		function div(id, dataset) {
			//Width and height
			var w = 400;
			var h = 300;
			
			//Set up stack method
			var stack = d3.layout.stack();

			//Data, stacked
			stack(dataset);
			
			var materialNames = [ <%for (Stock s : list2) {%> "<%=s.getMaterialName()%>",<%}%>];
			 
			var x = d3.scale.ordinal().rangeRoundBands([0, 400], 0.1)
            .domain(materialNames);

			//Set up scales
			var xScale = d3.scale.ordinal()
				.domain(d3.range(dataset[0].length))
				.rangeRoundBands([0, w], 0.1);
		
			var yScale = d3.scale.linear()
				.domain([0,100
				]) 
				.range([0, h-30]);
			
			var xAxis = d3.svg.axis().scale(xScale).orient("bottom"); //yScale
			
			//y축
			var yAxis = d3.svg.axis().scale(yScale).orient("left");
				
			//Easy colors accessible via a 10-step ordinal scale
			var colors = d3.scale.ordinal().range(["#3498DB", "#E74C3C"]);
		
			//Create SVG element
			var svg = d3.select("#div")
						.append("svg")
						.attr("width", w)
						.attr("height", h);
			
			
			// Add a group for each row of data
			var groups = svg.selectAll("g")
				.data(dataset)
				.enter()
				.append("g").attr("class","axis").call(yAxis).style("fill", function(d, i) {
					return colors(i);
				});

			// Add a rect for each data value
			var rects = groups.selectAll("rect")
				.data(function(d) { return d; })
				.enter()
				.append("rect")
				.attr("x", function(d, i) {
					return xScale(i);
				})
				.attr("y", function(d) {
					return yScale(d.y0);
				})
				.attr("height", function(d) {
					return yScale(d.y);//150; //210
				})
				.attr("width", xScale.rangeBand());
			
			svg.append("g").attr("class", "x axis")
            .attr("transform", "translate(0," + 270 + ")")
            .call(d3.svg.axis().scale(x).orient("bottom"));
			
		}
		</script>

	<script>
		var dataset = [
		    			[ <%for (Stock s : list2) {%> 
		    				{ x: <%=i%>, y: <%=s.getUsable()%> },
		    				<%i+=1; }%>
		    			],
		    			[ <%for (Stock s : list2) {%>
		    				{ x: <%=i%>, y: <%=s.getPercentage()%> },
		    				<%i+=1; }%>
		    					]
		    				];

		div('#div', dataset);
	</script>

	<section id="s">
		<img src="../image/main_mypage2.jpg"
			onclick="location.href='../mypage/MyPageEnrollStock.jsp'"> <img
			src="../image/main_stock2.jpg"
			onclick="location.href='../stockstatus/StockStatus.jsp'"> <img
			src="../image/main_sales2.jpg"
			onclick="location.href='../salesstatus/NewSalesStatus.jsp'"><br>
		<table>
			<tr>
				<td><img src="../image/welcome.jpg"><b><%=managerId%></b>
					<img src="../image/logout.jpg"
					onClick="location.href='../manager/user_control.jsp?action=logout'"></td>
			</tr>
		</table>

	</section>

</body>
</html>