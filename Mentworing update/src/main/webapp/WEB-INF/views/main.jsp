<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="js/greetings.js"></script>
<title>Insert title here</title>
<!-- 로그인 클릭시 나오는 화면 자바 스크립트 -->
</head>
<script>


	window.onload = function() {

		var joindata = document.getElementById("joinformdata").value;
		console.log(joindata);
		if (joindata == 1) {
			alert("회원가입을 축하합니다 5%할인쿠폰이 지급되었습니다");
		}
	};
</script>
<body>
	<div class="main_body">

		<!-- 그림 자동슬라이드 부분 -->
		<!-- 
           <div class="banner_img_container">
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
   </div>
   -->
		<input type="hidden" value="${basketcounting}" id="basketcounting">
		<input type="hidden" value="${joinformdata}" id="joinformdata">
		<!-- 그림 자동슬라이드 부분 -->

		<!--  메인 검색기능 -->
		<div class="main_banner_section">
			<div class="main_banner_section_wraper">
				<div class="main_banner_text_box">

					<span>멘투링 소개</span>

					<h1>우리는 성장기회의 평등을 추구합니다.</h1>
					<p>누구나 배움의 기회를 누리고 꿈을 이룰 수 있도록! 맨투링과 함께 배우고, 나누고, 성장하세요.</p>
				</div>
				<img src="resources/banner/banner_inside_img.png"
					class="banner_inside_img" width="2200px" height="100%">
			</div>
		</div>
		<div class="search_container">
			<div class="serch_main">
				<div class="search_title">
					<span>맨투링에서 가치를 높이세요</span>
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
			<div class="videoTypeclass_box">
				<button class="videotype_button" name="전체"
					onclick="location.href='/main'">#전체</button>
				<button class="videotype_button" name="인사/총무/노무"
					onclick="location.href='/main_class?videotype=인사/총무/노무'">#인사/총무/노무</button>
				<button class="videotype_button" name="마켓팅/MD"
					onclick="location.href='/main_class?videotype=마켓팅/MD'">#마켓팅/MD</button>
				<button class="videotype_button" name="홍보/CSR"
					onclick="location.href='/main_class?videotype=홍보/CSR'">#홍보/CSR</button>
				<button class="videotype_button" name="영업/영업관리"
					onclick="location.href='/main_class?videotype=영업/영업관리'">#영업/영업관리</button>
				<button class="videotype_button" name="해외영업"
					onclick="location.href='/main_class?videotype=해외영업'">#해외영업</button>
				<button class="videotype_button" name="유통/무역/구매"
					onclick="location.href='/main_class?videotype=유통/무역/구매'">#유통/무역/구매</button>
				<button class="videotype_button" name="유통/무역/구매"
					onclick="location.href='/main_class?videotype=IT개발'">#IT개발</button>
				<button class="videotype_button" name="디자인/예술"
					onclick="location.href='/main_class?videotype=디자인/예술'">#디자인/예술</button>
				<button class="videotype_button" name="연구/설계"
					onclick="location.href='/main_class?videotype=연구/설계'">#연구/설계</button>
				<button class="videotype_button" name="기타"
					onclick="location.href='/main_class?videotype=기타'">#기타</button>
			</div>
		</div>
		
		
		<%

if (loginUser != null) {
%>

		<c:set var="i" value="1"></c:set>
		<c:set var="doneLoop" value="false" />
	
		<div class="recent_lecture_container">
			<div class="recent_lecture_wrapper_title_box">
				<span>나의 최근 학습 강의</span><i class="fa-solid fa-angle-right"></i>
			</div>
			<div class="recent_lecture_wrapper">

					<c:if test="${empty video_record}">

    						<span style="
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    width: 100%;
    padding: 40px;
    align-items: center;
">최근에 학습하신 강의가 없습니다.</span>

					</c:if>
				<c:forEach var="video_record" items="${video_record}"
					varStatus="status">
					
					<c:forEach var="video" items="${video2}" varStatus="status">
						<c:choose>
						
					
						
							<c:when test="${video_record.vno==video.vno}">
								<c:if test="${doneLoop==false}">
								
								
								<c:set var="percent"
										value="${(video_record.video_record /video_record.video_end)*100 }" />
									<div class="recent_lecture_box">
										<div class="recent_lecture_box_lecture_img">
											<a href="../Mentor/videoview?vno=${video.vno}"> <video
													src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${video.videofile}"
													width="196px" height="100%" muted onmouseover="this.play()"
													onmouseout="this.pause()" autobuffer="true" class="clip"
													id="clip" /> </video></a>
										</div>
										<div class="recent_lecture_box_information_box">
											<div class="recent_lecture_box_information_box_title">
												<span> ${video.videoname} </span>
											</div>
											<!-- <span>최근시청날짜:${video_record.watch_date}</span> -->

											<!--  <a href="../Mentor/videoview?vno=${video.vno}&&starttime=0"
											onclick="return confirm('강의를 처음부터 들으시겠습니까?');">처음부터 재생</a>-->
											<div
												class="recent_lecture_box_information_box_information_box">
												<div>
													<div class="dead_line_percent_box">
														<div class="dead_line_box">
															<span>기한:무제한 <span class="center_var">|</span></span>
														</div>
														<div class="percent_box">
															<span>진도율</span>
															<fmt:formatNumber type="number" pattern="0.00"
																value="${ ((percent*100) - ((percent*100)%1)) * (1/100)   } " />
															%
														</div>
													</div>
													<div class="prograss_var_box">
														<progress
															value="<fmt:formatNumber type="number" pattern="0.00"
													value="${ ((percent*100) - ((percent*100)%1)) * (1/100)   } " />"
															max="100"></progress>
													</div>
												</div>
												<div class="recent_lecture_box_play_box">

													<a href="../Mentor/videoview?vno=${video.vno}">바로 학습</a><i
														class="fa-solid fa-play"></i>

												</div>
											</div>
										</div>
									</div>
									<c:set var="i" value="${i+1}"></c:set>
									<c:if test="${i==5}">
										<c:set var="doneLoop" value="true" />
									</c:if>
								</c:if> 

							</c:when>
						</c:choose>
						
					</c:forEach>




				</c:forEach>
			</div>
		</div>


	<%} %>

		<div class="main_top_content_wraper">
			<div class="main_top_content_box_header">
				<span class="main_top_content_box_header_top"> 강력 추천하는 베스트
					TOP 3 강의 </span> <span class="main_top_content_box_header_bottom">
					Popular Courses TOP 3 lecture </span>
			</div>
			<div class="main_top_content_box">

				<c:forEach var="best_video" items="${best_video}" varStatus="status">
					<c:forEach var="video" items="${video2}" varStatus="status">

						<c:choose>
							<c:when test="${video.videofile==best_video.vfilename}">
								<div class="card_content">
									<div class="best_video_count_back">
										<span class="best_video_count">누적판매 수<span
											class="best_video_count_num">${best_video.bestvideo_count}</span></span>
									</div>
									<i class="fa-solid fa-star"></i> <span class="i_inside_title">TOP3</span>
									<div class="main_top_content_lecture_video">
										<a href="../Mentor/videoview?vno=${video.vno}"> <video
												src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${video.videofile}"
												width="370px" height="210px" muted onmouseover="this.play()"
												onmouseout="this.pause()" autobuffer="true"
												style="border-radius: 0.5rem;" class="clip" id="clip" /> </video></a>
									</div>
									<div class="card_content_information_box">
										<div class="card_content_information_box_lecture_type_box">
											<span class="card_content_information_box_lecture_type">${video.videotype}</span>
											<i class="fa-solid fa-down"></i>
										</div>
										<span class="card_content_information_box_name">${video.videoname}</span>
										<span class="card_content_information_box_videoprice">${video.name}
											멘토 ·₩${video.videoprice}</span>
										<!-- 판갯수:${best_video.bestvideo_count} -->

									</div>

								</div>

							</c:when>

						</c:choose>

					</c:forEach>
				</c:forEach>
			</div>
		</div>
		<div class="main_content_body_container">


			<div class="main_content_body">
			
			<div class="main_content_lecture_box_wraper">
					<div class="lecture_course_header">
						<a
							href="http://localhost:8080/Mentor/course_class?videotype=%EB%94%94%EC%9E%90%EC%9D%B8/%EC%98%88%EC%88%A0">
							<span class="lecture_course_header_parent"><span
								class="lecture_course_header_point">디자인·예술</span> 분야 강의</span><i
							class="fa-solid fa-angle-right"></i>
						</a> <span class="lecture_course_header_child">국내 최고의 현직자들이
							업로드한 디자인·예술 분야 강의입니다!</span>
					</div>
					<div class="main_content_lecture_box">
						<c:forEach var="video" items="${video}" varStatus="status">

							<c:choose>
								<c:when test="${video.videotype=='디자인/예술'}">

									<div class="content">
										<div class="main_content_lecture_video">
											<a href="../Mentor/videoview?vno=${video.vno}"> <video
													src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${video.videofile}"
													width="400px" height="300px" muted
													onmouseover="this.play()" onmouseout="this.pause()"
													autobuffer="true" style="border-radius: 0.5rem;"
													class="clip" id="clip" /> </video></a>
										</div>
										<div class="content_information">
											<div class="content_information_title">
												<span>${video.videoname}</span>
											</div>
											<div class="content_information_sub_title">
												<span>${video.videotype}</span>
											</div>
										</div>
									</div>

								</c:when>

							</c:choose>

						</c:forEach>
					</div>
				</div>
				<div class="main_content_lecture_box_wraper">
					<div class="lecture_course_header">
						<a
							href="http://localhost:8080/Mentor/course_class?videotype=IT%EA%B0%9C%EB%B0%9C">
							<span class="lecture_course_header_parent"><span
								class="lecture_course_header_point">IT개발</span> 분야 강의</span><i
							class="fa-solid fa-angle-right"></i>
						</a> <span class="lecture_course_header_child">국내 최고의 현직자들이
							업로드한 IT개발 분야 강의입니다!</span>
					</div>
					<div class="main_content_lecture_box">
						<c:forEach var="video" items="${video}" varStatus="status">

							<c:choose>
								<c:when test="${video.videotype=='IT개발'}">

									<div class="content">
										<div class="main_content_lecture_video">
											<a href="../Mentor/videoview?vno=${video.vno}"> <video
													src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${video.videofile}"
													width="400px" height="300px" muted
													onmouseover="this.play()" onmouseout="this.pause()"
													autobuffer="true" style="border-radius: 0.5rem;"
													class="clip" id="clip" /> </video></a>
										</div>
										<div class="content_information">
											<div class="content_information_title">
												<span>${video.videoname}</span>
											</div>
											<div class="content_information_sub_title">
												<span>${video.videotype}</span>
											</div>
										</div>
									</div>

								</c:when>

							</c:choose>

						</c:forEach>
					</div>
				</div>
				<div class="main_content_lecture_box_wraper">
					<div class="lecture_course_header">
						<a
							href="http://localhost:8080/Mentor/course_class?videotype=%EC%9D%B8%EC%82%AC/%EC%B4%9D%EB%AC%B4/%EB%85%B8%EB%AC%B4">
							<span class="lecture_course_header_parent"><span
								class="lecture_course_header_point">인사·총무·노무</span> 분야 강의</span><i
							class="fa-solid fa-angle-right"></i>
						</a> <span class="lecture_course_header_child">국내 최고의 현직자들이
							업로드한 인사·총무·노무 분야 강의입니다!</span>
					</div>
					<div class="main_content_lecture_box">
						<c:forEach var="video" items="${video}" varStatus="status">

							<c:choose>
								<c:when test="${video.videotype=='인사/총무/노무'}">

									<div class="content">
										<div class="main_content_lecture_video">
											<a href="../Mentor/videoview?vno=${video.vno}"> <video
													src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${video.videofile}"
													width="400px" height="300px" muted
													onmouseover="this.play()" onmouseout="this.pause()"
													autobuffer="true" style="border-radius: 0.5rem;"
													class="clip" id="clip" /> </video></a>
										</div>
										<div class="content_information">
											<div class="content_information_title">
												<span>${video.videoname}</span>
											</div>
											<div class="content_information_sub_title">
												<span>${video.videotype}</span>
											</div>
										</div>
									</div>

								</c:when>

							</c:choose>

						</c:forEach>
					</div>
				</div>
				<div class="main_content_lecture_box_wraper">
					<div class="lecture_course_header">
						<a
							href="http://localhost:8080/Mentor/course_class?videotype=%EB%A7%88%EC%BC%93%ED%8C%85/MD">
							<span class="lecture_course_header_parent"><span
								class="lecture_course_header_point">마켓팅·MD</span> 분야 강의</span><i
							class="fa-solid fa-angle-right"></i>
						</a> <span class="lecture_course_header_child">국내 최고의 현직자들이
							업로드한 마켓팅·MD 분야 강의입니다!</span>
					</div>
					<div class="main_content_lecture_box">
						<c:forEach var="video" items="${video}" varStatus="status">

							<c:choose>
								<c:when test="${video.videotype=='마케팅/MD'}">

									<div class="content">
										<div class="main_content_lecture_video">
											<a href="../Mentor/videoview?vno=${video.vno}"> <video
													src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${video.videofile}"
													width="400px" height="300px" muted
													onmouseover="this.play()" onmouseout="this.pause()"
													autobuffer="true" style="border-radius: 0.5rem;"
													class="clip" id="clip" /> </video></a>
										</div>
										<div class="content_information">
											<div class="content_information_title">
												<span>${video.videoname}</span>
											</div>
											<div class="content_information_sub_title">
												<span>${video.videotype}</span>
											</div>
										</div>
									</div>

								</c:when>

							</c:choose>

						</c:forEach>
					</div>
				</div>
				<div class="main_content_lecture_box_wraper">
					<div class="lecture_course_header">
						<a
							href="http://localhost:8080/Mentor/course_class?videotype=%EC%98%81%EC%97%85/%EC%98%81%EC%97%85%EA%B4%80%EB%A6%AC">
							<span class="lecture_course_header_parent"><span
								class="lecture_course_header_point">영업·영업관리</span> 분야 강의</span><i
							class="fa-solid fa-angle-right"></i>
						</a> <span class="lecture_course_header_child">국내 최고의 현직자들이
							업로드한 영업·영업관리 분야 강의입니다!</span>
					</div>
					<div class="main_content_lecture_box">
						<c:forEach var="video" items="${video}" varStatus="status">

							<c:choose>
								<c:when test="${video.videotype=='영업/영업관리'}">

									<div class="content">
										<div class="main_content_lecture_video">
											<a href="../Mentor/videoview?vno=${video.vno}"> <video
													src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${video.videofile}"
													width="400px" height="300px" muted
													onmouseover="this.play()" onmouseout="this.pause()"
													autobuffer="true" style="border-radius: 0.5rem;"
													class="clip" id="clip" /> </video></a>
										</div>
										<div class="content_information">
											<div class="content_information_title">
												<span>${video.videoname}</span>
											</div>
											<div class="content_information_sub_title">
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
	</div>
</body>

</html>