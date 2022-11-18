<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./jsp_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/resources/css/styles.css"
	rel="stylesheet" />
<!-- 헤더부분 -->
<%@include file="./mainheader.jsp"%>
<!-- 헤더부분 -->
<script src="https://kit.fontawesome.com/20556dcc55.js"
	crossorigin="anonymous"></script>
<title>Insert title here</title>
<script>

function Check_Form(){
	
	var certificate_number=document.getElementById("certificate_number").value
	
	const randomnumber=document.getElementById("randomnumber").value
	
	if (randomnumber!=certificate_number){
		alert("SMS 인증번호가 일치하지않습니다");
		return false;
	}else{
		return true;
	}
}

</script>
</head>
<body>
<% Object random_Str = session.getAttribute("random_Str"); %>

	<form action="/member/second_certificate" method="post" onsubmit='return Check_Form()'>
		<div class="second_certificate_container">
			<div class="second_certificate_wraper">
				<div class="second_certificate_title_box">
					<input type="hidden" id="randomnumber" value="<%=random_Str%>">
					<span class="second_certificate_title">SMS 인증번호를 입력해주세요.</span> <span
						class="second_certificate_sub_title">Please enter SMS
						authentication number.</span>
				</div>
				<div class="second_certificate_input_box">
					<input type="text" placeholder="인증번호입력" name="certificate_number" id="certificate_number"
						class="second_certificate_input">
					<div id="timer"></div>
				</div>
				<div class="second_certificate_login_box">
					<button type="submit">2차 로그인</button>
				</div>
				<div class="second_certificate_information_box">
					<span>· Mentworing에 등록된 휴대전화 번호로 SMS 메시지가 발송됩니다.</span> <span>·
						SMS로 인증번호가 발송되지 않을 경우 개인정보 페이지에서 휴대전화를 확인하십시오.</span> <span>· 인증에
						문제가 있는 경우 Q&A로 문의해주세요.</span>
				</div>
			</div>
		</div>
	</form>
	<!-- 하단부분 -->
	<%@ include file="./footer.jsp"%>
	<!-- 하단부분 -->
</body>
<script>
	var time = 180;
	var min = "";
	var sec = "";

	var timer = setInterval(function() {

		min = parseInt(time / 60);
		sec = time % 60;

		document.getElementById("timer").innerHTML = min + "분" + sec + "초";
		time--;

		if (time < 0) {
			clearInterval(timer);
			document.getElementById("timer").innerHTML = "시간초과";
		}
	}, 1000);
</script>
</html>