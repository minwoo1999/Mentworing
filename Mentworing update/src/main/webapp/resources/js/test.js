
var userId = document.getElementById("userId").value
const checkbox = document.getElementById('checkbox');
var authenticationId_check = document.getElementById("authenticationId_check").value
const toggleSwitch = document.querySelector(".switch");
let toggleText = document.querySelector("#certificate_onoff");
let toggleState = false;
let count = 0;

if (toggleState === false) {
	toggleText.innerText = "OFF";
	toggleState = true;
}
if (authenticationId_check == "checkin") {
	toggleText.innerText = "ON";
	checkbox.checked = true;
	toggleState = false;
} else {
	toggleText.innerText = "OFF";
	checkbox.checked = false;
	toggleState = true;
}

toggleSwitch.addEventListener("change", function() {


	alert("2차인증은 핸드폰을 통해 이뤄집니다\n전화번호를 꼭 확인해주세요.");

	if (toggleState === true) {
		toggleText.innerText = "ON";
		toggleState = false;
	}
	else {
		toggleText.innerText = "OFF";
		toggleState = true;
	}

	$.ajax({

		url: "/member/second_certificate_onoff?userId=" + userId + "&onoff=" + toggleText.innerText,
		type: 'get',
		dataType: 'json',
		success: function(result) {
			if (result.msg == "true") {
				console.log("정상작동");
			} else {
				console.log("정상작동x");
			}
		}

	})

	console.log(toggleText.innerText);




})