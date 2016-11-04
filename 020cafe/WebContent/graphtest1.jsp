<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>D3: Stack layout stacked bar chart</title>

<style type="text/css">
/* No style rules here yet */
</style>
</head>
<body>
	<div id="chart"></div>
	<script src="http://d3js.org/d3.v3.min.js"></script>
	<script>
	var data = [
	            {
	             id: 1,
	             name: 'foo',
	                layers: {a: 10, b: 13}
	            }, 
	            {
	             id: 2,
	             name: 'bar',
	                layers: {a: 8, b: 5}
	            },
	            {
	             id: 3,
	             name: 'baz',
	                layers: {a: 3, b: 5}
	            },
	            {
	             id: 4,
	             name: 'qux',
	                layers: {a: 4, b: 15}
	            },
	            {
	             id: 5,
	             name: 'asdf',
	                layers: {a: 2, b: 3}
	            }
	          ]
	          //get the layernames present in the first data element
	          var layernames = d3.keys(data[0].layers);
	          //get idheights, to use for determining scale extent, also get barnames for scale definition
	          var idheights = [];
	          var barnames = [];
	          for (var i=0; i<data.length; i++) {
	              tempvalues = d3.values(data[i].layers);
	              tempsum = 0;
	              for (var j=0; j<tempvalues.length; j++) {tempsum = tempsum + tempvalues[j];}
	              idheights.push(tempsum);
	              barnames.push(data[i].name);
	          };

	          var margin = {top: 10, right: 10, bottom: 30, left: 30},
	              width = 400 - margin.left - margin.right,
	              height = 300 - margin.top - margin.bottom;

	          var x = d3.scale.ordinal()
	              .domain(barnames)
	              .rangeRoundBands([0, width], .25);

	          var y = d3.scale.linear()
	              .domain([0, d3.max(idheights)])
	              .range([height, 0]);
	              
	          var colors = d3.scale.category10();

	          var xAxis = d3.svg.axis()
	              .scale(x)
	              .orient("bottom");

	          var yAxis = d3.svg.axis()
	              .scale(y)
	              .orient("left");

	          var svg = d3.select("#chart").append("svg")
	              .attr("width", width + margin.left + margin.right)
	              .attr("height", height + margin.top + margin.bottom)
	            .append("g")
	              .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

	          svg.append("g")
	              .attr("class", "x axis")
	              .attr("transform", "translate(0," + height + ")")
	              .call(xAxis);

	          svg.append("g")
	              .attr("class", "y axis")
	              .call(yAxis);
	          //add a g element for each bar
	          var bargroups = svg.append("g")
	              .attr("class", "bars")
	              .selectAll("g")
	              .data(data, function(d) {return d.id;})
	            .enter().append("g")
	              .attr("id", function(d) {return d.name;});
	          //sub-selection for rect elements
	          var barrects = bargroups.selectAll("rect")
	              .data(function(d) {
	                  //set data as an array of objects [{height: _, y0: _},..]
	                  //must compute sum of other elements to get y0 (computed height)
	                  var temparray = [];
	                  var tempsum = 0;
	                  for (var i=0; i<layernames.length; i++) {
	                      console.log(layernames[i]);
	                      temparray.push(
	                          {height: d.layers[layernames[i]],
	                           y0: tempsum + d.layers[layernames[i]]}
	                      );
	                      tempsum = tempsum + d.layers[layernames[i]];
	                  }
	                  return temparray;
	              })
	            .enter().append("rect")
	              .attr({
	                  "x": function(d,i,j) {return x(barnames[j]);},
	                  "y": function(d) {return y(d.y0);},
	                  "width": x.rangeBand(),
	                  "height": function(d) {return height - y(d.height);}
	              })
	              .style("fill", function(d,i,j) {return colors(i)});   

	</script>

	
</body>
</html>