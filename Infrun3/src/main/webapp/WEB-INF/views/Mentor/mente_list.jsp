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
<script type='text/javascript'>
	function functionC(name, mentorprofile) {
		var mentorname = document.getElementById("mentorname").value
		console.log("멘토이름" + mentorname);
		console.log("상대이름" + name);
		sessionStorage.setItem('chatyourname', name); // 세션 등록
		$
				.ajax({
					url : "/Mentor/mente_list_getchatname?name=" + name,
					type : 'get',
					dataType : 'json',
					success : function(result) {
						if (result != null) {
							console.log(result.msg);
							console.log(result);
							for (var i = 0; i < result.length; i++) {
								console.log(result.at(i).name);
								if (result.at(i).name == mentorname) {
									console.log(i);
									$("#chating")
											.append(

													"<div class='chat_box_menti'><div class='chat_box_menti_chat_time'><span class='me'>"
															+ result.at(i).message
															+ "</span><span id='chat_me_date'>"
															+ result.at(i).chat_date
															+ "</span>"
															+ "</div>"
															+ "<img src='https://infruntest.s3.ap-northeast-2.amazonaws.com/"+ mentorprofile +"' class='chat_my_img' height='30' width='30'>");
									$('#chating').scrollTop(
											$('#chating')[0].scrollHeight);
								}
								if (result.at(i).name == name) {

									$("#chating")
											.append(
													"<div class='chat_box_mentor'><img src='${pageContext.request.contextPath}/resources/img/profile.jpg' id='img2' height='30' width='30' class='chat_other_img'><div class='chat_box_mentor_chat_time'> <span class='others'>"
															+ result.at(i).name
															+ " :"
															+ result.at(i).message
															+ "</span><span id='chat_others_date'>"
															+ result.at(i).chat_date
															+ "</span>"
															+ "</div>");

								}

							}

						} else {
							console.log("실패하였습니다.");
						}
					}
				});

		var overlay = $('<div class="overlay"></div>');
		console.log(overlay);
		overlay.show();
		overlay.appendTo(document.body);
		$('.Login_popup').show();
		$('.close').click(function() {
			$('.Login_popup').hide();
			overlay.appendTo(document.body).remove();
			$("#otherchatting").empty();
			$("#mychatting").empty();
			location.reload();
			return false;
		});
	}
</script>

<body>
	<div class="mentor_page_body">
		<!-- 헤더부분 -->
		<%@include file="./mainheader.jsp"%>
		<!-- 헤더부분 -->



		<div class='Login_popup'>
			<div class='Login_cnt223'>

				<%@include file="../Mentor/Mentor_chat.jsp"%>

			</div>
		</div>

		<input type="hidden" value="${mentorname}" id="mentorname"> <input
			type="hidden" value="${name}" id="username">


		<c:set var="tempname" value="" />

		<c:forEach var="paymentlist" items="${paymentlist}" varStatus="status">

			<c:choose>


				<c:when test="${paymentlist.mno==mno}">

					<c:if test="${paymentlist.userId != tempname}">

						<c:forEach var="userlist" items="${userlist}">
							<c:if test="${paymentlist.userId == userlist.id}">
								<p class="mentelist_userId">${userlist.name}수강생이신청한강의목록</p>

								<input type="button" value="${userlist.name}"
									onclick="functionC('${userlist.name}','${mentor.profile}');">

								<video
									src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${paymentlist.vfilename}"
									class="mentorview_content_img"></video>


							</c:if>

						</c:forEach>
					</c:if>

					<c:if test="${paymentlist.userId == tempname}">


						<video
							src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${paymentlist.vfilename}"
							class="mentorview_content_img"></video>


					</c:if>

				</c:when>

			</c:choose>

				<c:set var="tempname" value="${paymentlist.userId}" />


		</c:forEach>


		<p class="pagehelper">${pageHttp}</p>


		<!-- 하단부분 -->
		<%@ include file="./footer.jsp"%>
		<!-- 하단부분 -->
		<script src="https://kit.fontawesome.com/20556dcc55.js"
			crossorigin="anonymous"></script>
	</div>
</body>
</html>