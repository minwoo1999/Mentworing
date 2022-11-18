<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./jsp_header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/resources/css/style.css?after"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/styles.css?after"
	rel="stylesheet" />
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<title>Insert title here</title>
<style>
.pass_head {
	font-size: 50px;
	margin-bottom: 20px;
	text-align: center;
}
</style>
</head>


<script>
	function Cancel_btn() {
		findPassForm.id.value = "";
		findPassForm.email.value = "";
		findPassForm.id.focus();

	}

	function Check_Pre() {

		if (findPassForm.id.value.lenth < 1) {

			alert("아이디을 입력해주세요");
			findPassForm.id.value = "";
			findPassForm.id.focus();
			return false;

		}

		if (findPassForm.email.value.length < 1) {

			alert("email을 입력해주세요");
			findPassForm.email.value = "";
			findPassForm.email.focus();
			return false;
		}
		return true;
	}
</script>
<body>
	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->
	<spring:hasBindErrors name="user">
		<p align="left">
			<span class="fieldError"> <c:forEach var="error"
					items="${errors.globalErrors}">
					<spring:message code="${error.code}" />
				</c:forEach></span>
		</p>
	</spring:hasBindErrors>
	<h1>${errMsg}</h1>
	<div class="login-page">
	<p class="pass_head">비밀번호 찾기</p>
		<br> <br> <br>
		<div class="form">
			<form:form modelAttribute="user" Name='findPassForm' Method='post'
				Action='findPass' onsubmit='return Check_Pre()'>
				<p align="left">
					<span class="fieldError"> <form:errors path="id" /></span>
				</p>
				<input type="text" name='id' type="text" placeholder="아이디"
					required="required" />
				<p align="left">
					<span class="fieldError"> <form:errors path="email" /></span>
				</p>
				<input type="email" name='email' type="text" placeholder="이메일"
					required="required" />

				<button type="submit">비밀번호 찾기</button>
				<br>
				<br>
				<button type="reset" Onclick='Cancel_btn()'>취소</button>
			</form:form>
		</div>
	</div>
	<!-- 헤더부분 -->
	<%@include file="./footer.jsp"%>
	<!-- 헤더부분 -->
</body>
</html>