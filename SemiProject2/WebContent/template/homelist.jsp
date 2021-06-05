<%@page import="semi.beans.BookLikeDao"%>
<%@page import="semi.beans.BookLikeDto"%>
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
	int member;
	boolean isLogin;
	
	List<BookLikeDto> bookLikeList;
	try{
		member = (int)session.getAttribute("member");
		isLogin = true;
		BookLikeDao bookLikeDao = new BookLikeDao();
		bookLikeList = bookLikeDao.list(member);
	}
	catch(Exception e){
		member = 0;
		isLogin = false;
		bookLikeList = null;
	}	
%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
		<%if(isLogin){%>
			<%for(BookLikeDto bookLikeDto : bookLikeList){%>
				$("#like<%=bookLikeDto.getBookOrigin()%>").removeClass("book-good");
				$("#like<%=bookLikeDto.getBookOrigin()%>").addClass("book-good-on");
			<%}%>
		<%}%>
		
		$.fn.initBookLike = function(){
			<%if(isLogin){%>
				<%for(BookLikeDto bookLikeDto : bookLikeList){%>
					$("#like<%=bookLikeDto.getBookOrigin()%>").removeClass("book-good");
					$("#like<%=bookLikeDto.getBookOrigin()%>").addClass("book-good-on");
				<%}%>
			<%}%>
		
			$(".book-like").click(function(){
				if(<%=member %> == 0){
					alert("로그인이 필요한 기능입니다.");
					return;
				}
				var type;
				
				if($(this).hasClass("book-good")){
					$(this).removeClass("book-good");
					$(this).addClass("book-good-on");
					type = "insert";
				}
				else{
					$(this).removeClass("book-good-on");
					$(this).addClass("book-good");
					type = "delete";
				}			
				
				var url = "<%=root%>/book/bookLike.kh";
				$.ajax({
					type:"GET",
					url:url,
					dataType:"html",
					data:{
						type : type,
						memberNo : <%=member%>,
						bookOrigin : $(this).attr("id")
					},
					error : function(request,status,error){
						alert("이미 좋아요한 상품입니다."); //에러 상태에 대한 세부사항 출력						
					}
				});
			});	
		};
		
		$.fn.initBookLike();
	});
</script>
<link rel="stylesheet" type="text/css" href="<%= root%>/css/list.css">


<div class="container-1200 inf-container">
<div class=" book-list inf-list">
	<%for(BookDto bookDto : bookList){ %>
	<div class="book-item">	
		<a href="<%=root%>/book/bookDetail.jsp?no=<%=bookDto.getBookNo()%>" class="book-img-a" >
		<%if(bookDto.getBookImage()==null){
			bookDto.setBookImage(root+"/image/nullbook.png");
		} %>
			<%if(bookDto.getBookImage().startsWith("https")){ %>
			<img title="<%=bookDto.getBookTitle() %>" class="book-img" src="<%=bookDto.getBookImage()%>">
			<%}else{ %>
			<img title="<%=bookDto.getBookTitle() %>" class="book-img" src="<%=root%>/book/bookImage.kh?bookNo=<%=bookDto.getBookNo()%>">
			<%} %>

		</a>
		
		<a href="javascript:void(0);" class="book-like book-good" id="like<%=bookDto.getBookNo()%>"></a> 
		<a class="book-publisher"><span><%=bookDto.getBookPublisher() %></span></a>
		<a href="<%=root%>/book/bookDetail.jsp?no=<%=bookDto.getBookNo()%>" class="book-title overflow"  title="<%=bookDto.getBookTitle() %>"><%=bookDto.getBookTitle() %></a>
		<%if(bookDto.getBookAuthor()==null){
			bookDto.setBookAuthor("편집부");
		} %>
		<a class="book-author overflow" title="<%=bookDto.getBookAuthor() %>"><%=bookDto.getBookAuthor() %></a>

	<%if(bookDto.getBookDiscount()!=0 && bookDto.getBookDiscount()!=bookDto.getBookPrice()){ %>
		<div style="width: 100%;text-align: right;">
		<a class="book-discount"><%=(int)(((double)(bookDto.getBookPrice()-bookDto.getBookDiscount())/(double)bookDto.getBookPrice())*(100.0))%>%</a>
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
			if(page<10){
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

			$.fn.initBookLike();
			}
		};
	});
</script>


