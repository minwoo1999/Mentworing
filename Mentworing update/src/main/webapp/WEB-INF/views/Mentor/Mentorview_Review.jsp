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
		var flag = true;
		var values = document.getElementsByName("vno");
		var size = $("input[name='vno']").length;
		var vnoarr = new Array();
		count = 0
		for (i = 0; i < size; i++) {
			if (values[i].checked) {
				vnoarr[count] = $("input[name='vno']").eq(i).attr("value");
				count += 1;
			}

		}

		var count = 0;
		for (var i = 0; i < values.length; i++) {
			if (values[i].checked) {
				count++;
			}
		}

		if (count < 1) {
			flag = false;
			alert("장바구니를 체크해주세요" + flag);
			return flag;
		}

		$.ajax({
			url : "/basket/checkbasket?vno=" + vnoarr,
			type : 'get',
			dataType : 'json',
			async : false,
			success : function(result) {
				if (result.msg == "true") {
					alert("장바구니 담기완료!");
					flag = true;

				} else {
					flag = false;
					alert("장바구니에 이미 담겨있습니다");

				}
			}
		});

		return flag;

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
								var str = result.at(i).message;
								console.log(str);
								console.log(str.includes("jpg"));

								if (memberprofile != "") {
									if (result.at(i).name == username) {

										if (str.includes("jpg")
												|| str.includes("png")
												|| str.includes("PNG")
												|| str.includes("JPG")) {
											$("#chating")
													.append(

															"<div class='chat_box_menti'><div class='chat_box_menti_chat_time'><span class='me'>"
																	+ "<a href='https://infruntest.s3.ap-northeast-2.amazonaws.com/"
																	+ result
																			.at(i).message
																	+ "'><img src='https://infruntest.s3.ap-northeast-2.amazonaws.com/"
																	+ result
																			.at(i).message
																	+ "' width='160' height='180' class='file_img'></a>"
																	+ "</span><span id='chat_me_date'>"
																	+ result
																			.at(i).chat_date
																	+ "</span>"
																	+ "</div>"
																	+ "<img src='https://infruntest.s3.ap-northeast-2.amazonaws.com/"+ memberprofile +"' class='chat_my_img' height='40' width='40'>");

											$('#chating')
													.scrollTop(
															$('#chating')[0].scrollHeight);
										} else {
											$("#chating")
													.append(

															"<div class='chat_box_menti'><div class='chat_box_menti_chat_time'><span class='me'>"
																	+ result
																			.at(i).message
																	+ "</span><span id='chat_me_date'>"
																	+ result
																			.at(i).chat_date
																	+ "</span>"
																	+ "</div>"
																	+ "<img src='https://infruntest.s3.ap-northeast-2.amazonaws.com/"+ memberprofile +"' class='chat_my_img' height='40' width='40'>");

											$('#chating')
													.scrollTop(
															$('#chating')[0].scrollHeight);
										}
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
																+ "<img src='${pageContext.request.contextPath}/resources/img/profile.jpg' class='chat_my_img' height='40' width='40'>");

										$('#chating').scrollTop(
												$('#chating')[0].scrollHeight);
									}
								}

								if (result.at(i).name == mentorname) {

									if (str.includes("jpg")
											|| str.includes("png")
											|| str.includes("PNG")
											|| str.includes("JPG")) {

										$("#chating")
												.append(
														"<div class='chat_box_mentor'><img src='https://infruntest.s3.ap-northeast-2.amazonaws.com/"+ mentorprofile +"' id='img2' height='40' width='40' class='chat_other_img'><div class='chat_box_mentor_chat_time'> <span class='others'>"
																+ "멘토"
																+ result.at(i).name

																+ "<a href='https://infruntest.s3.ap-northeast-2.amazonaws.com/"
																+ result.at(i).message
																+ "'><img src='https://infruntest.s3.ap-northeast-2.amazonaws.com/"
																+ result.at(i).message
																+ "' height='180' width='160'></a>"
																+ "</span><span id='chat_others_date'>"
																+ result.at(i).chat_date
																+ "</span>"
																+ "</div>");
									} else {
										$("#chating")
												.append(
														"<div class='chat_box_mentor'><img src='https://infruntest.s3.ap-northeast-2.amazonaws.com/"+ mentorprofile +"' id='img2' height='40' width='40' class='chat_other_img'><div class='chat_box_mentor_chat_time'> <span class='others'>"
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
<script type='text/javascript'>
	function mentor_review() {
		var showlay = $('<div id="metor_review_container"></div>');
		showlay.show();
		showlay.appendTo(document.body);
		$('.cont').show();
		$('.close').click(function() {
			$('.cont').hide();
			showlay.appendTo(document.body).remove();
			return false;
		});
	}

	$(document).ready(function() {
		var review_check = document.getElementById("review_check_id").value;
		console.log("리븄썻는지 체크" + review_check);

		if (review_check != "") {
			if (confirm("후기작성완료! 해당페이지로 이동하시겠습니까?")) {
				location.href = "../board/Mentor_Review";
			}
		}
	});

	function check_review() {
		if (confirm("후기작성을 하시겠습니까 ?")) {
			return true;
		} else {
			return false;
		}
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
						<div class="mento_review_box">
							<button class="mento_review_btn" onclick="mentor_review()">
								<i class="fa-solid fa-leaf"></i><span
									class="mentor_review_plus_btn">멘토 후기작성</span>
							</button>
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
		<div class="lecture_review_container">
			<div class="lecture_review_wrapper">
				<a href="../Mentor/Mentorview?mno=${mno}">강의</a> 
				 <a href="../Mentor/Mentorview_Review?mno=${mno}" id="choose_btn">후기</a>  
			 </div>
		 </div>
		<div class=mentor_view_content_nav>
			<div class="mentor_view_content_header_container">
				<div class="mentor_view_content_header">
					<a class="mentor_view_content_header_title" href="#"> <span>${mentorname} 멘토에게 등록된
							멘토링 후기 </span> <i class="fa-solid fa-sun"></i>
					</a> 
				</div>
			</div>
		</div>
	<div class="mentor_view_review_container">
		<div class="mentor_view_review_wrapper">
		
		
		
			<c:forEach var="mentorreview" items="${mentorreview}">
			<div class="mentor_view_review_content_box">
				<div class="mentor_view_review_i_box">
					<i class="fa-solid fa-leaf"></i>
				</div>
				<div class="mentor_view_review_content">
					<div>
					<span class="mentor_view_review_content_writer_id">${mentorreview.writerid}</span>
					<span class="mentor_view_review_content_date">${mentorreview.review_date}</span>
					</div>
					<div class="mentor_view_review_content_star_box">
						<c:choose>
							<c:when test="${mentorreview.grade==1}">
								<i class="fa-solid fa-star"></i>
							</c:when>
							<c:when test="${mentorreview.grade==2}">
								<i class="fa-solid fa-star"></i>
								<i class="fa-solid fa-star"></i>
							</c:when>
							<c:when test="${mentorreview.grade==3}">
								<i class="fa-solid fa-star"></i>
								<i class="fa-solid fa-star"></i>
								<i class="fa-solid fa-star"></i>
							</c:when>
							<c:when test="${mentorreview.grade==4}">
								<i class="fa-solid fa-star"></i>
								<i class="fa-solid fa-star"></i>
								<i class="fa-solid fa-star"></i>
							</c:when>
							<c:when test="${mentorreview.grade==5}">
								<i class="fa-solid fa-star"></i>
								<i class="fa-solid fa-star"></i>
								<i class="fa-solid fa-star"></i>
								<i class="fa-solid fa-star"></i>
								<i class="fa-solid fa-star"></i>
							</c:when>
						</c:choose>
						</div>
						<div class="mentor_view_review_content_review">
							${mentorreview.content}
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

		<!-- 하단부분 -->
		<%@ include file="./footer.jsp"%>
		<!-- 하단부분 -->
	</div>
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
			method="POST" onsubmit="return movebasket();">
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
				<div class="basketbutton">
					<input type="submit" value="장바구니담기">
				</div>
			</div>


		</form>
		<!-- 하단부분 -->
		<%@ include file="./footer.jsp"%>
		<!-- 하단부분 -->
	</div>
	<%
	} else {
	%>

	<div class='Login_popup'>
		<div class='Login_cnt223' id='mentor_view_chat'>
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
						<div class="mento_review_box">
							<button class="mento_review_btn" onclick="mentor_review()">
								<i class="fa-solid fa-leaf"></i><span
									class="mentor_review_plus_btn">멘토 후기작성</span>
							</button>
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
		<div class="lecture_review_container">
			<div class="lecture_review_wrapper">
				<a href="../Mentor/Mentorview?mno=${mno}">강의</a> 
				 <a href="../Mentor/Mentorview_Review?mno=${mno}" id="choose_btn">후기</a>  
			 </div>
		 </div>
		<div class=mentor_view_content_nav>
			<div class="mentor_view_content_header_container">
				<div class="mentor_view_content_header">
					<a class="mentor_view_content_header_title" href="#"> <span>${mentorname} 멘토에게 등록된
							멘토링 후기 </span> <i class="fa-solid fa-sun"></i>
					</a> 
				</div>
			</div>
		</div>
	<div class="mentor_view_review_container">
		<div class="mentor_view_review_wrapper">
		
		
		
			<c:forEach var="mentorreview" items="${mentorreview}">
			<div class="mentor_view_review_content_box">
				<div class="mentor_view_review_i_box">
					<i class="fa-solid fa-leaf"></i>
				</div>
				<div class="mentor_view_review_content">
					<div>
					<span class="mentor_view_review_content_writer_id">${mentorreview.writerid}</span>
					<span class="mentor_view_review_content_date">${mentorreview.review_date}</span>
					</div>
					<div class="mentor_view_review_content_star_box">
						<c:choose>
							<c:when test="${mentorreview.grade==1}">
								<i class="fa-solid fa-star"></i>
							</c:when>
							<c:when test="${mentorreview.grade==2}">
								<i class="fa-solid fa-star"></i>
								<i class="fa-solid fa-star"></i>
							</c:when>
							<c:when test="${mentorreview.grade==3}">
								<i class="fa-solid fa-star"></i>
								<i class="fa-solid fa-star"></i>
								<i class="fa-solid fa-star"></i>
							</c:when>
							<c:when test="${mentorreview.grade==4}">
								<i class="fa-solid fa-star"></i>
								<i class="fa-solid fa-star"></i>
								<i class="fa-solid fa-star"></i>
							</c:when>
							<c:when test="${mentorreview.grade==5}">
								<i class="fa-solid fa-star"></i>
								<i class="fa-solid fa-star"></i>
								<i class="fa-solid fa-star"></i>
								<i class="fa-solid fa-star"></i>
								<i class="fa-solid fa-star"></i>
							</c:when>
						</c:choose>
						</div>
						<div class="mentor_view_review_content_review">
							${mentorreview.content}
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
		<div class="profile_chat">
			<input type="hidden" value="${name}" id="username"> <input
				type="hidden" value="${paymentId}" id="paymentId">
			<button class="btn_chat"
				onclick="functionC('${mentorname}','${mentor.profile}','${memberprofile.profile}');">
				<img src="${pageContext.request.contextPath}/resources/img/logo.png"
					class="chat_btn_img">
			</button>

		</div>
		<!-- 하단부분 -->
		<%@ include file="./footer.jsp"%>
		<!-- 하단부분 -->
	</div>
	<%
	}
	%>
	<div class="cont">
		<div class="stars">
			<div class="mntor_review_box_nav_bar">
				<span>후기 작성</span> <a href='' class='mntor_review_box_nav_bar_close'>X</a>
			</div>
			<form action="../board/Mentor_Review"
				onsubmit='return check_review()' method="POST"
				style="padding-top: 20px;">
				<input type="hidden" name="writerid" value="${userId}"> <input
					type="hidden" name="mno" value="${mno}"> <input
					class="star star-5" id="star-5-2" value="5" type="radio"
					name="star" /> <label class="star star-5" for="star-5-2"></label>
				<input class="star star-4" id="star-4-2" value="4" type="radio"
					name="star" /> <label class="star star-4" for="star-4-2"></label>
				<input class="star star-3" id="star-3-2" value="3" type="radio"
					name="star" /> <label class="star star-3" for="star-3-2"></label>
				<input class="star star-2" id="star-2-2" value="2" type="radio"
					name="star" /> <label class="star star-2" for="star-2-2"></label>
				<input class="star star-1" id="star-1-2" value="1" type="radio"
					name="star" /> <label class="star star-1" for="star-1-2"></label>
				<div class="rev-box">
					<textarea class="review" col="30" name="content"></textarea>
					<label class="review" for="review">리뷰를 정성껏 작성해 주세요.</label> <input
						type="submit" class="review_complete_btn" value="작성완료">
				</div>
				<input type="hidden" value="${review_check}" id="review_check_id">
			</form>

		</div>
	</div>


</body>
</html>