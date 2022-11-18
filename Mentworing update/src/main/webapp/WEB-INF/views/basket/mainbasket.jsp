<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./jsp_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="${pageContext.request.contextPath}/resources/css/styles.css?after"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/resources/css/style.css?after"
	rel="stylesheet" />
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<meta charset="UTF-8">
<title>Insert title here</title>

<meta name="viewport"
	content="width=device-width,height=device-height,initial-scale=1.0">
</head>
<script>
	function removebasket(bno) {
		$.ajax({
			url : "/basket/deletebasket?bno=" + bno,
			type : 'get',
			dataType : 'json',
			success : function(result) {
				if (result.msg == "true") {
					console.log("삭제완료");
					location.reload();
				} else {
					console.log("삭제실패");
				}
			}
		});
	}
</script>
<script>
	/* Set values + misc */
	var promoCode;
	var promoPrice;
	var fadeTime = 300;

	/* Assign actions */
	$('.quantity input').change(function() {
		updateQuantity(this);
	});

	$('.remove button').click(function() {
		removeItem(this);
	});

	$(document).ready(function() {
		updateSumItems();
	});

	$('.promo-code-cta').click(function() {

		promoCode = $('#promo-code').val();

		if (promoCode == '10off' || promoCode == '10OFF') {
			//If promoPrice has no value, set it as 10 for the 10OFF promocode
			if (!promoPrice) {
				promoPrice = 10;
			} else if (promoCode) {
				promoPrice = promoPrice * 1;
			}
		} else if (promoCode != '') {
			alert("Invalid Promo Code");
			promoPrice = 0;
		}
		//If there is a promoPrice that has been set (it means there is a valid promoCode input) show promo
		if (promoPrice) {
			$('.summary-promo').removeClass('hide');
			$('.promo-value').text(promoPrice.toFixed(2));
			recalculateCart(true);
		}
	});

	/* Recalculate cart */
	function recalculateCart(onlyTotal) {
		var subtotal = 0;

		/* Sum up row totals */
		$('.basket-product').each(function() {
			subtotal += parseFloat($(this).children('.subtotal').text());
		});

		/* Calculate totals */
		var total = subtotal;

		//If there is a valid promoCode, and subtotal < 10 subtract from total
		var promoPrice = parseFloat($('.promo-value').text());
		if (promoPrice) {
			if (subtotal >= 10) {
				total -= promoPrice;
			} else {
				alert('Order must be more than £10 for Promo code to apply.');
				$('.summary-promo').addClass('hide');
			}
		}

		/*If switch for update only total, update only total display*/
		if (onlyTotal) {
			/* Update total display */
			$('.total-value').fadeOut(fadeTime, function() {
				$('#basket-total').html(total.toFixed(2));
				$('.total-value').fadeIn(fadeTime);
			});
		} else {
			/* Update summary display. */
			$('.final-value').fadeOut(fadeTime, function() {
				$('#basket-subtotal').html(subtotal.toFixed(2));
				$('#basket-total').html(total.toFixed(2));
				if (total == 0) {
					$('.checkout-cta').fadeOut(fadeTime);
				} else {
					$('.checkout-cta').fadeIn(fadeTime);
				}
				$('.final-value').fadeIn(fadeTime);
			});
		}
	}

	/* Update quantity */
	function updateQuantity(quantityInput) {
		/* Calculate line price */
		var productRow = $(quantityInput).parent().parent();
		var price = parseFloat(productRow.children('.price').text());
		var quantity = $(quantityInput).val();
		var linePrice = price * quantity;

		/* Update line price display and recalc cart totals */
		productRow.children('.subtotal').each(function() {
			$(this).fadeOut(fadeTime, function() {
				$(this).text(linePrice.toFixed(2));
				recalculateCart();
				$(this).fadeIn(fadeTime);
			});
		});

		productRow.find('.item-quantity').text(quantity);
		updateSumItems();
	}

	function updateSumItems() {
		var sumItems = 0;
		$('.quantity input').each(function() {
			sumItems += parseInt($(this).val());
		});
		$('.total-items').text(sumItems);
	}

	/* Remove item from cart */
	function removeItem(removeButton) {
		/* Remove row from DOM and recalc cart total */
		var productRow = $(removeButton).parent().parent();
		productRow.slideUp(fadeTime, function() {
			productRow.remove();
			recalculateCart();
			updateSumItems();
		});
	}
</script>
<script type='text/javascript'>
function cupon_choice() {
	var showlay = $('<div class="cupon_choice_box_container"></div>');
	showlay.show();
	showlay.appendTo(document.body);
	$('.cupon_choice_container').show();
	$('.close').click(function() {
		$('.cupon_choice_container').hide();
		showlay.appendTo(document.body).remove();
		return false;
	});
}

function coupon_discount() {
	
	
	var cno = $("#coupon_check").val();
	console.log(cno);
	var Totalprice = $("#Totalprice");
	var Totalpricevalue = $("#Totalprice").val();
	
	$
	.ajax({
		url : "/basket/coupon_discount?cno=" + cno,
		type : 'get',
		dataType : 'json',
		success : function(result) {
			if (result.msg != "false") {
				console.log(result.coupon);
				discount=result.msg*0.01;
				resultdiscount=Totalpricevalue-(Totalpricevalue*discount);
				console.log(resultdiscount);
				document.getElementById("Totalprice").value = resultdiscount;
				document.getElementById("coupon_button").value = result.coupon;
				document.getElementById("discount_price").value = Totalpricevalue*discount;
				$("#flag").val("true");
				console.log(result.msg); 
				$('.cupon_choice_container').hide();
				$('.cupon_choice_box_container').hide();

				
			} else {
				console.log("제대로 작동하지않음");
			}
		}
	});
	
}
</script>
<body>

	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->
	<div class="mainbasket_body">
		<div class="main_basket_title_container">
			<div class="main_basket_title_wraper">
				<span class=main_basket_title_title>Start building your
					knowledge!</span> <span class=main_basket_title_subtitle>강의를 수강하고
					지식을 쌓아보세요!</span>
			</div>
		</div>

		<div class="madin_basket_main">
			<div class="basket">
				
				<c:set var="sum" value="0" />
				<c:forEach var="basket" items="${basket}" varStatus="status">
					<div class="basket-labels"></div>
					<div class="basket-product">
						<div class="item">
							<div class="product-image">
								<video
									src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${basket.bfilename}"
									height="100px" /></video>
							</div>
						</div>
						<div class="product-details">
							<span class=product_name> ${basket.title} </span>
						</div>
						<div class="price">${basket.price}원</div>
						<div class="remove">
							<input type="hidden" name="bno" id="bno" value="${basket.bno}">
							<button onclick="removebasket(${basket.bno})">Remove</button>
						</div>
					</div>
					<c:set var="sum" value="${sum + basket.price}" />
				</c:forEach>

			</div>




			<div class="cupon_choice_container">


				<div class="cupon_choice_box">

					<div class="cupon_choice_box_title_box">
						<span>쿠폰 선택</span><i class="fa-solid fa-ticket-simple"></i> <a
							href='' class='main_basket_cupon_boc_close_btn'>X</a>
					</div>
					<div class="cupon_box_box">
						<c:forEach var="coupon" items="${coupon}" varStatus="status">

							<div class="cupon_box_index_line">
								<span class="cupon_box_index_line_1">사용여부</span> <span
									class="cupon_box_index_line_2">쿠폰명</span> <span
									class="cupon_box_index_line_3">사용기간</span> <span
									class="cupon_box_index_line_4">할인율</span>
							</div>
							<div class="cupon_box_main_box">
								<span class="cupon_box_main_box_1"> <input
									type="checkbox" name="${coupon.cno}" value="${coupon.cno}"
									id="coupon_check"></span> <span class="cupon_box_main_box_2">${coupon.coupon_name}</span>
								<span class="cupon_box_main_box_3"> ${coupon.start_date}~<br>${coupon.end_date}</span>
								<span class="cupon_box_main_box_4">
									${coupon.discount_rate}%</span>
							</div>
						</c:forEach>
					</div>
					<div class="cupon_choice_ok_btn_box">
						<button onclick="coupon_discount()";>확인</button>
					</div>
				</div>
			</div>
			<aside>
				<div class="summary">
					<div class="summary-total-items">
						<div class="buy_user_information_title_box">
							<span class="buy_user_information_title_">구매자 정보</span> <br>
						</div>
						<input type="hidden" id="userId" value="${userId}">
						<div class="buy_user_name_phone_address">
							<span class="order_bottom_box_user_info_user">이름
								&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
								${userName}</span> <span>휴대폰 번호 &nbsp&nbsp&nbsp&nbsp${userphone}</span>
							<span>주소&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
								${useraddress} </span>
						</div>
					</div>
					<div class="buy_information_title">
						<span>구매정보</span>
					</div>
					<div class="summary-subtotal">

						<c:forEach var="basket" items="${basket}" varStatus="status">

							<div class="basket_check_box">
								<div class="subtotal-title">${basket.title}</div>
								<div class="subtotal-value final-value" id="basket-subtotal">${basket.price}
									원</div>
								<input type="hidden" name="bno2" id="bno2" value="${basket.vno}">
							</div>

						</c:forEach>

					</div>
					<div class="cupon_box">
						<input type="text" id="coupon_button" readonly
							class="cupon_box_cupon_name">
						<button class="cupon_box_cupon_btn" onclick="cupon_choice()">쿠폰선택</button>
					</div>
					<div class="summary-total">
						<span>할인금액</span>
						<div>
							<input type="text" id="discount_price" readonly value=""><span>원</span>
						</div>
					</div>

					<div class="basket-total">
						<span class="total-title_box">Total</span> <input type="text"
							class="totalprice_input_box" id="Totalprice" readonly
							value="${sum}"> <span>원</span>
					</div>

					<div class="summary-checkout">
						<button class="checkout-cta" id="check_module">Go to
							Checkout</button>
					</div>
					<div class="caution_box">
						회원 본인은 주문내용을 확인했으며, <span>구매조건 및 개인정보취급방침</span>과 결제에 동의합니다.
					</div>
				</div>
			</aside>
		</div>

		<!-- 하단부분 -->
		<%@ include file="./footer.jsp"%>
		<!-- 하단부분 -->
		<script src="https://kit.fontawesome.com/20556dcc55.js"
			crossorigin="anonymous"></script>


	</div>
</body>

<script>
	
		const userId=document.getElementById("userId").value; //유저아이디 가지고왔어
		const bno=document.getElementById("bno2").value; 
		let getMemberInfo;
		var arr = new Array(); //배열선언
		
		
		var size = $("input[name='bno2']").length; //장바구니 번호 사이즈
        for(i=0;i< size; i++){//번호 만큼 배열로 넣기
            //alert( i + $("input[name='inputName']").eq(i).attr("value") );
            //네임에 값을 넣어줌
            arr[i]=$("input[name='bno2']").eq(i).attr("value");
           	
        }
		var arr=arr.toString();
	
	  	
		$("#check_module").click(function() {
			console.log(bno);
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
</html>