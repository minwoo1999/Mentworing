<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./jsp_header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!-- --------------위에는 스크립트 아래는 css ---------------------------------------------------------->
<link href="${pageContext.request.contextPath}/resources/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet" />
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<head>
<meta charset="UTF-8">
<title>주문</title>
</head>
<body>
	
	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->
	<div class="order_body">
	<div class="order_title_container">
		<div class="order_title_wraper">
			<span class="order_title_title">Please finish your purchase!</span>
			<span class="order_title_subtitle">마지막으로 점검 후 구매하세요!</span>
		</div>
	</div>
	
			<div class="order_main_container">
				<div class="order_main_content_wraper">
					<c:set var="sum" value="0" />
					<c:forEach var="basket" items="${basket}" varStatus="status">
						<div class="order_content_box">
							<div class="order_content_box_video">
								<video
									src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${basket.bfilename}" height="150px">
								</video>
							</div>
							<div class="order_content_inforamtion">
								<span class="order_content_title">${basket.title}</span>
								<span class="order_content_pay">₩${basket.price}</span>
							</div>
						</div>
						<input type="hidden" name="bno" id="bno" value="${basket.vno}">
						<c:set var="sum" value="${sum + basket.price}" />
					</c:forEach>
			</div>
			<div class=order_bottom_wraper>
					<div class="order_bottom_box">
						<div class="order_bottom_box_title">
							<span>Payment</span>
						</div>
						<div class="order_bottom_box_user_info">
									<input type="hidden" id="userId" value="${userId}">
									<span class="order_bottom_box_user_info_user">구매자: ${userName} 전화번호: ${userphone}</span>
									<span>주소: ${useraddress} </span>
						</div>
						<div class="order_button">
							<button id="check_module" type="button">Pay now</button>
						</div>
					</div>
				</div>
		</div>
		<!-- 하단부분 -->
		<%@ include file="./footer.jsp"%>
		<!-- 하단부분 -->
	</div>

	<script>
	
		const userId=document.getElementById("userId").value; //유저아이디 가지고왔어
		const bno=document.getElementById("bno").value; //유저아이디 가지고왔어
		let getMemberInfo;
		var arr = new Array(); //배열선언
		
		
		var size = $("input[name='bno']").length; //장바구니 번호 사이즈
        for(i=0;i< size; i++){//번호 만큼 배열로 넣기
            //alert( i + $("input[name='inputName']").eq(i).attr("value") );
            //네임에 값을 넣어줌
            arr[i]=$("input[name='bno']").eq(i).attr("value");
           	
        }
		var arr=arr.toString();
	
	  
		$("#check_module").click(function() {
			console.log(arr);
			var IMP = window.IMP; // 생략가능
			IMP.init('imp11197901');
			// 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
			// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
			IMP.request_pay({
				pg : 'html5_inicis', // version 1.1.0부터 지원.
				/*
				 'kakao':카카오페이,
				 html5_inicis':이니시스(웹표준결제)
				 'nice':나이스페이
				 'jtnet':제이티넷
				 'uplus':LG유플러스
				 'danal':다날
				 'payco':페이코
				 'syrup':시럽페이
				 'paypal':페이팔
				 */

				pay_method : 'card',
				/*
				 'samsung':삼성페이,
				 'card':신용카드,
				 'trans':실시간계좌이체,
				 'vbank':가상계좌,
				 'phone':휴대폰소액결제
				 */
				merchant_uid : 'merchant_' + new Date().getTime(),
				/*
				 merchant_uid에 경우
				 https://docs.iamport.kr/implementation/payment
				 위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
				 참고하세요.
				 나중에 포스팅 해볼게요.
				 */
				name : '주문명:결제테스트',
				//결제창에서 보여질 이름
				amount : 100,
				//가격
				buyer_email : '1',
				buyer_name : 'asdf',
				buyer_tel : '010-1234-5678',
				buyer_addr : '서울특별시 강남구 삼성동',
				buyer_postcode : '123-456',
				m_redirect_url : 'https://www.yourdomain.com/payments/complete'
			/*
			 모바일 결제시,
			 결제가 끝나고 랜딩되는 URL을 지정
			 (카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐)
			 */
			}, function(rsp) {
				if (rsp.success) { // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
					$.ajax({
						url : "/basket/order",
						type : 'POST',
						contentType : "application/json",
						data : JSON.stringify({
							"vno" : arr,
							"userId" : userId
						}),
						success : function(result) {
							console.log(result);
							result = JSON.parse(result);
							console.log(result.msg);
							if (result.msg = ("true")) {
								var msg = '결제 완료되었습니다.';
								alert(msg);
								location.href = "../main";
							} else {
								console.log("결제실패");
							}

							console.log(result.msg);
						}
					});
				} else {
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
					alert(msg);
				}

			});
		});
	</script>

</body>
</html>
