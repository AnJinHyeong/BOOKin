<%@page import="java.util.List"%>
<%@page import="semi.beans.GenreDto"%>
<%@page import="semi.beans.GenreDao"%>
<%@page import="semi.beans.BookDto"%>
<%@page import="semi.beans.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int no = Integer.parseInt(request.getParameter("no"));

	BookDao bookDao = new BookDao();
	BookDto bookDto = bookDao.get(no);
	
	int price=bookDto.getBookPrice(); //정가
	int discount=bookDto.getBookDiscount(); //할인가
	int priceDif=price-discount; //정가-할인가
	int discountPercent=price/priceDif;//할인율
	int newDiscount=0;
	

	GenreDao genreDao=new GenreDao();
	GenreDto genreDto=genreDao.get(bookDto.getBookGenreNo());
	List<GenreDto> genreList2=genreDao.topGenreList(); 	
	GenreDto genreDto1=genreDao.getTopGenre(bookDto.getBookGenreNo());
	List<GenreDto> genreList1;
	GenreDto genreDto2=genreDao.get(genreDto1.getGenreParents());
	
	
	
	 
	
%>
<style>
.thumb {
    width: 100px;
    height: 100px;
   
}
.book-preview-image{
	margin-top:15px;
	
}
.file-edit-icon{
 	margin-left:0px;
 	margin-top:15px;
 	margin-bottom:-13px;
}
</style>    
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-500">

	<div class="row">
		<h1>책 정보 수정</h1>
	</div>
	
	<form action="bookEdit.kh" method="post">
		<input type="hidden" name="book_no" value="<%=bookDto.getBookNo()%>">
	
		<div class="row text-left">
			<label>제목</label>	
			<input type="text" name="book_title" class="form-input form-input-underline" required autocomplete="off" value="<%=bookDto.getBookTitle()%>">
		</div>
		
		 
		 <div class="row text-left">
		 <label>이미지</label>
  			<div class="form-input form-input-underline">
  				
			    <div id="preview" ><img src="<%=bookDto.getBookImage()%>" class="book-preview-image"></div>
			    <div class="file-edit-icon">
				    <span><a href="#" class="preview-edit form-btn">수정</a></span>
				    <span><a href="#" class="preview-de form-btn">삭제</a></span>
			     	</div>
			     <div style="visibility:hidden;">
			     	<input type="file" name="file" id="file" class="upload-box upload-plus" accept="image/*">   
			     	<input type="hidden" name="book_image" value="<%=bookDto.getBookImage() %>">
			     </div>
			     
			    
			      
			    
		    </div>
		</div> 
		
		<div class="row text-left">
		<label>저자</label>	
			<input type="text" name="book_author" class="form-input form-input-underline" required autocomplete="off" value="<%=bookDto.getBookAuthor()%>">
		</div>
		
		<div class="row text-left">
			<label>정가</label>	
			<input id="price" type="text" name="book_price" required class="form-input form-input-underline" autocomplete="off" value="<%=bookDto.getBookPrice()%>">
		</div>
		<div class="row text-left">
			<label>할인율(%)</label>	
			<input id="discount-percent" type="text" required class="form-input form-input-underline" autocomplete="off" value="<%=discountPercent%>" >
			<div id="price-print" class="site-color-red"></div>
 			<input type="hidden" name="book_discount" value="<%=bookDto.getBookDiscount()%>">
		</div>
		
		
		<div class="row text-left">
			<label>책 정보</label>	
			<textarea name="book_description" class="form-input form-input-underline" autocomplete="off">
			<%=bookDto.getBookDescription()%>
			</textarea>
		</div>
		
		
		
	<div class="row text-left">
		<label>출판사</label>	
			<input type="text" name="book_publisher" class="form-input form-input-underline" required autocomplete="off" value="<%=bookDto.getBookPublisher()%>">
		</div>
		
		
		
		<%-- <div class="row text-left" >
		<label>장르</label>	
		<div> 
		 <select data-id="a" name="top-genre" id="top-genre">
				<option value=<%=bookDto.getBookGenreNo()%> selected><%=genreDto2.getGenreName()%></option>
			<%for(int i=0;i<genreList2.size();i++){ %>
				
					<option value=<%=i%>><%=genreList2.get(i).getGenreName()%></option>
				
			<%} %>
		</select>
		<!--selected 된 값의 최상위 부모 값을 넣어야 함  
		근데 selected된 값을 html로 어떻게 가져오는지 ..ㅎ-->
		<%genreList1=genreDao.childGenreList(160);%> 
		
		<select data-id="b" name="middle-genre" id="middle-genre">
			<option value="" selected><%=genreDto1.getGenreName() %></option>
			
			
		</select>
		<select data-id="c" name="last-genre" id="last-genre">
			<option value=""selected><%=genreDto.getGenreName() %></option>
		</select> 
		</div> 

			
		</div>
 --%>		 
			
			
			
				
		<div class="row">
			<input type="submit" value="책 정보 수정" class="form-btn form-btn-negative">
		</div>
		
	</form>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>

	//이미지파일
	console.log()
	function handleFileSelect(event) {
	    var input = this;
	    console.log(input.files)
	    if (input.files && input.files.length) {
	        var reader = new FileReader();
	        this.enabled = false
	        reader.onload = (function (e) {
	        console.log(e)
	            $("#preview").html(['<img class="thumb" src="', e.target.result, '" title="', escape(e.name), '"/>'].join(''))
	        });
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	$('#file').change(handleFileSelect);
	$('.file-edit-icon').on('click', '.preview-de', function () {
	    $("#preview").empty()
	    $("#file").val("");
	});
	$('.preview-edit').click( function() {
	  $("#file").click();
	} );

	//할인가 계산
	 $(function(){
			$("#discount-percent").change(function(){
			var price=$("#price").val();
			var discountPercent=$(this).val();
			var newDiscountPrice=price*(100-discountPercent)/100;
			/*alert("할인가: "+newDiscountPrice+"원"); */
			document.getElementById("price-print").innerHTML="할인가: "+newDiscountPrice+"원";
			$("input[name=book_discount]").val(newDiscountPrice);
		});
	}); 
	
	//다중 select문 구현
	
	$(function() {
		
		$("select[data-id=a]").change(function() {
			var temp = $("select[data-id=b]");
			var a = $(this).val();
			temp.children().remove();
			temp.append('<option value="">선택하세요</option>');
			
			<%genreList1=genreDao.childGenreList(genreDto1.getGenreParents());%> 
			var middleGenre=[];
			
			<%for(int i=0;i<genreList1.size();i++){%>	
			middleGenre.push("<%=genreList1.get(i).getGenreName()%>");
			<%}%>
			console.log(middleGenre)
			
			
			
			/* 
			var middleGenre0=['국내여행','해외여행','테마여행','지도/지리'];
			var middleGenre1=['경제','경영','마케팅/세일즈','제테크/투자','창업/취업'];
			var middleGenre2=['웹/컴퓨터입문/활용','IT전문서','그래픽/멀티미디어','오피스활용도서','컴퓨터수험서'];
			var middleGenre3=['교양만화','드라마','성인만화','순정만화','스포츠만화','SF/판타지','액션/무협만화','명랑/코믹만화','공포/추리','학원만화','웹툰/카툰에세이','기타만화','일본어판만화','영문판만화'];
			 */
			
			 if(a == '0'){
				for(var i=0;i<middleGenre.length;i++){
					temp.append("<option value=0"+i+">"+middleGenre[i]+"</option>");
				}
			}
			else if(a == '1'){
				for(var i=0;i<middleGenre.length;i++){
					temp.append("<option value=1"+i+">"+middleGenre[i]+"</option>");
				}
			}
			else if(a == '2'){
				for(var i=0;i<middleGenre.length;i++){
					temp.append("<option value=2"+i+">"+middleGenre[i]+"</option>");
				}
			}
			else if(a == '3'){
				for(var i=0;i<middleGenre.length;i++){
					temp.append("<option value=3"+i+">"+middleGenre[i]+"</option>");
				}
				}
			else if(a == '4'){
				for(var i=0;i<middleGenre.length;i++){
					temp.append("<option value=4"+i+">"+middleGenre[i]+"</option>");
				}
				}
			else if(a == '5'){
				for(var i=0;i<middleGenre.length;i++){
					temp.append("<option value=5"+i+">"+middleGenre[i]+"</option>");
				}
				}
			else if(a == '6'){
				for(var i=0;i<middleGenre.length;i++){
					temp.append("<option value=6"+i+">"+middleGenre[i]+"</option>");
				}
				}
			else if(a == '7'){
				for(var i=0;i<middleGenre.length;i++){
					temp.append("<option value=7"+i+">"+middleGenre[i]+"</option>");
				}
				}  
			}); 
		$("select[data-id=b]").change(function() {
			var temp = $("select[data-id=c]");
			var b = $(this).val();
			temp.children().remove();
			temp.append('<option value="">선택하세요</option>');
			
			var childGenre=[];
			<%-- <%for(int i=0;i<middelGenre.size();i++){%>	
			childGenre.push(middleGenre[i]);
			<%}%> --%>
			
			if(b == '00'){
				for(var i=0;i<childGenre.length;i++){
					temp.append("<option value=0.00.00"+i+">"+childGenre[i]+"</option>");
				}		
			}
			else if(b == '01'){
				for(var i=0;i<childGenre.length;i++){
					temp.append("<option value=0.01.00"+i+">"+childGenre[i]+"</option>");
				}
			}
			else if(b == '02'){
				for(var i=0;i<childGenre.length;i++){
					temp.append("<option value=0.02.00"+i+">"+childGenre[i]+"</option>");
				}
			}
			else if(b == '03'){
				for(var i=0;i<childGenre.length;i++){
					temp.append("<option value=0.03.00"+i+">"+childGenre[i]+"</option>");
				}
				}
			else if(b == '10'){
				for(var i=0;i<childGenre.length;i++){
					temp.append("<option value=0.10.00"+i+">"+childGenre[i]+"</option>");
				}
				}
			});
	}); 
	
			
	

		
</script>
<jsp:include page="/template/footer.jsp"></jsp:include>