<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/resources/css/styles.css"
	rel="stylesheet" />
<title>강의 업로드 - ManTworing</title>
</head>

<body>
	<div class="video_upload_body">
	<script>
   
   function setThumbnail(event) { for (var image of event.target.files) { var reader = new FileReader(); reader.onload = function(event) { var img = document.createElement("img"); img.setAttribute("src", event.target.result); document.querySelector("div#image_container").appendChild(img); }; console.log(image); reader.readAsDataURL(image); } }
   
   
   </script>
			<!-- 헤더부분 -->
			<%@include file="./mainheader.jsp"%>
			<!-- 헤더부분 -->
			<div class="video_upload_title_container">
				<div class="video_upload_title_wraper">
					<span class=video_upload_title_title>Please upload the lecture for everyone's</span>
					<span class=video_upload_title_subtitle>멘티들에게 도움이 되는 강의를 업로드해주세요!</span>
				</div>
			</div>



			<form:form modelAttribute="Video" method="post"
				action="videoupload" enctype="multipart/form-data">
				<div class="video_upload_main_container">
					<div class="video_upload_main_wraper">
						<div class="video_upload_main_imgbox">
							<th><video id="video" controls></video></th>
							<td><input id="file-input" type="file" accept="video/*"
								class="img_registration_btn" name="videofile">
						</div>


						<div class="video_upload_information_box">
							<div class="video_upload_information_input_box">
								<div class="video_upload_information_input_title">
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
							<input type="hidden" name="mno" value="${mno}">
							<div class="video_upload_information_input_box">
								<div class="information_input_title">
									<span>강의명을 입력하세요</span><i class="fa-solid fa-star"></i>
								</div>
								<input type="text" name="videoname" placeholder=" 강의명을 입력하세요."
									class="major">
							</div>
							<div class="video_upload_information_input_box">
								<div class="information_input_title">
									<span>강의 가격을 입력하세요</span><i class="fa-solid fa-star"></i>
								</div>
								<input type="text" name="videoprice"
									placeholder=" 강의 가격을 입력하세요." class="certificate">
							</div>
							<div class="video_upload_information_input_box">
								<div class="information_input_title">
									<span>강의를 소개하세요</span><i class="fa-solid fa-star"></i>
								</div>
								<textarea id="video_upload_big_box" name="videointroduce"
									placeholder="강의 소개를 작성해주세요." class="introduce"></textarea>
							</div>
							
						</div>
					</div>
					<button type="submit" class="mentor_registration_btn">강의
						등록</button>
						
						<!-- 하단부분 -->

				</div>
			</form:form>
			
	<%@ include file="./footer.jsp"%>
<!-- 하단부분 -->
		
		<script src="https://kit.fontawesome.com/20556dcc55.js"
		crossorigin="anonymous"></script>
		</div>
</body>
<script>

const input = document.getElementById('file-input');
const video = document.getElementById('video');
const videoSource = document.createElement('source');

input.addEventListener('change', function() {
  const files = this.files || [];

  if (!files.length) return;
  
  const reader = new FileReader();

  reader.onload = function (e) {
    videoSource.setAttribute('src', e.target.result);
    video.appendChild(videoSource);
    video.load();
    video.pause();
  };
  
  reader.onprogress = function (e) {
    console.log('progress: ', Math.round((e.loaded * 100) / e.total));
  };
  
  reader.readAsDataURL(files[0]);
});
</script>
</html>