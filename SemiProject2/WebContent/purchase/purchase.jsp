<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="semi.beans.BookDto"%>
<%@page import="semi.beans.BookDao"%>
<%@page import="semi.beans.MemberDto"%>
<%@page import="semi.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int no=(Integer)session.getAttribute("member");
	
	String root=request.getContextPath();
	MemberDao memberDao=new MemberDao();
	MemberDto memberDto=memberDao.getMember(no);
	BookDao bookDao=new BookDao();
	String[] bookNos = request.getParameterValues("no");
	List<BookDto> bookList = new ArrayList<>();
	for(String bookNo : bookNos){
		int bookNotoInt = Integer.parseInt(bookNo);
		BookDto bookDto=bookDao.get(bookNotoInt);
		bookList.add(bookDto);
	}
	int sum=0;
%>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-700">
	<div class="row">
		<h1>주문/결제</h1>
	</div>
	
 	<form action="purchaseInsert.kh"  method="post">
 	
 		<%for(BookDto bookDto : bookList){
 			if(bookDto.getBookDiscount()==0)bookDto.setBookDiscount(bookDto.getBookPrice());
 			sum+=bookDto.getBookDiscount();
 		%>
		<div class="book-detail-semi-box" style="border:1px solid lightgray; padding:0px;">
 		<input type="hidden" value="<%=bookDto.getBookNo()%>" name="purchaseBook" >
         <div class="book-price-semi-image">
         
            <a href="">
            
            <%if(bookDto.getBookImage().startsWith("https")){ %>
            <img src="<%=bookDto.getBookImage() %>" style="width:80%;">
			<%}else{ %>
			<img src="<%=root%>/book/bookImage.kh?bookNo=<%=bookDto.getBookNo()%>" style="width:80%;">
			<%} %>
            
            </a>
            
         </div>
         <div class="book-price-semi-info">
            <div class="book-price-semi-title"><%=bookDto.getBookTitle() %></div><br>
            <div><%=bookDto.getBookAuthor() %></div><br>
            <div><%=bookDto.getBookPublisher() %></div><br>
         </div>
         
         
         <div class="book-price-semi-price">
            <div class="price-top-box">
	            <div>가격: <span><%=bookDto.getBookDiscount() %></span> 원</div>
	            <div>수량: <input class="purchaseAmount" name="purchaseAmount" type="number" min="1" value="1"/></div>
	            <div>+</div>
	            <div>배송료: 0원</div>
            </div>
            <hr>
            <div class="price-bottom-box"><span style="font-size:20px;" class="final_price"><%=bookDto.getBookDiscount()%></span><span>원</span></div>
      
         </div>
      </div>
      <%} %>
      <div >총 <span class="sum_price"><%=sum%></span>원</div>
		<div class="row text-left book-detail-semi-box"> 
			<div class="book-detail-semi-title">주문자 정보</div>
			<div>
				<input type="hidden" name="purchaseMember" value="<%=memberDto.getMemberNo()%>">
				<div><%=memberDto.getMemberName() %></div><br>
				<div>
					<span><%=memberDto.getMemberPhone() %></span>&ensp;
					<span><a href="<%=root %>/member/myInfo_check.jsp" class="button-style">수정</a></span>
					
				</div>
				<br>
				<div>
					<span><%=memberDto.getMemberEmail() %></span>&ensp;
					<a href="<%=root %>/member/myinfo.jsp?memberNo=<%=memberDto.getMemberNo()%>" class="button-style">수정</a>
				</div>
				
				
			
				
			</div>
		</div>
		<hr>
		<div class="row text-left book-detail-semi-box">
			<div class="book-detail-semi-title">배송지 정보</div>
			<div >
				<div >배송지 선택</div><br>
						<input type="radio" name="address" value="1" checked="checked" onclick="newRecipientInfo(this.value);">&nbsp;&nbsp;기본배송지&nbsp;&nbsp;
						<input type="radio" name="address" value="2" onclick="newRecipientInfo(this.value);">&nbsp;&nbsp;신규배송지&nbsp;&nbsp;
						<div>
							<div><span>수령인</span><input type="text" name="purchaseRecipient" placeholder=" 50자 이내로 입력하세요" value="<%=memberDto.getMemberName()%>" id="member-name"></div>
							<div><span>연락처</span><input type="text" name="purchasePhone" placeholder="-를 제외하고 입력하세요" value="<%=memberDto.getMemberPhone()%>" id="member-phone"></div>
							<div><span>주소</span><input type="text" name="purchaseAddress" value="<%=memberDto.getMemberAddress()%>" id="member-address"></div>
							<a href="#" onclick="showDiv2()" class="button-style">수정</a> 
								<div id="show-div2" style="display:none">	
									<div class="show-div">
										<div>
											<input type="text" name="zipcode" size="7" id="sample6_postcode" placeholder="우편번호">
									    	<input type="button" class="btn-style" value="우편번호찾기" onclick="sample6_execDaumPostcode()">		
										</div>
										<div class="address-div"><input type="text" name="address1" size="40" id="sample6_address" placeholder="주소" class="input-style"></div>
										<div class="address-div"><input type="text" name="address2" size="40" id="sample6_address2" placeholder="상세주소" class="input-style"></div>
										<div style="margin-top:10px;">
											<input type="button" value="확인" class="button-style" onclick="changeAddress()">
											<input type="reset" value="초기화" class="button-style">
											<input type="button" value="취소" class="button-style" onclick="hideDiv2()">
										</div>
				</div>
			</div>		
	</div>
	</div>
	</div>
		<hr>
		
		<div class="row text-left book-detail-semi-box">
			<div  class="book-detail-semi-title">결제수단</div>
			<input type="radio"  value="계좌 간편결제" checked="checked">&nbsp;&nbsp;계좌 간편결제&nbsp;&nbsp;
			<input type="radio" value="카드 간편결제">&nbsp;&nbsp;카드 간편결제&nbsp;&nbsp;
			<input type="radio" value="일반결제">&nbsp;&nbsp;일반결제
		</div>
		<hr>
		<div>
			
			<input type="checkbox" class="check-item" id="c1"><label>위 상품의 구매조건 확인 및 결제진행 동의</label>
		</div>
		
		<input type="submit" value="결제하기">
	</form> 
</div>

<script> 
var memberName='<%=memberDto.getMemberName()%>';
var memberPhone='<%=memberDto.getMemberPhone()%>';
var memberAddress='<%=memberDto.getMemberAddress()%>';



//radio box 신규배송지 체크시 div 출력
 function newRecipientInfo(v){
	
	if(v=="2"){
		document.getElementById("member-name").value="";
		document.getElementById("member-phone").value="";
		document.getElementById("member-address").value=""; 	
	}else{
		document.getElementById("member-name").value=memberName;
		document.getElementById("member-phone").value=memberPhone;
		document.getElementById("member-address").value=memberAddress; 
	}
} 

//주소 변경 버튼 누를시 div 출력 
function showDiv2(){
	document.getElementById("show-div2").style.display="";
}
//취소 누를시 div 숨기기
function hideDiv2(){
	document.getElementById("show-div2").style.display="none";
}
//확인 누를시 주소변경
function changeAddress(){
	var newAddress=document.getElementById("sample6_address").value+" "+document.getElementById("sample6_address2").value;
	console.log(newAddress);
	document.getElementById("member-address").value=newAddress;
}

//우편번호 찾기
function sample6_execDaumPostcode() {
    new daum.Postcode({
		oncomplete : function(data) {
           var fullAddr = ''; // 최종 주소 변수
           var extraAddr = ''; // 조합형 주소 변수

           if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
               fullAddr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                fullAddr = data.jibunAddress;
            }
            if (data.userSelectedType === 'R') {
            
                if (data.bname !== '') {
                     extraAddr += data.bname;
                }
                if (data.buildingName !== '') {
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
            }
            document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('sample6_address').value = fullAddr;
            document.getElementById('sample6_address2').focus();
        }
    }).open();
} 

window.addEventListener("load",function(){
	const purchaseAmount = document.querySelectorAll('.purchaseAmount');
	for(var i =0 ; i< purchaseAmount.length;i++){
		purchaseAmount[i].addEventListener("input",function(){
			var amo = this.value;
			this.parentNode.parentNode.nextElementSibling.nextElementSibling.children[0].textContent=amo*this.parentNode.previousElementSibling.children[0].textContent;
			var sum_price = document.querySelector(".sum_price");
			var final_prices = document.querySelectorAll(".final_price");
			var sum=0;
			for(var j =0 ; j< final_prices.length;j++){
				console.dir(final_prices[j].textContent)
				sum+=final_prices[j].textContent*1;
				console.dir(sum)
			}
			sum_price.textContent = sum;
		})
	}
});

</script>
<jsp:include page="/template/footer.jsp"></jsp:include>