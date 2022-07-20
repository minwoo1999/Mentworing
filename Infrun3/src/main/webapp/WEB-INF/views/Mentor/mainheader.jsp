<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./jsp_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="${pageContext.request.contextPath}/resources/component/header.css?after"
	rel="stylesheet" />
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.8.2.js"></script>
<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

<meta charset="UTF-8">

<title>Insert title here</title>
</head>
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
<script>


function checkmentor(ma) {
    if(ma==null){
    	location.href = "mentor_register";
    }else{
    	alert("이미 신청하셨습니다");
    }
}
function logout(){
	
	sessionStorage.removeItem("mentorviewmentorname"); //멘티꺼니까 일반회원로그아웃에서 세션종료
	location.href="/member/logout";
	console.log("일반회원 로그아웃 및 세션종료");
	
}

function mentorlogout(){
	
	sessionStorage.removeItem("chatyourname"); //멘티꺼니까 일반회원로그아웃에서 세션종료
	location.href="/member/logout";
	console.log("멘토회원 로그아웃 및 세션종료");
	
}

</script>
<%
Object loginUser = session.getAttribute("userId");
Object mentoryn = session.getAttribute("mentoryn");
if (loginUser == null) {
%>

<body>
	<div class="bottom_header">
		<div class="bottom_header_main">
			<div class="bottom_header_left_menu">
				 <a class="title"
					href=../main>Mantworing</a>
				</a> <a class="left_menu one" href=/Mentor/Mentor_list> 멘토링 </a> <a
					class="left_menu two"> 강의목록 </a> <a class="left_menu three">
					멘토링 후기 </a> <a class="left_menu four" href=/board/list> Q & A </a>
			</div>
			<div class="bottom_header_right_menu">
				<button class="login" type="button" onclick="functionA();">로그인</button>
				<button class="join" type="button" onclick="functionB();">회원가입</button>
			</div>
		</div>
	</div>
	<!-- 로그인에 관련된 div 창 -->

	<script type="text/javascript">
	
	function functionB() {
		location.href = "/member/join;
	}
	
		function checkMsg() {
			var errCode = "${msgCode}";
			if (errCode != "") {
				alert(errCode);
			}
		}
	</script>
	<script type='text/javascript'>
		function functionA() {
			var overlay = $('<div id="overlay"></div>');
			console.log(overlay);
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

	<script type="text/javascript">
	
	function functionB() {
		location.href = "/member/join";
	}
	</script>
	<div class='popup'>
		<div class='cnt223'>
			<a href='' class='close'>X</a>

			<div class="login-page">
				<div class="form">
					<form:form class="login-form" modelAttribute="user" method="post"
						action="/member/login">

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
							<li id="lilogb"><a href="/member/join">회원가입</a></li>|
							<li id="lilog"><a href="/member/findId">아이디/</a> <a
								href="/member/findPass" class="pwd">비밀번호 찾기</a></li>
						</ul>
						</p>

					</form:form>

				</div>
			</div>




		</div>
	</div>

	<%
	} else if (loginUser.equals("asd")) {
	%>
	<div class="bottom_header">
		<div class="bottom_header_main">
			<div class="bottom_header_left_menu">
				 <a class="title"
					href="../main">ManTworing</a> <a class="left_menu one"
					href=/Mentor/Mentor_list> 멘토링 </a> <a class="left_menu two"
					onclick="location.href='/Mentee/mentee_videolist'"> 강의목록 </a> <a
					class="left_menu three" href="./mento"> 멘토링 후기 </a> <a
					class="left_menu four" href=/board/list> Q & A </a>
			</div>
			<div class="bottom_header_right_menu">
				<button class="join" type="button"
					onclick="location.href='/userlist'">회원관리</button>
				<button class="login" type="button"
					onclick="location.href='/member/logout'">로그아웃</button>
				<button class="join" type="button"
					onclick="location.href='/mentor_register_list'">멘토승인목록</button>
				<button class="join" type="button">마이페이지</button>

			</div>
		</div>
	</div>
	<!-- 로그인에 관련된 div 창 -->
	<%
	} else if (mentoryn != null) {
	%>

	<div class="top_header">
		<div class="top_header_main">
			<div class="top_header_left_menu">
				<i class="fa-brands fa-canadian-maple-leaf"></i> <a
					class="education" href="#">OOO</a>
			</div>
		</div>
	</div>
	<div class="bottom_header">
		<div class="bottom_header_main">
			<div class="bottom_header_left_menu">
				 <a class="title"
					href=../main>ManTworing</a>
				 <a class="left_menu one" href=/Mentor/Mentor_list> 멘토링 </a> <a
					class="left_menu two"
					onclick="location.href='/Mentee/mentee_videolist'"> 강의목록 </a> <a
					class="left_menu three"> 멘토링 후기 </a> <a class="left_menu four"
					href=/board/list> Q & A </a>
			</div>
			<div class="bottom_header_right_menu">


				<button class="join" type="button">마이페이지</button>
				<button class="join" type="button"
					onclick="location.href='../Mentor/videoupload'">강의업로드</button>
				<button class="join" type="button"
					onclick="location.href='../Mentor/Myvideo'">MY강의</button>
				<button class="join" type="button"
					onclick="location.href='../Mentor/mente_list'">멘티목록</button>


				<button class="login" type="button" onclick="mentorlogout();">로그아웃</button>


			</div>
		</div>
	</div>
	<!-- 로그인에 관련된 div 창 -->


	<%
	} else {
	%>
	<div class="bottom_header">
		<div class="bottom_header_main">
			<div class="bottom_header_left_menu">
				<a class="title" href=../main> Mantworing</a> </a> <a
					class="left_menu one" href=/Mentor/Mentor_list>멘토링 </a> <a
					class="left_menu two"
					onclick="location.href='/Mentee/mentee_videolist'"> 강의목록 </a> <a
					class="left_menu three"> 멘토링 후기 </a> <a class="left_menu four"
					href=/board/list> Q & A </a>
			</div>
			<div class="bottom_header_right_menu">
				<button class="shopping_cart" type="button"
					onclick="location.href='/basket/mainbasket'">
					<i class="fa-solid fa-cart-shopping"></i>
				</button>
				<div id="chat_div">
					<button class="fa-solid fa-comment" style="font-size:20px";></button>
					<span class="chat_count_bedge">${checkMessage}</span>
				</div>
				<button class="my_page" type="button"
					onclick="location.href='/mentee_Mypage'">
					<i class="fas fa-user"></i>
				</button>
				<button class="logout" type="button" onclick="logout();">로그아웃</button>


				<div class="messsage_container">
					<div id="slide"
						style="display: none; box-shadow: 0px 0px 7px -2px; flex-direction: column; width: 400px; border-radius: 15px; height: 100%; padding: 10px">
						<c:forEach var="notificationmember" items="${notificationmember}"
							varStatus="status">

							<a href="../Mentor/Mentorview?mno=${notificationmember.mno}">
								<img
								src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${notificationmember.memberprofile}"
								width="50px" height="50px" style="border-radius: 40px;" /></img>
								${notificationmember.name}멘토가 보낸메세지
								수:${notificationmember.notificationnumber}
							</a>
							<br>


						</c:forEach>
					</div>
				</div>

			</div>
		</div>
	</div>
	</div>


	<!-- 로그인에 관련된 div 창 -->
	<%
	} //
	%>
</body>
<script>

chat_div.onmouseover = function(event) {

	$("#slide").css("display", "block ");
	
};

slide.onmouseleave = function(event) {

	$("#slide").css("display", "none");
};
	
	





</script>

</html>