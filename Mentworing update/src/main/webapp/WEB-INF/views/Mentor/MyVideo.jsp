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
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->

	<div class="MyVideo_body">
		<div class="my_video_title_container">
				<div class="my_video_title_wraper">
					<span class=my_video_title_title>You can modify and delete the lecture</span>
					<span class=my_video_title_subtitle>강의를 수정 및 삭제할 수 있습니다!</span>
				</div>
			</div>
		<div class="metee_mypage_container" >
			<div class="metee_mypage_side_wraper">
			<span class="menu_title_box_span">Menu</span>
			<button onclick="location.href=''../Mentor/Myvideo'" id="selet_my_upload_lecture">My강의</button>
			<button onclick="location.href='../Mentor/Mentor_Mypage'">개인정보수정</button>
			<button onclick="location.href='../Mentor/Mentor_Mypage_Chart'">월매출통계</button>
			<button onclick="location.href='../Mentor/videoupload'">강의업로드</button>
			<button onclick="location.href='../Mentor/mente_list'">멘티목록</button>
				
			</div>
			<div class="metee_mypage_main_wraper">
			
			<div class="videoEditBody">
				<div class="MyVideo_content_body_container">
					<div class="MyVideo_content_body">
						<c:forEach var="video" items="${video}" varStatus="status">
							<div class="Myvideo_content">
	
								<a href="../Mentor/videoview?vno=${video.vno}"> <video
										src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${video.videofile}"
										width="400px" height="200px" /></video></a>
								<div class="Myvideo_content2">
									<span class="Myvideo_videoname">${video.videoname}(${video.videotype})</span>
									<span class="Myvideo_videoprice">가격: ${video.videoprice}</span>
	
									<div class="MyVideoButton">
										<input type="button" value="수정" class="Myvido_edit_button"
											onclick="location.href='/Mentor/videoedit?vno=${video.vno}'">
										<input type="button" value="삭제" class="Myvido_delete_button"
											onclick="location.href='/Mentor/videodelete?vno=${video.vno}'">
									</div>
								</div>
	
	
	
	
							</div>
	
						</c:forEach>
	
	
	
					</div>
				</div>
			</div>
	
	</div>
			
		</div>
	</div>
	<!-- 하단부분 -->
			<%@ include file="./footer.jsp"%>
			<!-- 하단부분 -->
</body>
</html>