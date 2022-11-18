<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/8b98a99811.js"
	crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/hls.js@latest"></script>
<script src="https://code.jquery.com/jquery-3.6.0.slim.js"
	integrity="sha256-HwWONEZrpuoh951cQD1ov2HUK5zA5DwJ1DNUXaM6FsY="
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.8.2.js"></script>

<link
	href="https://fonts.googleapis.com/css2?family=Oswald:wght@200;500&display=swap"
	rel="stylesheet" />
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	function Check_Form(check) {
		console.log(check);
		if (check == "true") {
			console.log(check);
			window.scrollTo(1200, 1150);
			content.focus()
		} else {
			window.scrollTo(0, 0);
		}

	}

	function deleteapply(vano, vno) {

		if (confirm("선택하신 댓글을 삭제하시겠습니까?")) {
			location.href = "delete_video_apply?vano=" + vano + "&vno=" + vno;
		}

	}
</script>
<body onload="Check_Form('${applycheck}')">


	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->

	<%
	Object loginUser_videoview = session.getAttribute("userId");
	if (loginUser_videoview == null) {
	%>



	<div class="video_view_body">
		<!--  <div class="video_view_title_container">
			<div class="video_view_title_wraper">
				<span class=video_view_title_title>Watch the lecture for one
					minute first!</span> <span class=video_view_title_subtitle>강의를 1분
					동안 먼저 시청해보세요!</span>
			</div>
		</div>
		-->
		<div class="video_view_container">
			<div class="video_view_wraper">
				<video
					src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${video.videofile}"
					controls autoplay id="player">
				</video>
			</div>
		</div>
		<div class="videoview_main_side_container">
			<div class="videoview_main_container">
				<div class="video_view_body_container">
					<div class="video_view_body_wraper">
						<div class="video_view_body_video_name">
							<span class="video_type_font">#${video.videotype}</span>
							<span class="video_title_span">${video.videoname}</span>
						</div>
						<div class="video_view_body_video_count_date">
							<span class="video_view_body_video_count"><i
								class="fa-solid fa-eye"></i> 조회수 6,358,839회 </span> <span
								class="video_view_body_video_date"> 2019. 11. 09 </span>
						</div>
					</div>
				</div>
				<div class="video_view_profile_information_container">
					<div class="video_view_profile_information_wraper">
						<div class="video_view_profile_box">
							<a href="../Mentor/Mentorview?mno=${mno}"
								class="video_view_profile_img"> <img
								src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${mentorprofile}" /></a>
						</div>
						<div class="video_view_information_box">
							<div class="video_view_information_box_mentor_name">
								<span>"${userName} 멘토의 강의 소개"</span>
							</div>
							<div class="video_view_information_box_lecture_intro">
								<span>${video.videointroduce}</span>
							</div>
						</div>
					</div>
				</div>
				<div class="lecture_comment_container">
					<div class="lecture_comment_wraper">
					<img src="${pageContext.request.contextPath}/resources/img/user.png" width="30px"
					class="comment_profil_img">


						<form action="videoview" method="post"
							class="videoview_recomment_input">
							<input type="hidden" id="profile" name="profile"
								value="${profile}"> <input type="hidden" id="writerId"
								name="userId" value="${userId}" /> <input type="hidden"
								id="vno" name="vno" value="${video.vno}" />
							<div class="lecture_comment_input_submit_box">
								<input type="text" placeholder="로그인 후 이용가능합니다" readonly
									class="lecture_comment_input_bar" id="content" name="content"
									class="commentForm"></input> <input type="submit" value="확인" 
									class="comment_submit_btn" disabled/>
							</div>
						</form>

					</div>
				</div>
				<div class="lecture_comment_box_container">
					<div class="lecture_comment_box_wraper">

						<c:forEach var="apply" items="${apply}" varStatus="status">
							<div class="comment_profile_comment_box">
								<div class="profile_name_date_box">
									<img
										src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${apply.profile}"
										class="comment_profil_img"><span class="comment_user_id">${apply.userId}</span><span
										class="when_comment_date">${apply.va_date}</span>
									<c:choose>
										<c:when test="${apply.userId==userId}">
											<a onclick="deleteapply('${apply.vano}','${apply.vno}')"
												class="comment_romove_btn">댓글삭제</a>
										</c:when>
									</c:choose>
								</div>
								<div class="comment_information_box">
									<p>${apply.content}</p>
								</div>
							</div>

						</c:forEach>
					</div>
				</div>
			</div>
			<div class="videoview_side_container">
				<div class="videoview_side_title_wraper">
					<a href="#" <span>수강 중인 강의 리스트</span>
						<i class="fa-solid fa-angle-right"></i></a>
					<!-- 여기에 멘티 결제목록으로 이동하는 링크 걸어주시고 -->
				</div>
				<div class="lecture_in_progress_wraper_not_login">



					<i class="fa-solid fa-triangle-exclamation"></i><span>로그인 후 이용이 가능합니다.</span>
					




				</div>
				<div class="recommended_lecture_wraper">
					<div class="recommended_lecture_wraper_title_box">
						<span>추천 강의 리스트</span><i class="fa-solid fa-angle-right"></i>
					</div>
					<div class="recommended_lecture_wraper_lecure_box">



						<c:forEach var="video_recommend" items="${video_recommend}"
							varStatus="status">

							<c:if test="${video.videotype==video_recommend.videotype}">

								<div class="recommended_lecture_wraper_box">
									<div class="lecture_in_progres_box">
										<div class="lecture_in_progres_box_img_box">
											<a href="../Mentor/videoview?vno=${video_recommend.vno}">
												<video
													src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${video_recommend.videofile}"
													width="168px" height="94px" muted onmouseover="this.play()"
													onmouseout="this.pause()" autobuffer="true" class="clip"
													id="clip" /> </video>
											</a>
										</div>
										<div class="lecture_in_progres_box_information_box">
											<span
												class="lecture_in_progres_box_information_box_lecture_title">${video_recommend.videoname}</span>
											<span
												class="lecture_in_progres_box_information_box_mentor_name">${video_recommend.name}</span>
											<span
												class="lecture_in_progres_box_information_box_count_field">조회수
												242만회 • ${video_recommend.videotype}</span> <span></span>
										</div>
									</div>
								</div>
							</c:if>
						</c:forEach>



					</div>
				</div>
			</div>
		</div>
		<input type="hidden" value="${record}" id="record"> <input
			type="hidden" value="${paycheckvno}" id="paycheckvno">


		<%
		} else {
		%>



		<div class=video_view_body>
		<!--  
			<div class="video_view_title_container">
				<div class="video_view_title_wraper">
					<span class=video_view_title_title>Watch the lecture for one
						minute first!</span> <span class=video_view_title_subtitle>강의를 1분
						동안 먼저 시청해보세요!</span>
				</div>
			</div>
			-->
			<div class="video_view_container">
				<div class="video_view_wraper">
					<video
						src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${video.videofile}"
						controls autoplay id="player">
					</video>
				</div>
			</div>
			<div class="videoview_main_side_container">
				<div class="videoview_main_container">
					<div class="video_view_body_container">
						<div class="video_view_body_wraper">
							<div class="video_view_body_video_name">
								<span class="video_type_font">#${video.videotype}</span>
								<span class="video_title_span">${video.videoname}</span>
							</div>
							<div class="video_view_body_video_count_date">
								<span class="video_view_body_video_count"><i
									class="fa-solid fa-eye"></i> 조회수 6,358,839회 </span> <span
									class="video_view_body_video_date"> 2019. 11. 09 </span>
							</div>
						</div>
					</div>
					<div class="video_view_profile_information_container">
						<div class="video_view_profile_information_wraper">
							<div class="video_view_profile_box">
								<a href="../Mentor/Mentorview?mno=${mno}"
									class="video_view_profile_img"> <img
									src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${mentorprofile}" /></a>
							</div>
							<div class="video_view_information_box">
								<div class="video_view_information_box_mentor_name">
									<span>"${userName} 멘토의 강의 소개"</span>
								</div>
								<div class="video_view_information_box_lecture_intro">
									<span>${video.videointroduce}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="lecture_comment_container">
						<div class="lecture_comment_wraper">
							<img
								src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${profile}"
								class="comment_profil_img">

							<form action="videoview" method="post"
								class="videoview_recomment_input">
								<input type="hidden" id="profile" name="profile"
									value="${profile}"> <input type="hidden" id="writerId"
									name="userId" value="${userId}" /> <input type="hidden"
									id="vno" name="vno" value="${video.vno}" />
								<div class="lecture_comment_input_submit_box">
									<input type="text" placeholder="댓글 추가..."
										class="lecture_comment_input_bar" id="content" name="content"
										class="commentForm"></input> <input type="submit" value="확인"
										class="comment_submit_btn" />
								</div>
							</form>

						</div>
					</div>
					<div class="lecture_comment_box_container">
						<div class="lecture_comment_box_wraper">

							<c:forEach var="apply" items="${apply}" varStatus="status">
								<div class="comment_profile_comment_box">
									<div class="profile_name_date_box">
										<img
											src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${apply.profile}"
											class="comment_profil_img"><span
											class="comment_user_id">${apply.userId}</span><span
											class="when_comment_date">${apply.va_date}</span>
										<c:choose>
											<c:when test="${apply.userId==userId}">
												<a onclick="deleteapply('${apply.vano}','${apply.vno}')"
													class="comment_romove_btn">댓글삭제</a>
											</c:when>
										</c:choose>
									</div>
									<div class="comment_information_box">
										<p>${apply.content}</p>
									</div>
								</div>

							</c:forEach>
						</div>
					</div>
				</div>
				<div class="videoview_side_container">
					<div class="videoview_side_title_wraper">
						<a href="#" <span>수강 중인 강의 리스트</span>
							<i class="fa-solid fa-angle-right"></i></a>
						<!-- 여기에 멘티 결제목록으로 이동하는 링크 걸어주시고 -->
					</div>
					<div class="lecture_in_progress_wraper">



						<c:forEach var="videoview_videolist"
							items="${videoview_videolist}" varStatus="status">
							<c:forEach var="videoview_payment_count"
								items="${videoview_payment_count}">

								<c:choose>
									<c:when
										test="${videoview_payment_count.vfilename==videoview_videolist.videofile}">
										<div class="lecture_in_progres_box">
											<div class="lecture_in_progres_box_img_box">
												<a href="../Mentor/videoview?vno=${videoview_videolist.vno}">
													<video
														src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${videoview_videolist.videofile}"
														width="168px" height="94px" muted
														onmouseover="this.play()" onmouseout="this.pause()"
														autobuffer="true" class="clip" id="clip" /> </video>
												</a>
											</div>
											<div class="lecture_in_progres_box_information_box">
												<span
													class="lecture_in_progres_box_information_box_lecture_title">${videoview_videolist.videoname}
												</span> <span
													class="lecture_in_progres_box_information_box_mentor_name">${videoview_videolist.name}
												</span> <span
													class="lecture_in_progres_box_information_box_count_field">조회수
													242만회</span>• ${videoview_videolist.videotype}<span></span> <span>수강생
													명:${videoview_payment_count.bestvideo_count}</span>
											</div>
										</div>
									</c:when>


								</c:choose>


							</c:forEach>

						</c:forEach>





					</div>
					<div class="recommended_lecture_wraper">
						<div class="recommended_lecture_wraper_title_box">
							<span>추천 강의 리스트</span><i class="fa-solid fa-angle-right"></i>
						</div>
						<div class="recommended_lecture_wraper_lecure_box">



							<c:forEach var="video_recommend" items="${video_recommend}"
								varStatus="status">

								<c:if test="${video.videotype==video_recommend.videotype}">

									<div class="recommended_lecture_wraper_box">
										<div class="lecture_in_progres_box">
											<div class="lecture_in_progres_box_img_box">
												<a href="../Mentor/videoview?vno=${video_recommend.vno}">
													<video
														src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${video_recommend.videofile}"
														width="168px" height="94px" muted
														onmouseover="this.play()" onmouseout="this.pause()"
														autobuffer="true" class="clip" id="clip" /> </video>
												</a>
											</div>
											<div class="lecture_in_progres_box_information_box">
												<span
													class="lecture_in_progres_box_information_box_lecture_title">${video_recommend.videoname}</span>
												<span
													class="lecture_in_progres_box_information_box_mentor_name">${video_recommend.name}</span>
												<span
													class="lecture_in_progres_box_information_box_count_field">조회수
													242만회 • ${video_recommend.videotype}</span> <span></span>
											</div>
										</div>
									</div>
								</c:if>
							</c:forEach>



						</div>
					</div>
				</div>
			</div>
			<input type="hidden" value="${record}" id="record"> <input
				type="hidden" value="${paycheckvno}" id="paycheckvno">

			<%
			}
			%>
			
		</div>
		<script src="https://kit.fontawesome.com/20556dcc55.js"
			crossorigin="anonymous"></script>
</body>

<script>
	var record = document.getElementById('record').value
	document.getElementById('player').currentTime = record;
	var time = 0;
	var vid = document.getElementById("player");
	var vno = document.getElementById("vno").value;
	var paycheckvno = document.getElementById("paycheckvno").value;

	if (paycheckvno == "0") {
		//Assign an ontimeupdate event to the <video> element, and execute a function if the current playback position has changed
		vid.ontimeupdate = function() {
			console.log("결제가되지않은 동영상서비스");
			myFunction();

		};
	}

	if (paycheckvno == "1") {
		setInterval(function() {
			time = parseInt(vid.currentTime);
			console.log("동영상 총길이" + vid.duration);
			console.log("결제가 된 동영상 서비스");
			console.log("10초도달 DB저장" + Math.floor(time));
			$.ajax({
				url : "/Mentor/video_record_go?video_record="
						+ Math.floor(time) + "&vno=" + vno + "&duration="
						+ Math.floor(vid.duration),
				type : 'get',
				dataType : 'json',
				async : false,
				success : function(result) {
					if (result.msg == "true") {
						console.log('DB에 동영상 최신화 성공');

					} else {
						console.log('DB에 동영상 최신화 실패');

					}
				}
			});
		}, 10000);

	}

	function myFunction() {
		//Display the current position of the video in a <p> element with id="demo"
		time = parseInt(vid.currentTime);

		console.log(Math.floor(time));
		if (30 < time) {
			location.href = "../main";
			alert("제한시간초과");
		}
	}
</script>
</html>