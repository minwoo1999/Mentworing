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
<link rel="stylesheet"
	href="https://cdn.inflearn.com/dist/css/MAIN.e591d738c57f9294d012.css?after" />
<link rel="stylesheet"
	href="https://cdn.inflearn.com/dist/css/_order_list.33bc13562d1e0dd9ac3a.css?after" />
<link rel="stylesheet"
	href="https://cdn.inflearn.com/dist/vendor/bulma-accordion.min.css?after" />
<link rel="stylesheet"
	href="https://cdn.inflearn.com/dist/vendor/bulma-switch.min.css?after" />
<link rel="stylesheet"
	href="https://cdn.inflearn.com/dist/vendor/bulma-tooltip.min.css?after" />
<link rel="stylesheet"
	href="https://cdn.inflearn.com/dist/fontawesome/css/all.css?after" />
<title>Insert title here</title>
</head>
<body>
	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->

	<br>
	<br>
	<br>
	<main id="main">
		<section class="user_orders_section">
			<div class="container">
				<div class="column is-centered">
					<h3>내 구매 내역</h3>
					<div class="table_container">
						<table
							class="order table is-bordered is-fullwidth is-striped is-hoverable is-centered">
							<thead>
								<tr>
									<th>주문 번호</th>
									<th>주문 날짜</th>
									<th>상태</th>
									<th>주문명</th>
									<th>금액</th>
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
													<td>결제완료</td>

													<td class="order_name"><a class="link_to"
														href="/orders/1677392">${paymentdetaillist.vfilename}
															</a></td>
													<td class="pay_price"><span>₩${paymentdetaillist.price}</span><br>
														<span class="discounted">- ₩0</span><br> <span>₩${paymentdetaillist.price}</span>
													</td>
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
		</section>
	</main>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>


	<!-- 하단부분 -->
	<%@ include file="./footer.jsp"%>
	<!-- 하단부분 -->

</body>
</html>