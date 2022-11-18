<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./jsp_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet" />
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.8.2.js"></script>
<meta charset="UTF-8">

<title>Insert title here</title>
<!-- 로그인 클릭시 나오는 화면 자바 스크립트 -->

</head>

<body>


	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->
	<div class="mentor_page_body">



		<!--  메인 검색기능 -->
		<div class="mentor_search_container">
			<div class="mentor_serch_main">
				<div class="mentor_search_title">
					<span>원하시는 멘토를 검색해보세요</span>
				</div>
				<div class="mentor_serach_input">
					<input type="text" placeholder="배우고 싶은 지식을 입력하세요.">
					<button class="mentor_search_submit">
						<i class="fa-solid fa-magnifying-glass"></i>
					</button>
				</div>
			</div>
		</div>

		<!--  IT개발영역 -->

		<div class=mentor_main_content_nav>
			<div class="mentor_main_content_header_container">
				<div class="mentor_main_content_header">
					<a class="mentor_main_content_header_title" href="#"> <span>IT
							개발 멘토 </span> <i class="fa-solid fa-computer"></i> 
					</a> <span class="mentor_main_content_sub_title">국내 최고의 IT 개발
						멘토들 입니다.</span>
				</div>
			</div>
		</div>

		<div class="mentor_main_content_body_container">
			<div class="mentor_main_content_body">
				<c:forEach var="userlist" items="${userlist}" varStatus="status">
					<c:forEach var="mentor" items="${mentorlist}" varStatus="status">

						<c:choose>
							<c:when test="${userlist.no==mentor.no}">

								<c:if test="${mentor.officetype=='IT개발'}">
									<div class="mentor_content">
										<a href="../Mentor/Mentorview?mno=${mentor.mno}"><img
											src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${mentor.profile}"
											width="100px" height="100px" /></a>
										<div class="mentor_content_information">
											<div class="mentor_content_information_title">
												<span class="mentor_name">${userlist.name}</span>
											</div>
											<div class="content_information_sub_title">
												<span>${mentor.officetype}</span>
											</div>
										</div>
									</div>
								</c:if>
							</c:when>
						</c:choose>

					</c:forEach>
				</c:forEach>
			</div>
		</div>


		<!--  인사,총무,노무영역 -->


		<div class=mentor_main_content_nav>
			<div class="mentor_main_content_header_container">
				<div class="mentor_main_content_header">
					<a class="mentor_main_content_header_title" href="#"> <span>인사,총무,노무
							멘토 </span> <i class="fa-solid fa-calculator"></i>
					</a> <span class="mentor_main_content_sub_title">국내 최고의 인사팀 멘토들
						입니다.</span>
				</div>
			</div>
		</div>

		<div class="mentor_main_content_body_container">
			<div class="mentor_main_content_body">
				<c:forEach var="userlist" items="${userlist}" varStatus="status">
					<c:forEach var="mentor" items="${mentorlist}" varStatus="status">

						<c:choose>
							<c:when test="${userlist.no==mentor.no}">

								<c:if test="${mentor.officetype=='인사/총무/노무'}">
									<div class="mentor_content">
										<a href="../Mentor/Mentorview?mno=${mentor.mno}"><img
											src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${mentor.profile}"
											width="100px" height="100px" /></a>
										<div class="mentor_content_information">
											<div class="mentor_content_information_title">
												<span class="mentor_name">${userlist.name}</span>
											</div>
											<div class="content_information_sub_title">
												<span>${mentor.officetype}</span>
											</div>
										</div>
									</div>
								</c:if>
							</c:when>
						</c:choose>

					</c:forEach>
				</c:forEach>
			</div>
		</div>


		<!--  마켓팅/MD -->


		<div class=mentor_main_content_nav>
			<div class="mentor_main_content_header_container">
				<div class="mentor_main_content_header">
					<a class="mentor_main_content_header_title" href="#"> <span>마켓팅/MD
							멘토 </span> <i class="fa-solid fa-headphones"></i>
					</a> <span class="mentor_main_content_sub_title">국내 최고의 마켓팅/MD
						멘토들 입니다.</span>
				</div>
			</div>
		</div>

		<div class="mentor_main_content_body_container">
			<div class="mentor_main_content_body">
				<c:forEach var="userlist" items="${userlist}" varStatus="status">
					<c:forEach var="mentor" items="${mentorlist}" varStatus="status">

						<c:choose>
							<c:when test="${userlist.no==mentor.no}">

								<c:if test="${mentor.officetype=='마케팅/MD'}">
									<div class="mentor_content">
										<a href="../Mentor/Mentorview?mno=${mentor.mno}"><img
											src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${mentor.profile}"
											width="100px" height="100px" /></a>
										<div class="mentor_content_information">
											<div class="mentor_content_information_title">
												<span class="mentor_name">${userlist.name}</span>
											</div>
											<div class="content_information_sub_title">
												<span>${mentor.officetype}</span>
											</div>
										</div>
									</div>
								</c:if>
							</c:when>
						</c:choose>

					</c:forEach>
				</c:forEach>
			</div>
		</div>


		<!--  영업/영업관리 -->


		<div class=mentor_main_content_nav>
			<div class="mentor_main_content_header_container">
				<div class="mentor_main_content_header">
					<a class="mentor_main_content_header_title" href="#"> <span>영업/영업관리
							멘토 </span> <i class="fa-solid fa-car"></i> 
					</a> <span class="mentor_main_content_sub_title">국내 최고의 영업/영업관리
						멘토들 입니다.</span>
				</div>
			</div>
		</div>

		<div class="mentor_main_content_body_container">
			<div class="mentor_main_content_body">
				<c:forEach var="userlist" items="${userlist}" varStatus="status">
					<c:forEach var="mentor" items="${mentorlist}" varStatus="status">

						<c:choose>
							<c:when test="${userlist.no==mentor.no}">

								<c:if test="${mentor.officetype=='영업/영업관리'}">
									<div class="mentor_content">
										<a href="../Mentor/Mentorview?mno=${mentor.mno}"><img
											src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${mentor.profile}"
											width="100px" height="100px" /></a>
										<div class="mentor_content_information">
											<div class="mentor_content_information_title">
												<span class="mentor_name">${userlist.name}</span>
											</div>
											<div class="content_information_sub_title">
												<span>${mentor.officetype}</span>
											</div>
										</div>
									</div>
								</c:if>
							</c:when>
						</c:choose>

					</c:forEach>
				</c:forEach>
			</div>
		</div>

		<!--  디자인/예술-->


		<div class=mentor_main_content_nav>
			<div class="mentor_main_content_header_container">
				<div class="mentor_main_content_header">
					<a class="mentor_main_content_header_title" href="#"> <span>디자인/예술
							멘토 </span> <i class="fa-solid fa-paintbrush"></i>
					</a> <span class="mentor_main_content_sub_title">국내 최고의 디자인/예술
						멘토들 입니다.</span>
				</div>
			</div>
		</div>

		<div class="mentor_main_content_body_container">
			<div class="mentor_main_content_body">
				<c:forEach var="userlist" items="${userlist}" varStatus="status">
					<c:forEach var="mentor" items="${mentorlist}" varStatus="status">

						<c:choose>
							<c:when test="${userlist.no==mentor.no}">

								<c:if test="${mentor.officetype=='디자인/예술'}">
									<div class="mentor_content">
										<a href="../Mentor/Mentorview?mno=${mentor.mno}"><img
											src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${mentor.profile}"
											width="100px" height="100px" /></a>
										<div class="mentor_content_information">
											<div class="mentor_content_information_title">
												<span class="mentor_name">${userlist.name}</span>
											</div>
											<div class="content_information_sub_title">
												<span>${mentor.officetype}</span>
											</div>
										</div>
									</div>
								</c:if>
							</c:when>
						</c:choose>

					</c:forEach>
				</c:forEach>
			</div>
		</div>

		<!-- 하단부분 -->
		<%@ include file="./footer.jsp"%>
		<!-- 하단부분 -->
		<script src="https://kit.fontawesome.com/20556dcc55.js"
			crossorigin="anonymous"></script>
	</div>
</body>
</html>