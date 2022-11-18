<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./jsp_header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<link
	href="${pageContext.request.contextPath}/resources/css/style.css?after"
	rel="stylesheet" />
<title>Insert title here</title>
<style>
.resultscreen {
	justify-content: center;
    font-size: 40px;
    display: flex;
    margin-top: 50px;
    margin-bottom: 20px;
    text-align: center;
}
</style>
</head>

<script>
	function Cancel_btn() {
		updatePassForm.pass2.value = "";
		updatePassForm.pass.value = "";
		updatePassForm.name.focus();

	}

	function Check_Pre() {

		if (updatePassForm.pass.value.lenth < 1) {

			alert("패스워드을 입력해주세요");
			updatePassForm.pass.value = "";
			updatePassForm.pass.focus();
			return false;

		}

		if (updatePassForm.pass2.value.length < 1) {

			alert("패스워드 확인을 입력해주세요");
			updatePassForm.pass2.value = "";
			updatePassForm.pass2.focus();
			return false;
		}

		if (updatePassForm.pass.value != updatePassForm.pass2.value) {

			alert("패스워드가 일치하지않습니다.");
			updatePassForm.pass2.value = "";
			updatePassForm.pass2.focus();
			return false;
		}
		return true;
	}
</script>
<body>
	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->
	<h1>${errMsg}</h1>
	<br>
	<br>
	<br>

		<a class="resultscreen">비밀번호 변경화면</a>

	<br>
	<br>
	<br>
	<div class="form">
		<form:form modelAttribute="user" Name='updatePassForm' Method='post'
			Action='updatePass' onsubmit='return Check_Pre()'>
			<form:input path="id" type="text" readonly='true' placeholder="아이디" />
			<span class="fieldError"><form:errors path="id" /></span>

			<form:input path="pass" type="password" showPassword="true"
				placeholder="비밀번호" name="pass" />
			<input type="password" value="${pass}" showPassword="true"
				name="pass2" placeholder="비밀번호 확인" />

			<button type="submit">비밀번호수정</button>
			<br>
			<br>
			<button type="reset" Onclick='Cancel_btn()'>취소</button>
		</form:form>
	</div>
</body>
</html>