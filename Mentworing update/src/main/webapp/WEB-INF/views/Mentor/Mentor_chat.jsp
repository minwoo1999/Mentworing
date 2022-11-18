<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet" />
<link href="${path}/resources/css/normalbase.css" rel="stylesheet" />
<link href="${path}/resources/css/mbs.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/chat.css"
	rel="stylesheet" type="text/css" />

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.9.2/i18n/jquery.ui.datepicker-ko.min.js"></script>
<meta charset="UTF-8">
<title>Chating</title>

<style>
.msgImg {
	width: 200px;
	height: 125px;
}

.clearBoth {
	clear: both;
}

.img {
	float: right;
}
</style>
</head>

<script type="text/javascript">
	var sessionname = document.getElementById("sessionname").value;

	var ws;

	function wsOpen() {
		ws = new WebSocket("ws://" + location.host + "/chating");
		wsEvt();
	}

	function wsEvt() {
		ws.onopen = function(data) {
			//소켓이 열리면 동작
		}

		ws.onmessage = function(data) {
			$('#chating').scrollTop($('#chating')[0].scrollHeight);

			console.log("온 메세지로 들어왔음");

			var today = new Date();

			var year = today.getFullYear();
			var month = ('0' + (today.getMonth() + 1)).slice(-2);
			var day = ('0' + today.getDate()).slice(-2);
			var hours = ('0' + today.getHours()).slice(-2);
			var minutes = ('0' + today.getMinutes()).slice(-2);
			var seconds = ('0' + today.getSeconds()).slice(-2);

			var timeString = year + '-' + month + '-' + day + ' ' + hours + ':'
					+ minutes + ':' + seconds;
			//메시지를 받으면 동작
			var msg = data.data;
			var d = JSON.parse(msg);
			console.log("파일은" + d.file);
			console.log(d);
			console.log("내이름:" + d.userName, "상대이름" + d.yourName);

			//현재 들어온사용자와 해당하는 멘토에게만 채팅을 뿌려주기위한 if 문

			
				if (msg != null && msg.trim() != '' && d.file == null) {

					console.log("온 메세지 ");
					console.log(sessionStorage.getItem("memberprofile"));
					console.log(sessionStorage.getItem("mentorprofile"));
					console.log(msg);

					if (d.type == "getId") {
						var si = d.sessionId != null ? d.sessionId : "";
						if (si != '') {
							$("#sessionId").val(si);
						}
					} else if (d.type == "message") {
						if (d.userName == sessionname || d.yourName == sessionname) {
							console.log("같긴해");


						if (d.sessionId == $("#sessionId").val()) {
							var mentorprofile = $("#mentorprofile").val();
							var memberprofile = $("#memberprofile").val();

							if ($("#mentorprofile").val() != "") {

								$("#chating")
										.append(

												"<div class='chat_box_menti'><div class='chat_box_menti_chat_time'><span class='me'>"
														+ d.msg
														+ "</span><span id='chat_me_date'>"
														+ timeString
														+ "</span>"
														+ "</div>"
														+ "<img src='https://infruntest.s3.ap-northeast-2.amazonaws.com/"+ mentorprofile +"' class='chat_my_img' height='30' width='30'>");
								$('#chating').scrollTop(
										$('#chating')[0].scrollHeight);
							}

							if ($("#memberprofile").val() != "") {
								$("#chating")
										.append(

												"<div class='chat_box_menti'><div class='chat_box_menti_chat_time'><span class='me'>"
														+ d.msg
														+ "</span><span id='chat_me_date'>"
														+ timeString
														+ "</span>"
														+ "</div>"
														+ "<img src='https://infruntest.s3.ap-northeast-2.amazonaws.com/"+ memberprofile +"' class='chat_my_img' height='30' width='30'>");
								$('#chating').scrollTop(
										$('#chating')[0].scrollHeight);
							}

						} else {
							$("#chating")
									.append(
											"<div class='chat_box_mentor'><img src='https://infruntest.s3.ap-northeast-2.amazonaws.com/"
													+ sessionStorage
															.getItem("mentorprofile")
													+ "' id='img2' height='40' width='40' class='chat_other_img'><div class='chat_box_mentor_chat_time'><span class='others'>"
													+ d.userName
													+ " :"
													+ d.msg
													+ "</span><span id='chat_others_date'>"
													+ timeString
													+ "</span>"
													+ "</div>");
							$('#chating').scrollTop(
									$('#chating')[0].scrollHeight);
						}

					} else {
						console.warn("unknown type!")
					}
				} else {
					console.log("온 파일");
					mentorviewmentorname = sessionStorage
							.getItem('mentorviewmentorname');
					console.log(mentorviewmentorname + "과 소통중");
					var mentorprofile = $("#mentorprofile").val();
					var memberprofile = $("#memberprofile").val();
					console.log("멘토 프로파일" + mentorprofile);
					console.log("멘티 프로파일" + memberprofile);

					if (mentorprofile != "") {
						$("#chating")
								.append(

										"<div class='chat_box_menti'><div class='chat_box_menti_chat_time'><span class='me'>"
												+ "<img src='https://infruntest.s3.ap-northeast-2.amazonaws.com/"
							+ d.file +"' height='180' width='160'  class='file_img'>"
												+ "</span><span id='chat_me_date'>"
												+ timeString
												+ "</span>"
												+ "</div>"
												+ "<img src='https://infruntest.s3.ap-northeast-2.amazonaws.com/"+ mentorprofile +"' class='chat_my_img' height='30' width='30'>");
						$('#chating').scrollTop($('#chating')[0].scrollHeight);
					} else {
						$("#chating")
								.append(
										"<img src='${pageContext.request.contextPath}/resources/img/profile.jpg' class='chat_other_img' height='30' width='30'>"
												+ "<span class='others'>"
												+ "멘토"
												+ mentorviewmentorname
												+ "</span>"
												+ "<div class='chat_box_mentor'><div class='chat_box_mentor_chat_time'><span class='others'>"
												+ "<img src='https://infruntest.s3.ap-northeast-2.amazonaws.com/"
							+ d.file +"' height='180' width='160'  class='file_img'>"
												+ "</span><span id='chat_others_date'>"
												+ timeString
												+ "</span>"
												+ "</div>");
						$('#chating').scrollTop($('#chating')[0].scrollHeight);
					}

				}

			}
		}

		document.addEventListener("keypress", function(e) {
			if (e.keyCode == 13) { //enter press
				send();
			}
		});
	}

	window.onload = function chatName() {
		var userName = $("#userName").val();
		if (userName == null || userName.trim() == "") {
			$("#userName").focus();
		} else {
			wsOpen();
			$("#yourName").hide();
			$("#yourMsg").show();
		}
	}

	function send() {

		var file = null;
		var fileReader = null;
		var key = window.event.keyCode;

		file = document.querySelector("#fileUpload").files[0];

		var chatyourname = sessionStorage.getItem('chatyourname'); // 세션 가져오기
		var mentorviewyourchatname = sessionStorage
				.getItem('mentorviewmentorname'); // 세션 가져오기
		if (chatyourname == null) {
			chatyourname = sessionStorage.getItem('mentorviewmentorname'); // 세션 가져오기
		} else {
			chatyourname = sessionStorage.getItem('chatyourname');
		}

		if (file != null) {
			console.log("ajax위");
			var formData = new FormData($('#fileForm')[0]);
			console.log(formData);
			$.ajax({
				type : "POST",
				enctype : 'multipart/form-data', // 필수
				url : '/Mentor/chat_multipartUpload',
				data : formData, // 필수
				processData : false, // 필수
				contentType : false, // 필수
				cache : false,
				success : function(result) {
					console.log("파일 전송잘됨");
				},
				error : function(e) {
				}
			});

			fileReader = new FileReader();
			console.log("파일send");
			var param = {
				type : "fileUpload",
				file : file.name,
				sessionId : $("#sessionId").val(),
				userName : $("#userName").val(),
				yourName : chatyourname
			};
			console.log("파일send2");
			ws.send(JSON.stringify(param)); //파일 보내기전 메시지를 보내서 파일을 보냄을 명시한다.
			$('#fileUpload').val("");
			$('#chatting').val("");
			fileReader.readAsArrayBuffer(file);
		} else {
			if (key != 13 && $("#chatting").val() == "") {
				alert("메세지를 입력해주세요");
				return false;
			}

			var option = {
				type : "message",
				sessionId : $("#sessionId").val(),
				userName : $("#userName").val(),
				msg : $("#chatting").val(),
				yourName : chatyourname
			}
			ws.send(JSON.stringify(option))
			$('#chatting').val("");
		}

	}

	function fileSend() {
		var file = null;
		var fileReader = null;
		var chatyourname = sessionStorage.getItem('chatyourname'); // 세션 가져오기
		var mentorviewyourchatname = sessionStorage
				.getItem('mentorviewmentorname'); // 세션 가져오기
		if (chatyourname == null) {
			chatyourname = sessionStorage.getItem('mentorviewmentorname'); // 세션 가져오기
		} else {
			chatyourname = sessionStorage.getItem('chatyourname');
		}
		file = document.querySelector("#fileUpload").files[0];
		fileReader = new FileReader();
		console.log("파일send");
		var param = {
			type : "fileUpload",
			file : file.name,
			sessionId : $("#sessionId").val(),
			userName : $("#userName").val(),
			yourName : chatyourname
		};
		console.log("파일send2");
		ws.send(JSON.stringify(param)); //파일 보내기전 메시지를 보내서 파일을 보냄을 명시한다.
		$('#fileUpload').val("");
		$('#chatting').val("");
		fileReader.readAsArrayBuffer(file);
	}
</script>


<body>
	<div class="chatting_container">
		<div class="chatting_title_close">
			<span class="chatting_title">Mantworing</span><a
				class="chatting_close_btn" href='' class='close'>x</a>
		</div>
		<input type="hidden" id="sessionId" value=""> <input
			type="hidden" id="sessionname" value="${name}">

		<div id="chating" class="chating"></div>

		<input type="hidden" id="memberprofile"
			value="${memberprofile.profile}"> <input type="hidden"
			id="mentorprofile" value="${mentorprofile}">



		<div id="yourName">
			<table class="inputTable">
				<tr>
					<th>사용자명</th>
					<th><input type="hidden" name="userName" id="userName"
						value="${name}" class="chat_input"></th>
					<th><button onclick="chatName()" id="startBtn"
							class="chat_button">이름 등록</button></th>
				</tr>
			</table>
		</div>
		<div id="yourMsg">

			<form id="fileForm" method="post" enctype="multipart/form-data">
				<input type="file" id="fileUpload" name="file"
					class="fa-solid fa-paperclip">
			</form>
			<input id="chatting" placeholder="보내실 메시지를 입력하세요." class="chat_input">
			<button onclick="send()" id="sendBtn" class="chat_button">전송</button>




		</div>
	</div>


</body>
</html>