<%@page import="semi.beans.QnaReplyDto"%>
<%@page import="semi.beans.QnaReplyDao"%>
<%@page import="semi.beans.MemberDto"%>
<%@page import="semi.beans.MemberDao"%>
<%@page import="semi.beans.QnaBoardDto"%>
<%@page import="semi.beans.QnaBoardDao"%>
<%@page import="semi.beans.QnaReplyMemberDto"%>
<%@page import="semi.beans.QnaReplyMemberDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String root = request.getContextPath();
	String type=request.getParameter("type");
	int member;
	try{
		member = (int)session.getAttribute("member");
	}
	catch(Exception e){
		member = 0;
	}
	
	//페이지 네이셔 구현 코드
	int pageNo;//현재 페이지 번호
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
		if(pageSize < 10){
			throw new Exception();
		}
	}
	catch(Exception e){
		pageSize = 15;//기본값 15개
	}
	
	//rownum의 시작번호(startRow)와 종료번호(endRow)를 계산
	int startRow = pageNo * pageSize - (pageSize-1);
	int endRow = pageNo * pageSize;
	
	QnaBoardDao qnaBoardDao = new QnaBoardDao();
	List<QnaBoardDto> qnaList;
	if(type==null||type.equals("all")){
	qnaList = qnaBoardDao.list(startRow, endRow);
	}else{
	qnaList = qnaBoardDao.noReplyList(startRow, endRow);
	}
	int count = qnaBoardDao.getCount();
		
	int blockSize = 10;
	int lastBlock = (count + pageSize - 1) / pageSize;
	//	int lastBlock = (count - 1) / pageSize + 1;
	int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
	if(endBlock > lastBlock){//범위를 벗어나면
		endBlock = lastBlock;//범위를 수정
	}
	
%>
<style>
	.pagination{
		padding: 10px 0;
		margin: 0 auto;
		text-align: center;
	}
	.pagination > a {
		color:grey;
		text-decoration: none;
		display:inline-block; 
		min-width:35px;
		
		border:1px solid transparent;
		padding:0.5rem;
		text-align: center;
	}
	.pagination > a:hover,
	.pagination > a.on {
		border:1px solid lightgray;
		color:#ff9f43;
	}
	.q1-a1{
		background-color: rgb(231, 241, 253,0.5);
	}
	
 	.admin-qna-row{ 
 		width: 100%;
 		margin: 5px auto;
 		padding-left: 10px;
 	} 
	.notice-regit-reply {
		width: 98%;
		min-height: 100px;
		margin: 10px auto ;
 	    padding: 5px 0 ;
	    border: 2px solid #cfcfcf;
	    border-radius: 6px;
	    box-sizing: border-box;
	}
	.comment_inbox_text{
	    display: block;
	    width: 100%;
	    min-height: 100px;
	    border: 0;
	    font-size: 13px;
	    resize: none;
	    box-sizing: border-box;
	    background: transparent;
	    color: var(--skinTextColor);
	    outline: 0;
	}
	.form-btn {
		border:none;
	}
	.form-btn.form-btn-normal {
		background-color: white;
		color:gray;
		border:1px solid gray;	
		width: 50px;
		height: 30px;
		padding: 5px;
	}
</style>
<jsp:include page="/template/adminSidebar.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	function viewContent(obj){
		var con = document.querySelectorAll(".con");
		var ans = document.querySelectorAll(".ans");
				
		if(con != null){
			for(var i=0; i<con.length; i++){
				con[i].style.display = "none";	
			}				
		}
		
		if(ans != null){
			for(var i=0; i<ans.length; i++){
				ans[i].style.display = "none";	
			}				
		}
		
		var q1 = document.querySelectorAll(".q"+obj.id);
		var a1 = document.querySelectorAll(".a"+obj.id);
		
		if(q1 != null){
			for(var i=0; i<q1.length; i++){
				q1[i].style.display = "";	
			}				
		}
		
		if(a1 != null){
			for(var i=0; i<a1.length; i++){
				a1[i].style.display = "";	
			}				
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
	//답글 수정
	function updateReply(obj){
		var viewClass = document.querySelectorAll(".re");
		var editClass = document.querySelectorAll(".up");
		
		for(var i=0; i<viewClass.length; i++){
			viewClass[i].style.display = "";
			editClass[i].style.display = "none";
		}
		
		var viewWindow = document.querySelector("#re"+obj.id);
		var editWindow = document.querySelector("#up"+obj.id);
		
		if(viewWindow != null)
			viewWindow.style.display = "none";
		
		if(editWindow != null)
			editWindow.style.display = "";	
		
		var textarea = document.querySelector("#comment_update");
		textarea.focus();
	}
	
	function cancleUpdate(){
		var viewClass = document.querySelectorAll(".re");
		var editClass = document.querySelectorAll(".up");
		
		for(var i=0; i<viewClass.length; i++){
			viewClass[i].style.display = "";
			editClass[i].style.display = "none";
		}
	}
	
	window.addEventListener("load",function(){
		const all=document.querySelector(".all");
		const noreply=document.querySelector(".noreply");
		const rsform=document.querySelector(".rsform");
		all.addEventListener("click",function(){
			rsform.children[0].value="all"
			rsform.submit();
		})
		noreply.addEventListener("click",function(){
			rsform.children[0].value="noreply"
			rsform.submit();
		})
	})
</script>

<section>
	<div class="admin-content_area">
		<div class="admin-content ">
			<div class="admin-content_title a_bth">QnA 문의/공지사항 관리 

			<%if(type!=null&&type.equals("noreply")){ %>			
			<a class="noreply on">미답변</a>
			<a class="all">전체</a>
			<%}else{ %>
			<a class="noreply">미답변</a>
			<a class="all on">전체</a>
			<%} %>
			</div>
			<form class="rsform" action="" method="get">
				<input type="hidden" value="all" name="type">
			</form>
		</div>
	</div>
		<div class="admin-content_area">
			<div class="admin-content">
				<div class="admin-content_title">QnA 문의 목록</div>
				<div class="align-row choice-genre-area">
					<div class="search-table" style="min-height: 550px;">
						<table class="table table-border table-hover table-striped" style="text-align: center;">
							<thead>
								<tr>
									<th style="width: 1%;">번호</th>
									<th style="width: 2%;">구분</th>
									<th style="width: 20%;">제목</th>
									<th style="width: 3%;">작성자</th>
									<th style="width: 3%;">등록일자</th>
									<th style="width: 2%;">답변여부</th>
									<th style="width: 2%;">답변</th>
									<th style="width: 2%;">삭제</th>
								</tr>
							</thead>
							<tbody>
							<%for(QnaBoardDto qnaBoardDto : qnaList){ %>
								<tr>
									<td><%=qnaBoardDto.getQnaBoardNo() %></td>
									<td ><%=qnaBoardDto.getQnaBoardHeader() %></td>
									<td class="overflow" style="text-align: left;"><%=qnaBoardDto.getQnaBoardTitle() %></td>
									<td>
									<%
										MemberDao memberDao = new MemberDao();
									    MemberDto memberDto = memberDao.getMember(qnaBoardDto.getQnaBoardWriter());
									    String Id = memberDto.getMemberId();
								    %>
								    <%=Id %>
								    </td>
									<td><%=qnaBoardDto.getQnaBoardTime() %></td>
									<td>
										<span class="contents-info" oninput="contentsInfo();">							
											<!-- 댓글 개수 0보다 클 경우 답변완료 -->
											<%if(qnaBoardDto.getQnaBoardReply() > 0){ %>							
												<span style="color: #3296FF">답변완료</span>
											<%}	else{ %>
												<span style="color: #FF6E6E">답변대기</span>
											<%} %>						
										</span>
									</td>
									<td><a id="<%=qnaBoardDto.getQnaBoardNo() %>" class="update-btn" onclick="viewContent(this); return false" href="javascript:">답변</a></td>
									<td><a class="update-btn" style="background-color: #FF5A5A;" href="<%=root%>/admin/qnaboardAdminDelete.kh?qnaBoardNo=<%=qnaBoardDto.getQnaBoardNo()%>">삭제</a></td>
								</tr>
								
								<tr class="q<%=qnaBoardDto.getQnaBoardNo() %> con" style="display:none;">
									<td colspan="8" class="q1-a1" style="padding: 0;">
										<div style="width: 100%; min-height: 500px; background-color: white; padding: 10px;">
											<div class="notice-regit-reply" style="text-align: left; padding: 0 5px;">
												<pre class="overflow_nowrap"><%=qnaBoardDto.getQnaBoardContent() %></pre>
											</div>
											
											<!-- 답글 화면 구현 -->
											<%
												QnaReplyMemberDao qnaReplyMemberDao = new QnaReplyMemberDao();
												List<QnaReplyMemberDto> qnaReplyList = qnaReplyMemberDao.list(qnaBoardDto.getQnaBoardNo());
											%>
											<%for(QnaReplyMemberDto qnaReplyMemberDto : qnaReplyList){ %>
											<div class="notice-regit-reply re" id="re<%=qnaReplyMemberDto.getQnaReplyNo() %>">
												<div class="admin-qna-row" style="text-align: left;">
													<strong>BOOKin 관리자</strong>
												</div>
												<div class="admin-qna-row" style="text-align: left; min-height: 50px;">							
													<pre class="overflow_nowrap"><%=qnaReplyMemberDto.getQnaReplyContent() %></pre>
												</div>
												<div class="admin-qna-row" style="text-align: left;">
													<span><%=qnaReplyMemberDto.getQnaReplyTime() %></span>
												</div>
												<div class="admin-qna-row" style=" text-align: right; padding-right: 10px;">
													<a id="<%=qnaReplyMemberDto.getQnaReplyNo()%>" href="#" onclick="updateReply(this); return false" class="form-btn form-btn-normal update-btn">수정</a>
													<a class="form-btn form-btn-normal" href="<%= root%>/admin/deleteQnaReply.kh?qnaReplyNo=<%=qnaReplyMemberDto.getQnaReplyNo() %>&qnaReplyWriter=<%=qnaReplyMemberDto.getQnaReplyWriter() %>&qnaReplyOrigin=<%=qnaReplyMemberDto.getQnaReplyOrigin() %>">삭제</a>
												</div>
											</div>
											
											
											<div class="notice-regit-reply up" id="up<%=qnaReplyMemberDto.getQnaReplyNo() %>" style="display:none;">
												<form action="<%=root %>/admin/updateQnaReply.kh" method="post" >
													<div class="admin-qna-row">
														<div class="admin-qna-row" style="text-align: left;">
															<strong><%=qnaReplyMemberDto.getMemberId() %>(BOOKin 관리자)</strong>
														</div>
														<div class="admin-qna-row">							
															<textarea name="qnaReplyContent" placeholder="<%=qnaReplyMemberDto.getQnaReplyContent() %>" rows="1" class="comment_inbox_text" id="comment_update" style="overflow: hidden; overflow-wrap: break-word; height: 30px;" required></textarea>
															<input type="hidden" name="qnaReplyNo" value="<%=qnaReplyMemberDto.getQnaReplyNo() %>">
															<input type="hidden" name="qnaReplyWriter" value="<%=member %>">
															<input type="hidden" name="qnaReplyOrigin" value="<%=qnaBoardDto.getQnaBoardNo() %>" >
														</div>
													</div>
													
													<div class="admin-qna-row" style="padding-right: 10px; text-align: right;">
														<input type="submit" class="form-btn form-btn-normal" value="수정" >
														<input type="button" class="form-btn form-btn-normal" value="취소" onclick="cancleUpdate();" >
													</div>
												</form>
											</div>	
											<%} %>
											<!-- 답글 작성 -->
											<div class="notice-regit-reply">
												<form action="<%=root %>/admin/insertQnaReply.kh" method="post">	
													<div class="admin-qna-row">
														<div class="admin-qna-row" style="text-align: left; padding-left: 10px; ">
															<strong>BOOKin 관리자</strong>
														</div>
														<div class="admin-qna-row">							
															<textarea name="qnaReplyContent" placeholder="답변을 남겨주세요." rows="1" class="comment_inbox_text" style="overflow: hidden; overflow-wrap: break-word; height: 20px;" required></textarea>
															<input type="hidden" name="qnaReplyWriter" value="<%=member %>">
															<input type="hidden" name="qnaReplyOrigin" value="<%=qnaBoardDto.getQnaBoardNo() %>" >
														</div>
													</div>
													<div class="admin-qna-row " style="margin:5px 0; padding-right: 10px; text-align: right;">
														<input type="submit" class="form-btn form-btn-normal" value="등록">
													</div>
												</form>
											</div>
					
										</div>
									</td>
								</tr>
							<%} %>
							</tbody>
						</table>
					</div>
				</div>
				<!-- 페이지 네비게이션 자리 -->
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
					
				<form class="page-form" action="qnaReply.jsp" method="post">
					<input type="hidden" name="pageNo">
				</form>
			</div>
			
		</div>
</section>
</body>
</html>