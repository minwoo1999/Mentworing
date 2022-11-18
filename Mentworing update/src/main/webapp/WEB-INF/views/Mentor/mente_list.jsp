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
	function functionC(memberprofile,name, mentorprofile,roomno) {
		var mentorname = document.getElementById("mentorname").value;
		console.log("방번호"+roomno);
		
		console.log("멘토이름" + mentorname);
		console.log("상대이름" + name);
		
		sessionStorage.setItem('memberprofile', mentorprofile); // 세션 등록
		sessionStorage.setItem('mentorprofile', memberprofile); // 세션 등록
		
		sessionStorage.setItem('chatyourname', name); // 세션 등록
		$
				.ajax({
					url : "/Mentor/mente_list_getchatname?name=" + name+"&roomno="+roomno,
					type : 'get',
					dataType : 'json',
					success : function(result) {
						if (result != null) {
							console.log(result.msg);
							console.log(result);
							for (var i = 0; i < result.length; i++) {
								console.log(result.at(i).name);
								var str = result.at(i).message;
								if (result.at(i).name == mentorname) {

									console.log(str);
									console.log(str.includes("jpg"));
									console.log("멘티리스트 파일올리고 사진"
											+ mentorprofile);

									if (str.includes("jpg")
											|| str.includes("png")
											|| str.includes("PNG")
											|| str.includes("JPG")) {
										console.log("멘토가 파일올리고 들어오는곳");
										$("#chating")
												.append(

														"<div class='chat_box_menti'><div class='chat_box_menti_chat_time'><span class='me'>"
																+ "<img src='https://infruntest.s3.ap-northeast-2.amazonaws.com/"
																+ result.at(i).message
																+ "' height='180' width='160' class='file_img'>"
																+ "</span><span id='chat_me_date'>"
																+ result.at(i).chat_date
																+ "</span>"
																+ "</div>"
																+ "<img src='https://infruntest.s3.ap-northeast-2.amazonaws.com/"+ mentorprofile +"' class='chat_my_img' height='40' width='40'>");
										$('#chating').scrollTop(
												$('#chating')[0].scrollHeight);
									} else {
										console.log("멘토가 채팅칠떄 들어오는곳");
										$("#chating")
												.append(

														"<div class='chat_box_menti'><div class='chat_box_menti_chat_time'><span class='me'>"
																+ result.at(i).message
																+ "</span><span id='chat_me_date'>"
																+ result.at(i).chat_date
																+ "</span>"
																+ "</div>"
																+ "<img src='https://infruntest.s3.ap-northeast-2.amazonaws.com/"+ mentorprofile +"' class='chat_my_img' height='40' width='40'>");
										$('#chating').scrollTop(
												$('#chating')[0].scrollHeight);
									}

								}
								if (result.at(i).name == name) {
									if (str.includes("jpg")
											|| str.includes("png")
											|| str.includes("PNG")
											|| str.includes("JPG")) {
										$("#chating")
												.append(
														"<div class='chat_box_mentor'><img src='${pageContext.request.contextPath}/resources/img/profile.jpg' id='img2' height='40' width='40' class='chat_other_img'><div class='chat_box_mentor_chat_time'> <span class='others'>"
																+ result.at(i).name
																+ " :"
																+ "<img src='https://infruntest.s3.ap-northeast-2.amazonaws.com/"
																+ result.at(i).message
																+ "' height='180' width='160' class='file_img'>"
																+ "</span><span id='chat_others_date'>"
																+ result.at(i).chat_date
																+ "</span>"
																+ "</div>");
									} else {
										$("#chating")
												.append(
														"<div class='chat_box_mentor'><img src='${pageContext.request.contextPath}/resources/img/profile.jpg' id='img2' height='40' width='40' class='chat_other_img'><div class='chat_box_mentor_chat_time'> <span class='others'>"
																+ result.at(i).name
																+ " :"
																+ result.at(i).message
																+ "</span><span id='chat_others_date'>"
																+ result.at(i).chat_date
																+ "</span>"
																+ "</div>");
									}

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
<script type='text/javascript'>
	function mentee_lecture_list() {
		var show_lecture_list = $('<div id="mentee_lecture_list_box"></div>');
		show_lecture_list.show();
		show_lecture_list.appendTo(document.body);
		$('.mentee_lecture_list_box').show();
		$('.close').click(function() {
			$('.mentee_lecture_list_box').hide();
			showlay.appendTo(document.body).remove();
			return false;
		});
	}
</script>
<body>


	<input type="hidden" id="sessionname" value="${name}">
	<div class="mentee_list_body">
		<!-- 헤더부분 -->
		<%@include file="./mainheader.jsp"%>
		<!-- 헤더부분 -->
		<div class='Login_popup'>
			<div class='Login_cnt223'>

				<%@include file="../Mentor/Mentor_chat.jsp"%>

			</div>
		</div>
		
		
		
		<div class="mentee_list_title_container">
			<div class="mentee_list_title_wraper">
				<span class="mentee_list_title_title">Take care of the
					mentees who are taking the lecture</span> <span
					class="mentee_list_title_subtitle">강의를 수강 중인 멘티들을 관리하세요!</span>
			</div>
		</div>



		


		<div class="mentor_mentee_list_container">
			<div class="mentor_mentee_list_wraper">

				<div class="metee_mypage_side_wraper">
					<span class="menu_title_box_span">Menu</span>
					<button onclick="location.href=''../Mentor/Myvideo'">My강의</button>
					<button onclick="location.href='../Mentor/Mentor_Mypage'">개인정보수정</button>
					<button onclick="location.href='../Mentor/Mentor_Mypage_Chart'">월매출통계</button>
					<button onclick="location.href='../Mentor/videoupload'">강의업로드</button>
					<button onclick="location.href='../Mentor/mente_list'"
						id="selet_my_upload_lecture">멘티목록</button>
				</div>
				<div class="meteeList_mypage_main_wraper">
					<input type="hidden" value="${mentorname}" id="mentorname">
					<input type="hidden" value="${name}" id="username">
					

					<c:set var="tempname" value="" />


					<c:forEach var="paymentlist" items="${paymentlist}">
						<c:choose>


							<c:when test="${paymentlist.mno==mno}">

								<c:if test="${paymentlist.userId != tempname}">

									<c:forEach var="userlist" items="${userlist}">


										<c:forEach var="memberProfile" items="${memberProfile}">

											<c:forEach var="list" items="${list}">


												<c:if
													test="${paymentlist.userId == userlist.id && paymentlist.userId==memberProfile.userId &&list.name==userlist.name}">
													
													<div class="mentro_mentee_list_content">
														<input type="button" class="mentee_msg_count"
														value="${list.notificationnumber}"
														onclick="functionC('${memberProfile.profile}','${userlist.name}','${mentor.profile}','${list.roomno}');">
														<img
															src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${memberProfile.profile}"
															class="mentor_mentee_img">


														<div class="mentee_list_content_mentee_name">
															<i class="fa-solid fa-leaf"></i><span>${userlist.name}
																멘티</span>

														</div>

														<div class="menteeLectureListBox">
															<div class="menteeLectureBoxTitle">${userlist.name}
																멘티의 수강 리스트</div>
															<div class="MenteeLectureBox">
																<c:forEach var="video_record" items="${video_record}">
																	<c:forEach var="mentee_list" items="${mentee_list}">


																		<c:if
																			test="${mentee_list.no==video_record.no && mentee_list.vno==video_record.vno}">

																			<c:if test="${video_record.video_record!=0}">

																				<c:set var="percent"
																					value="${(video_record.video_record /video_record.video_end)*100 }" />
																			</c:if>



																			<c:if test="${userlist.name==mentee_list.name}">

																				<div class="LectureListWrapper">
																					<div class="LectureTitle_RecentDate">
																						<span class="menteeVideoName">📢
																							${mentee_list.videoname} (최근 수강 날짜 :
																							${video_record.watch_date})</span>
																					</div>
																					<div
																						class="recent_lecture_box_information_box_information_box">
																						<div class="PrograssBox">
																							<div class="leftPrograssBox">
																								<span>강의 진행률 </span>
																							</div>
																							<div class="prograssVarBox">
																								<progress
																									value="<fmt:formatNumber type="number" pattern="0.00"
													value="${ ((percent*100) - ((percent*100)%1)) * (1/100)   } " />"
																									max="100"></progress>
																							</div>
																							<div class="deadLinePercentBox">

																								<div class="percent_box">
																									<span>진도율</span>
																									<fmt:formatNumber type="number" pattern="0.00"
																										value="${ ((percent*100) - ((percent*100)%1)) * (1/100)   } " />
																									%
																								</div>
																							</div>
																						</div>
																					</div>
																				</div>

																			</c:if>


																		</c:if>



																	</c:forEach>
																</c:forEach>
															</div>
														</div>
													</div>
												</c:if>
											</c:forEach>
										</c:forEach>

									</c:forEach>
								</c:if>







							</c:when>

						</c:choose>


						<c:set var="tempname" value="${paymentlist.userId}" />

					</c:forEach>





					<c:set var="tempname" value="" />

					<c:set var="tempname2" value="" />



				</div>

			</div>
		</div>
		<p class="pagehelper">${pageHttp}</p>
		<!-- 하단부분 -->
		<%@ include file="./footer.jsp"%>
		<!-- 하단부분 -->
		<script src="https://kit.fontawesome.com/20556dcc55.js"
			crossorigin="anonymous"></script>
	</div>
</body>
</html>