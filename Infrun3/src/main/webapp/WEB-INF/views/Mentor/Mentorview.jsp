<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./jsp_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="${pageContext.request.contextPath}/resources/css/styles.css?after"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/resources/css/style.css?after"
	rel="stylesheet" />
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.8.2.js"></script>
<meta charset="UTF-8">

<title>Insert title here</title>
<!-- 로그인 클릭시 나오는 화면 자바 스크립트 -->
</head>
<script>
	function movebasket() {

		var values = document.getElementsByName("vno");
		var count = 0;
		for (var i = 0; i < values.length; i++) {
			if (values[i].checked) {
				count++;
			}
		}
		if (count < 1) {

			alert("장바구니를 체크해주세요");
			return false;

		} else {
			return true;
		}

	}
</script>
<script type='text/javascript'>
	function functionC(mentorname, mentorprofile, memberprofile) {
		var username = document.getElementById("username").value;
		console.log(memberprofile);
		console.log(mentorprofile);
		console.log("멘토이름" + mentorname);
		console.log("유저이름" + username);
		const userId = document.getElementById("paymentId").value;
		if (userId == "") {
			alert("결제를 한 후 이용부탁드립니다");
			history(-1);
		}
		sessionStorage.setItem('mentorviewmentorname', mentorname); // 세션 등록
		$
				.ajax({
					url : "/Mentor/mente_list_getchatname?mentorname="
							+ mentorname,
					type : 'get',
					dataType : 'json',
					success : function(result) {
						if (result != null) {
							console.log(result);
							for (var i = 0; i < result.length; i++) {

								if (memberprofile != "") {
									if (result.at(i).name == username) {
										$("#chating")
												.append(

														"<div class='chat_box_menti'><div class='chat_box_menti_chat_time'><span class='me'>"
																+ result.at(i).message
																+ "</span><span id='chat_me_date'>"
																+ result.at(i).chat_date
																+ "</span>"
																+ "</div>"
																+ "<img src='https://infruntest.s3.ap-northeast-2.amazonaws.com/"+ memberprofile +"' class='chat_my_img' height='30' width='30'>");

										$('#chating').scrollTop(
												$('#chating')[0].scrollHeight);
									}
								} else {
									if (result.at(i).name == username) {
										$("#chating")
												.append(

														"<div class='chat_box_menti'><div class='chat_box_menti_chat_time'><span class='me'>"
																+ result.at(i).message
																+ "</span><span id='chat_me_date'>"
																+ result.at(i).chat_date
																+ "</span>"
																+ "</div>"
																+ "<img src='${pageContext.request.contextPath}/resources/img/profile.jpg' class='chat_my_img' height='30' width='30'>");

										$('#chating').scrollTop(
												$('#chating')[0].scrollHeight);
									}
								}

								if (result.at(i).name == mentorname) {
									$("#chating")
											.append(
													"<div class='chat_box_mentor'><img src='https://infruntest.s3.ap-northeast-2.amazonaws.com/"+ mentorprofile +"' id='img2' height='30' width='30' class='chat_other_img'><div class='chat_box_mentor_chat_time'> <span class='others'>"
															+ "멘토"
															+ result.at(i).name
															+ " :"
															+ result.at(i).message
															+ "</span><span id='chat_others_date'>"
															+ result.at(i).chat_date
															+ "</span>"
															+ "</div>");

								}
							}

						} else {
							console.log("실패 ㅠ");
						}
					}
				});

		var overlay = $('<div class="overlay"></div>');
		console.log(overlay);
		overlay.show();
		overlay.appendTo(document.body);
		$('.Login_popup').show();
		$('.close').click(function() {
			$('.Login_popup').hide();
			overlay.appendTo(document.body).remove();
			$("#otherchattingname").empty();
			location.reload();
			return false;
		});
	}
</script>


<body>

	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->

	<%
	if (loginUser == null) {
	%>

	<div class="mentorview_body">
		<div class="profile_container">
			<div class="profile_wraper">
				<div class="profile">
					<div class=profile_img_box>
						<div class="profile-image">
							<img
								src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${mentor.profile}" />
						</div>

					</div>
					<div class="profile_information_box">
						<div class="profile_title">
							<span class="profile_name">"안녕하세요, 멘토 ${mentorname} 입니다."</span>
						</div>
						<div class="profile_class_intro_box">
							<span class="class_intro"> 강좌 소개 </span>
							<p class="profile_class_intro">${mentor.introduce}</p>
							<span class="class_intro"> 이런 분들에게 추천합니다. </span>
							<p class="profile_rcmcomment_intro">${mentor.rcmcomment}</p>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class=mentor_view_content_nav>
			<div class="mentor_view_content_header_container">
				<div class="mentor_view_content_header">
					<a class="mentor_view_content_header_title" href="#"> <span>${username}
							멘토의 강의 목록 </span> <i class="fa-solid fa-angle-right"></i>
					</a> <span class="mentor_view_content_sub_title"> 원하는 강의를 수강하시고
						실력을 키워보세요 </span>
				</div>
			</div>
		</div>
		<form class="mentorview_container" action="../Mentor/Mentorview"
			method="POST" onsubmit="return movebasket()">
			<div class="mentorview_wraper">
				<c:forEach var="video" items="${videolist}">
					<c:choose>
						<c:when test="${video.mno==mno}">
							<div class="mentorview_content">
								<input type="checkbox" id="vno" name="vno" value="${video.vno}">
								<div class=mentorview_content_video>
									<a href="../Mentor/videoview?vno=${video.vno}"> <video
											src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${video.videofile}"
											class="mentorview_content_img"></video></a>
								</div>
								<div class=mentorview_content_information>
									<span class="mentorview_content_name">${video.videoname}</span>
									<span class="mentorview_content_pay">₩${video.videoprice}원</span>
								</div>
							</div>
						</c:when>
					</c:choose>
				</c:forEach>

			</div>
	</div>
	</form>
	<%
	} else if (mentoryn != null) {
	%>

	<div class='Login_popup'>
		<div class='Login_cnt223'>
			<%@include file="../chat.jsp"%>
			<a href='' class='close'>X</a>
		</div>
	</div>
	<div class="mentorview_body">
		<div class="profile_container">
			<div class="profile_wraper">
				<div class="profile">
					<div class=profile_img_box>
						<div class="profile-image">
							<img
								src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${mentor.profile}" />
						</div>
					</div>
					<div class="profile_information_box">
						<div class="profile_title">
							<span class="profile_name">"안녕하세요, 멘토 ${mentorname} 입니다."</span>
						</div>
						<div class="profile_class_intro_box">
							<span class="class_intro"> 강좌 소개 </span>
							<p class="profile_class_intro">${mentor.introduce}</p>
							<span class="class_intro"> 이런 분들에게 추천합니다. </span>
							<p class="profile_rcmcomment_intro">${mentor.rcmcomment}</p>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class=mentor_view_content_nav>
			<div class="mentor_view_content_header_container">
				<div class="mentor_view_content_header">
					<a class="mentor_view_content_header_title" href="#"> <span>${username}
							멘토의 강의 목록 </span> <i class="fa-solid fa-angle-right"></i>
					</a> <span class="mentor_view_content_sub_title"> 원하는 강의를 수강하시고
						실력을 키워보세요 </span>
				</div>
			</div>
		</div>
		<form class="mentorview_container" action="../Mentor/Mentorview"
			method="POST" onsubmit="return movebasket()">
			<div class="mentorview_wraper">
				<c:forEach var="video" items="${videolist}">
					<c:choose>
						<c:when test="${video.mno==mno}">
							<div class="mentorview_content">
								<input type="checkbox" id="vno" name="vno" value="${video.vno}">
								<div class=mentorview_content_video>
									<a href="../Mentor/videoview?vno=${video.vno}"> <video
											src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${video.videofile}"
											class="mentorview_content_img"></video></a>
								</div>
								<div class=mentorview_content_information>
									<span class="mentorview_content_name">${video.videoname}</span>
									<span class="mentorview_content_pay">₩${video.videoprice}원</span>
								</div>
							</div>
						</c:when>
					</c:choose>
				</c:forEach>

			</div>
			<div class="basketbutton">
				<input type="submit" value="장바구니담기">
			</div>
	</div>
	</form>

	<%
	} else {
	%>

	<div class='Login_popup'>
		<div class='Login_cnt223'>
			<%@include file="../Mentor/Mentor_chat.jsp"%>
		</div>
	</div>
	<div class="mentorview_body">
		<div class="profile_container">
			<div class="profile_wraper">
				<div class="profile">
					<div class=profile_img_box>
						<div class="profile-image">
							<img
								src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${mentor.profile}" />
						</div>

						<div class="profile_chat">
							<input type="hidden" value="${name}" id="username"> <input
								type="hidden" value="${paymentId}" id="paymentId">

							<button class="btn_chat"
								onclick="functionC('${mentorname}','${mentor.profile}','${memberprofile.profile}');">멘토에게
								질문하세요!</button>

						</div>
					</div>
					<div class="profile_information_box">
						<div class="profile_title">
							<span class="profile_name">"안녕하세요, 멘토 ${mentorname} 입니다."</span>
						</div>
						<div class="profile_class_intro_box">
							<span class="class_intro"> 강좌 소개 </span>
							<p class="profile_class_intro">${mentor.introduce}</p>
							<span class="class_intro"> 이런 분들에게 추천합니다. </span>
							<p class="profile_rcmcomment_intro">${mentor.rcmcomment}</p>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class=mentor_view_content_nav>
			<div class="mentor_view_content_header_container">
				<div class="mentor_view_content_header">
					<a class="mentor_view_content_header_title" href="#"> <span>${username}
							멘토의 강의 목록 </span> <i class="fa-solid fa-angle-right"></i>
					</a> <span class="mentor_view_content_sub_title"> 원하는 강의를 수강하시고
						실력을 키워보세요 </span>
				</div>
			</div>
		</div>
		<form class="mentorview_container" action="../Mentor/Mentorview"
			method="POST" onsubmit="return movebasket()">
			<div class="mentorview_wraper">
				<c:forEach var="video" items="${videolist}">
					<c:choose>
						<c:when test="${video.mno==mno}">
							<div class="mentorview_content">
								<input type="checkbox" id="vno" name="vno" value="${video.vno}">
								<div class=mentorview_content_video>
									<a href="../Mentor/videoview?vno=${video.vno}"> <video
											src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${video.videofile}"
											class="mentorview_content_img"></video></a>
								</div>
								<div class=mentorview_content_information>
									<span class="mentorview_content_name">${video.videoname}</span>
									<span class="mentorview_content_pay">₩${video.videoprice}원</span>
								</div>
							</div>
						</c:when>
					</c:choose>
				</c:forEach>

			</div>
			<div class="basketbutton">
				<input type="submit" value="장바구니담기">
			</div>
	</div>
	</form>
	<%
	}
	%>

	<!-- 하단부분 -->
	<%@ include file="./footer.jsp"%>
	<!-- 하단부분 -->
	<script src="https://kit.fontawesome.com/20556dcc55.js"
		crossorigin="anonymous"></script>
	</div>
</body>
</html>