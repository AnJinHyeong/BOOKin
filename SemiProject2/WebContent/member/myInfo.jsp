<%@page import="semi.beans.MemberDto"%>
<%@page import="semi.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String root = request.getContextPath();

	boolean isLogin = session.getAttribute("member") != null;
	
	if(!isLogin){	
		response.sendRedirect("login.jsp");
		return;
	}
	
	int memberNo = (int)session.getAttribute("member");
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.getMember(memberNo);
%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	window.addEventListener("load",function(){
		//회원가입 취소 버튼 : 클릭 뒤로가기
		var js_cancel_signup = document.querySelector(".js_cancel_signup");
		js_cancel_signup.addEventListener("click",function(){
			history.back();
		});
		
		
		// 회원가입검사 테스트 오래걸려서 주석처리 해놀게요
		
		//회원가입 regex 검사
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
		}); 
	});
	
	$(function(){
		$("#memberDelete").click(function(){
			var result = confirm('정말 탈퇴하시겠습니까?');
			
			if(result){
				location.replace("memberDelete.kh?memberNo=<%=memberNo%>");
			}
		})
	})
</script>
<jsp:include page="/template/header.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="<%=root%>/css/myInfoLayout.css">
<link rel="stylesheet" type="text/css" href="<%=root%>/css/template.css">

	<!-- 주문 현황 영역 -->
	<div class="container-1200 myInfo-header">
		<dl class="bottom" style="padding-bottom:55px;">
		<dt>주문현황</dt>
		<dd>
			<div class="tit">0</div>
			<div class="txt">주문접수</div>
		</dd>
		<dd class="bottom-next">
			<img src="<%=root %>/image/myInfo_next.png" width="30px" height="30px">
		</dd>
		<dd>
			<div class="tit">0</div>
			<div class="txt">결제완료</div>
		</dd>
		<dd class="bottom-next">
			<img src="<%=root %>/image/myInfo_next.png" width="30px" height="30px">
		</dd>
		<dd>
			<div class="tit">0</div>
			<div class="txt">상품준비중</div>
		</dd>
		<dd class="bottom-next">
			<img src="<%=root %>/image/myInfo_next.png" width="30px" height="30px">
		</dd>
		<dd>
			<div class="tit">0</div>
			<div class="txt">출고시작</div>
		</dd>
		<dd class="bottom-next">
			<img src="<%=root %>/image/myInfo_next.png" width="30px" height="30px">
		</dd>
		<dd>
			<div class="tit">0</div>
			<div class="txt">배송중</div>
		</dd>
		<dd class="bottom-next">
			<img src="<%=root %>/image/myInfo_next.png" width="30px" height="30px">
		</dd>
		<dd>
			<div class="tit">0</div>
			<div class="txt">거래완료</div>
		</dd>
	</dl>
	</div>
	<main class="myInfo-main">		
		<!-- 사이드영역 -->
		<aside class="myInfo-aside">
			<h2 class="tit">MYPAGE</h2>
			<ul class="menu" >
				<li class="on"><a href="myInfo_check.jsp" id="edit-info">회원정보 수정 / 탈퇴</a></li>
				<li><a href="#">주문목록 / 배송조회</a></li>
				<li><a href="#">리뷰관리</a></li>				
				<li><a href="#">배송지 / 환불계좌 관리</a></li>
				<li><a href="#">고객센터</a></li>
				<li><a href="#">장바구니</a></li>
				<li><a href="#">좋아요</a></li>
			</ul>
		</aside>
		
		<!-- 컨텐츠영역 -->
		<section class="myInfo-section ">
			<article class="myInfo-article">
				<div class="align-column">
					<h3 style="margin-bottom: 40px;font-size:40px;" class="site-color">회원정보 수정</h3>
					<div class="text-left">
						<form class="container-800 align-column singup-form " action="memberEdit.kh" method="post">
							<input type="hidden" name="memberNo" value="<%=memberNo %>">
							<div><span>아이디</span><span style="width: 70%; text-align: left;"><%=memberDto.getMemberId() %></span></div>
							<input type="hidden" name="memberId" value="<%=memberDto.getMemberId() %>">
							<span class="hidden">아이디는 4~20자 영문 소문자,숫자 조합으로 등록해주세요</span>
							<div><span>비밀번호</span><input type="password" placeholder="6-20자:영문,숫자,특수문자조합(!@#$)" name="memberPw" required></div>
							<span class="hidden" style="margin-right:665px; text-align: right;">비밀번호는 6~20자 영문,숫자,특수문자조합(!@#$) 으로 등록해주세요</span>
							<div><span>새 비밀번호</span><input type="password" placeholder="6-20자:영문,숫자,특수문자조합(!@#$)" name="newMemberPw" class="js_pw" required></div>
							<span class="hidden" style="margin-right:665px; text-align: right;">비밀번호는 6~20자 영문,숫자,특수문자조합(!@#$) 으로 등록해주세요</span>
							<div><span>새 비밀번호 확인</span><input type="password" class="js_pw_c" required></div>
							<span class="hidden" style="margin-left:514px; text-align: left;">비밀번호를 확인해주세요</span>
							<div><span>휴대전화</span><input type="text" name="memberPhone" value="<%=memberDto.getMemberPhone() %>" required></div>
							<span class="hidden">.</span>
							<div><span>생일</span><input type="date" name="memberBirth" value="<%=memberDto.getMemberBirth() %>" required></div>
							<span class="hidden">.</span>
							<div><span>이메일</span><input type="email" name="memberEmail" value="<%=memberDto.getMemberEmail() %>" required></div>
							<span class="hidden">.</span>
							<div><span>주소</span><input type="text" name="memberAddress" value="<%=memberDto.getMemberAddress() %>" required></div>
							<span class="hidden">.</span>						
							<div style="width: 100% ;border-bottom:1px solid rgba(0,0,0,0.4);margin-bottom:40px"></div>
							
							<div class="signup-button-area">
								<button type="submit" class="form-btn form-btn-positive btn" style="margin-right: 30px;width:30%;">수정</button>								
								<button type="reset" class="form-btn form-btn-normal btn js_cancel_signup" style="margin-right: 30px;width:30%;">취소</button>
								<input type="button" id="memberDelete" class="form-btn form-btn-negative btn" value="회원탈퇴" style="margin-right: 30px; width:30%;">
							</div>
						</form>
					</div>
				</div>
			</article>
		</section>		
	</main>
<jsp:include page="/template/footer.jsp"></jsp:include>