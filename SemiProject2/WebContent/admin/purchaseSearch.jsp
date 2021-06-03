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
    		bookList.add(bookDto);
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
				
				
				<ol class="pagination-list pagination" style="margin:30px;margin-left: 32%;">
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
	</script>
</body>
</html>