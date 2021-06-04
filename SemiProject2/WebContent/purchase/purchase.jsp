
<%@page import="semi.beans.CartListDto"%>
<%@page import="semi.beans.CartListDao"%>
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
	int amount=0;
	String[] amounts=request.getParameterValues("amount"); 
	
	String root=request.getContextPath();
	MemberDao memberDao=new MemberDao();
	MemberDto memberDto=memberDao.getMember(no);
	BookDao bookDao=new BookDao();
	CartListDao cartListDao = new CartListDao();
	List<CartListDto> cartList;
	String[] bookNos = request.getParameterValues("no");
	List<BookDto> bookList = new ArrayList<>();
	for(String bookNo : bookNos){
		int bookNotoInt = Integer.parseInt(bookNo);
		BookDto bookDto=bookDao.get(bookNotoInt);
		bookList.add(bookDto);
	}

	int sum_price=2500;
	
if(amounts==null){
		String[] bookAmount=new String[bookList.size()];
		for(int i=0;i<bookAmount.length;i++){
			
			bookAmount[i]="1";
		}amounts=bookAmount;
	}
%>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="container-700">
	<div class="row" style="margin-bottom:40px;">
		<h1>주문/결제</h1>
	</div>
	
 	<form action="purchaseInsert.kh"  method="post">

     <div class="cart-table">
	      <table>
	      	 <colgroup style="width: 700px;">
                              <col style="width: 5%">
                              <col style="width: 45%">
                              <col style="width: 6%">
                              <col style="width: 35%">
                              <col style="width: 6%">   
                           </colgroup>
	      	<thead>
	      		<tr>
	      			<th colspan='2'>주문상품정보</th>
	      			<th style="text-align:right;">수량</th>
	      			<th>가격</th>
	      			<th>&nbsp;</th>
	      			
	      		</tr>
	      	</thead>
	      	<tbody>
	      		<%for(int i=0;i<bookList.size();i++){ %>
	      			
	      		<tr>	
	      			<td><a href="<%=root%>/book/bookDetail.jsp?no=<%=bookList.get(i).getBookNo()%>">
			            <%if(bookList.get(i).getBookImage().startsWith("https")){ %>
			            <img src="<%=bookList.get(i).getBookImage() %>" style="margin-right:20px;">
						<%}else{ %>
						<img src="<%=root%>/book/bookImage.kh?bookNo=<%=bookList.get(i).getBookNo()%>" style="margin-right:20px;">
						<%} %>
          		  </a>
          		  <input type="hidden" value="<%=bookList.get(i).getBookNo()%>" name="purchaseBook" style="margin-left:15px;"></td>
	      			<td><%=bookList.get(i).getBookTitle() %></td>
	      			<td style="text-align:right;"><input class="purchaseAmount" name="purchaseAmount" type="number" min="1" value=<%=amounts[i] %> style="width:40px; margin-left:60px;"/></td>    			
	      			<td style="text-align:center"><%=bookList.get(i).getBookDiscount() %></td>
	      			<td><button class="btn-del " type="button" id="<%=bookList.get(i).getBookNo()%>" >X</button></td>
	      			
	      		</tr>
	      		<%} %>
	      		
	      		<tr>
	      			<td >
	      				<div style="visibility:hidden;">
	      					<%for(int i=0;i<bookList.size();i++){ %>
	      					<%=sum_price+=bookList.get(i).getBookDiscount()*Integer.parseInt(amounts[i]) %>
	      				<%} %>
	      				</div>
	      			</td>
	      			<td colspan='5' class="table-result"><span>총상품가격 : </span><span class="sum_price"><%=sum_price-2500 %></span><span>원 + 배송비 : 2500 = 합계 : </span><span class="table-total-price sum_price"><%=sum_price %></span><span style="color:#ff6b6b;"> 원</span> </td>
	      		</tr>
	      	</tbody>
	      </table>
      </div>


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
               <a href="<%=root %>/member/myInfo_check.jsp" class="button-style">수정</a>
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
                  <div style="margin-top:10px;">
                     <div><span class="recipient-span">수령인&ensp;</span><input type="text" name="purchaseRecipient" placeholder=" 50자 이내로 입력하세요" value="<%=memberDto.getMemberName()%>" id="member-name" class="recipient-input-style"></div>
                     <div><span class="recipient-span">연락처&ensp;</span><input type="text" name="purchasePhone" placeholder="-를 제외하고 입력하세요" value="<%=memberDto.getMemberPhone()%>" id="member-phone" class="recipient-input-style"></div>
                     <div><span class="recipient-span">주소&ensp;&ensp;</span><input type="text" name="purchaseAddress" value="<%=memberDto.getMemberAddress()%>" id="member-address" class="recipient-input-style">&ensp;<a  href="#" onclick="showDiv2()" class="button-style">수정</a> </div>
                     
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
         <input type="radio" name="payment" value="계좌 간편결제" checked="checked">&nbsp;&nbsp;계좌 간편결제&nbsp;&nbsp;
         <input type="radio" name="payment" value="카드 간편결제">&nbsp;&nbsp;카드 간편결제&nbsp;&nbsp;
         <input type="radio" name="payment"value="일반결제">&nbsp;&nbsp;일반결제
      </div>

		<hr>
		

		

		<input type="submit" value="결제하기" class="pay-button">
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

function deleteRow(ths){
var val = document.querySelectorAll(".purchaseAmount");
	
	for(var i=0; i<val.length; i++){
		val[i].value = "0";
		
	} 
	var ths=$(ths);
	var thsParents=ths.parents("tr");
	
	//thsParents.remove();
	
	
}



window.addEventListener("load",function(){
	
	const purchaseAmount = document.querySelectorAll('.purchaseAmount');
	for(var i =0 ; i< purchaseAmount.length;i++){
		purchaseAmount[i].addEventListener("input",function(){
			var sum=2500;
			var sum_price = document.querySelectorAll(".sum_price");
			for(var j =0 ; j< purchaseAmount.length;j++){
				var amo = purchaseAmount[j].value;
				sum+=amo*purchaseAmount[j].parentElement.nextElementSibling.textContent;
			}
			for(var j=0;j<sum_price.length;j++){
				
				sum_price[j].textContent = sum;
				if(j==0){
					sum_price[j].textContent-=2500;
				}
			}
			
		})
	}
	
	const btn_del = document.querySelectorAll(".btn-del");
	var count = btn_del.length
	for(var i = 0 ;i<btn_del.length;i++){
		btn_del[i].addEventListener("click",function(){
			if(count>1){
			this.parentElement.previousElementSibling.previousElementSibling.children[0].value=0;
			for(var i =0 ; i< purchaseAmount.length;i++){
					var sum=2500;
					var sum_price = document.querySelectorAll(".sum_price");
					for(var j =0 ; j< purchaseAmount.length;j++){
						var amo = purchaseAmount[j].value;
						sum+=amo*purchaseAmount[j].parentElement.nextElementSibling.textContent;
					}
					for(var j=0;j<sum_price.length;j++){
						
						sum_price[j].textContent = sum;
						if(j==0){
							sum_price[j].textContent-=2500;
						}
					}
			}
			
				this.parentElement.parentElement.style.display="none"
				count--;
			}
		});
	}
});




</script>
<jsp:include page="/template/footer.jsp"></jsp:include>