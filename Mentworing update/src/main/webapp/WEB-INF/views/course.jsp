<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ include file="./jsp_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet" />






<!-- 헤더부분 -->
<%@include file="./mainheader.jsp"%>
<!-- 헤더부분 -->
<script src="https://kit.fontawesome.com/20556dcc55.js"
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.8.2.js"></script>


<meta charset="UTF-8">
<script src="js/greetings.js"></script>
<title>Insert title here</title>
<!-- 로그인 클릭시 나오는 화면 자바 스크립트 -->
</head>

<body>
<div class="course_container">
	<div class="course_wrapper">
	<div class="course_side_wrapper">
		<div class="course_side_wrapper_btn_box">
				<button  name="전체 강의"
					onclick="location.href='/Mentor/courseList'"><span>전체 강의</span><i class="fa-solid fa-chevron-right"></i></button>
		</div>
		<div class="course_side_wrapper_btn_box">		
				<button  name="인사·총무·노무"
					onclick="location.href='/Mentor/course_class?videotype=인사/총무/노무'"><span>인사·총무·노무</span><i class="fa-solid fa-chevron-right"></i></button>
		</div>
		<div class="course_side_wrapper_btn_box">
				<button  name="마켓팅·MD"
					onclick="location.href='/Mentor/course_class?videotype=마켓팅/MD'"><span>마켓팅·MD</span><i class="fa-solid fa-chevron-right"></i></button>
		</div>
		<div class="course_side_wrapper_btn_box">
				<button  name="홍보·CSR"
					onclick="location.href='/Mentor/course_class?videotype=홍보/CSR'"><span>홍보·CSR</span><i class="fa-solid fa-chevron-right"></i></button>
		</div>
		<div class="course_side_wrapper_btn_box">
				<button name="영업·영업관리"
					onclick="location.href='/Mentor/course_class?videotype=영업/영업관리'"><span>영업·영업관리</span><i class="fa-solid fa-chevron-right"></i></button>
		</div>
		<div class="course_side_wrapper_btn_box">
				<button  name="해외영업"
					onclick="location.href='/Mentor/course_class?videotype=해외영업'"><span>해외영업</span><i class="fa-solid fa-chevron-right"></i></button>
		</div>
		<div class="course_side_wrapper_btn_box">
				<button  name="유통·무역·구매"
					onclick="location.href='/Mentor/course_class?videotype=유통/무역/구매'"><span>유통·무역·구매</span><i class="fa-solid fa-chevron-right"></i></button>
		</div>
		<div class="course_side_wrapper_btn_box">
				<button  name="IT개발"
					onclick="location.href='/Mentor/course_class?videotype=IT개발'"><span>IT 개발</span><i class="fa-solid fa-chevron-right"></i></button>
		</div>
		<div class="course_side_wrapper_btn_box">
				<button  name="디자인·예술"
					onclick="location.href='/Mentor/course_class?videotype=디자인/예술'"><span>디자인·예술</span><i class="fa-solid fa-chevron-right"></i></button>
		</div>
		<div class="course_side_wrapper_btn_box">
				<button  name="연구·설계"
					onclick="location.href='/Mentor/course_class?videotype=연구/설계'"><span>연구·설계</span><i class="fa-solid fa-chevron-right"></i></button>
		</div>
		<div class="course_side_wrapper_btn_box">
				<button  name="기타"
					onclick="location.href='/Mentor/course_class?videotype=기타'"><span>기타</span><i class="fa-solid fa-chevron-right"></i></button>
		</div>
	</div>


	<div class="couse_content_wrapper">
	<div class="couse_content_choose_btn_box">
		<button  name="전체 강의"
					onclick="location.href='/Mentor/courseList'">전체 강의</button>
		<button  name="인사·총무·노무"
					onclick="location.href='/Mentor/course_class?videotype=인사/총무/노무'">인사·총무·노무</button>
		<button  name="마켓팅·MD"
					onclick="location.href='/Mentor/course_class?videotype=마켓팅/MD'">마켓팅·MD</button>
		<button  name="홍보·CSR"
					onclick="location.href='/Mentor/course_class?videotype=홍보/CSR'">홍보·CSR</button>			
		<button name="영업·영업관리"
					onclick="location.href='/Mentor/course_class?videotype=영업/영업관리'">영업·영업관리</button>			
		<button  name="해외영업"
					onclick="location.href='/Mentor/course_class?videotype=해외영업'">해외영업</button>			
		<button  name="유통·무역·구매"
					onclick="location.href='/Mentor/course_class?videotype=유통/무역/구매'">유통·무역·구매</button>
		<button  name="IT개발"
					onclick="location.href='/Mentor/course_class?videotype=IT개발'">IT 개발</button>
		
		<button  name="디자인·예술"
					onclick="location.href='/Mentor/course_class?videotype=디자인/예술'">디자인·예술</button>	
		<button  name="연구·설계"
					onclick="location.href='/Mentor/course_class?videotype=연구/설계'">연구·설계</button>
		<button  name="기타"
					onclick="location.href='/Mentor/course_class?videotype=기타'">기타</button>		
	</div>
		<div class="couse_content_body">

			<c:forEach var="video" items="${video2}" varStatus="status">

				<c:choose>
					<c:when test="${video.videotype=='IT개발'}">
						<div class="course_content">
							<div class="course_video_box">
				
								<a href="../Mentor/videoview?vno=${video.vno}"> <video
										src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${video.videofile}"
										 muted onmouseover="this.play()"
										onmouseout="this.pause()" autobuffer="true"
										style="border-radius: 0.5rem;" class="course_video" id="clip" /></a>
							</div>
							<div class="course_content_information">
								<div class="course_content_information_title">
									<span>${video.videoname}</span>
								</div>
								<div class="course_content_information_mentor">
									<span>${video.name}</span>
								</div>
								<div class="course_content_information_price"> 
									<span>₩${video.videoprice}</span>
								</div>
								<div class="course_content_information_type">
									<span>${video.videotype}</span>
								</div>
							</div>
						</div>
					</c:when>

				</c:choose>

			</c:forEach>


			<c:forEach var="video" items="${video2}" varStatus="status">

				<c:choose>
					<c:when test="${video.videotype=='인사/총무/노무'}">
						<div class="course_content">
							<div class="course_video_box">
								<a href="../Mentor/videoview?vno=${video.vno}"> 
								<video
										src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${video.videofile}"
										 muted onmouseover="this.play()"
										onmouseout="this.pause()" autobuffer="true"
										style="border-radius: 0.5rem;" class="course_video" id="clip"></video></a>
							</div>
							<div class="course_content_information">
								<div class="course_content_information_title">
									<span>${video.videoname}</span>
								</div>
								<div class="course_content_information_mentor">
									<span>${video.name}</span>
								</div>
								<div class="course_content_information_price"> 
									<span>₩${video.videoprice}</span>
								</div>
								<div class="course_content_information_type">
									<span>${video.videotype}</span>
								</div>
							</div>
						</div>
					</c:when>

				</c:choose>

			</c:forEach>

			<c:forEach var="video" items="${video2}" varStatus="status">

				<c:choose>
					<c:when test="${video.videotype=='마케팅/MD'}">
						<div class="course_content">
							<div class="course_video_box">
								<a href="../Mentor/videoview?vno=${video.vno}"> <video
										src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${video.videofile}"
										 muted onmouseover="this.play()"
										onmouseout="this.pause()" autobuffer="true"
										style="border-radius: 0.5rem;" class="course_video" id="clip" /> </video></a>
							</div>
							<div class="course_content_information">
								<div class="course_content_information_title">
									<span>${video.videoname}</span>
								</div>
								<div class="course_content_information_mentor">
									<span>${video.name}</span>
								</div>
								<div class="course_content_information_price"> 
									<span>₩${video.videoprice}</span>
								</div>
								<div class="course_content_information_type">
									<span>${video.videotype}</span>
								</div>
							</div>
						</div>
					</c:when>

				</c:choose>

			</c:forEach>

			<c:forEach var="video" items="${video2}" varStatus="status">

				<c:choose>
					<c:when test="${video.videotype=='디자인/예술'}">
						<div class="course_content">
							<div class="course_video_box">
								<a href="../Mentor/videoview?vno=${video.vno}"> <video
										src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${video.videofile}"
										 muted onmouseover="this.play()"
										onmouseout="this.pause()" autobuffer="true"
										style="border-radius: 0.5rem;" class="course_video" id="clip" /> </video></a>
							</div>
							<div class="course_content_information">
								<div class="course_content_information_title">
									<span>${video.videoname}</span>
								</div>
								<div class="course_content_information_mentor">
									<span>${video.name}</span>
								</div>
								<div class="course_content_information_price"> 
									<span>₩${video.videoprice}</span>
								</div>
								<div class="course_content_information_type">
									<span>${video.videotype}</span>
								</div>
							</div>
						</div>
					</c:when>

				</c:choose>

			</c:forEach>



			<c:forEach var="video" items="${video2}" varStatus="status">

				<c:choose>
					<c:when test="${video.videotype=='영업/영업관리'}">
						<div class="course_content">
							<div class="course_video_box">
								<a href="../Mentor/videoview?vno=${video.vno}"> <video
										src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${video.videofile}"
										 muted onmouseover="this.play()"
										onmouseout="this.pause()" autobuffer="true"
										style="border-radius: 0.5rem;" class="course_video" id="clip" /> </video></a>
							</div>
							<div class="course_content_information">
								<div class="course_content_information_title">
									<span>${video.videoname}</span>
								</div>
								<div class="course_content_information_mentor">
									<span>${video.name}</span>
								</div>
								<div class="course_content_information_price"> 
									<span>₩${video.videoprice}</span>
								</div>
								<div class="course_content_information_type">
									<span>${video.videotype}</span>
								</div>
							</div>
						</div>
					</c:when>

				</c:choose>

			</c:forEach>



		</div>
	</div>
	</div>
</div>
<!-- 하단부분 -->
		<%@ include file="./footer.jsp"%>
		<!-- 하단부분 -->
</body>

</html>