<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="./jsp_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet" />
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.resultscreen {
	justify-content: center;
	font-size: 50px;
	display: flex;
	text-align: center;
}

.findid {
	font-size: 20px;
}
</style>

</head>
<body>
	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->
	<div class="login-page">

		<a class="resultscreen">결과화면</a> <br> <br>
		<div class="form">
			<br> <br> <br> <br> <a class="findid">${userId}님의
				비밀번호 변경완료 </a> <br> <br> <br> <br> <br> <br>

			<div class="btn_box">
				<div class="btn_login">
					<button type="button" onclick="location.href='/main'">로그인</button>
				</div>
				<div class="others"></div>
			</div>
		</div>

		<div class="footer">
			<!-- 하단부분 -->
			<%@include file="./footer.jsp"%>
			<!-- 하단부분 -->
		</div>
</body>
</html>