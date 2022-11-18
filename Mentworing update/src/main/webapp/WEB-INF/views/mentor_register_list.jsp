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

</head>
<script type='text/javascript'>
	function approve(mano,no) {
		if (confirm("멘토로 등록하시겠습니까??")) {
			location.href = "mentor_register_ok?mano=" + mano+"&no="+no;
		}
	}
	
	function cancel(mano) {
		if (confirm("멘토승인취소 하시겠습니까?")) {
			location.href = "mentor_register_list_delete?mano="+mano;
		}
	}
</script>


<body>
	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->

	<div class="mentor_register_list">
		
		<div class="mentor_join_list_main_container">
			<div class="mentor_join_list_main_wraper">
				<form:form id="mentorlistForm" name="mentorlistForm" method="post">


					<table class="metor_list_table" border="1">
						<tr class="table_title">
							<th>승인번호</th>
							<th>회원번호</th>
							<th>사진</th>
							<th>자격증</th>
							<th>전공</th>
							<th>직무유형</th>
							<th>인사말</th>
							<th>자기소개</th>
							<th>승인</th>
							<th>취소</th>
						</tr>
						<tr class="deco_line">
							<th></th>
							<th></th>
							<th></th>
							<th></th>
							<th></th>
							<th></th>
							<th></th>
							<th></th>
						</tr>
						<c:forEach var="mentor" items="${mentorlist}" varStatus="status">
							<tr>
								<td>${mentor.mano}</td>
								<td>${mentor.no}</td>
								<td><img
									src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${mentor.profile}"
									width="100px" height="100px" /></td>
								<td>${mentor.certificate}</td>
								<td>${mentor.major}</td>
								<td>${mentor.officetype}</td>
								<td>${mentor.headcomment}</td>
								<td>${mentor.mainintroduce}</td>

								<td><a href="#"
									onclick="approve(${mentor.mano},${mentor.no})">승인</a></td>
								<td><a href="#"
									onclick="cancel(${mentor.mano},${mentor.no})">취소</a></td>
							</tr>
						</c:forEach>
					</table>
				</form:form>
			</div>
		</div>

		<!-- 하단부분 -->
		<%@ include file="./footer.jsp"%>
		<!-- 하단부분 -->
	</div>
	<script src="https://kit.fontawesome.com/20556dcc55.js"
		crossorigin="anonymous"></script>
</body>
</html>