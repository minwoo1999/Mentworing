<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./jsp_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<link href="${pageContext.request.contextPath}/resources/css/style.css?after"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/styles.css?after"
	rel="stylesheet" />
<title>Insert title here</title>
<style>
.id_head {
	font-size: 50px;
	margin-bottom: 20px;
	text-align: center;
}
</style>
</head>

<script>
	function Cancel_btn() {
		findIdForm.name.value = "";
		findIdForm.pass.value = "";
		findIdForm.name.focus();

	}

	function Check_Pre() {

		if (findIdForm.name.value.lenth < 1) {

			alert("이름을 입력해주세요");
			findIdForm.name.value = "";
			findIdForm.name.focus();
			return false;

		}

		if (findIdForm.email.value.length < 1) {

			alert("email을 입력해주세요");
			findIdForm.email.value = "";
			findIdForm.email.focus();
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


	<div class="login-page">

		<p class="id_head">아이디 찾기</p>
		<br> <br> <br>
		<div class="form">

			<form:form modelAttribute="user" Name='findIdForm' Method='post'
				Action='findId' onsubmit='return Check_Pre()'>

				<spring:hasBindErrors name="user">
					<p align="left">
						<span class="fieldError"> <c:forEach var="error"
								items="${errors.globalErrors}">
								<spring:message code="${error.code}" />
							</c:forEach></span>
					</p>
				</spring:hasBindErrors>


				<p align="left">
					<form:errors path="name" class="fieldError" />
				</p>



				<form:input path='name' type="text" placeholder="이름" />


				<p align="left">
					<form:errors path="email" class="fieldError" />
				</p>
				<form:input path='email' type="text" placeholder="이메일" />
				<button type="submit">아이디 찾기</button>
				<br>
				<br>
				<button type="reset" Onclick='Cancel_btn()'>취소</button>
			</form:form>
		</div>
	</div>
	<div class="footer">
		<!-- 하단부분 -->
		<%@include file="./footer.jsp"%>
		<!-- 하단부분 -->
	</div>
	
</body>
</html>