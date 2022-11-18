<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./jsp_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="${pageContext.request.contextPath}/resources/css/styles.css?after"
	rel="stylesheet" />

<link
	href="${pageContext.request.contextPath}/resources/css/style.css?after"
	rel="stylesheet" />

<link
	href="${pageContext.request.contextPath}/resources/css/pay_table.css?after"
	rel="stylesheet" />
<title>Insert title here</title>
</head>
<body>
	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->
	<div class="mentee_mypage_title_container">
				<div class="mentee_mypage_title_wraper">
					<span class=mentee_mypage_title_title>My coupons</span>
					<span class=mentee_mypage_title_subtitle>내 쿠폰 정보를 확인할 수 있습니다.</span>
				</div>
			</div>
	<div class="mentee_mypage_coupon_body">
	
			<div class="metee_mypage_container">
			<div class="metee_mypage_side_wraper">
			<span class="menu_title_box_span">Menu</span>
				<button onclick="location.href='../Mentee/mentee_Mypage_videolist'">강의목록</button>
				<button onclick="location.href='../mentee_Mypage_paymentlist'">결제목록</button>
				<button onclick="location.href='../basket/mentee_Mypage_coupon'" id="select_coupone_list">쿠폰함</button>
				<button onclick="location.href='../mentee_Mypage'">개인정보 수정</button>
				<button onclick="location.href='../mentee_MyPage_certificate'">2차인증 설정</button>
			</div>
			<div class="metee_mypage_main_wraper">
					<div class="table_container">
						<table class="order_table" id="coupon_list_table">
							<thead class="coupon_list_table_title_align">
								<tr>
									<th>쿠폰번호</th>
									<th>쿠폰명</th>
									<th>할인율</th>
									<th>사용 가능기간</th>
									<th>종료날짜</th>
									<th>사용여부</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="coupon" items="${coupon}">

									<tr class="order_row">

						

												<td>${coupon.cno}</td>
												<td class="order_name"><a class="link_to"
													>${coupon.coupon_name} </a></td>
													<td><a class="link_to">${coupon.discount_rate}%</a></td>
													<td class="pay_price"><span>${coupon.start_date}~<br>${coupon.end_date}</span>
													
												</td>
												
												<td>
												<time
														datetime="Fri Apr 01 2022 22:05:08 GMT+0900 (GMT+09:00)">${coupon.end_date}</time>
												</td>
												

												
												
												

												<td>X</td>

									</tr>
					
						
								</c:forEach>
							</tbody>
						</table>
					</div>
	</div>

	
	</div>
</div>
<!-- 하단부분 -->
	<%@ include file="./footer.jsp"%>
	<!-- 하단부분 -->
</body>
</html>