<%@page import="semi.beans.QnaBoardDao"%>
<%@page import="semi.beans.ReviewDao"%>
<%@page import="java.util.Map"%>
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
    SimpleDateFormat format = new SimpleDateFormat("yy-MM-dd");
    Map<String,Integer> map = purchaseDao.getAllPurchaseState(format.format(dateS), format.format(dateE));
    ReviewDao reviewDao = new ReviewDao();
    QnaBoardDao qnaDao = new QnaBoardDao();
    
    int todayReviewCount = reviewDao.getTodayReview();
    int qnaCount = qnaDao.getNoReplyQna();
    if(startDate==null){
    	startDate=format.format(dateS);
    }
    if(endDate==null){
    	endDate=format.format(dateE);
    }
    List<List<String>> pList =  purchaseDao.getChartData(startDate,endDate);
	%>

<jsp:include page="/template/adminSidebar.jsp"></jsp:include>
	<section>
		<div class="admin-home_content_area">
			<div class="admin-home_content">
				<div class="admin-content_title">
					주문 / 배송
				</div>
				<div class="admin-content-itmes">
				<div><span>신규 주문</span><a href="<%=root %>/admin/purchaseSearch.jsp?startDate=<%=format.format(dateS) %>&endDate=<%=format.format(dateE) %>&type=전체&keyword=&dType=결제완료"><%=map.get("결제완료") %> 건</a></div>
				<div><span>주문확인</span><a href="<%=root %>/admin/purchaseSearch.jsp?startDate=<%=format.format(dateS) %>&endDate=<%=format.format(dateE) %>&type=전체&keyword=&dType=주문확인"><%=map.get("주문확인") %> 건</a></div>
				<div><span>배송중</span><a href="<%=root %>/admin/purchaseSearch.jsp?startDate=<%=format.format(dateS) %>&endDate=<%=format.format(dateE) %>&type=전체&keyword=&dType=배송중"><%=map.get("배송중") %> 건</a></div>
				<div><span>배송완료</span><a href="<%=root %>/admin/purchaseSearch.jsp?startDate=<%=format.format(dateS) %>&endDate=<%=format.format(dateE) %>&type=전체&keyword=&dType=배송완료"><%=map.get("배송완료") %> 건</a></div>
				</div>
			</div>
			<div class="admin-home_content">
				<div class="admin-content_title">
					문의/리뷰
				</div>
				<div class="admin-content-itmes">
				<div><span>신규 리뷰</span><a href="<%=root %>/admin/review.jsp"><%=todayReviewCount %> 건</a></div>
				<div><span>미답변 문의</span><a href="<%=root %>/admin/qnaReply.jsp?type=noreply"><%=qnaCount %> 건</a></div>
				</div>
			</div>
			
		</div>
		<div class="admin-home_chart_area">
			
			<div class="admin-chart">
				<div class="admin-content_title admin-search date-search">
					매출 통계
					<a style="margin-left:20px;">1주일</a><a>1개월</a><a>3개월</a>
					<form action="" class="date_form">
					<input type="date" name="startDate" class="date1" style="visibility: hidden">
					<input type="date" name="endDate" class="date2" style="visibility: hidden">
					</form>
				</div>
				<div class="chart">
					<canvas id="myChart"  style="width:100%;height: 530px;"></canvas>
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