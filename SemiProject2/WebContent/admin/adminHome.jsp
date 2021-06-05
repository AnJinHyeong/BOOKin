<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	String root = request.getContextPath();
%>
<script src="http://d3js.org/d3.v3.min.js"></script>
<jsp:include page="/template/adminSidebar.jsp"></jsp:include>
	<section>
		<div class="admin-home_content_area">
			<div class="admin-home_content">
				<div class="admin-content_title">
					주문 / 배송
				</div>
				<div class="admin-content-itmes">
				<div><span>신규 주문</span><a>0건</a></div>
				<div><span>배송중</span><a>0건</a></div>
				<div><span>배송완료</span><a>0건</a></div>
				</div>
			</div>
			<div class="admin-home_content">
				<div class="admin-content_title">
					문의/리뷰
				</div>
				<div class="admin-content-itmes">
				<div><span>신규 리뷰</span><a>0건</a></div>
				<div><span>신규 문의</span><a>0건</a></div>
				</div>
			</div>
			
		</div>
		<div class="admin-home_chart_area">
			
			<div class="admin-chart">
				<div class="admin-content_title">
					매출 통계
				</div>
				<div>
					<svg></svg>
				</div>
			</div>
		</div>
	</section>
	<script>
	chart = {
			  const svg = d3.select(DOM.svg(width, height))
			      .style("-webkit-tap-highlight-color", "transparent")
			      .style("overflow", "visible");

			  svg.append("g")
			      .call(xAxis);

			  svg.append("g")
			      .call(yAxis);
			  
			  svg.append("path")
			      .datum(data)
			      .attr("fill", "none")
			      .attr("stroke", "steelblue")
			      .attr("stroke-width", 1.5)
			      .attr("stroke-linejoin", "round")
			      .attr("stroke-linecap", "round")
			      .attr("d", line);

			  const tooltip = svg.append("g");

			  svg.on("touchmove mousemove", function(event) {
			    const {date, value} = bisect(d3.pointer(event, this)[0]);

			    tooltip
			        .attr("transform", `translate(${x(date)},${y(value)})`)
			        .call(callout, `${formatValue(value)}
			${formatDate(date)}`);
			  });

			  svg.on("touchend mouseleave", () => tooltip.call(callout, null));

			  return svg.node();
			}
	
	callout = ƒ(g, value);
	
	callout = (g, value) => {
		  if (!value) return g.style("display", "none");

		  g
		      .style("display", null)
		      .style("pointer-events", "none")
		      .style("font", "10px sans-serif");

		  const path = g.selectAll("path")
		    .data([null])
		    .join("path")
		      .attr("fill", "white")
		      .attr("stroke", "black");

		  const text = g.selectAll("text")
		    .data([null])
		    .join("text")
		    .call(text => text
		      .selectAll("tspan")
		      .data((value + "").split(/\n/))
		      .join("tspan")
		        .attr("x", 0)
		        .attr("y", (d, i) => `${i * 1.1}em`)
		        .style("font-weight", (_, i) => i ? null : "bold")
		        .text(d => d));

		  const {x, y, width: w, height: h} = text.node().getBBox();

		  text.attr("transform", `translate(${-w / 2},${15 - y})`);
		  path.attr("d", `M${-w / 2 - 10},5H-5l5,-5l5,5H${w / 2 + 10}v${h + 20}h-${w + 20}z`);
		}
	
	data = Array(1280) [
		  {date: 2007-04-23, value: 93.24},
		  {date: 2007-04-24, value: 95.35},
		  {date: 2007-04-25, value: 98.84},
		  {date: 2007-04-26, value: 99.92},
		  {date: 2007-04-29, value: 99.8},
		  {date: 2007-05-01, value: 99.47},
		  {date: 2007-05-02, value: 100.39},
		  {date: 2007-05-03, value: 100.4},
		  {date: 2007-05-04, value: 100.81},
		  {date: 2007-05-07, value: 103.92},
		  {date: 2007-05-08, value: 105.06},
		  {date: 2007-05-09, value: 106.88},
		  {date: 2007-05-09, value: 107.34},
		  {date: 2007-05-10, value: 108.74},
		  {date: 2007-05-13, value: 109.36},
		  {date: 2007-05-14, value: 107.52},
		  {date: 2007-05-15, value: 107.34},
		  {date: 2007-05-16, value: 109.44},
		  {date: 2007-05-17, value: 110.02},
		  {date: 2007-05-20, value: 111.98}
	]
	
	data = Object.assign(d3.csvParse(await FileAttachment("aapl.csv").text(), d3.autoType).map(({date, close}) => ({date, value: close})), {y: "$ Close"})
	
	x = ƒ(n)
	
	x = d3.scaleUtc()
    .domain(d3.extent(data, d => d.date))
    .range([margin.left, width - margin.right])
    
    y = ƒ(n)
    
    y = d3.scaleLinear()
    .domain([0, d3.max(data, d => d.value)]).nice()
    .range([height - margin.bottom, margin.top])
    
    xAxis = ƒ(g)
    
    xAxis = g => g
    .attr("transform", `translate(0,${height - margin.bottom})`)
    .call(d3.axisBottom(x).ticks(width / 80).tickSizeOuter(0))
    
    yAxis = ƒ(g)
    
    yAxis = g => g
    .attr("transform", `translate(${margin.left},0)`)
    .call(d3.axisLeft(y))
    .call(g => g.select(".domain").remove())
    .call(g => g.select(".tick:last-of-type text").clone()
        .attr("x", 3)
        .attr("text-anchor", "start")
        .attr("font-weight", "bold")
        .text(data.y))
        
        
 	line = ƒ(a)
 	
	
		line = d3.line()
    .curve(d3.curveStep)
    .defined(d => !isNaN(d.value))
    .x(d => x(d.date))
    .y(d => y(d.value))
    
    formatValue = ƒ(value)
    
    function formatValue(value) {
	  return value.toLocaleString("en", {
	    style: "currency",
	    currency: "USD"
	  });
	}
    
    formatDate = ƒ(date)
    
    function formatDate(date) {
	  return date.toLocaleString("en", {
	    month: "short",
	    day: "numeric",
	    year: "numeric",
	    timeZone: "UTC"
	  });
	}
    
    bisect = ƒ(mx)
    
    bisect = {
	  const bisect = d3.bisector(d => d.date).left;
	  return mx => {
	    const date = x.invert(mx);
	    const index = bisect(data, date, 1);
	    const a = data[index - 1];
	    const b = data[index];
	    return b && (date - a.date > b.date - date) ? b : a;
	  };
	}
    
    height = 500
    
    margin = ({top: 20, right: 30, bottom: 30, left: 40})
    
    
    
    
	</script>
</body>
</html>