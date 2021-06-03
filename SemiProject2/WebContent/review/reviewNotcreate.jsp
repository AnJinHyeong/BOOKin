<%@page import="semi.beans.PurchaseDto"%>
<%@page import="semi.beans.ReviewBookDto"%>
<%@page import="semi.beans.BookDto"%>
<%@page import="semi.beans.BookDao"%>
<%@page import="java.util.List"%>
<%@page import="semi.beans.ReviewDao"%>
<%@page import="semi.beans.ReviewDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%ReviewDto reviewDto = new ReviewDto(); 
ReviewDao reviewDao = new ReviewDao();
int memberno=(Integer)session.getAttribute("member");


List<ReviewBookDto> reviewList = reviewDao.ReviewPurchaselist();
BookDao bookDao =new BookDao();
				


%>

<div class="container-1200">
	<div class="row">
		
		<%if(reviewDto.getReviewNo()==0){%>
			<h2>작성할 리뷰</h2>	
				<table>
					<thead>
					<tr>
						<th>리뷰 번호</th>
						<th>리뷰 내용</th>
						<th>평점</th>
						
						 <th>책 제목</th>	
						 <th>책이미지</th>
					</tr>
					</thead>
				<tbody>
				<%for(ReviewBookDto  reviewBookDto : reviewList) { %>
						<tr>
							<th><%=reviewBookDto.getReviewNo() %></th>
							<th><%=reviewBookDto.getReviewContent() %></th>
							<th><%=reviewBookDto.getReviewRate() %></th>
							<th><%=bookDao.get(reviewBookDto.getBookNo()).getBookTitle()%></th>
							<th><img src="<%=bookDao.get(reviewBookDto.getBookNo()).getBookImage()%>"></th>
							
					
					
					<%} %>
				<%} %>
				
				
				
				</tbody>
				
				</table>
			

			
			
			
			
			
			
			
			
			
			
			
		
		
	
	</div>
    </div>
    
    
    
    
 