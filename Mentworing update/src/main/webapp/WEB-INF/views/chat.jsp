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
<style>
.chat_button {
	background-color: #FFE400;
	width: 110px;
	height: 55px;
}

* {
	margin: 0;
	padding: 0;
}

.store-header {
	font-size: 42px;
	border-bottom: 3px solid #ccc;
	padding: 24px;
	margin-top: 30px;
}

ul, ol, li {
	margin-top: 30px;
	list-style: none;
}

.container {
	width: 700px;
	padding: 25px
}

.container h1 {
	text-align: left;
	padding: 5px 5px 5px 15px;
	color: #FFBB00;
	border-left: 3px solid #FFBB00;
	margin-bottom: 20px;
}

.move {
	font-size: 15px;
	display: block;
	margin-top: 10px;
	margin-left: 446px;
	margin-bottom: 80px;
}

.chating {
	background-color: #D4F4FA;
	height: 740px;
	overflow: auto;
	text-align: right;
}

.chating .me {
	background-color: white;
	padding: 15px 13px;
	border-radius: 15px;
	outline: 1px solid black;
	color: black;
	font-size: 20px;
	font-weight: bolder !important;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: normal;
	line-height: 1.2;
	word-wrap: break-word;
	display: -webkit-box;
	-webkit-line-clamp: 3;
	-webkit-box-orient: vertical;
	border-top-right-radius: 0px;
	margin-right: 0px;
	margin-left: 330px;
	text-align: center;
	width: 40%;
	height: 10%;
}

img {
	border: 0 none;
	font-size: 0;
	line-height: 0;
	border-radius: 30px;
}

#img2 {
	border: 0 none;
	font-size: 0;
	line-height: 0;
	border-radius: 30px;
	margin-right: 580px;
	text-align: left;
}

.chating .others {
	background-color: white;
	padding: 15px 13px;
	border-radius: 15px;
	outline: 1px solid black;
	color: black;
	font-size: 20px;
	font-weight: bolder !important;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: normal;
	line-height: 1.2;
	word-wrap: break-word;
	display: -webkit-box;
	-webkit-line-clamp: 3;
	-webkit-box-orient: vertical;
	border-top-left-radius: 3px;
	margin-right: 0px;
	margin-left: 50px;
	width: 40%;
	height: 10%;
	text-align: center;
}

.chat_input {
	border-radius: 15px;
	width: 530px;
	height: 90px;
}

#yourMsg {
	display: none;
}

#chat_others_date {
	position: relative;
	margin-right: 210px;
}

#chat_me_date {
	position: relative;
	margin-right: 300px;
}
</style>
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

						$("#chating")
								.append(

										"<br><img src='${pageContext.request.contextPath}/resources/img/profile.jpg' id='img1' height='50' width='50'><p class='me'>"
												+ d.msg
												+ "</p><p id='chat_me_date'>"
												+ timeString + "</p>");
						$('#chating').scrollTop($('#chating')[0].scrollHeight);
					} else {
						$("#chating")
								.append(
										"<br> <img src='${pageContext.request.contextPath}/resources/img/profile.jpg' id='img2' height='50' width='50'> <p class='others'>"
												+ d.userName
												+ " :"
												+ d.msg
												+ "</p><p id='chat_others_date'>"
												+ timeString + "</p>");
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
		var option = {
			type : "message",
			sessionId : $("#sessionId").val(),
			userName : $("#userName").val(),
			msg : $("#chatting").val()
		}
		ws.send(JSON.stringify(option))
		$('#chatting').val("");
	}
</script>


<body>

	<div id="container" class="container">
		<h1>채팅</h1>
		<input type="hidden" id="sessionId" value="">

		<div id="chating" class="chating">

			<c:forEach var="chat" items="${chatVO}">


				<c:choose>

					<c:when test="${chat.name==name}">
						<br>
						<br>
						<br>
						<div>${chat.name}</div>

						<img
							src="${pageContext.request.contextPath}/resources/img/profile.jpg"
							id="img" height="50" width="50" />
						<p class="me">${chat.message}</p>
						<p id="chat_me_date">${chat.chat_date}</p>

					</c:when>

					<c:when test="${chat.name==mentorname}">

						<br>
						<div style="text-align: left;"> ${mentorname}</div>
						<img
							src="${pageContext.request.contextPath}/resources/img/profile.jpg"
							id="img2" height="50" width="50" />
						<p class="others">${chat.name}:${chat.message}
							<br>
						</p>
						<p id="chat_others_date">${chat.chat_date}</p>
					</c:when>



				</c:choose>

			</c:forEach>
		</div>





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
			<table class="inputTable">
				<tr>
					<th><input id="chatting" placeholder="   보내실 메시지를 입력하세요."
						class="chat_input"></th>
					<th><button onclick="send()" id="sendBtn" class="chat_button">보내기</button></th>
				</tr>
			</table>
		</div>
	</div>


</body>
</html>