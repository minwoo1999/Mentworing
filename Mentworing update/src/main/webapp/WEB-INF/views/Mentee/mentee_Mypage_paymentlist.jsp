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

	<div class="mentee_mypage_paymentlist_body">
		<div class="mentee_mypage_title_container">
			<div class="mentee_mypage_title_wraper">
				<span class=mentee_mypage_title_title>My payment</span> <span
					class=mentee_mypage_title_subtitle>내 결제 정보를 확인할 수 있습니다.</span>
			</div>
		</div>

		<div class="metee_mypage_container">
			<div class="metee_mypage_side_wraper">
				<span class="menu_title_box_span">Menu</span>
				<button onclick="location.href='../Mentee/mentee_Mypage_videolist'">강의목록</button>
				<button onclick="location.href='../mentee_Mypage_paymentlist'"
					id="select_payment_list">결제목록</button>
				<button onclick="location.href='../basket/mentee_Mypage_coupon'">쿠폰함</button>
				<button onclick="location.href='../mentee_Mypage'">개인정보 수정</button>
				<button onclick="location.href='../mentee_MyPage_certificate'">2차인증
					설정</button>

			</div>

			<div class="metee_mypage_main_wraper">
				<div class="table_container">
					<table class="order_table">
						<thead>
							<tr>
								<th>결제번호</th>
								<th>결제날짜</th>
								<th>강의명</th>
								<th>금액</th>
								<th>결제상태</th>
								<th>상품</th>

							</tr>
						</thead>
						<tbody>
							<c:forEach var="paymentdetaillist" items="${paymentdetaillist}">
								<c:forEach var="paymentlist" items="${paymentlist}">
									<tr class="order_row">

										<c:choose>
											<c:when test="${paymentlist.pno==paymentdetaillist.pno}">

												<td>${paymentdetaillist.pdno}</td>
												<td><time
														datetime="Fri Apr 01 2022 22:05:08 GMT+0900 (GMT+09:00)">${paymentlist.payment_date}</time>
												</td>


												<td class="order_name"><a class="link_to"
													href="/orders/1677392">${paymentdetaillist.vfilename} </a></td>
												<td class="pay_price"><span>₩${paymentdetaillist.price}</span><br>
													<span class="discounted">- ₩0</span><br> <span>₩${paymentdetaillist.price}</span>
												</td>
												<td>결제완료</td>
												<td><a class="link_to"
													onclick="location.href='../Mentor/videoview?vno=${paymentdetaillist.vno}'">보기</a></td>



											</c:when>
										</c:choose>


									</tr>
								</c:forEach>
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