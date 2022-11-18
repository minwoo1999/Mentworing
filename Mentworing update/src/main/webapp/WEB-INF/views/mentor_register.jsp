<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/resources/css/styles.css"
	rel="stylesheet" />
<title>Insert title here</title>
</head>

<body>
	<script>
   
   function setThumbnail(event) { for (var image of event.target.files) { var reader = new FileReader(); reader.onload = function(event) { var img = document.createElement("img"); img.setAttribute("src", event.target.result); document.querySelector("div#image_container").appendChild(img); }; console.log(image); reader.readAsDataURL(image); } }
   
   
   </script>

	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->
	<div class="mentor_register_body">
		<div class=mentor_register_body>

			<div class="mentor_register_title_container">
				<div class="mentor_register_title_wraper">
					<span class=mentor_register_title_title>Be a mentor and
						upload a lecture</span> <span class=mentor_register_title_subtitle>멘토가
						되어서 강의를 업로드해보세요!</span>
				</div>
			</div>

			<form:form modelAttribute="Mentor" method="post"
				action="mentor_register" enctype="multipart/form-data">
				<div class="mentor_join_main_container">
					<div class="mentor_join_main_wraper">
						<div class="metor_join_main_imgbox">
							<th><label for="content"></label></th>
							<td><div id="image_container"></div></td> <input type="file"
								class="img_registration_btn" id="file" accept="image/*"
								onchange="setThumbnail(event);" name="profile" multiple />
						</div>


						<div class="information_box">
							<div class="information_input_box">
								<div class="information_input_title">
									<span>직무 유형</span><i class="fa-solid fa-star"></i>
								</div>
								<select name="officetype" class="duty">
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
							<input type="hidden" name="no" value="${userNo}">
							<div class="information_input_box">
								<div class="information_input_title">
									<span>전공 정보</span><i class="fa-solid fa-star"></i>
								</div>
								<input type="text" name="major" placeholder=" 전공 정보를 입력하세요."
									class="major">
							</div>
							<div class="information_input_box">
								<div class="information_input_title">
									<span>자격증 정보</span><i class="fa-solid fa-star"></i>
								</div>
								<input type="text" name="certificate"
									placeholder=" 자격증 정보를 입력하세요." class="certificate">
							</div>
							<div class="information_input_box">
								<div class="information_input_title">
									<span>인사말</span><i class="fa-solid fa-star"></i>
								</div>
								<textarea id="big_box" name="headcomment"
									placeholder="인사말을 작성해주세요." class="introduce"></textarea>
							</div>
							<div class="information_input_box">
								<div class="information_input_title">
									<span>자기소개</span><i class="fa-solid fa-star"></i>
								</div>
								<textarea id="big_box" name="mainintroduce"
									placeholder="자기소개를 입력하세요." class="introduce"></textarea>
							</div>

							<div class="information_input_box">
								<div class="information_input_title">
									<span>이런분들에게 추천합니다</span><i class="fa-solid fa-star"></i>
								</div>
								<textarea id="big_box" name="rcmcomment"
									placeholder="이런 분들에게 추천합니다." class="introduce"></textarea>
							</div>
						</div>
					</div>
					<button type="submit" class="mentor_register_join_btn">멘토
						등록</button>
				</div>

			</form:form>
			<div class="icon_menu_bar_container">
				<div class="icon_menu_bar_wrap">
					<a href="#" class="icon_menu"> <i
						class="fa-solid fa-chalkboard-user"></i> <span>멘토링</span>
					</a> <a href="#" class="icon_menu"> <i class="fa-solid fa-list"></i>
						<span>강의목록</span>
					</a> <a href="#" class="icon_menu"> <i
						class="fa-solid fa-pen-to-square"></i> <span>멘토링 후기</span>
					</a> <a href="#" class="icon_menu"> <i
						class="fa-solid fa-clipboard-question"></i> <span>Q & A</span>
					</a>
				</div>
			</div>

		</div>
	</div>
	<script src="https://kit.fontawesome.com/20556dcc55.js"
		crossorigin="anonymous"></script>
</body>
</html>