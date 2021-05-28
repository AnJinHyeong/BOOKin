<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	window.addEventListener("load",function(){
		//회원가입 취소 버튼 : 클릭 뒤로가기
		var js_cancel_signup = document.querySelector(".js_cancel_signup");
		js_cancel_signup.addEventListener("click",function(){
			history.back();
		});
		
		
		// 회원가입검사 테스트 오래걸려서 주석처리 해놀게요
		
		//회원가입 regex 검사
		//아이디 검사
/* 		var js_id = document.querySelector(".js_id");
		js_id.addEventListener("blur",function(){
			var id_regex = /^[\da-z]{4,20}$/;
			this.parentElement.nextElementSibling.classList.remove("visible","hidden");
			if(id_regex.test(this.value)){
				this.parentElement.nextElementSibling.classList.add("hidden");
			}else{
				console.dir(this.parentElement.nextElementSibling);
				this.parentElement.nextElementSibling.classList.add("visible");
				this.value="";
			}
		});
		
		//비밀번호 검사
		var js_pw = document.querySelector(".js_pw");
		js_pw.addEventListener("blur",function(){
			var pw_regex = /^[\da-zA-Z!@#$]{6,20}$/;
			this.parentElement.nextElementSibling.classList.remove("visible","hidden");
			if(pw_regex.test(this.value)){
				this.parentElement.nextElementSibling.classList.add("hidden");
			}else{
				console.dir(this.parentElement.nextElementSibling);
				this.parentElement.nextElementSibling.classList.add("visible");
				this.value="";
			}
		});
		//비밀번호 확인 검사
		var js_pw_c = document.querySelector(".js_pw_c");
		js_pw_c.addEventListener("blur",function(){
			this.parentElement.nextElementSibling.classList.remove("visible","hidden");
			if(this.value==js_pw.value){
				this.parentElement.nextElementSibling.classList.add("hidden");
			}else{
				console.dir(this.parentElement.nextElementSibling);
				this.parentElement.nextElementSibling.classList.add("visible");
				this.value="";
			}

		});  */
	});

</script>			

<jsp:include page="/template/header.jsp"></jsp:include>

	<div class="align-column">
		<h3 style="margin-bottom: 40px;font-size:40px;" class="site-color">JOIN US</h3>
	<form class="container-500 align-column singup-form" action="signup.kh" method="post">
		<div><span>아이디</span><input type="text" placeholder="4-20자:영문 소문자,숫자조합" name="memberId" class="js_id" required></div>
		<span class="hidden">아이디는 4~20자 영문 소문자,숫자 조합으로 등록해주세요</span>
		<div><span>비밀번호</span><input type="password" placeholder="6-20자:영문,숫자,특수문자조합(!@#$)" name="memberPw" class="js_pw" required></div>
		<span class="hidden">비밀번호는 6~20자 영문,숫자,특수문자조합(!@#$) 으로 등록해주세요</span>
		<div><span>비밀번호 확인</span><input type="password" class="js_pw_c" required></div>
		<span class="hidden">비밀번호를 확인해주세요</span>
		<div><span>이름</span><input type="text" name="memberName" required></div>
		<span class="hidden">.</span>
		<div><span>휴대전화</span><input type="text" name="memberPhone" required></div>
		<span class="hidden">.</span>
		<div><span>생일</span><input type="date" name="memberBirth" required></div>
		<span class="hidden">.</span>
		<div><span>이메일</span><input type="email" name="memberEmail" required></div>
		<span class="hidden">.</span>
		<div><span>주소</span><input type="text" name="memberAddress" required></div>
		<span class="hidden">.</span>
		<div><span>성별</span >
		<select style="margin-right: 220px" required name="memberGender">
			<option value="M">남자</option>
			<option value="F">여자</option>
		</select>
		</div>
		<div style="width: 100% ;border-bottom:1px solid rgba(0,0,0,0.4);margin-bottom:40px;margin-top: 40px"></div>
		
		<div class="signup-button-area">
			<button type="submit" class="form-btn form-btn-positive btn">가입</button>
			<button type="reset" class="form-btn form-btn-normal btn js_cancel_signup">취소</button>
		</div>
	</form>
	</div>
<jsp:include page="/template/footer.jsp"></jsp:include>