<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	String root = request.getContextPath();
%>

<jsp:include page="/template/adminSidebar.jsp"></jsp:include>
	<section>
		<div class="admin-home_content_area">
			<div class="admin-home_content">
				<div class="admin-content_title">
					주문 / 배송
				</div>
				<div class="admin-content-itmes">
				<div><span>신규 주문</span><a>0건</a></div>
				<div><span>배송중</span><a>0건</a></div>
				<div><span>배송완료</span><a>0건</a></div>
				</div>
			</div>
			<div class="admin-home_content">
				<div class="admin-content_title">
					문의/리뷰
				</div>
				<div class="admin-content-itmes">
				<div><span>신규 리뷰</span><a>0건</a></div>
				<div><span>신규 문의</span><a>0건</a></div>
				</div>
			</div>
			
		</div>
		<div class="admin-home_chart_area">
			
			<div class="admin-chart">
				<div class="admin-content_title">
					매출 통계
				</div>
			</div>
		</div>
	</section>
</body>
</html>