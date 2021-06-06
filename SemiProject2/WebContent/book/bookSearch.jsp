 <%@page import="semi.beans.GenreDao"%>
<%@page import="semi.beans.BookDto"%> 
 <%@page import="semi.beans.BookDao"%> 
 <%@page import="java.util.List"%> 
 <%@ page language="java" contentType="text/html; charset=UTF-8" 
     pageEncoding="UTF-8"%> 

<% 
	String root = request.getContextPath();
	String keyword = request.getParameter("keyword");
	String type=request.getParameter("type");
	String typeToKor=null;
	
	BookDao bookDao = new BookDao();
	GenreDao genreDao = new GenreDao();
	
	List<BookDto> bookTitleList=null;
	List<BookDto> bookAuthorList=null;
	List<BookDto> bookPublisherList=null;
	List<BookDto> bookList=null;
	
	int titleCount=0;
	int authorCount=0;
	int publisher=0;
	int count=0;
	int pageNo=0;
	
	int startBlock=0;
	int endBlock =0;
	if(type==null){
		
	int startRow=1;
	int endRow=5;
	
	bookTitleList=bookDao.titleSearch(keyword, startRow, endRow);
	bookAuthorList=bookDao.authorSearch(keyword, startRow, endRow);
	bookPublisherList=bookDao.publisherSearch(keyword, startRow, endRow);
	
	titleCount=bookDao.getTitleCount(keyword);
	authorCount=bookDao.getAuthorCount(keyword);
	publisher=bookDao.getPublisherCount(keyword);
	
	}else{
		pageNo = Integer.parseInt(request.getParameter("pageNo"));
		
		int pageSize=20;
		int blockSize=10;
		int startRow=pageNo*20-19;
		int endRow=pageNo*20;
		
		if(type.equals("title")){
			count=bookDao.getTitleCount(keyword);
			bookList=bookDao.titleSearch(keyword, startRow, endRow);
			typeToKor="책 제목";
		}else if(type.equals("autor")){
			count=bookDao.getAuthorCount(keyword);
			bookList=bookDao.authorSearch(keyword, startRow, endRow);
			typeToKor="저자";
		}else{
			count=bookDao.getPublisherCount(keyword);
			bookList=bookDao.publisherSearch(keyword, startRow, endRow);
			typeToKor="출판사";
		} 
		
		startBlock = (pageNo-1)/blockSize*blockSize+1;
     	endBlock = startBlock+blockSize-1;
     	
    	int lastBlock = (count + pageSize - 1) / pageSize;
    	
    	if(endBlock > lastBlock){//범위를 벗어나면
    		endBlock = lastBlock;//범위를 수정
    	}
	}
	
	int member;
	try {
		member = (int) session.getAttribute("member");
	} catch (Exception e) {
		member = 0;
	}	
%>
<link rel="stylesheet" type="text/css" href="<%= root%>/css/search.css">
<link rel="stylesheet" type="text/css" href="<%= root%>/css/common.css">

<jsp:include page="/template/searchHeader.jsp"></jsp:include>
<style>
.search-page-btn{
    width: 100;
    height: 30;
    padding-top: 5px;
    display: block;
    font-size: 15px;
    padding-left: 0;
    padding-right: 0;
    text-align: center;
}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
		$(".go-to-cart").click(function(){
			var form = $(this).next();
			var hidden = form.children();
			var data = [];
			
			hidden.each(function(){
				data.push($(this).val());
			});			
									
			var url = "<%=root%>/member/searchToCartInsert.kh";
			
			console.log(url);
			$.ajax({
				type:"POST",
				url: url,
				dataType:"html",
				data:{
					cartAmount : data[0],
					memberNo : data[1],
					bookNo : data[2]
				},
				error : function(request,status,error){
					alert('code:'+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); //에러 상태에 대한 세부사항 출력
					alert(e);
				}
			});
			
			alert("장바구니에 담겼습니다.");
		});
	});
</script>
<div class="container-1200 align-column">

<%if(type==null){ %>
	<div class="search-head" style="margin-top:-40px;align-self: flex-start;">
		<span>책 제목에서 <span class="keyword">'<%=keyword %>'</span> 검색결과 <%=titleCount%></span>
	</div>
	<div class="search-list-area align-column">
	<%for(BookDto bookDto:bookTitleList){ %>
		<div class="align-row space-between search-list">
			<a href="bookDetail.jsp?no=<%=bookDto.getBookNo()%>">			
			
			<%if(bookDto.getBookImage().startsWith("https")){ %>
			<img title="<%=bookDto.getBookTitle() %>" class="search-img" src="<%=bookDto.getBookImage()%>">
			<%}else{ %>
			<img title="<%=bookDto.getBookTitle() %>" class="search-img" src="<%=root%>/book/bookImage.kh?bookNo=<%=bookDto.getBookNo()%>">
			<%} %>
			
			</a>
			<div class="book-info">
				<span>[<%=genreDao.get(bookDto.getBookGenreNo()).getGenreName() %>]</span>
				<a class="search-book-title" href="bookDetail.jsp?no=<%=bookDto.getBookNo()%>"><span class="overflow block" title="<%=bookDto.getBookTitle()%>"><%=bookDto.getBookTitle() %></span></a>
				<span class="author_pub"><%=bookDto.getBookAuthor()%> | <%=bookDto.getBookPublisher()%> | <%=bookDto.getBookPubDate() %></span>
				<span><%=bookDto.getBookDescription()%></span>
			</div>
			<div class="search-book-review">				
				<span>조회수 <%=bookDto.getBookView()%></span>
			</div>
			<div class="search-book-price">
			
			<%if(bookDto.getBookDiscount()!=0 &&bookDto.getBookDiscount()!=bookDto.getBookPrice()){ %>
				<span><%=bookDto.getBookPrice()%> 원 <span class="discount-rate">[<%=bookDto.getBookPrice()/(bookDto.getBookPrice()-bookDto.getBookDiscount())%>%↓]</span></span>
				<span class="final-price"><%=bookDto.getBookDiscount()%> 원</span>
			<%}else{ %>
				<span class="final-price"><%=bookDto.getBookPrice()%> 원</span>
			<%}; %>
			</div>
			<div class="search-book-review search-button">
				<a class="search-page-btn" href="<%=root %>/purchase/purchase.jsp?no=<%=bookDto.getBookNo()%>">바로구매</a>
				<a class="search-page-btn go-to-cart" href="javascript:void(0);">장바구니</a>
				<form action="<%=root %>/member/cartInsert.kh" method="post" class="searchToCartInsert">
					<input type="hidden" name="cartAmount" value="1">                  
					<input type="hidden" name="memberNo" value="<%=member %>">
					<input type="hidden" name="bookNo" value="<%=bookDto.getBookNo() %>"> 				
               </form>				
			</div>
		</div>
	<%} %>
	<%if(titleCount==0){ %>
	<span class="nosearch">검색결과가 없습니다</span>
	<%}else if(titleCount>5){ %>
	<a class="search-more" href="?pageNo=1&type=title&keyword=<%=keyword%>">더보기 &gt;</a>
	<%}else{ %>
	<%} %>
	</div>
	
	<div class="search-head search-head-margintop" >
		<span >저자에서 <span class="keyword">'<%=keyword %>'</span> 검색결과 <%=authorCount%></span>
	</div>
	
	<div class="search-list-area align-column">
	<%for(BookDto bookDto:bookAuthorList){ %>
		<div class="align-row space-between search-list">
			<a href="bookDetail.jsp?no=<%=bookDto.getBookNo()%>">
			
			<%if(bookDto.getBookImage().startsWith("https")){ %>
			<img title="<%=bookDto.getBookTitle() %>" class="search-img" src="<%=bookDto.getBookImage()%>">
			<%}else{ %>
			<img title="<%=bookDto.getBookTitle() %>" class="search-img" src="<%=root%>/book/bookImage.kh?bookNo=<%=bookDto.getBookNo()%>">
			<%} %>
			
			</a>
			<div class="book-info">
				<span>[<%=genreDao.get(bookDto.getBookGenreNo()).getGenreName() %>]</span>
				<a class="search-book-title" href="bookDetail.jsp?no=<%=bookDto.getBookNo()%>"><span class="overflow block" title="<%=bookDto.getBookTitle()%>"><%=bookDto.getBookTitle() %></span></a>
				<span class="author_pub"><%=bookDto.getBookAuthor()%> | <%=bookDto.getBookPublisher()%> | <%=bookDto.getBookPubDate() %></span>
				<span><%=bookDto.getBookDescription()%></span>
			</div>
			<div class="search-book-review">
				<span>4/5</span>
				<span>리뷰 200</span>
			</div>
			<div class="search-book-price">
			
			<%if(bookDto.getBookDiscount()!=0 &&bookDto.getBookDiscount()!=bookDto.getBookPrice()){ %>
				<span><%=bookDto.getBookPrice()%> 원 <span class="discount-rate">[<%=bookDto.getBookPrice()/(bookDto.getBookPrice()-bookDto.getBookDiscount())%>%↓]</span></span>
				<span class="final-price"><%=bookDto.getBookDiscount()%> 원</span>
			<%}else{ %>
				<span class="final-price"><%=bookDto.getBookPrice()%> 원</span>
			<%}; %>
			</div>
			<div class="search-book-review search-button">
				<a class="search-page-btn" href="<%=root %>/purchase/purchase.jsp?no=<%=bookDto.getBookNo()%>">바로구매</a>
				<a class="search-page-btn go-to-cart" href="javascript:void(0);">장바구니</a>
				<form action="<%=root %>/member/cartInsert.kh" method="post" class="searchToCartInsert">
					<input type="hidden" name="cartAmount" value="1">                  
					<input type="hidden" name="memberNo" value="<%=member %>">
					<input type="hidden" name="bookNo" value="<%=bookDto.getBookNo() %>"> 				
               </form>
			</div>
		</div>
	<%} %>
	<%if(authorCount==0){ %>
	<span class="nosearch">검색결과가 없습니다</span>
	<%}else if(authorCount>5){ %>
	<a class="search-more" href="?pageNo=1&type=author&keyword=<%=keyword%>">더보기 &gt;</a>
	<%}else{ %>
	
	<%} %>
	</div>
	
	
	<div class="search-head search-head-margintop" >
		<span >출판사에서 <span class="keyword">'<%=keyword %>'</span> 검색결과 <%=publisher%></span>
	</div>
	
	
	<div class="search-list-area align-column">
	<%for(BookDto bookDto:bookPublisherList){ %>
		<div class="align-row space-between search-list">
			<a href="bookDetail.jsp?no=<%=bookDto.getBookNo()%>">
			
			<%if(bookDto.getBookImage().startsWith("https")){ %>
			<img title="<%=bookDto.getBookTitle() %>" class="search-img" src="<%=bookDto.getBookImage()%>">
			<%}else{ %>
			<img title="<%=bookDto.getBookTitle() %>" class="search-img" src="<%=root%>/book/bookImage.kh?bookNo=<%=bookDto.getBookNo()%>">
			<%} %>
			
			</a>
			<div class="book-info">
				<span>[<%=genreDao.get(bookDto.getBookGenreNo()).getGenreName() %>]</span>
				<a class="search-book-title" href="bookDetail.jsp?no=<%=bookDto.getBookNo()%>"><span class="overflow block" title="<%=bookDto.getBookTitle()%>"><%=bookDto.getBookTitle() %></span></a>
				<span class="author_pub"><%=bookDto.getBookAuthor()%> | <%=bookDto.getBookPublisher()%> | <%=bookDto.getBookPubDate() %></span>
				<span><%=bookDto.getBookDescription()%></span>
			</div>
			<div class="search-book-review">
				<span>4/5</span>
				<span>리뷰 200</span>
			</div>
			<div class="search-book-price">
			
			<%if(bookDto.getBookDiscount()!=0 &&bookDto.getBookDiscount()!=bookDto.getBookPrice()){ %>
				<span><%=bookDto.getBookPrice()%> 원 <span class="discount-rate">[<%=bookDto.getBookPrice()/(bookDto.getBookPrice()-bookDto.getBookDiscount())%>%↓]</span></span>
				<span class="final-price"><%=bookDto.getBookDiscount()%> 원</span>
			<%}else{ %>
				<span class="final-price"><%=bookDto.getBookPrice()%> 원</span>
			<%}; %>
			</div>
			<div class="search-book-review search-button">
				<a class="search-page-btn" href="<%=root %>/purchase/purchase.jsp?no=<%=bookDto.getBookNo()%>">바로구매</a>
				<a class="search-page-btn go-to-cart" href="javascript:void(0);">장바구니</a>
				<form action="<%=root %>/member/cartInsert.kh" method="post" class="searchToCartInsert">
					<input type="hidden" name="cartAmount" value="1">                  
					<input type="hidden" name="memberNo" value="<%=member %>">
					<input type="hidden" name="bookNo" value="<%=bookDto.getBookNo() %>"> 				
               </form>
			</div>
		</div>
	<%} %>
	<%if(publisher==0){ %>
	<span class="nosearch">검색결과가 없습니다</span>
	<%}else if(publisher>5){ %>
		<a class="search-more" href="?pageNo=1&type=publisher&keyword=<%=keyword%>">더보기 &gt;</a>
	<%}else{ %>
	
	<%} %>
	</div>
	<%}else{ %>   <!-- request parameter에 type이 있을때 -->
	<div class="search-head" style="margin-top:-40px;align-self: flex-start;">
		<span><span class="keyword"><%=typeToKor %> '<%=keyword %>'</span> 검색결과 <%=count%></span>
	</div>
	
	
	
	<div class="search-list-area align-column">
	<%for(BookDto bookDto:bookList){ %>
		<div class="align-row space-between search-list">
			<a href="bookDetail.jsp?no=<%=bookDto.getBookNo()%>">
			
			<%if(bookDto.getBookImage().startsWith("https")){ %>
			<img title="<%=bookDto.getBookTitle() %>" class="search-img" src="<%=bookDto.getBookImage()%>">
			<%}else{ %>
			<img title="<%=bookDto.getBookTitle() %>" class="search-img" src="<%=root%>/book/bookImage.kh?bookNo=<%=bookDto.getBookNo()%>">
			<%} %>
			
			</a>
			<div class="book-info">
				<span>[<%=genreDao.get(bookDto.getBookGenreNo()).getGenreName() %>]</span>
				<a class="search-book-title" href="bookDetail.jsp?no=<%=bookDto.getBookNo()%>"><span class="overflow block" title="<%=bookDto.getBookTitle()%>"><%=bookDto.getBookTitle() %></span></a>
				<span class="author_pub"><%=bookDto.getBookAuthor()%> | <%=bookDto.getBookPublisher()%> | <%=bookDto.getBookPubDate() %></span>
				<span><%=bookDto.getBookDescription()%></span>
			</div>
			<div class="search-book-review">
				<span>4/5</span>
				<span>리뷰 200</span>
			</div>
			<div class="search-book-price">
			
			<%if(bookDto.getBookDiscount()!=0 &&bookDto.getBookDiscount()!=bookDto.getBookPrice()){ %>
				<span><%=bookDto.getBookPrice()%> 원 <span class="discount-rate">[<%=bookDto.getBookPrice()/(bookDto.getBookPrice()-bookDto.getBookDiscount())%>%↓]</span></span>
				<span class="final-price"><%=bookDto.getBookDiscount()%> 원</span>
			<%}else{ %>
				<span class="final-price"><%=bookDto.getBookPrice()%> 원</span>
			<%}; %>
			</div>
			<div class="search-book-review search-button">
				<a class="search-page-btn" href="<%=root %>/purchase/purchase.jsp?no=<%=bookDto.getBookNo()%>">바로구매</a>
				<a class="search-page-btn go-to-cart" href="javascript:void(0);">장바구니</a>
				<form action="<%=root %>/member/cartInsert.kh" method="post" class="searchToCartInsert">
					<input type="hidden" name="cartAmount" value="1">                  
					<input type="hidden" name="memberNo" value="<%=member %>">
					<input type="hidden" name="bookNo" value="<%=bookDto.getBookNo() %>"> 				
               </form>
			</div>
		</div>
	<%} %>
	</div>
	
	<ol class="pagination-list pagination" style="margin:30px">
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
		<input type="hidden" name="keyword" value="<%=keyword%>">
		<input type="hidden" name="type" value="<%=request.getParameter("type")%>">
		<input type="hidden" name="pageNo"/>
	</form>
	<%} %>
</div>
<script>
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
<jsp:include page="/template/footer.jsp"></jsp:include>