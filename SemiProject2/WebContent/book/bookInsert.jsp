<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-500">

	<div class="row">
		<h1>정보 등록</h1>
	</div>
	
	<form action="bookInsert.kh" method="post">
		<div class="row text-left">
			<label>이름</label>	
			<input type="text" name="book_name" class="form-input form-input-underline" required autocomplete="off">
		</div>
		
		<div class="row text-left">
			<label>저자</label>	
			<input type="text" name="book_writer" class="form-input form-input-underline" required autocomplete="off">
		</div>
		
		
		<div class="row text-left">
			<label>출판사</label>	
			<input type="text" name="book_publisher" required class="form-input form-input-underline" autocomplete="off">
		</div>
		
		<div class="row text-left">
			<label>장르</label>	
			<input type="text" name="book_genre" required class="form-input form-input-underline" autocomplete="off">
		</div>
		
		<div class="row text-left">
			<label>출판사</label>	
			<select name="book_nation">
			<option value="">선택하세요</option>
				<option>국내도서</option>
				<option>해외도서</option>
			</select>
		</div>
		<div class="row text-left">
			<label>가격</label>	
			<input type="text" name="book_price" required class="form-input form-input-underline" autocomplete="off">
		</div>
		
		<div class="row text-left">
			<label>책소개</label>	
			<input type="text" name="book_info" required class="form-input form-input-underline" autocomplete="off">
		</div>
		<div class="row text-left">
			<label>책이미지</label>	
			<input type="text" name="book_img" required class="form-input form-input-underline" autocomplete="off">
		</div>
		
		<div class="row text-left">
			<label>목차</label>	
			<input type="text" name="book_table" required class="form-input form-input-underline" autocomplete="off">
		</div>
		<div class="row text-left">
			<label>출간일</label>	
			<input type="text" name="book_start" required class="form-input form-input-underline" autocomplete="off">
		</div>
		
		
		<div class="row">
			<input type="submit" value="등록" class="form-btn form-btn-positive">
		</div>
		
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>