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
    font-size: 14px;
    font-weight: 400;
    color: #888;
    cursor: pointer;
}

#login_dodge_btn {
	position: absolute;
	right: 0;
	top: 0;
	margin-right: 10px;
	margin-top: 10px;
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
    margin: 10% auto;
    background: #ffffff;
    position: relative;
    z-index: 103;
    padding: 15px 35px;
    border-radius: 5px;
    box-shadow: 0px 0px 3px 0px whitesmoke;
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
				<a class="title" href=../main>Mentworing</a> </a> <a
					class="left_menu one" href=../Mentor/courseList> 강의 </a> <a
					class="left_menu one" href=/Mentor/Mentor_list> 멘토링 </a> <a class="left_menu three"
					href=../board/Mentor_Review> 멘토링 후기 </a> <a class="left_menu four"
					href=/board/list> Q & A </a>
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
			<a href='' class='close' id="login_dodge_btn">⨉</a>

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

						
						<form:input path='id' type="text" placeholder="아이디"
							class="login_input" id="loginIdInput" />

						
						<form:input path='pass' type="password" placeholder="비밀번호"
							class="login_input" id="loginPasswordInput" />

						<button type="submit">login</button>

						<p class="message">
						<ul id="ullog">
							<li id="lilogb"><a href="/member/join">회원가입</a></li>
							<span class="login_side_bar">|</span>
							<li id="lilog"><a href="/member/findId">아이디 찾기</a> </li>
							<span class="login_side_bar">|</span>
							<li id="lilog"><a
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
				<a class="title" href="../main">Mentworing</a> <a
					class="left_menu one" href=../Mentor/courseList> 강의 </a> <a
					class="left_menu one" href=/Mentor/Mentor_list> 멘토링 </a> <a
					class="left_menu three" href=../board/Mentor_Review> 멘토링 후기 </a> <a
					class="left_menu four" href=/board/list> Q & A </a>
			</div>
			<div class="bottom_header_right_menu">
				<button class="join" type="button"
					onclick="location.href='/userlist'">회원관리</button>
				<button class="join" type="button"
					onclick="location.href='/mentor_register_list'">멘토승인목록</button>
				<button class="login" type="button"
					onclick="location.href='/member/logout'">로그아웃</button>



			</div>
		</div>
	</div>
	<!-- 로그인에 관련된 div 창 -->
	<%
	} else if (mentoryn != null) {
	%>

	<div class="bottom_header">
		<div class="bottom_header_main">
			<div class="bottom_header_left_menu">
				<a class="title" href=../main>Mentworing</a> <a
					class="left_menu one" href=../Mentor/courseList> 강의 </a> <a
					class="left_menu one" href=/Mentor/Mentor_list> 멘토링 </a> <a
					class="left_menu three" href=../board/Mentor_Review> 멘토링 후기 </a> <a
					class="left_menu four" href=/board/list> Q & A </a>
			</div>
			<div class="bottom_header_right_menu">


				<button class="join mentor_header_margin" type="button"
					onclick="location.href='../Mentor/Myvideo'"><i class="fas fa-user"></i></button>
				<button class="join mentor_header_margin" type="button"
					onclick="location.href='../Mentor/videoupload'"><i class="fa-solid fa-photo-film"></i></button>
					
				<button class="join mentor_header_margin" type="button"
					onclick="location.href='../Mentor/mente_list'"><i class="fa-solid fa-users"></i><span class="menteeSendChatCount">${sumMessage}</span></button>


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
				<a class="title" href=../main> Mentworing</a> </a> <a
					class="left_menu one" href=../Mentor/courseList> 강의 </a> <a
					class="left_menu one" href=/Mentor/Mentor_list>멘토링 </a> <a
					class="left_menu two" href="/mentor_register"> 멘토신청 </a> <a
					class="left_menu three" href=../board/Mentor_Review> 멘토링 후기 </a> <a
					class="left_menu four" href=/board/list> Q & A </a>
			</div>
			<div class="bottom_header_right_menu">

				<div id="basket_div">
					<button class="shopping_cart" type="button"
						onclick="location.href='/basket/mainbasket'">
						<i class="fa-solid fa-cart-shopping"></i>
					</button>
					<span class="basket_count_bedge">${basketcounting}</span>
				</div>
				<div id="chat_div">
					<button class="fa-solid fa-comment" style="font-size: 20px";></button>
					<span class="chat_count_bedge">${checkMessage}</span>
				</div>
				<button class="my_page" type="button"
					onclick="location.href='../Mentee/mentee_Mypage_videolist'">
					<i class="fas fa-user"></i>
				</button>
				<button class="logout" type="button" onclick="logout();">로그아웃</button>

			</div>
		</div>

	</div>
	<div class="messsage_container">
		<div id="slide"
			style="display: none;box-shadow: 0px 0px 7px -2px;flex-direction: column;width: 350px;/* height: 350px; */min-height: 200px;background: rgb(255, 255, 255);border-radius: 10px;padding: 0px 10px;max-height: 350px;">
			<div class="caht_slide_title">
				<span>읽지 않은 <span class="point_text">메세지</span></span>
			</div>
			<div class="chat_box_wrapper">
			<c:forEach var="notificationmember" items="${notificationmember}"
				varStatus="status">
				
					<div class="chat_box_message_box">
	
						<a href="../Mentor/Mentorview?mno=${notificationmember.mno}"
							class="message_box_flex"> <img
							src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${notificationmember.memberprofile}"
							width="50px" height="50px" style="border-radius: 5px;" /></img> <span
							class="side_margin_span"><span class="chat_name_width">${notificationmember.name}</span>멘토가
								보낸메세지</span> ${notificationmember.notificationnumber}
						</a>
					</div>
				

			</c:forEach>
			</div>
		</div>

	</div>
	<div class="messsage_container2">
		<div id="basket_slide">
			<div class="basket_slide_inside" id="basket_slide_inside">
				<div class="basket_slide_title_bar">
					<span>수강바구니</span>
				</div>
				<c:set var="sum" value="0" />
				<div class="basket_slide_content_box">
					<c:forEach var="basket" items="${basket}" varStatus="status">

						<div class="basket_slide_content">
							<div>
								<video
									src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${basket.bfilename}"
									width="90px" height="60px" /></video>
							</div>
							<div class="basket_slide_content_title_price">
								<span class="basket_title">${basket.title}</span> <span class="basket_prcie_span">${basket.price}<span>원</span></span>
							</div>
							<c:set var="sum" value="${sum + basket.price}" />
						</div>

					</c:forEach>
				</div>
				<div class="basket_slide_footer_bar">
					<span>총결제금액</span> <input type="text"
						class="basket_slide_price_box" readonly value="${sum}"> <span>원</span>
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

	$(".talk_login_header_icon").css("background","#1dc078");
	$("#slide").css("display", "block ");
	$("#basket_slide").css("display", "none");
	$(".cart_login_header_icon").css("background","none");
	
	
};

slide.onmouseleave = function(event) {

	$(".talk_login_header_icon").css("background","none");
	$("#slide").css("display", "none");
};

basket_div.onmouseover = function(event) {
	console.log("들어옴");
	$("#basket_slide").css("display", "block");
	$(".cart_login_header_icon").css("background","#1dc078");
	$(".talk_login_header_icon").css("background","none");
	$("#slide").css("display", "none");b
	
};

basket_slide_inside.onmouseleave = function(event) {
	$("#basket_slide").css("display", "none");
	$(".cart_login_header_icon").css("background","none");
};
	
	





</script>

</html>