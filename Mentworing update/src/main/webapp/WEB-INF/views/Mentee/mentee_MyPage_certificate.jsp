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
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.3/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->
	
	<input type="hidden" value="<%=loginUser%>" id="userId">
	<div class="mentee_mypage_certificate_title_container">
				<div class="mentee_mypage_certificate_title_wraper">
			<span class=mentee_mypage_certificate_title_title>Secure your account with secondary authentication</span>
			<span class=mentee_mypage_certificate_title_subtitle>2차 인증을 통해 계정을 보호하세요.</span>
		</div>
	</div>
	<div class="mentee_mypage_coupon_body">
		<div class="metee_mypage_container">
			<div class="metee_mypage_side_wraper">
				<span class="menu_title_box_span">Menu</span>
				<button onclick="location.href='../Mentee/mentee_Mypage_videolist'">강의목록</button>
				<button onclick="location.href='../mentee_Mypage_paymentlist'">결제목록</button>
				<button onclick="location.href='../basket/mentee_Mypage_coupon'"
					>쿠폰함</button>
				<button onclick="location.href='../mentee_Mypage'">개인정보 수정</button>
				<button onclick="location.href='../mentee_MyPage_certificate'" id="select_coupone_list">2차인증
					설정</button>
			</div>
			<div class="metee_mypage_certificate_main_wraper">
				<div class="metee_mypage_certificate_text_box">
					<span>• 2차 인증 기능을 활성화하시면 로그인 시 SMS 인증번호 입력을 통해 계정을 보호하실 수 있습니다.</span>
					<span>• Secondary authentication sms when you login to activate the authentication can protect your account through the numbers.</span>
				</div>
				<div class="certificate_btn_box">
				
					<label class="switch"> 
					<input type="checkbox" id="checkbox"> 
						<span class="slider round"></span>
					</label>
				<p id="certificate_onoff"></p>
				</div>
				<input type="hidden" value="${authenticationId_check}" id="authenticationId_check">
				<!-- <p style="display: none;">ON</p>  --> 
			</div>
		</div>
		
		
	</div>
	
	
	<!-- 하단부분 -->
	<%@ include file="./footer.jsp"%>
	<!-- 하단부분 -->
	
<script src="resources/js/test.js"></script>
</body>
</html>