<%@page import="java.text.DecimalFormat"%>
<%@page import="semi.beans.BookDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="semi.beans.PurchaseDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	String root = request.getContextPath();
    PurchaseDao purchaseDao = new PurchaseDao();
    String startDate=request.getParameter("startDate");
    String endDate=request.getParameter("endDate");
    Date dateS = new Date(System.currentTimeMillis()-7*24*60*60*1000);
    Date dateE = new Date(System.currentTimeMillis()+24*60*60*1000);
    BookDao bookDao = new BookDao();
    SimpleDateFormat format = new SimpleDateFormat("yy-MM-dd");
    int sum=0;
    if(startDate==null){
    	startDate=format.format(dateS);
    }
    if(endDate==null){
    	endDate=format.format(dateE);
    }
    List<List<String>> pList =  purchaseDao.getChartData(startDate,endDate);
    List<List<String>> ptList =  purchaseDao.getTableData(startDate,endDate);
    DecimalFormat format2 = new DecimalFormat("###,###");
	%>

<jsp:include page="/template/adminSidebar.jsp"></jsp:include>
	<section>
		<div class="admin-content_area">
			<div class="admin-content">
				<div class="admin-content_title">
					매출 통계
				</div>
			</div>
		</div>
		<div class="admin-home_chart_area">
			<div class="admin-chart">
				<div class="admin-content_title admin-search date-search" >
					
					<a style="margin-left:8px;">1주일</a><a>1개월</a><a>3개월</a>
					<form action="" class="date_form">
					<input type="date" name="startDate" class="date1" style="margin-left:20px;" <%if(startDate!=null){ %>value="<%=startDate%>"<%} %> > <span> &nbsp;~&nbsp; </span> 
					<input type='date' name="endDate" class="date2" <%if(endDate!=null){ %>value="<%=endDate%>"<%} %>  >
					<input type="submit" value="검색" style="margin-left:12px; padding:0.2rem 1rem; color:white; background-color:#ff9f43;border:none;cursor: pointer;box-shadow: rgb(0 0 0 / 16%) 0px 1px 4px; ">
					</form>
				</div>
				<div class="chart">
					<canvas id="myChart"  style="width:100%;height: 530px;"></canvas>
				</div>
			</div>
		</div>
		
		<div class="admin-content_area" style="margin-top: 45px;">
			<div class="admin-content">
				<div class="search-table">
				<%if(ptList.size()==0){ %>
				<span class="no_Data">데이터가 없습니다</span>
				<%}else{ %>
					<table class="table table-border table-hover table-striped">
						<thead>
							<tr>
								<th style="width:10%">구매일</th>
								<th style="width:5%">상품번호</th>
								<th style="width:40%">상품</th>
								<th style="width:5%">구매번호</th>
								<th style="width:5%">수량</th>
								<th style="width:5%">정가</th>
								<th style="width:5%">할인가</th>
								<th style="width:5%">판매가</th>
							</tr>
						</thead>
						<tbody>
						<%for(List<String> bd : ptList){ %>
							<tr>
								<td style="	text-align: center;"><%=bd.get(0).substring(0,10) %></td>
								<td><%=bd.get(3)%></td>
								<td><%=bookDao.get(Integer.parseInt(bd.get(3))).getBookTitle() %></td>
								<td><%=bd.get(2) %></td>
								<td><%=bd.get(1) %></td>
								<td style="	text-align: center;"><%=format2.format(Integer.parseInt(bd.get(4))) %></td>
								<td style="	text-align: center;"><%=format2.format(Integer.parseInt(bd.get(5))) %></td>
								<td style="	text-align: center;"><%=format2.format(Integer.parseInt(bd.get(6))) %></td>
							</tr>
						<%	sum+=Integer.parseInt(bd.get(6));} %>
						</tbody>
					</table>
					<div style="text-align: right; padding : 1rem">합계 <%=format2.format(sum) %>원</div>
	<%} %>
				</div>
			</div>
		</div>
	</section>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script>
	
	window.addEventListener("load",function(){
		var today = new Date();

		const date2=document.querySelector(".date2")
		const date1=document.querySelector(".date1")
		
		if(date1.value=="" && date2.value==""){
			date2.value = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
			date2.valueAsNumber= date2.valueAsNumber+24*60*60*1*1000;
			date1.valueAsNumber = date2.valueAsNumber-24*60*60*1*1000;
			
		}
		
		
		const date_range_btn = document.querySelectorAll(".admin-search.date-search>a")
		for(var i = 0 ; i<date_range_btn.length;i++){
			date_range_btn[i].addEventListener("click",function(){
				if(this.textContent=='오늘'){
					date2.value = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
					date2.valueAsNumber= date2.valueAsNumber+24*60*60*1*1000;
					date1.valueAsNumber = date2.valueAsNumber-24*60*60*1*1000;
					for(var j = 0 ; j<date_range_btn.length;j++){
						date_range_btn[j].classList.remove('on')
					}
					this.classList.add('on');
				}else if(this.textContent=='1주일'){
					date1.valueAsNumber = date2.valueAsNumber-24*60*60*7*1000;
					for(var j = 0 ; j<date_range_btn.length;j++){
						date_range_btn[j].classList.remove('on')
					}
					this.classList.add('on');
				}else if(this.textContent=='1개월'){
					date1.valueAsNumber = date2.valueAsNumber-24*60*60*31*1000;
					for(var j = 0 ; j<date_range_btn.length;j++){
						date_range_btn[j].classList.remove('on')
					}
					this.classList.add('on');
				}else if(this.textContent=='3개월'){
					date1.valueAsNumber = date2.valueAsNumber-24*60*60*92*1000;
					for(var j = 0 ; j<date_range_btn.length;j++){
						date_range_btn[j].classList.remove('on')
					}
					this.classList.add('on');
				}
				
				const date_form = document.querySelector(".date_form");
				
				date_form.submit();
			});
		}
	});
	
	
	const labels = [
		<%for(int i =0;i<pList.size();i++){%>
		'<%=pList.get(i).get(0)%>',
		<%}%>
		];
	const data = {
	  labels: labels,
	  datasets: [
			{
			    label: '매출',
			    yAxisID: 'y',
			    backgroundColor: '#ff9f43',
			    borderColor: '#ff9f43',
			    data: [
			    	<%for(int i =0;i<pList.size();i++){%>
					<%=Integer.parseInt(pList.get(i).get(2))%>,
					<%}%>
			    	],
	       	},
	 	 	{
			    label: '수량',
			    yAxisID: 'y1',
			    backgroundColor: '#ff6b6b',
			    borderColor: '#ff6b6b',
			    data: [
			    	<%for(int i =0;i<pList.size();i++){%>
					<%=Integer.parseInt(pList.get(i).get(1))%>,
					<%}%>
			    	],
		 	}
	  ]
	};
	
	
	const config = {
			  type: 'line',
			  data: data,
			  options: {
			    responsive: false,
			    interaction: {
			      mode: 'index',
			      intersect: false,
			    },
			    stacked: false,
			    scales: {
			      y: {
			        type: 'linear',
			        display: false,
			        position: 'left',
			      },
			      y1: {
			        type: 'linear',
			        display: false,
			        position: 'right',

			        // grid line settings
			        grid: {
			          drawOnChartArea: false, // only want the grid lines for one axis to show up
			        },
			      },
			    }
			  },
			};
	var myChart = new Chart(
		    document.querySelector('#myChart'),
		    config
		  );

	
	
	</script>
</body>
</html>