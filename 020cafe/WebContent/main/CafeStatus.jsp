<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>오또카페</title>
<link rel="shortcut icon" type="image/x-icon" href="../image/favicon.ico" />
<style>
body {
	margin: 0px auto;
}

.bar {
	fill: steelblue;
}

.axis path {
	display: none;
}
</style>

</head>
<body>
	<div id="div1"></div>
	<script src="//d3js.org/d3.v4.min.js"></script>
	<script>
	function div(id, dataset) {
		var w = 500;
		var h = 100;
		var barPadding = 1;

		//var dataset = [ 5, 10, 13, 19, 21, 25, 22, 18, 15, 13, 11, 12, 15, 20,
		//		18, 17, 16, 18, 23, 25 ];

		//Create SVG element
		var svg = d3.select("body").append("svg").attr("width", w).attr(
				"height", h);

		svg.selectAll("rect").data(dataset).enter().append("rect").attr("x",
				function(d, i) {
					return i * (w / dataset.length);
				}).attr("y", function(d) {
			return h - (d * 4);
		}).attr("width", w / dataset.length - barPadding).attr("height",
				function(d) {
					return d * 4;
				}).attr("fill", function(d) {
			return "rgb(0, 0, " + (d * 10) + ")";
		});

		svg.selectAll("text").data(dataset).enter().append("text").text(
				function(d) {
					return d;
				}).attr("x", function(d, i) {
			return i * (w / dataset.length) + 5;
		}).attr("y", function(d) {
			return h - (d * 4) + 15;
		}).attr("font-family", "sans-serif").attr("font-size", "11px").attr(
				"fill", "white");
	}
		
	</script>
	<script>
		var data = [ [{x:0, y:10}, {x:1, y:20}], [{x:0, y:20}, {x:1, y:30}] ];

		div('#div1', data);
	</script>
</body>
</html>