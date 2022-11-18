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
	<div class="mentee_videolist_body">
		<p class="mentee_videolist_title">나의 강의목록</p>



		<div class="metee_videolist_container">
			<c:forEach var="paymentList" items="${paymentList}">
				<c:choose>

					<c:when test="${paymentList.userId==userId}">



						<a href="../Mentor/videoview?vno=${paymentList.vno}"><video
								src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${paymentList.vfilename}"
								class="mentee_videolist_content_img"></video></a>
						



					</c:when>

				</c:choose>

			</c:forEach>
		</div>
		<!-- 하단부분 -->
		<%@ include file="./footer.jsp"%>
		<!-- 하단부분 -->
	</div>
	</div>
</body>
</html>