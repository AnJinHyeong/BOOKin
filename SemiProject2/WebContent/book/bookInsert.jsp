<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-500">
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
    <script type="text/javascript">
        $(function() {
            $("#filename").on('change', function(){
                readURL(this);
            });
        });
        function readURL(input) {
            if (input.files && input.files[0]) {
               var reader = new FileReader();
               reader.onload = function (e) {
                  $('#preImage').attr('src', e.target.result);
               }
               reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
	<div class="row">
		<h1>정보 등록</h1>
	</div>
	
	<form action="bookInsert.kh" method="post" enctype="multipart/form-data">
		<div class="row text-left">
		
			<label>책이름</label>	
			<input type="text" name="book_title" class="form-input form-input-underline" required autocomplete="off">
		
		</div>
		
		<div class="row text-left">
		
			<label>책이미지</label>	
	<input type="file" id="filename" name="book_image" class="form-input form-input-underline" required autocomplete="off">
	<img id="preImage" src="${pageContext.request.contextPath}/saveFile/${noticeVO.filename}" alt="image_title" onerror='this.src="${pageContext.request.contextPath}/images/no_img.jpg"'/>
		</div>
	
		
		
		<div class="row text-left">
			<label>저자</label>	
			<input type="text" name="book_author" required class="form-input form-input-underline" autocomplete="off">
		</div>
		
		<div class="row text-left">
			<label>정가</label>	
			<input type="text" name="book_price" required class="form-input form-input-underline" autocomplete="off">
		</div>
		
		<div class="row text-left">
			<label>할인가</label>	
			<input type="text" name="book_discount" class="form-input form-input-underline" autocomplete="off">
		</div>
		<div class="row text-left">
			<label>출판사</label>	
			<input type="text" name="book_publisher" required class="form-input form-input-underline" autocomplete="off">
		</div>
		
		<div class="row text-left">
			<label>책소개</label>	
			<textarea name="book_description" class="form-input form-input-underline" autocomplete="off"></textarea>
		</div>
		<div class="row text-left">
			<label>출간일</label>	
			<input type="text" name="book_pubdate" required class="form-input form-input-underline" autocomplete="off">
		</div>
		
		<div class="row text-left">
			<label>장르</label>	
			<input type="text" name="book_genre" required class="form-input form-input-underline" autocomplete="off">
		</div>
		
		<div class="row">
			<input type="submit" value="등록" class="form-btn form-btn-positive">
		</div>
		
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>