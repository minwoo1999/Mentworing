<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet" />
<script src="https://kit.fontawesome.com/8b98a99811.js"
	crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/hls.js@latest"></script>
<script src="https://code.jquery.com/jquery-3.6.0.slim.js"
	integrity="sha256-HwWONEZrpuoh951cQD1ov2HUK5zA5DwJ1DNUXaM6FsY="
	crossorigin="anonymous"></script>

<link
	href="https://fonts.googleapis.com/css2?family=Oswald:wght@200;500&display=swap"
	rel="stylesheet" />
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>


	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->
	<div class=video_view_body>
		<div class="video_view_title_container">
			<div class="video_view_title_wraper">
				<span class=video_view_title_title>Watch the lecture for one
					minute first!</span> <span class=video_view_title_subtitle>강의를 1분
					동안 먼저 시청해보세요!</span>
			</div>
		</div>
		<div class="video_view_container">
			<div class="video_view_wraper">
				<video
					src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${video.videofile}"
					controls autoplay id="player">
				</video>
			</div>
		</div>
		<div class="video_view_body_container">
			<div class="video_view_body_wraper">
				<div class="video_view_body_video_name">
					${video.videoname} <span class="video_type_font">#${video.videotype}</span>
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
						<span>"멘토 ${userName}님의 강의 소개."</span>
					</div>
					<div class="video_view_information_box_lecture_intro">
						<span>${video.videointroduce}</span>
					</div>
				</div>
			</div>
		</div>




		<!-- 하단부분 -->
		<%@ include file="./footer.jsp"%>
		<!-- 하단부분 -->
	</div>
	<script src="https://kit.fontawesome.com/20556dcc55.js"
		crossorigin="anonymous"></script>
</body>

<script>
	var time = 0;
	var vid = document.getElementById("player");

	//Assign an ontimeupdate event to the <video> element, and execute a function if the current playback position has changed
	vid.ontimeupdate = function() {

		myFunction()

	};

	function myFunction() {
		//Display the current position of the video in a <p> element with id="demo"
		time = parseInt(vid.currentTime);
		console.log(time);
		if (30 < time) {
			location.href = "../main";
			alert("제한시간초과");
		}
		console.log(vid.currentTime);
	}
</script>
</html>