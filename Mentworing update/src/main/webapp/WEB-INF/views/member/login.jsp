<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./jsp_header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.8.2.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet" />

<style>
#overlay {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: #000;
	filter: alpha(opacity = 70);
	-moz-opacity: 0.7;
	-khtml-opacity: 0.7;
	opacity: 0.7;
	z-index: 100;
	display: none;
}

.cnt223 a {
	    text-decoration: none;
    line-height: 1.38;
    letter-spacing: -.3px;
    font-size: 20px;
    font-weight: 400;
    color: #616568;
    border-bottom: 1px solid #858a8d;
    cursor: pointer;
}

.popup {
	width: 100%;
	margin: 0 auto;
	display: none;
	position: fixed;
	z-index: 101;
}

.cnt223 {
	min-width: 450px;
    width: 200px;
    min-height: 150px;
    margin: 100px auto;
    background: #f3f3f3;
    position: relative;
    z-index: 103;
    padding: 15px 35px;
    border-radius: 5px;
    box-shadow: 0 5px 5px #f3f3f3;
}
}

.cnt223 p {
	clear: both;
	color: #555555;
	/* text-align: justify; */
	font-size: 20px;
	font-family: sans-serif;
}

.cnt223 p a {
	color: #d91900;
	font-weight: bold;
}

.cnt223 .x {
	float: right;
	height: 35px;
	left: 22px;
	position: relative;
	top: -25px;
	width: 34px;
}

.cnt223 .x:hover {
	cursor: pointer;
}
</style>
</head>
<script type='text/javascript'>
	$(function() {
		var overlay = $('<div id="overlay"></div>');
		overlay.show();
		overlay.appendTo(document.body);
		$('.popup').show();
		$('.close').click(function() {
			$('.popup').hide();
			overlay.appendTo(document.body).remove();
			return false;
		});

		$('.x').click(function() {
			$('.popup').hide();
			overlay.appendTo(document.body).remove();
			return false;
		});
	});

	function functionA() {
		var overlay = $('<div id="overlay"></div>');
		overlay.show();
		overlay.appendTo(document.body);
		$('.popup').show();
		$('.close').click(function() {
			$('.popup').hide();
			overlay.appendTo(document.body).remove();
			return false;
		});
	}
</script>
<body style="overflow-y: hidden">
	<script type="text/javascript">
		function checkMsg() {
			var errCode = "${msgCode}";
			if (errCode != "") {
				alert(errCode);
			}
		}
	</script>

	<div class='popup'>
		<div class='cnt223'>
		<a href='' class='close'>X</a>

			<div class="login-page">
				<div class="form">
					<form:form class="login-form" modelAttribute="user" method="post"
						action="login.do">

						<spring:hasBindErrors name="user">
							<p align="left">
								<span class="fieldError"> <c:forEach var="error"
										items="${errors.globalErrors}">
										<spring:message code="${error.code}" />
									</c:forEach></span>
							</p>
						</spring:hasBindErrors>

						<p align="left">
							<form:errors path="id" class="fieldError" />
						</p>
						<form:input path='id' type="text" placeholder="username" />

						<p align="left">
							<span class="fieldError"><form:errors path="pass" /></span>
						</p>
						<form:input path='pass' type="password" placeholder="password" />

						<button type="submit">login</button>

						<p class="message">
						<ul id="ullog">
							<li id="lilogb"><a href="/bbs/join">회원가입</a></li>|
							<li id="lilog"><a href="/bbs/findId">아이디/</a> <a
								href="/bbs/findPass" class="pwd">비밀번호 찾기</a></li>
						</ul>
						</p>

					</form:form>

				</div>
			</div>


			

		</div>
	</div>
	<button onclick="functionA();">키기</button>
<body onload="checkMsg()">

</body>


</html>