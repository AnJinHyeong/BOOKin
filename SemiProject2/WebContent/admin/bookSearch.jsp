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
    	int pageNo=0;
	    int startBlock=0;
		int endBlock =0;
		
		int pageSize=0;
		int blockSize=0;
		int startRow=0;
		int endRow=0;
		
		int count=0;
		
		String root = request.getContextPath();
    	GenreDao genreDao = new GenreDao();
    	List<GenreDto> topGenreList = genreDao.topGenreList();
    	BookDao bookDao = new BookDao();
    	BookDto bookDto=null;
    	
    	List<BookDto> bookList = new ArrayList<>();
    	
    	if(request.getParameter("bookNo")!=null && !request.getParameter("bookNo").equals("")){
    		bookDto=bookDao.get(Integer.parseInt(request.getParameter("bookNo")));
    		System.out.println(bookDto);
    		bookList.add(bookDto);
    		count=1;
    	}else{
    		long genreNo=0;
			if(request.getParameter("bookGenre")!=null){
				genreNo=genreDao.getGenreNoByName(request.getParameter("bookGenre"));
			}
			if(request.getParameter("bookTitle")!=null && request.getParameter("bookAuthor")!=null &&request.getParameter("bookPublisher")!=null){
				if(request.getParameter("pageNo")!=null){
					if(request.getParameter("pageNo").equals("")){
						pageNo = 1;
					}else{
						pageNo = Integer.parseInt(request.getParameter("pageNo"));
					}
					
				}else{
					pageNo = 1;
				}
				System.out.println(pageNo);
				System.out.println(request.getParameter("pageNo"));
				pageSize=20;
				blockSize=10;
				startRow=pageNo*pageSize-19;
				endRow=pageNo*pageSize;
				
    			bookList = bookDao.adminSearch(request.getParameter("bookTitle"),request.getParameter("bookAuthor"),request.getParameter("bookPublisher"),genreNo,startRow,endRow);
    			count=bookDao.adminSearchCount(request.getParameter("bookTitle"),request.getParameter("bookAuthor"),request.getParameter("bookPublisher"),genreNo);
    			startBlock = (pageNo-1)/blockSize*blockSize+1;
    	     	endBlock = startBlock+blockSize-1;
    	     	
    	    	int lastBlock = (count + pageSize - 1) / pageSize;
    	    	
    	    	if(endBlock > lastBlock){//범위를 벗어나면
    	    		endBlock = lastBlock;//범위를 수정
    	    	}
			}
    	}
    	
    	System.out.println(bookList.size());
	%>
<link rel="stylesheet" type="text/css" href="<%= root%>/css/common.css">
<jsp:include page="/template/adminSidebar.jsp"></jsp:include>
	<section>
		<div class="admin-content_area">
			<div class="admin-content">
				<div class="admin-content_title">
					상품 조회/수정
				</div>
			</div>
		</div>
		<form action="" method="get" >
		
		<div class="admin-content_area">
			<div class="admin-content">
				<div class="admin-content_title">
					검색어
				</div>
				<div class="admin-search">
					<div>책 번호</div>
					<input type='number' name="bookNo">
				</div>
				<div class="admin-search">
					<div>책 제목</div>
					<input type='text' name="bookTitle" >
				</div>
				<div class="admin-search">
					<div>저자</div>
					<input type='text' name="bookAuthor" >
				</div>
				<div class="admin-search">
					<div>출판사</div>
					<input type='text' name="bookPublisher" >
				</div>
			</div>
		</div>
		
		<div class="admin-content_area">
			<div class="admin-content">
				<div class="admin-content_title">
					카테고리
				</div>
				<div class="align-row choice-genre-area">
					<div class="choice-genre top-genre">
						<ul>
						<%for(GenreDto genreDto : topGenreList){ %>
							<li><%=genreDto.getGenreName() %></li>
						<%} %>
						</ul>
					</div>
					<div class="choice-genre child-genre">
						<ul>
						</ul>
					</div>
					<div class="choice-genre g-child-genre">
						<ul>
						</ul>
					</div>
				</div>
				<div class="show_genre">
				<span class="show_genre1"></span>
				<span class="show_genre2"></span>
				<span class="show_genre3"></span>
				</div>
			</div>
			<input type="hidden" name='bookGenre' class="input_genre"/>
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
					<table class="table table-border table-hover table-striped">
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>저자</th>
								<th>출판사</th>
								<th>정가</th>
								<th>할인가</th>
								<th>카테고리</th>
								<th>출판일</th>
								<th>수정</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody>
						<%for(BookDto bd : bookList){ %>
							<tr>
								<td style="	text-align: center;"><%=bd.getBookNo() %></td>
								<td><a href="<%=root%>/book/bookDetail.jsp?no=<%=bd.getBookNo()%>"><%=bd.getBookTitle() %></a></td>
								<td><%=bd.getBookAuthor() %></td>
								<td><%=bd.getBookPublisher() %></td>
								<td style="	text-align: center;"><%=bd.getBookPrice() %></td>
								<td style="	text-align: center;"><%=bd.getBookDiscount() %></td>
								<td style="	text-align: center;"><%=genreDao.get(bd.getBookGenreNo()).getGenreName() %></td>
								<td style="	text-align: center;"><%=bd.getBookPubDate() %></td>
								<td style="	text-align: center;"><a class="update-btn" href="bookEdit.jsp?bookNo=<%=bd.getBookNo()%>">수정</a></td>
								<td style="	text-align: center;"><a class="update-btn" href="<%=root%>/book/bookDelete.kh?bookNo=<%=bd.getBookNo()%>" style="background-color:#ff6b6b">삭제</a></td>
							</tr>
						<%} %>
						</tbody>
					</table>
				
				<%if(count > 1) { %>
					<ol class="pagination-list pagination" style="text-align: center; margin-top: 20px;">
						<%if(pageNo>10){ %>
						<li><a>이전</a></li>
						<%} %>
						<% for(int i = startBlock;i<=endBlock;i++){ %>
						<%if(pageNo==i){ %>
						<li class="on"><a><%=i %></a></li>
						<%}else{ %>
						<li><a><%=i %></a></li>
						<%} %>
						<%} %>
						<%if(pageNo-1<endBlock/10*10){ %>
						<li><a>다음</a></li>
						<%} %>
					</ol>
					<form class="search-page-form" action="" method="get">
						<input type="hidden" name="bookTitle"  value="<%=request.getParameter("bookTitle")%>">
						<input type="hidden" name="bookAuthor" value="<%=request.getParameter("bookAuthor")%>">
						<input type="hidden" name="bookPublisher"  value="<%=request.getParameter("bookPublisher")%>">
						<input type="hidden" name='bookGenre' value="<%=request.getParameter("bookGenre")%>">
						<input type="hidden" name="pageNo"/>
					</form>
				<%} %>
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
		const searchform=document.querySelector(".search-page-form")
		const formPageNo=document.querySelector('input[name="pageNo"]')
		const pageNo=document.querySelectorAll(".pagination > li > a")
		for(var i=0;i<pageNo.length;i++){
			if(pageNo[i].textContent=="이전"){
				pageNo[i].addEventListener("click",function(){
					formPageNo.value=this.parentElement.nextElementSibling.textContent-1
					searchform.submit();
				})
			}else if(pageNo[i].textContent=="다음"){
				pageNo[i].addEventListener("click",function(){
					formPageNo.value=parseInt(this.parentElement.previousElementSibling.textContent)+1
					searchform.submit();
				})
			}else{
				pageNo[i].addEventListener("click",function(){
					formPageNo.value=this.textContent		
					searchform.submit();
				})
			}
		}
		
	})

	window.addEventListener("load",function(){
			let map = new Map();
			let childList;
			let gchildList;
			let liList;
			<%for(GenreDto genreDto : topGenreList){%>
				childList=[];
				<%for(GenreDto childDto : genreDao.childGenreList(genreDto.getGenreNo())){%>
					childList.push('<%=childDto.getGenreName()%>');
					gchildList=[];
					<%for(GenreDto grandchildDto : genreDao.childGenreList(childDto.getGenreNo())){%>
						gchildList.push('<%=grandchildDto.getGenreName()%>')
					<%}
					if(childDto.getGenreName().equals("예술/대중문화")){%>
						map.set('예술', gchildList);
					<%}else{%>
						map.set('<%=childDto.getGenreName()%>', gchildList);
					<%}%>
				<%}%>
				map.set('<%=genreDto.getGenreName()%>', childList);
			<%}%>

			let ch_genre_li;
			const top_genre_list = document.querySelectorAll(".top-genre li");
			const child_genre_list=document.querySelector(".child-genre>ul")
			const g_child_genre_list=document.querySelector(".g-child-genre>ul")
			const show_genre1 = document.querySelector(".show_genre1");
			const show_genre2 = document.querySelector(".show_genre2");
			const show_genre3 = document.querySelector(".show_genre3");
			const show_genre = document.querySelector(".show_genre");
			const input_genre = document.querySelector(".input_genre");
			let isTwo;
			
				for(var i=0;i<top_genre_list.length;i++){
				top_genre_list[i].addEventListener("click",function(){
					isTwo = false;
					show_genre.style.visibility='hidden'
					for(var j=0;j<top_genre_list.length;j++){
						top_genre_list[j].style.color="rgba(0,0,0,0.8)";
					}
					this.style.color="#ff9f43";
					if(this.innerHTML=='만화' || this.innerHTML=='시/에세이'){
						isTwo=true;
					}
					ch_genre_li=map.get(this.innerHTML);
					show_genre1.innerHTML=this.innerHTML;
					while ( child_genre_list.hasChildNodes() ) { 
						child_genre_list.removeChild( child_genre_list.firstChild ); 
					}
					while ( g_child_genre_list.hasChildNodes() ) { 
						g_child_genre_list.removeChild( g_child_genre_list.firstChild ); 
					}
					liList=[];
					for(var j=0;j<ch_genre_li.length;j++){
						var tem_li= document.createElement("li");	
						var tem_text=document.createTextNode(ch_genre_li[j]);
						tem_li.appendChild(tem_text);
						liList.push(tem_li);
						child_genre_list.appendChild(tem_li);
					}
					
					if(isTwo){
						for(var j=0;j<liList.length;j++){
							liList[j].addEventListener('click',function(){
								let cli = this.parentElement.children;
								for(var k=0;k<cli.length;k++){
									cli[k].style.color="rgba(0,0,0,0.8)";
								}
								this.style.color="#ff9f43";
								show_genre2.innerHTML=' > '+this.innerHTML
								input_genre.value=this.innerHTML;
								show_genre3.innerHTML=""
								show_genre.style.visibility='visible'
							});
						}
					}else{
						for(var j=0;j<liList.length;j++){
							liList[j].addEventListener('click',function(){
								let cli = this.parentElement.children;
								for(var k=0;k<cli.length;k++){
									cli[k].style.color="rgba(0,0,0,0.8)";
								}
								this.style.color="#ff9f43";
								if(this.innerHTML=="예술/대중문화"){
									ch_genre_li=map.get('예술');
								}else{									
									ch_genre_li=map.get(this.innerHTML);
								}
								show_genre2.innerHTML=' > '+this.innerHTML
								while ( g_child_genre_list.hasChildNodes() ) { 
									g_child_genre_list.removeChild( g_child_genre_list.firstChild ); 
								}
								liList=[];
								for(var k=0;k<ch_genre_li.length;k++){
									var tem_li= document.createElement("li");	
									var tem_text=document.createTextNode(ch_genre_li[k]);
									tem_li.appendChild(tem_text);
									liList.push(tem_li);
									g_child_genre_list.appendChild(tem_li);
								}
								
								for(var k=0;k<liList.length;k++){
									liList[k].addEventListener('click',function(){
										let gcli = this.parentElement.children;
										for(var q=0;q<gcli.length;q++){
											gcli[q].style.color="rgba(0,0,0,0.8)";
										}
										this.style.color="#ff9f43";
										show_genre3.innerHTML=' > '+this.innerHTML
										input_genre.value=this.innerHTML;
										show_genre.style.visibility='visible'
									})
								}
							});
						}
					}
					
					
				});
			}
		});
	</script>
</body>
</html>