<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="${pageContext.request.contextPath}/resources/css/styles.css?after"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/resources/css/style.css?after"
	rel="stylesheet" />
<title>Insert title here</title>
</head>
<body>
	<div class=vidio_edit_body>
	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->
	<div class="video_edit_title_container">
				<div class="video_edit_title_wraper">
					<span class=video_edit_title_title>You can modify the lecture</span>
					<span class=video_edit_title_subtitle>강의를 수정할 수 있습니다!</span>
				</div>
			</div>
			<form:form modelAttribute="Video" method="post"
				onsubmit="return checkvideo()" action="videoedit" enctype="multipart/form-data">
				<div class="vidio_edit_main_container">
					<div class="vidio_edit_main_wraper">
						<div class="vidio_edit_main_imgbox">
							<th><video id="video" width="600" height="400" controls></video></th>
							<td><input id="file-input" type="file" accept="video/*"
								class="img_registration_btn" name="videofile">
						</div>


						<div class="vidio_edit_information_box">
							<div class="information_input_box">
								<div class="information_input_title">
									<span>강의 종류를 선택하세요</span><i class="fa-solid fa-star"></i>
								</div>
								<select name="videotype" class="lecture_duty">
									<option value="인사/총무/노무">인사/총무/노무</option>
									<option value="마케팅/MD">마케팅/MD</option>
									<option value="홍보/CSR<">홍보/CSR</option>
									<option value="영업/영업관리">영업/영업관리</option>
									<option value="해외영업">해외영업</option>
									<option value="유통/무역/구매">유통/무역/구매</option>
									<option value="IT개발">IT개발</option>
									<option value="디자인/예술">디자인/예술</option>
									<option value="연구/설계">연구/설계</option>
									<option value="기타">기타</option>
								</select>
							</div>
							<input type="hidden" name="mno" value="${mno}"> <input
								type="hidden" name="vno" value="${vno}">
							<div class="vidio_edit_information_input_box">
								<div class="information_input_title">
									<span>강의명을 입력하세요</span><i class="fa-solid fa-star"></i>
								</div>
								<input type="text" name="videoname" value="${videoname}"
									class="major">
							</div>
							<div class="vidio_edit_information_input_box">
								<div class="information_input_title">
									<span>강의 가격을 입력하세요</span><i class="fa-solid fa-star"></i>
								</div>
								<input type="text" name="videoprice" value="${videoprice}"
									class="certificate">
							</div>
							<div class="vidio_edit_information_input_box">
								<div class="information_input_title">
									<span>강의를 소개하세요</span><i class="fa-solid fa-star"></i>
								</div>
								<textarea id="vidio_edit_big_box" name="videointroduce" class="introduce">${videointroduce}</textarea>
							</div>

						</div>
					</div>
					<button type="submit" class="video_edit_submit_btn">강의 수정</button>
				</div>

			</form:form>
		





	<!-- 하단부분 -->
	<%@ include file="./footer.jsp"%>
	<!-- 하단부분 -->
	</div>
</body>

<script>
	const input = document.getElementById('file-input');
	const video = document.getElementById('video');
	const videoSource = document.createElement('source');
	input.addEventListener('change', function() {
		const files = this.files || [];

		if (!files.length)
			return;

		const reader = new FileReader();

		reader.onload = function(e) {
			videoSource.setAttribute('src', e.target.result);
			video.appendChild(videoSource);
			video.load();
			video.pause();
		};

		reader.onprogress = function(e) {
			console.log('progress: ', Math.round((e.loaded * 100) / e.total));
		};

		reader.readAsDataURL(files[0]);
	});
	
	

</script>
</html>