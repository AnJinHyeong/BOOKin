<%@page import="semi.beans.PurchaseDao"%>
<%@page import="org.apache.catalina.filters.ExpiresFilter.XServletOutputStream"%>
<%@page import="java.util.ArrayList"%>
<%@page import="semi.beans.BookDto"%>
<%@page import="semi.beans.BookDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="semi.beans.GenreDto"%>
<%@page import="java.util.List"%>
<%@page import="semi.beans.GenreDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%	
		int count=0;
		
		String root = request.getContextPath();
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String type = request.getParameter("type");
		String dType = request.getParameter("dType");
		String keyword = request.getParameter("keyword");
		PurchaseDao purchaseDao = new PurchaseDao();
		List<List<String>> purList = purchaseDao.purchaseSearch(startDate, endDate, type, keyword, dType);
		
		if(purList!=null){
			count=purList.size();
		}
	%>
<link rel="stylesheet" type="text/css" href="<%= root%>/css/common.css">
<jsp:include page="/template/adminSidebar.jsp"></jsp:include>
	<section>
		<div class="admin-content_area">
			<div class="admin-content">
				<div class="admin-content_title">
					주문통합검색
				</div>
			</div>
		</div>
		<form action="" method="get" >
		
		<div class="admin-content_area">
			<div class="admin-content">
				<div class="admin-content_title">
					조회기간
				</div>
				<div class="admin-search">
					<div>결제일</div>
				</div>
				<div class="admin-search date-search">
					<a>오늘</a><a>1주일</a><a>1개월</a><a>3개월</a>
				</div>
				<div class="admin-search">
					<input type="date" name="startDate" class="date1" <%if(startDate!=null){ %>value="<%=startDate%>"<%} %> > <span> &nbsp;~&nbsp; </span> 
					<input type='date' name="endDate" class="date2" <%if(endDate!=null){ %>value="<%=endDate%>"<%} %>  >
				</div>
			</div>
		</div>
		
		<div class="admin-content_area">
			<div class="admin-content">
				<div class="admin-content_title">
					상세조건
				</div>
				<div class="admin-search">
					<select name="type">
						<option>전체</option>
						<option <%if(type!=null&&type.equals("purchaseNo")){%>selected<%}%> value="purchaseNo">주문번호</option>
						<option <%if(type!=null&&type.equals("bookNo")){%>selected<%}%>  value="bookNo">상품번호</option>
						<option <%if(type!=null&&type.equals("purchaseRecipient")){%>selected<%}%>  value="purchaseRecipient">주문자명</option>
					</select>
					<input type="text" name="keyword" <%if(keyword!=null){ %>value="<%=keyword%>"<%} %>/>
				</div>
			</div>
		</div>
		
		<div class="admin-content_area">
			<div class="admin-content">
				<div class="admin-content_title">
					주문상태
				</div>
				<div class="admin-search">
					<select name="dType">
						<option>전체</option>
						<option <%if(dType!=null&&dType.equals("결제완료")){%>selected<%}%>>결제완료</option>
						<option <%if(dType!=null&&dType.equals("주문확인")){%>selected<%}%>>주문확인</option>
						<option <%if(dType!=null&&dType.equals("배송중")){%>selected<%}%>>배송중</option>
						<option <%if(dType!=null&&dType.equals("배송완료")){%>selected<%}%>>배송완료</option>
					</select>
				</div>
			</div>
		</div>
		<button class="submit-btn">검색</button>
		</form>
		
		<div class="admin-content_area" style="margin-top: 45px;">
			<div class="admin-content">
				<div class="admin-content_title" >
					상품목록 (총 <%=count %> 개)
				</div>
				<div class="search-table">
				<%if(count==0){ %>
				<span class="no_Data">데이터가 없습니다</span>
				<%}else{ %>
				
				
				<form method="post" action="<%=root%>/purchase/purchaseUpdate.kh">
					<table class="table table-border table-hover table-striped purchase-table" >
						<thead>
							<tr>
								<th style="width:3%"><input class="all_cb" type="checkbox"></th>
								<th style="width:5%">주문번호</th>
								<th style="width:5%">상품번호</th>
								<th style="width:5%">수량</th>
								<th style="width:8%">주문상태</th>
								<th style="width:15%">주문일</th>
								<th style="width:10%">수령인</th>
								<th style="width:15%">배송지</th>
								<th style="width:10%">연락처</th>
								<th style="width:10%">정가</th>
								<th style="width:10%">판매가</th>
							</tr>
						</thead>
						
						<tbody>
						<%for(List<String> sList : purList){ %>
						<tr>
							<%for(int i = 0;i<sList.size();i++){ %>
							<%if(i==0){ %>
							<td><input type="checkbox" value="<%=sList.get(i)%>" name="purchaseNo"></td>
							<%} %>
							<td <%if(i==0){%>class="tr0<%=sList.get(i)%>" <%} %>>
							<%if(i==9 && sList.get(9).equals("0")){ %>
							<%=sList.get(8) %>
							<%}else{ %>
							<%=sList.get(i) %>
							
							<%}%>
							</td>
							<%}%>
						</tr>
						<%} %>
						</tbody>
					</table>
					<button type="submit" class="confirmOrder s-btn" name="confirmOrder" value='true'>주문확인</button> 
					<button type="submit" class="delivery s-btn" name="delivery" value='true'>출고</button>
				</form>
	<%} %>
				</div>
			</div>
		</div>
	</section>
<script>
	window.onpageshow = function(event){
		if(event.persisted || (window.performance && window.performance.navigation.type==2)){
			console.log('뒤로가기')
			window.location.reload();
		}else{
			console.log('뒤로가기x')
			console.log(window.performance)
			console.log(window.performance.navigation.type)
		}
	}
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
			});
		}
		var mySet = new Set();
		const confirmOrder = document.querySelector('.confirmOrder');
		const delivery = document.querySelector('.delivery');
		const tr = document.querySelectorAll("tbody>tr");
		for(var i = 0  ; i<tr.length;i++){
			tr[i].addEventListener("mouseover",function(){
				const sel_tr=document.querySelectorAll("."+this.children[1].className);
				for(var j = 0  ; j<tr.length;j++){
					tr[j].style.backgroundColor="white";
				}
				for(var j =0 ;j<sel_tr.length;j++){
					sel_tr[j].parentElement.style.backgroundColor="rgb(231, 241, 253,0.5)";
				}
			})
			
			tr[i].addEventListener("mouseout",function(){
				for(var j = 0  ; j<tr.length;j++){
					tr[j].style.backgroundColor="white";
				}
				
			})
			
			tr[i].children[0].children[0].addEventListener("input",function(){
				var cls_name=this.parentElement.nextElementSibling.className;
				const sel_tr=document.querySelectorAll("."+cls_name);
				
				if(this.checked){
					for(var j =0 ;j<sel_tr.length;j++){
						sel_tr[j].previousElementSibling.children[0].checked=true;
						sel_tr[j].previousElementSibling.children[0].classList.remove("ckfalse");
						sel_tr[j].previousElementSibling.children[0].classList.add("cktrue");
					}
				}else{
					for(var j =0 ;j<sel_tr.length;j++){
						sel_tr[j].previousElementSibling.children[0].checked=false;
						sel_tr[j].previousElementSibling.children[0].classList.remove("cktrue");
						sel_tr[j].previousElementSibling.children[0].classList.add("ckfalse");
					}
				}
				
				const ck = document.querySelectorAll(".cktrue");
				if(ck.length==0){
					delivery.style.display = 'none'
					confirmOrder.style.display="none"
				}
				for(var j=0;j<ck.length;j++){
					console.log(this.parentElement.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.textContent)
					mySet.add(ck[j].parentElement.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.textContent)
					
					if(mySet.size==1){
						console.dir(mySet)
						if(mySet.has('\n\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t주문확인\n\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t')){
							delivery.style.display = 'block'
							confirmOrder.style.display="none"
						}else if(mySet.has('\n\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t결제완료\n\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t')){
							delivery.style.display = 'none'
							confirmOrder.style.display="block"
						}	
					}else{
						delivery.style.display = 'none'
						confirmOrder.style.display="none"
					}
					
				}
					mySet.clear();
			})
		}
		
		const all_cb = document.querySelector(".all_cb");
		if(all_cb){
			all_cb.addEventListener("input",function(){
				if(this.checked){
					for(var i = 0  ; i<tr.length;i++){
						tr[i].children[0].children[0].checked=true;
						tr[i].children[0].children[0].classList.remove("ckfalse");
						tr[i].children[0].children[0].classList.add("cktrue");
					}
				}else{
					for(var i = 0  ; i<tr.length;i++){
						tr[i].children[0].children[0].checked=false;
						tr[i].children[0].children[0].classList.remove("cktrue");
						tr[i].children[0].children[0].classList.add("ckfalse");
					}
				}
				
				
			})
		}
		
	})
	</script>
</body>
</html>