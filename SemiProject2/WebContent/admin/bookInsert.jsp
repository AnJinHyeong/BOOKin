<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="semi.beans.GenreDto"%>
<%@page import="java.util.List"%>
<%@page import="semi.beans.GenreDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
		String root = request.getContextPath();
    	GenreDao genreDao = new GenreDao();
    	List<GenreDto> topGenreList = genreDao.topGenreList();
	%>

<jsp:include page="/template/adminSidebar.jsp"></jsp:include>
	<section>
		<div class="admin-content_area">
			<div class="admin-content">
				<div class="admin-content_title">
					상품 등록
				</div>
			</div>
		</div>
		<form action="<%=root%>/book/bookInsert.kh" method="post" enctype="multipart/form-data">
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
		
		<div class="admin-content_area">
			<div class="admin-content">
				<div class="admin-content_title">
					책 제목
				</div>
				<div class="admin-input_text">
				<input type='text' name="bookTitle" required>
				</div>
			</div>
		</div>
		
		<div class="admin-content_area">
			<div class="admin-content ">
				<div class="admin-content_title">
					판매가
				</div>
				<div class="content_price">
					<span>정가</span>
					<input required type="number" placeholder="숫자만 입력" name="bookPrice">
					<span>원</span>
				</div>
				<div class="content_price">
					<span>판매가</span>
					<input type="number" placeholder="숫자만 입력" name="bookDiscount">
					<span>원</span>
				</div>
			</div>
		</div>
		
		<div class="admin-content_area">
			<div class="admin-content ">
				<div class="admin-content_title">
					상품 이미지
				</div>
				<div class='img-up-text'><span>이미지 등록</span></div>
				<label for="input-file">
				  <img class='admin-upload_img'>
				</label>
				<input class="input_img" required type="file" accept=".png, .jpg, .gif" id="input-file" name="bookImage" style="display: none"/>
			</div>
		</div>
		
		<div class="admin-content_area">
			<div class="admin-content">
				<div class="admin-content_title">
					책 소개
				</div>
				<div class="admin-input_text">
				<textarea name="bookDescription"></textarea>
				</div>
			</div>
		</div>
		
		<div class="admin-content_area">
			<div class="admin-content">
				<div class="admin-content_title">
					저자
				</div>
				<div class="admin-input_text">
				<input type='text' name="bookAuthor">
				</div>
			</div>
		</div>
		
		<div class="admin-content_area">
			<div class="admin-content">
				<div class="admin-content_title">
					출판사
				</div>
				<div class="admin-input_text">
				<input type='text' name="bookPublisher">
				</div>
			</div>
		</div>
		
		<div class="admin-content_area">
			<div class="admin-content">
				<div class="admin-content_title">
					출간일
				</div>
				<div class="admin-input_text">
				<input type="date" name="bookPubDate">
				</div>
			</div>
		</div>
		<button class="submit-btn">등록</button>
		</form>
	</section>
	<script>
		
		window.addEventListener("load",function(){
			function readImage(input) {
			    // 인풋 태그에 파일이 있는 경우
			    if(input.files && input.files[0]) {
			        // 이미지 파일인지 검사 (생략)
			        // FileReader 인스턴스 생성
			        const reader = new FileReader()
			        // 이미지가 로드가 된 경우
			        reader.onload = e => {
			            const previewImage = document.querySelector(".admin-upload_img")
			            previewImage.src = e.target.result
			        }
			        // reader가 이미지 읽도록 하기
			        reader.readAsDataURL(input.files[0])
			    }
			}
			// input file에 change 이벤트 부여
			const inputImage = document.querySelector(".input_img")
			inputImage.addEventListener("change", e => {
			    readImage(e.target)
			})
			
			
			
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