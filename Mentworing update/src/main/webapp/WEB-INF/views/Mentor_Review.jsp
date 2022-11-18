<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./jsp_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="${pageContext.request.contextPath}/resources/css/styles.css?after"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/resources/css/style.css?after"
	rel="stylesheet" />
</head>
<body>
	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->
	<div class="mentor_review_body">
		<div class="mentor_review_title_container">
			<div class="mentor_review_title_wraper">
				<span class=mentor_review_title_title>Mentoring review</span> <span
					class=mentor_review_title_subtitle>선배와 동료들에게 조언을 구해보세요. 더
					빨리, 멀리 갈 수 있어요.😀</span>
			</div>
		</div>

		<div class="mentor_review_content_container">
			<div class="mentor_review_content_wraper">


				<c:forEach var="review" items="${review}" varStatus="status">
					<c:forEach var="member" items="${member}" varStatus="status">
						<c:forEach var="mentor" items="${mentor}" varStatus="status">
							<c:choose>
								<c:when test="${review.mno==mentor.mno && mentor.no==member.no}"> 
								
								
									<div class="mentor_review_review_box">
								<div class="mentor_review_metor_img_box">
									<a href="../Mentor/Mentorview?mno=${review.mno}"> <img
										src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${review.mentorprofile}"
										class="mentor_review_metor_img" /></a>
								</div>
								<div class="mentor_review_star_review_writer_information">
									<div class="mentor_review_mentor_name"><i class="fa-solid fa-leaf"></i>${member.name} 멘토</div>
									<div class="mentor_review_star_box">

										<c:choose>
											<c:when test="${review.grade==1}">
												<i class="fa-solid fa-star"></i>
											</c:when>
											<c:when test="${review.grade==2}">
												<i class="fa-solid fa-star"></i>
												<i class="fa-solid fa-star"></i>
											</c:when>
											<c:when test="${review.grade==3}">
												<i class="fa-solid fa-star"></i>
												<i class="fa-solid fa-star"></i>
												<i class="fa-solid fa-star"></i>
											</c:when>
											<c:when test="${review.grade==4}">
												<i class="fa-solid fa-star"></i>
												<i class="fa-solid fa-star"></i>
												<i class="fa-solid fa-star"></i>
											</c:when>
											<c:when test="${review.grade==5}">
												<i class="fa-solid fa-star"></i>
												<i class="fa-solid fa-star"></i>
												<i class="fa-solid fa-star"></i>
												<i class="fa-solid fa-star"></i>
												<i class="fa-solid fa-star"></i>
											</c:when>
										</c:choose>
									</div>
									<div class="metor_review_review_box">
								
										<span class="review_box_review_content_min_height">${review.content}</span>
										<!-- <span>작성번호:${review.rno}</span> -->
									</div>
									<div class="metor_review_review_information_box">
									
										<span class="review_writerid">😉 ${review.writerid}</span> <span>${review.review_date}</span>
									</div>
								</div>
							</div>
								</c:when>
							</c:choose>
							
						</c:forEach>
					</c:forEach>
				</c:forEach>
			
			</div>
				
				
		</div>
			<center>${pageHttp}</center>	
		<!-- 하단부분 -->
		<%@ include file="./footer.jsp"%>
		<!-- 하단부분 -->
	</div>
</body>
</html>