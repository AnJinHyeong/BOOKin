<%@page import="java.util.ArrayList"%>
<%@page import="semi.beans.CartListDto"%>
<%@page import="semi.beans.CartListDao"%>
<%@page import="semi.beans.GenreDto"%>
<%@page import="semi.beans.GenreDao"%>
<%@page import="semi.beans.CartDto"%>
<%@page import="semi.beans.BookDto"%>
<%@page import="java.util.List"%>
<%@page import="semi.beans.BookDao"%>
<%@page import="semi.beans.MemberDto"%>
<%@page import="semi.beans.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
   String root = request.getContextPath();
   
%>
<%

   int member;
   try{
      member = (int)session.getAttribute("member");
   }
   catch(Exception e){
      member = 0;
   }

   CartDto cartDto = new CartDto();
   
%>

<%
	String bookTitle = request.getParameter("bookTitle");

	boolean isTitle = bookTitle!= null;

	int pageNo; //현재 페이지 번호
	try{
		pageNo = Integer.parseInt(request.getParameter("pageNo"));
		if(pageNo < 1) {
			throw new Exception();
		}
	}
	catch(Exception e){
		pageNo = 1;//기본값 1페이지
	}
	
	int pageSize;
	try{
		pageSize = Integer.parseInt(request.getParameter("pageSize"));
		if(pageSize < 4){
			throw new Exception();
		}
	}
	catch(Exception e){
		pageSize = 4;//기본값 10개
	}
	
	// rownum의 시작번호(startRow)와 종료번호(endRow)를 계산
	int startRow = pageNo * pageSize - (pageSize-1);
	int endRow = pageNo * pageSize;
	
	CartListDao cartListDao = new CartListDao();
	List<CartListDto> cartList;
		if(isTitle){
			cartList = cartListDao.titleList(bookTitle, startRow, endRow);	
		}
		else{
			cartList = cartListDao.list(startRow, endRow);
		}

		int count;
		if(isTitle){
			count = cartListDao.getCountTitle(bookTitle);
		}
		else{
			count = cartListDao.getCount();
		}
		
		int blockSize = 10;
		int lastBlock = (count + pageSize - 1) / pageSize;
		int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
		int endBlock = startBlock + blockSize - 1;
		
		if(endBlock > lastBlock){//범위를 벗어나면
			endBlock = lastBlock;//범위를 수정
		}
		
		
		int totalPrice = 0;		
		List<CartListDto> priceList = cartListDao.priceList(member);
		int a = 2500; //배송비
		
		for(CartListDto cartListDto : priceList){
			if(cartListDto.getBookDiscount() > 0){
				totalPrice += cartListDto.getBookDiscount() * cartListDto.getCartAmount() ;
			} 
			else{
				totalPrice += cartListDto.getBookPrice() * cartListDto.getCartAmount() ;
			}			
		}
		
		int cartTotalPrice = 0;
		if(priceList.size() == 0)
			cartTotalPrice = totalPrice;
		else
			cartTotalPrice = totalPrice + a;
		
%>

<%
	int no;
	try{
		no = Integer.parseInt(request.getParameter("no"));
	}
	catch(Exception e){
		no = 0;
	}
	
	
%>



<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(window).on("scroll", function(){
		console.log("scroll moved");
	});
</script>

<jsp:include page="/template/header.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="<%=root%>/css/myInfoLayout.css">
<link rel="stylesheet" type="text/css" href="<%=root%>/css/template.css">
<link rel="stylesheet" type="text/css" href="<%=root%>/css/cart.css">

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
   var checktest = false;
   var priceReset = false;
   
   $(function(){
      $(".btn-del").click(function(){     
    	  if(confirm("삭제하시겠습니까?") == true){
         	$(location).attr("href", "<%=root%>/member/cartDelete.kh?cartNo=" + $(this).attr('id'));
         }
    	  else{
    		  return;
    	  }
      });
      
      $.fn.calPrice = function(){
    	  $(".check-item").each(function(index, item){
         	 if($(item).is(":checked")){
         		var cartno = "#" + $(item).attr("data-cartno");
         		var bookno = "#" + $(item).attr("data-bookno");
         		
         		var q = Number($(bookno).text()) * Number($(cartno).val()) + Number(cartprice);  	 
				var o = Number($(bookno).text()) * Number($(cartno).val()) + Number(price);
				$("#carttotalprice").text(q);
				$("#totalprice").text(o);
         	 }
          });
      };
      
      $(".pl").click(function(){
         var a = $(this).prev();
         var no = a.val();
         no = Number(no) + 1;
         a.val(no);
         
         var id = "#checked" + $(this).attr("data-bookno");
         
         if($(id).is(":checked")){
        	 var bookno = "#" + $(this).attr("data-bookno");                   
             var price = $("#totalprice").text(); //상품금액           
             var cartprice = $("#carttotalprice").text(); //총 결제금액
                         
             var p = Number(cartprice) + Number($(bookno).text());
             var o = Number(price) + Number($(bookno).text());
             
             $("#carttotalprice").text(p);  
             $("#totalprice").text(o);  
         }       
           
      });
      
      $(".mi").click(function(){
         var b = $(this).next();
         var mo = b.val();
         mo = Number(mo) - 1;        
         if(mo > 0){
        	 b.val(mo);
         }
         else{
            alert("최소주문은 1개 이상부터 가능합니다");
            return;
         }
         
		var id = "#checked" + $(this).attr("data-bookno");
         
         if($(id).is(":checked")){
        	 var bookno = "#" + $(this).attr("data-bookno");                    
             var price = $("#totalprice").text(); //상품금액            
             var cartprice = $("#carttotalprice").text(); //총 결제금액
                          
             var p = Number(cartprice) - Number($(bookno).text());      
             var o = Number(price) - Number($(bookno).text());
             
             $("#carttotalprice").text(p);   
             $("#totalprice").text(o);  
         }   
		
      });
      
      
      
      $(".check-item").click(function(){
    	  var bookno = "#" + $(this).attr("data-bookno"); //가격   	 	
		  var cartno = "#" + $(this).attr("data-cartno"); //수량   
		
			var cartprice = $("#carttotalprice").text();   	
			var price = $("#totalprice").text();
			
			if($(this).is(":checked") == true){
				
				var q = Number($(bookno).text()) * Number($(cartno).val()) + Number(cartprice);  	 
				var o = Number($(bookno).text()) * Number($(cartno).val()) + Number(price);
				$("#carttotalprice").text(q);
				$("#totalprice").text(o);
			}
			else{
				  var q = Number(cartprice) - (Number($(bookno).text()) * Number($(cartno).val()));   	
			      var o = Number(price) - (Number($(bookno).text()) * Number($(cartno).val()));
					$("#carttotalprice").text(q);
					$("#totalprice").text(o);
			}	 	
						
			var price=0;
			
			if(resetPrice){
				var price = Number($("#carttotalprice").text()) + Number(2500) ;
				console.log(price);
					
				$("#carttotalprice").text(price);				
				resetPrice = false;
			}		
			
			if($("#carttotalprice").text() == "2500"){
				$("#carttotalprice").text("0");
				resetPrice =true;
			}
      });
      
     
      
      $("#del").click(function(){ 	    	  
    	  var result = confirm("삭제하시겠습니까?");
    	  
    	  if(!result)
    		  return;
    	  
    	  $(".check-item").each(function(index, item){
    		  if($(item).is(":checked")){        		  
        		  <%-- $(location).attr("href", "<%=root%>/member/cartDelete.kh?cartNo=" + $(item).attr("data-cartno")); --%>
        		  $.ajax({
                      url: "<%=root%>/member/cartDelete.kh",
                      type: "GET",           
                      data: {"cartNo": $(item).attr("data-cartno")},
                      
                      async: false,
                      success: function(data) {                   
                    	  
                      },
                      error: function(msg, error) {
                          alert(error);
                      }
                  });
        		  
        	  }
    	  });   
    	  
    	  alert("삭제완료");
    	  location.reload();
    	     
    	  <%-- for(int i=0; i<checkBox.length; i++){
    		  if(checkBox[i].is(":checked")){        		  
        		  $(location).attr("href", "<%=root%>/member/cartDelete.kh?cartNo=" + checkBox[i].attr("data-cartno"));
        	  }
    	  } --%>
      });
      
      $("#delAll").click(function(){
		  var result =  confirm("전체삭제하시겠습니까?");
    	  
    	  if(!result)
    		  return;
    	 
    	  $(location).attr("href", "<%=root %>/member/cartDeleteAll.kh?memberNo=" + <%=member%>);	     	
      });
     
      
      $(".allCheckBox").click(function(){
         if($(this).is(":checked") == true){
            $(".check-item").prop("checked", true);
            $(".allCheck").val("전체상품 해제");
            
            $("#carttotalprice").text(<%=cartTotalPrice %>);
 			$("#totalprice").text(<%=totalPrice %>);
         }
         else{
            $(".check-item").prop("checked", false);            
            $(".allCheck").val("전체상품 선택");
            
            $("#carttotalprice").text(0);
 			$("#totalprice").text(0);
 			resetPrice = true;
         }
         checktest = !checktest;      
      });   
      
      <!-- 버튼 -->
      $(".allCheck").click(function(){
          if(checktest == false){
             $(".check-item").prop("checked", true);   
             $(".allCheckBox").prop("checked", true);
             $(this).val("전체상품 해제");
             
            $("#carttotalprice").text(<%=cartTotalPrice %>);
 			$("#totalprice").text(<%=totalPrice %>);
          }
          else{
             $(".check-item").prop("checked", false);
             $(".allCheckBox").prop("checked", false);
             $(this).val("전체상품 선택");
             
             $("#carttotalprice").text(0);
 			$("#totalprice").text(0);
 			resetPrice = true;
          }
          	checktest = !checktest;      
         
       });      
    
     $(".allCheck").click();
     
     
   });

</script>
<script type="text/javascript">
  function checkInputNum(){
      if (((event.keyCode<48 || event.keyCode>57))){
          event.returnValue = false;
      }
  }

</script>
<script>
	//페이지 네이션 
	$(function(){
		$(".pagination > a").click(function(){
			//주인공 == a태그
			var pageNo = $(this).text();
			if(pageNo == "이전"){//이전 링크 : 현재 링크 중 첫 번째 항목 값 - 1
				pageNo = parseInt($(".pagination > a:not(.move-link)").first().text()) - 1;
				$("input[name=pageNo]").val(pageNo);
				$(".page-form").submit();//강제 submit 발생
			}	
			else if(pageNo == "다음"){//다음 링크 : 현재 링크 중 마지막 항목 값 + 1
				pageNo = parseInt($(".pagination > a:not(.move-link)").last().text()) + 1;
				$("input[name=pageNo]").val(pageNo);
				$(".page-form").submit();//강제 submit 발생
			}
			else{//숫자 링크
				$("input[name=pageNo]").val(pageNo);
				$(".page-form").submit();//강제 submit 발생
			}
		});
	});
</script>

<script>

</script>
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
            <li><a href="myInfo_check.jsp" id="edit-info">회원정보 수정 / 탈퇴</a></li>
            <li><a href="#">주문목록 / 배송조회</a></li>
            <li><a href="review.jsp">리뷰관리</a></li>            
            <li><a href="<%=root%>/qna/qnaList.jsp">고객센터</a></li>
            <li class="on"><a href="cart.jsp">장바구니</a></li>
            <li><a href="bookLike.jsp">좋아요</a></li>
         </ul>
      </aside>
      <!-- 장바구니 -->
      <section class="cart-section">
      	<h2 class="cart-t">장바구니</h2>
   		<div class="cart-table">
                        <table>
                           <caption></caption>
                           <colgroup style="width: 700px;">
                              <col style="width: 5%">
                              <col style="width: 45%">
                              <col style="width: 6%">
                              <col style="width: 35%">
                              <col style="width: 6%">   
                           </colgroup>
                         <thead>
                            <tr>
                               <th scope="col">
                                  <span class="cs-form">
                                     <!-- 누르면 차트에 있는 상품 모두 클릭 -->
                                     <input type="checkbox" class="allCheckBox" >
                                     <!-- <label for="allCheck">선택</label> -->
                                  </span>
                               </th>
                               <th scope="col">주문상품정보</th>
                               <th scope="col">수량</th>
                               <th scope="col">가격</th>
                               <th scope="col"><!-- 공백 --></th>
                           </tr>
                         </thead>
                         <tbody>
                         	
                            <%for(CartListDto cartListDto : cartList){ %>
                           <tr>
                              <td>
                               	<span class="cs-form">
                                 	<input type="checkbox" class="check-item"  id="checked<%=cartListDto.getBookNo() %>" data-bookno="<%=cartListDto.getBookNo()%>" data-cartno="<%=cartListDto.getCartNo() %>" name="list_cart"> 
                                </span>
                             </td>                                    
                              <td class="tleft">      
                                   <div>
                                   		
                                       <a href="<%=root %>/book/bookDetail.jsp?no=<%=cartListDto.getBookNo() %>" >
                                           <img src="<%=cartListDto.getBookImage() %>">
                                       </a>
                                           <div class="tit">
                                           		<a href="<%=root %>/book/bookDetail.jsp?no=<%=cartListDto.getBookNo() %>" >
                                           		   <%=cartListDto.getBookTitle() %>  
                                           		</a>   
                                          </div>     
                                                                        
                                    </div>                                   
                             </td>
                                 
                                 <!-- 수량체크부분 -->
                              <td>
                                  <div class="cart-count">
                                     <button type="button" name="button" class="mi" data-bookno="<%=cartListDto.getBookNo()%>"><img src="<%=root %>/image/minus-solid.svg" alt="minus" class="amount-image"></button>
                                     <input type="text" onkeyPress="javascript:checkInputNum();"value="<%=cartListDto.getCartAmount()%>" id="<%=cartListDto.getCartNo()%>">   
                                     <button type="button" name="button" class="pl"  data-bookno="<%=cartListDto.getBookNo()%>"><img src="<%=root %>/image/plus-solid.svg" alt="plus" class="amount-image"></button>                                 
                                  </div>
                              </td>
                                 
                                 <!-- 가격부분 -->
                             <td>
                                    
                                    
                                    <%if(cartListDto.getBookDiscount() > 0){%>
	                                     <span class="c1" style="text-decoration: line-through;" >
                                      		판매가 : <%=cartListDto.getBookPrice() %>원
                                   		 </span>
	                                     <span class="c2"  style="text-align: center">
	                                        <strong>할인가 : 
	                                        	<span id="<%=cartListDto.getBookNo()%>">	
	                                        		<%=cartListDto.getBookDiscount() %>
	                                        	</span>	
	                                        원</strong>
	                                     </span> 	                                                                    
                                    <%}else { %>
                                    	 <span class="c1" style="color: #000" >
                                            <strong>
                                            판매가 :
                                            	<span id="<%=cartListDto.getBookNo()%>"> 
                                            		<%=cartListDto.getBookPrice() %>
                                            	</span>
                                            원</strong>
                                   		 </span>
                                   		
                                    <% } %>
                                    
                             </td>
                              
                                 <!-- 삭제버튼 -->
                             <td>
                                  <button class="btn-del" type="button" id="<%=cartListDto.getCartNo()%>">X</button>
                             </td>   
                                                              
                           </tr>
                              <%} %>
                           </tbody>
                        </table>
                        
                     <div class="btnbox right"> 
                        <input type="button" class="allCheck" value="전체상품 선택" id="btn-s-black">
                        <input type="button" class="btn-s-black " id="del" value="선택상품 삭제" >
                        <input type="button" class="btn-s-black" id="delAll" value="전체상품 삭제">
                     </div>            
                     
                     <div class="pagination">
	
						<%if(startBlock > 1){ %>
						<a class="move-link">이전</a>
						<%} %>
						
						<%for(int i = startBlock; i <= endBlock; i++){ %>
							<%if(i == pageNo){ %>
								<a class="on"><%=i%></a>
							<%}else{ %>
								<a><%=i%></a>
							<%} %>
						<%} %>
						
						<%if(endBlock < lastBlock){ %>
						<a class="move-link">다음</a>
						<%} %>
		
                     </div>
					<form class="page-form" action="cart.jsp" method="post">
						<input type="hidden" name="pageNo">
					</form>       
               </div>
    
    
    
     		
              	 <div id="paybox" class="paybox" >
                   <div class="cart-top">
                    결제금액
                        <span class="cart-price">
                           <strong>
                           		<span id = "carttotalprice">
                           			<%=cartTotalPrice %>
                           		</span>원	
                           </strong>
                        </span>
                           
	                   <div class="info"><br>
	                    총 상품금액
	                       <span class="c2">
	                       		<span id = "totalprice">
	                           		<%=totalPrice %>
	                           	</span>원
	                       </span><br>
	
	                    배송비
	                       <span class="c2">
	                            <%=a %>원
	                       </span><br>
	                                 
	                    
	                   </div>
                   </div>
                        
                   <div class="btnbox">                         
                         <button class="btn-m-red" type="button" style="margin-bottom : 2px;">
                             전체상품 주문하기
                         </button>
                         <button class="btn-m-line" type="button" >
                             선택상품 주문하기
                         </button>                          
                   </div>
                                               
               </div>

      </section>      
   </main>
<jsp:include page="/template/footer.jsp"></jsp:include>