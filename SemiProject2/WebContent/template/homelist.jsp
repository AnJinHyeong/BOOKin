<%@page import="java.text.DecimalFormat"%>
<%@page import="semi.beans.GenreDto"%>
<%@page import="semi.beans.GenreDao"%>
<%@page import="semi.beans.BookDto"%>
<%@page import="java.util.List"%>
<%@page import="semi.beans.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String root = request.getContextPath();
	BookDao bookdao = new BookDao();
	int infPage;
	if(request.getParameter("page")!=null){
		infPage=Integer.parseInt(request.getParameter("page"));
	}else{
		infPage=1;
	}
	List<BookDto> bookList;
	if(request.getParameter("genre")!=null){
		Long genreNo =Long.parseLong(request.getParameter("genre"));
		bookList=bookdao.genreList(genreNo, infPage);
	}else{
 		bookList =bookdao.list(infPage);
	}
	
	
	DecimalFormat format = new DecimalFormat("###,###");
%>
<link rel="stylesheet" type="text/css" href="<%= root%>/css/list.css">


<div class="container-1200 inf-container">
<div class=" book-list inf-list">
	<%for(BookDto bookDto : bookList){ %>
	<div class="book-item">
		<a href="<%=root%>/book/bookDetail.jsp?no=<%=bookDto.getBookNo()%>" class="book-img-a">
		<%if(bookDto.getBookImage()==null){
			bookDto.setBookImage(root+"/image/nullbook.png");
		} %>
			<img title="<%=bookDto.getBookTitle() %>" class="book-img" src="<%=bookDto.getBookImage()%>">
		</a>
		<a class="book-publisher"><span><%=bookDto.getBookPublisher() %></span></a>
		<a href="<%=root%>/book/bookDetail.jsp?no=<%=bookDto.getBookNo()%>" class="book-title overflow"  title="<%=bookDto.getBookTitle() %>"><%=bookDto.getBookTitle() %></a>
		<%if(bookDto.getBookAuthor()==null){
			bookDto.setBookAuthor("편집부");
		} %>
		<a class="book-author overflow" title="<%=bookDto.getBookAuthor() %>"><%=bookDto.getBookAuthor() %></a>

	<%if(bookDto.getBookDiscount()!=0 && bookDto.getBookDiscount()!=bookDto.getBookPrice()){ %>
		<div style="width: 100%;text-align: right;">
		<a class="book-discount"><%=bookDto.getBookPrice()/(bookDto.getBookPrice()-bookDto.getBookDiscount())%>%</a>
		<a class="book-price"><%=format.format(bookDto.getBookDiscount()) %></a><a style="font-weight: 900;color:rgba(0,0,0,0.5);"> 원</a>
		</div>
	<%}else{ %>
		<div style="width: 100%;text-align: right;">
		
		<a class="book-price"><%=format.format(bookDto.getBookPrice()) %></a><a style="font-weight: 900;color:rgba(0,0,0,0.5);"> 원</a>
		</div>
	<%} %>
	</div>   
	<%} %>
	</div>
</div>
<div class="inf-pagination"></div>
<script>
	window.addEventListener("load",function(){
		
		var inf_pagination = document.querySelector('.inf-pagination');
		var inf_container = document.querySelector('.inf-container');
		var screenHeight = screen.height;
		let oneTime = false;
		
		var page=1;
		document.addEventListener('scroll',function(){
			var fullHeight = inf_container.clientHeight;
			var scrollPosition = pageYOffset;
			console.log(fullHeight);
			if (fullHeight-screenHeight/2 <= scrollPosition && !oneTime) {
				 oneTime = true;
				 madeBox(); 
			}
		});
		
		function madeBox(){
			page+=1;
			const URLSearch = new URLSearchParams(location.search);
			URLSearch.set('page', String(page));
			const newParam = URLSearch.toString();
			const nextURL='<%=root%>/template/homelist.jsp?'+newParam;
			console.log('<%=root%>/template/homelist.jsp?'+newParam);
			const xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function() {
				if (xhr.readyState === xhr.DONE) { 
				    if (xhr.status === 200 || xhr.status === 201) {
				      const data = xhr.response; // 다음페이지의 정보
				      const addList = data.querySelector('.inf-list'); // 다음페이지에서 list아이템을 획득
				      inf_container.appendChild(addList); // infinite에 list를 더해주기
				      oneTime = false; // oneTime을 다시 false로 돌려서 madeBox를 불러올 수 있게 해주기
				    } else {
				      console.error(xhr.response);
				    }
				 }
			};
			
			xhr.open('GET', nextURL); 
			xhr.send();
			xhr.responseType = "document";
			
		};
	});
</script>


