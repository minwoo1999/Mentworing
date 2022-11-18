<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 성공화면</title>
<style>
.form {
	display: block;
	margintop: 20px;
	position: relative;
	z-index: 1;
	height: 500px;
	background: #FFFFFF;
	max-width: 360px;
	margin: 0 auto 100px;
	padding: 45px;
	text-align: center;
	border-radius: 30px/30px;
	box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0
		rgba(0, 0, 0, 0.24);
	margintop: 50px;
}

* {
	user-select: none;
	outline: none;
}

.login-page {
	width: 500px;
	padding: 0 0 0;
	margin: auto;
	text-align: center;
	background: #B7F0B1;
	height: 800px;
	border-radius: 50px/30px;
}

.login_box {
	width: 80%;
	background: #3fe87f;
	padding-bottom: 20px;
	margin: 0 auto;
}

.login_title {
	padding: 15px 0px 15px 0px;
	font-size: 25px;
	font-weight: bold;
	color: #444444;
	text-align: center;
	margin-bottom: 1em;
}

.login_id, .login_pwd {
	width: 100%;
	text-align: center;
}

.inp {
	width: 80%;
	font-size: 17px;
	background: none;
	border: 0px;
	border-bottom: 1px solid #777;
	outline: none;
	margin-top: 1em;
	margin: 10px 0px 10px 0px;
	padding-top: 10px;
	padding-bottom: 10px;
}

.inp:focus {
	border-bottom: 1px solid #4a4a4a;
}

.inp::placeholder {
	color: #3F3F3F;
}

.login_input {
	margin-bottom: 3em;
}

.btn_login {
	text-align: center;
}

.btn_login>button {
	width: 70%;
	padding: 10px 0px 10px 0px;
	border: 0px;
	background:  #B7F0B1;
	font-size: 17px;
	color: #000000;
	font-weight: bold;
	border-radius: 30px/30px;
}

.others {
	text-align: center;
}

.others ul {
	padding-left: 0px;
}

.others ul>span {
	color: #DEDEDE;
}

.others ul>li {
	display: inline-block;
}

.others ul>li a {
	color: #4A4A4A;
	text-decoration: none;
	font-size: 15px;
}
</style>
</head>
<body>
	


	<div class="login-page">
		<br> <br>

		<h1>로그인성공</h1>


		<br> <br>
		<div class="form">
			<h2>
				로그인 성공
				<h2>
					<br> <br> <br> <br>
					<center>
						<h5> 환영합니다,${ loginUser.name }씨！
							<h5>
					</center>
					<br> <br> <br> <br>

					<div class="btn_box">
						<div class="btn_login">
							<button type="button" onclick="location.href='/bbs/editUser?userId=${loginUser.id}'">회원정보수정</button>
						</div>
						<div class="btn_login">
							<button type="button" onclick="location.href='/bbs/logout'">[logout]</button>
						</div>
						<div class="others"></div>
					</div>
		</div>
</body>
</html>