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
<meta charset="UTF-8">
<title>Chating</title>
</head>

<script type="text/javascript">
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
			if (msg != null && msg.trim() != '') {
				var d = JSON.parse(msg);
				if (d.type == "getId") {
					var si = d.sessionId != null ? d.sessionId : "";
					if (si != '') {
						$("#sessionId").val(si);
					}
				} else if (d.type == "message") {
				
					if (d.sessionId == $("#sessionId").val()) {
						var mentorprofile=$("#mentorprofile").val();
						var memberprofile=$("#memberprofile").val();
					
						
						if($("#mentorprofile").val()!=""){
							console.log(mentorprofile);
							console.log(memberprofile);
							$("#chating")
							.append(

									"<div class='chat_box_menti'><div class='chat_box_menti_chat_time'><span class='me'>"
											+ d.msg
											+ "</span><span id='chat_me_date'>"
											+ timeString + "</span>"
											+ "</div>"
											+"<img src='https://infruntest.s3.ap-northeast-2.amazonaws.com/"+ mentorprofile +"' class='chat_my_img' height='30' width='30'>");
					$('#chating').scrollTop($('#chating')[0].scrollHeight);
						}
						
						if ($("#memberprofile").val()!=""){
							$("#chating")
							.append(

									"<div class='chat_box_menti'><div class='chat_box_menti_chat_time'><span class='me'>"
											+ d.msg
											+ "</span><span id='chat_me_date'>"
											+ timeString + "</span>"
											+ "</div>"
											+"<img src='https://infruntest.s3.ap-northeast-2.amazonaws.com/"+ memberprofile +"' class='chat_my_img' height='30' width='30'>");
					$('#chating').scrollTop($('#chating')[0].scrollHeight);
						}
					
				
						
					} else {
						$("#chating")
								.append(
										"<div class='chat_box_mentor'><img src='${pageContext.request.contextPath}/resources/img/profile.jpg' id='img2' height='30' width='30' class='chat_other_img'><div class='chat_box_mentor_chat_time'><span class='others'>"
												+ d.userName
												+ " :"
												+ d.msg
												+ "</span><span id='chat_others_date'>"
												+ timeString + "</span>"
												+ "</div>");
					}

				} else {
					console.warn("unknown type!")
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

		var chatyourname = sessionStorage.getItem('chatyourname'); // 세션 가져오기
		var mentorviewyourchatname=sessionStorage.getItem('mentorviewmentorname'); // 세션 가져오기
		if(chatyourname==null){
			 chatyourname=sessionStorage.getItem('mentorviewmentorname'); // 세션 가져오기
		}else{
			 chatyourname=sessionStorage.getItem('chatyourname');
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
</script>


<body>
	<div class="chatting_container">
		<div class= "chatting_title_close">
			<span class="chatting_title">Mantworing</span><a class="chatting_close_btn" href='' class='close'>x</a>
		</div>	
		<input type="hidden" id="sessionId" value="">

		<div id="chating" class="chating">


				

		</div>

		<input type="hidden" id="memberprofile" value="${memberprofile.profile}">
		<input type="hidden" id="mentorprofile" value="${mentorprofile}">



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
			
				
					<input id="chatting" placeholder="보내실 메시지를 입력하세요." class="chat_input">
					<button onclick="send()" id="sendBtn" class="chat_button">전송</button>
				
			
		</div>
	</div>


</body>
</html>