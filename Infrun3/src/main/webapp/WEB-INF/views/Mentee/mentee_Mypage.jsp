<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="${pageContext.request.contextPath}/resources/css/styles.css?after"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/resources/css/joinStyle.css?after"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath}/resources/css/style.css?after"
	rel="stylesheet" />
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.9.2/i18n/jquery.ui.datepicker-ko.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>


<script type="text/javascript">
	function errCodeCheck(msgCode) {

		console.log(msgCode);
		if (msgCode != null && msgCode != "") {
			alert(msgCode);
			location.href = "../main"
		}

	}

	function DaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				var addr = '';
				var extraAddr = '';
				if (data.userSelectedType === 'R') {
					addr = data.roadAddress;
				} else {
					addr = data.jibunAddress;
				}
				if (data.userSelectedType === 'R') {
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}
					document.getElementById("addr2").value = extraAddr;
				} else {
					document.getElementById("addr2").value = '';
				}
				document.getElementById("zip").value = data.zonecode;
				document.getElementById("addr1").value = addr;
				document.getElementById("addr2").focus();
			}
		}).open();
	}

	function Check_Form() {
		if (joinForm.pass.value != joinForm.pass_re.value) {
			alert("패스워드가 일치하지 않습니다.");
			joinForm.pass.focus();
			return false;
		}
		if ($("#flag").val() == "false") {
			alert("ID 중복검사가 실시되지 않았습니다.");
			$("id").focus();
			return false;
		}
		return true;
	}
</script>
<script>
   
   function setThumbnail(event) { 
	   
	   
	   document.getElementById("imgId").src = "b.PNG";
	   for (var image of event.target.files) 
	   { 
		   var reader = new FileReader(); 
		   reader.onload = function(event) { 
			   
			   document.getElementById("imgId").src = event.target.result;
			 
		   }; 
			   console.log(image);
			   reader.readAsDataURL(image);
		} 
	}
   
   
   </script>
<body onload="errCodeCheck('${msgCode}');">
	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->
	<div class="joinForm_body">

		<form id="fregisterform" name="joinForm" method=post
			Action='mentee_Mypage' enctype="multipart/form-data">

			<table width="600px" cellpadding="0" cellspacing="0" align=center>
				<!-- <tr><td><img src="${pageContext.request.contextPath}/resources/img/cont_joinform.gif" border=0></td></tr>-->
				<p class="member">마이페이지</p>
				<button onclick="location.href='../mentee_Mypage_paymentlist'">결제목록</button>

			</table>

			<table width="600px" cellpadding="0" cellspacing="0" align=center
				class="table01">
				<colgroup>
					<col width="150">
					<col width="*">
				</colgroup>
				<tr>
					<td class="tle">아이디</td>
					<td class="cont">
						<div class="col-md-4">
							<input maxlength=20 size=20 id='reg_mb_id' name="id" class="ed"
								value="${user.id}" readonly /> <span id="message"></span>
						</div>
						<p class="cmt mg_t5">* 영문자, 숫자, _ 만 입력 가능. 최소 3자이상 입력하세요.</p> <input
						type="hidden" id="flag" name="flag" value="false">
					</td>
				</tr>
				<tr>
					<td class="tle">비밀번호</td>
					<td class="cont"><input class=ed type=password name="pass"
						size=20 maxlength="20" required placeholder="password-1"></td>
				</tr>
				<tr>
					<td class="tle">비밀번호 확인</td>
					<td class="cont"><input class=ed type=password name="pass_re"
						size=20 maxlength=20 required placeholder="password-2"></td>
				</tr>
				<tr>
					<td class="tle">이름</td>
					<td class="cont"><input name="name" placeholder="name"
						value="${user.name}" readonly class="ed2" class="ed" required>
						<span class='cmt'>* 공백없이 한글만 입력 가능</span></td>
				</tr>
				<tr>
					<td class="tle">E-mail</td>
					<td class="cont"><input class=ed type=text id='reg_mb_email'
						name='email' value='${user.email}' readonly size=38 maxlength=100
						required value=''> <span id='msg_mb_email'></span></td>
				</tr>


				<tr>
					<td class="tle">전화번호</td>
					<td class="cont"><input class=ed type=text name='phone'
						value=${user.phone } readonly size=21 maxlength=20 required
						placeholder='전화번호' value=''></td>
				</tr>
				<tr>
					<td class="tle">주소</td>
					<td class="cont">
						<table width="330" border="0" cellspacing="0" cellpadding="0"
							class="nobd">
							<tr>
								<td height="25" class="nobd"><input class=ed type=text
									id="zip" name="zip" value='${user.zip}' readonly required>
									<a href="javascript:;" Onclick='DaumPostcode()'><img
										src="${pageContext.request.contextPath}/resources/img/btn_postsearch.png"
										width="30px" height="30px" border=0 align=absmiddle></a></td>
							</tr>
							<tr>
								<td height="25" colspan="2" class="nobd"><input class=ed
									type=text id="addr1" value='${user.addr1}' readonly
									name="addr1" size=60 required></td>
							</tr>
							<tr>
								<td height="25" colspan="2" class="nobd"><input class=ed
									type=text id='addr2' value='${user.addr2}' readonly
									name='addr2' size=60 required></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="tle"><input type="file" id="file" accept="image/*"
						class="tle" onchange="setThumbnail(event);" name="profile"
						multiple /></td>

					<td><div id="image_container"
							style="width: 100px; height: 100px;">
							<img
								src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${memberprofile.profile}" id="imgId" width="200px",height="200px">
						</div></td>

				</tr>
			</table>

			<div align=center class="mg_t20">
				<input type="submit" class="myButton" value="회원정보수정">
			</div>
		</form>
		<!-- 하단부분 -->
		<%@ include file="./footer.jsp"%>
		<!-- 하단부분 -->
</body>
</html>