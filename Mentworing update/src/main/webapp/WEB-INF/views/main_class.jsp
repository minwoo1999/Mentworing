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
	<div class="main_body">
		<!-- 그림 자동슬라이드 부분 -->
		<!--  	<div class="banner_img_container">
		<div class="banner_img">
			<section class="banner">

				<img src="resources/banner/img.png" id=mainimage alt="Ysjimage"
					width="2200px" height="100%">

				<script bgcolor="lightgrey">
					var myImage = document.getElementById("mainimage");
					var imageArray = [ "resources/banner/img2.png",
							"resources/banner/img3.png",
							"resources/banner/img.png" ];
					var imageIndex = 0;

					function changeimage() {

						myImage.setAttribute("src", imageArray[imageIndex]);
						imageIndex++;
						if (imageIndex >= imageArray.length) {
							imageIndex = 0;
						}
					}
					setInterval(changeimage, 4000);
				</script>
				
				
			</section>
		</div>
	</div>

	<div class="banner_controller_container">
		<div class="banner_controller">
			<button class="left" type="button">
				<i class="fa-solid fa-angle-left"></i>
			</button>
			<button class="pause" type="button" onclick="$">
				<i class="fa-solid fa-pause"></i>
			</button>
			<button class="right" type="button">
				<i class="fa-solid fa-angle-right"></i>
			</button>
		</div>
	</div>-->
		<!-- 그림 자동슬라이드 부분 -->

		<!--  메인 검색기능 -->
		<div class="search_container">
			<div class="serch_main">
				<div class="search_title">
					<span>인프런에서 가치를 높이세요</span>
				</div>
				<div class="serach_input">
					<input type="text" placeholder="배우고 싶은 지식을 입력하세요.">
					<button class="search_submit">
						<i class="fa-solid fa-magnifying-glass"></i>
					</button>
				</div>
			</div>
		</div>
		<div class="videoTypeclass">
			<button class="videotype_button" name="전체"
				onclick="location.href='../main'">전체</button>
			<button class="videotype_button" name="인사/총무/노무"
				onclick="location.href='../main_class?videotype=인사/총무/노무'">인사/총무/노무</button>
			<button class="videotype_button" name="마켓팅/MD"
				onclick="location.href='../main_class?videotype=마켓팅/MD'">마켓팅/MD</button>
			<button class="videotype_button" name="홍보/CSR"
				onclick="location.href='../main_class?videotype=홍보/CSR'">홍보/CSR</button>
			<button class="videotype_button" name="영업/영업관리"
				onclick="location.href='../main_class?videotype=영업/영업관리'">영업/영업관리</button>
			<button class="videotype_button" name="해외영업"
				onclick="location.href='../main_class?videotype=해외영업'">해외영업</button>
			<button class="videotype_button" name="유통/무역/구매"
				onclick="location.href='../main_class?videotype=유통/무역/구매'">유통/무역/구매</button>
			<button class="videotype_button" name="유통/무역/구매"
				onclick="location.href='../main_class?videotype=IT개발'">IT개발</button>
			<button class="videotype_button" name="디자인/예술"
				onclick="location.href='../main_class?videotype=디자인/예술'">디자인/예술</button>
			<button class="videotype_button" name="연구/설계"
				onclick="location.href='../main_class?videotype=연구/설계'">연구/설계</button>
			<button class="videotype_button" name="기타"
				onclick="location.href='../main_class?videotype=기타'">기타</button>
		</div>


		<div class=main_content_nav>
			<div class="main_content_header_container">
				<div class="main_content_header">
					<a class="main_content_header_title" href="#"> <span>1분
							미리보기</span> <i class="fa-solid fa-hand-holding-dollar"></i> <i
						class="fa-solid fa-angle-right"></i>
					</a> <span class="main_content_sub_title">미리보기 강의시간은 1분 입니다.</span>
				</div>
			</div>
		</div>
		<div class="main_content_body_container">
			<div class="main_content_body">
				<c:forEach var="video" items="${video}" varStatus="status">
					<div class="content">
						<a href="../Mentor/videoview?vno=${video.vno}"> <video
								src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${video.videofile}"
								width="400px" height="300px" /></video></a>
						<div class="content_information">
							<div class="content_information_title">
								<span>${video.videoname}</span>
							</div>
							<div class="content_information_sub_title">
								<span>${video.videotype}</span>
							</div>
							<div class="content_information_sub_title">
								<span>가격:${video.videoprice}</span>
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
</body>

</html>