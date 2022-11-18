<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./jsp_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="${pageContext.request.contextPath}/resources/css/styles.css?after"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/resources/css/style.css?after"
	rel="stylesheet" />
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->
	<div class="mentee_mypage_videolist_body">

		<div class="mentee_mypage_title_container">
				<div class="mentee_mypage_title_wraper">
					<span class=mentee_mypage_title_title>my lectures</span>
					<span class=mentee_mypage_title_subtitle>내 강의를 확인할 수 있습니다.</span>
				</div>
			</div>
		<div class="metee_mypage_container">
			<div class="metee_mypage_side_wraper">
			<span class="menu_title_box_span">Menu</span>
				<button onclick="location.href='../Mentee/mentee_Mypage_videolist'" id="select_video_list">강의목록</button>
				<button onclick="location.href='../mentee_Mypage_paymentlist'">결제목록</button>
				<button onclick="location.href='../basket/mentee_Mypage_coupon'">쿠폰함</button>
				<button onclick="location.href='../mentee_Mypage'">개인정보 수정</button>
				<button onclick="location.href='../mentee_MyPage_certificate'">2차인증 설정</button>
				
			</div>
			<div class="metee_mypage_main_wraper">
				<div class="mentee_my_page_main_section">
				<c:forEach var="video" items="${video}">
					<c:forEach var="paymentList" items="${paymentList}">
						<c:choose>
		
							<c:when test="${paymentList.userId==userId}">
		
								<c:if test="${video.vno==paymentList.vno}">
								
									<div class="mentee_my_page_lecture">
										<a href="../Mentor/videoview?vno=${paymentList.vno}"><video
												src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${paymentList.vfilename}"
												class="mentee_videolist_content_img"></video></a>
										<div class="mentee_my_page_lecture_information">
											<span>${video.videoname}</span>
											<span>${video.videotype}</span>
										</div>
									</div>
								
								</c:if>
		
		
							</c:when>
		
						</c:choose>
		
					</c:forEach>
				</c:forEach>
				</div>
			</div>
		
	</div>
	</div>
	<!-- 하단부분 -->
		<%@ include file="./footer.jsp"%>
		<!-- 하단부분 -->
</body>
</html>