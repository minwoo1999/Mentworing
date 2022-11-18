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
   
function setThumbnail(event) { for (var image of event.target.files) { var reader = new FileReader(); reader.onload = function(event) { var img = g=document.createElement("img"); img.setAttribute("src", event.target.result); g.setAttribute("class","img"); document.querySelector("div#image_container").innerHTML = ''; document.querySelector("div#image_container").appendChild(img); }; console.log(image); reader.readAsDataURL(image); } }
   
   
   </script>
<body onload="errCodeCheck('${msgCode}');">
	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->
	<div class="joinform_body">
		<div class="mentee_mypage_title_container">
				<div class="mentee_mypage_title_wraper">
					<span class=mentee_mypage_title_title>Modifying information</span>
					<span class=mentee_mypage_title_subtitle>개인정보를 수정할 수 있습니다.</span>
				</div>
			</div>
			<div class="metee_mypage_container">
			<div class="metee_mypage_side_wraper">
			<span class="menu_title_box_span">Menu</span>
				<button onclick="location.href='../Mentee/mentee_Mypage_videolist'">강의목록</button>
				<button onclick="location.href='../mentee_Mypage_paymentlist'">결제목록</button>
				<button onclick="location.href='../basket/mentee_Mypage_coupon'">쿠폰함</button>
				<button onclick="location.href='../mentee_Mypage'" id="select_mypage">개인정보 수정</button>
				<button onclick="location.href='../mentee_MyPage_certificate'">2차인증 설정</button>
				
			</div>
			<div class="metee_mypage_main_wraper_join_style">
				<form id="myPage_input_form" name="joinForm" method=post
					Action='mentee_Mypage' enctype="multipart/form-data">
					<span class="myPageInfutTitle">아이디</span>
					<input class="myPageInputBox" maxlength=20 size=20 id='reg_mb_id' name="id" value="${user.id}" readonly /> 
					<span class="inputComment">* 아이디는 변결할 수 없습니다.</span> 
	 				<input class="myPageInputBox" type="hidden" id="flag" name="flag" value="false">
				
					<span class="myPageInfutTitle">비밀번호</span>
					<input class="myPageInputBox" type=password
						name="pass" size=20 maxlength="20" required
						placeholder="password-1">
				
					<span class="myPageInfutTitle">비밀번호 확인</span>
					<input class="myPageInputBox" type=password
						name="pass_re" size=20 maxlength=20 required
						placeholder="password-2">
				
					<span class="myPageInfutTitle">이름</span>
					<input class="myPageInputBox" name="name" placeholder="name"
						value="${user.name}" readonly class="ed2" class="ed" required>
						<span class="inputComment">* 이름은 변결할 수 없습니다.</span> 
			
					<span class="myPageInfutTitle">E-mail</span>
					<input class="myPageInputBox" type=text
						id='reg_mb_email' name='email' value='${user.email}' readonly
						size=38 maxlength=100 required value=''> 
				

					<span class="myPageInfutTitle">전화번호</span>
					<input class="myPageInputBox" type=text name='phone'
						value=${user.phone } readonly size=21 maxlength=20 required
						placeholder='전화번호' value=''>
				
					<span class="myPageInfutTitle">주소</span>
						<input class="myPageInputBox" type=text
									id="zip" name="zip" value='${user.zip}' readonly required>
									<a href="javascript:;" Onclick='DaumPostcode()' class="address_btn"><i class="fa-solid fa-location-dot"></i></a>
							
								<input class="myPageInputBox"
									type=text id="addr1" value='${user.addr1}' readonly
									name="addr1" size=60 required>
							
								<input class="myPageInputBox"
									type=text id='addr2' value='${user.addr2}' readonly
									name='addr2' size=60 required>
					<span class="myPageInfutTitle">프로필 이미지</span>	
					<div class="myPage_profile_img_box">
					<div id="image_container">
							<img class="img"
								src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${memberprofile.profile}">
						</div>
					<input  type="file" id="file" accept="image/*"
						 onchange="setThumbnail(event);" name="profile"
						multiple />
					</div>	
					

			<div align=center class="profile_correction">
				<input type="submit" class="myButton" value="회원정보수정">
			</div>
		</form>
		</div>
		
		</div>
		</div>
		<!-- 하단부분 -->
		<%@ include file="./footer.jsp"%>
		<!-- 하단부분 -->
</body>
</html>