<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<style>
#dyTable{
	border: solid 1px black;
	width: 90%;
	border-collapse: collapse;
}

th, tr, td{
	border: solid 1px black;
}

th{
	height: 30px;
}

</style>
<script>
	var originWord = "";
	var bookObj;
	var pageSize = 10;
	var pageNo = 1;
	var startRow = pageNo * pageSize - (pageSize-1);
	var endRow = pageNo * pageSize;
				
	var blockSize = 10;
	var count = 0;
	
	//	int lastBlock = (count - 1) / pageSize + 1;
	var startBlock = 1;
	var endBlock = 10;
	var lastBlock = 0;
	
	$(function(){
		$.fn.createPageNation = function(){
			var html = "";
			lastBlock = parseInt((count - 1) / pageSize + 1);	
		
			if(endBlock > lastBlock){//범위를 벗어나면
				endBlock = lastBlock;//범위를 수정
			}
			
			if(startBlock > 1){
				html += "<a class=\"move-link\">&lt;이전</a>";
			}
			
			for(var i=startBlock; i<=endBlock; i++){
				if(i==pageNo)
					html += "<a class=\"on\">" + i + "</a>";
				else
					html += "<a>" + i + "</a>"; 
			}
			
			if(endBlock < lastBlock){
				html += "<a class=\"move-link\">다음&gt;</a>";				
			}
			
			$(".pagination").empty();
			$(".pagination").append(html);			
			
			$.fn.regitPageFunc();
		};
		
		$.fn.regitPageFunc = function(){
			$(".pagination > a").click(function(){
				if($(this).hasClass("move-link")  == true){
					var text = $(this).text();
					if(text == "<이전"){//이전 링크 : 현재 링크 중 첫 번째 항목 값 - 1
						pageNo = parseInt($(".pagination > a:not(.move-link)").first().text()) - 1;
						startBlock = pageNo - blockSize + 1;
						endBlock = startBlock + blockSize - 1;
					}	
					else if(text == "다음>"){//다음 링크 : 현재 링크 중 마지막 항목 값 + 1
						pageNo = parseInt($(".pagination > a:not(.move-link)").last().text()) + 1;
						startBlock = pageNo;
						endBlock = startBlock + blockSize - 1;
					}
				}
				else{
					pageNo = $(this).text();					
				}
				$("#search-btn").click();
				$('html,body').scrollTop(0);
			});
		};		
		
		$.fn.insertDb = function(){
			$(".insertDb").click(function(){
				var idx = $(this).attr('id');
				console.log(bookObj);
				console.log(bookObj.documents[idx]);
			});
		};
		
		$("#search-btn").click(function(){
			var word = $("#word").val();
			var html = "";			
			$("#word").val(word);
			
			if(originWord != word){
				originWord = word;
				pageNo = 1;
				startBlock = 1;
				endBlock = 10;
			}
			
			//SetInterval(function(){
				
			//}, 300000);
									
			$.ajax({
				method: "GET",
				url: "https://dapi.kakao.com/v3/search/book?target=title",
				data: { query: word, page: pageNo },
				headers: { Authorization: "KakaoAK 0b82cc8edea62e4bceea5c251539d827" }			
				
			})
			.done(function(msg) {
				var id = 0;
				for(key in msg.documents){
					html += "<tr>";
					html += "<td width=\"100\" align=\"center\"><img src=" + msg.documents[key].thumbnail + " width=\"100\"></td>";
					html += "<td align=\"center\">" + msg.documents[key].title + "</td>";
					html += "<td align=\"center\" style=\"width:140px;\">" + msg.documents[key].authors[0] + "</td>";
					html += "<td align=\"center\" style=\"width:70px;\">" + msg.documents[key].price + "</td>";
					html += "<td align=\"center\" style=\"width:50px;\"><input type=\"checkbox\" style=\"width:18px; height:18px;\"></td>";
					html += "<td align=\"center\" style=\"width:80px;\"><input type=\"button\" value=\"추가\" class=\"insertDb\" id=\""+id+"\" style=\"width:45px; height:30px;\"></td>";
					html += "</tr>";
					id++;
				}
				
				console.log(msg);
				bookObj = msg;
				$("#tBody").empty();
				$("#tBody").append(html);
				
				count = msg.meta.pageable_count;
				$.fn.createPageNation();
				$.fn.insertDb();
			});
		});
		
		$("#word").keyup(function(e){
			if(e.keyCode==13)
				$("#search-btn").click();
		});
	});	
</script>
 
<jsp:include page="/template/header.jsp"></jsp:include>
    
<div class="container-1000">
	<div class="row text-center">	
		<div style="display:inline-block; ">
			<input id="word" type="text" placeholder="검색어를 입력하세요" style="height: 36px;">		
		</div>
		
		<div style="display:inline-block; ">
			<input id="search-btn" class="form-btn form-btn-normal" type="button" value="검색" style="width:50px;">		
		</div>
	</div>
	
	<div class="row text-center">
		<table id="dyTable">
			<th>표지</th>
			<th>제목</th>
			<th>저자</th>
			<th>가격</th>
			<th><input type="checkbox" style="width:18px; height:18px;"></th>
			<th>DB 추가</th>
			<tbody id="tBody">
				
			</tbody>
		</table>
	</div>
	
	<div class="pagination text-center">
		
	</div>
	
	<form class="page-form" action="insertBook.jsp" method="post">
		<input type="hidden" name="pageNo">
	</form>
</div>


<jsp:include page="/template/footer.jsp"></jsp:include>