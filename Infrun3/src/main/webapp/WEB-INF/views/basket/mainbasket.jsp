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
<body>
	
	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->
	<div class="mainbasket_body">
	<div class="main_basket_title_container">
		<div class="main_basket_title_wraper">
			<span class=main_basket_title_title>Start building your knowledge!</span>
			<span class=main_basket_title_subtitle>강의를 수강하고 지식을 쌓아보세요!</span>
		</div>
	</div>
	<div class="main">
		<div class="basket">
		<div class="basket_name_box">
			<span id=product_img>강의 이미지</span>
			<span id=product_title>제목</span>
			<span id=product_price>가격</span>
			<span id=product_delete>삭제</span>
		</div>
			<c:set var="sum" value="0" />
			<c:forEach var="basket" items="${basket}" varStatus="status">
				<div class="basket-labels">
					
				</div>
				<div class="basket-product">
					<div class="item">
						<div class="product-image">
							<video
								src="https://infruntest.s3.ap-northeast-2.amazonaws.com/${basket.bfilename}"
								height="100px" /></video>
						</div>
					</div>
					<div class="product-details">
							<span class=product_name>
								${basket.title}
							</span>
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
		<aside>
			<div class="summary">
				<div class="summary-total-items">
					<span class="total-items">Pay once, own it forever</span>
				</div>
				<div class="summary-subtotal">
					<c:forEach var="basket" items="${basket}" varStatus="status">

								<div>
									<div class="subtotal-title">${basket.title}</div>
									<div class="subtotal-value final-value" id="basket-subtotal">${basket.price} 원</div>
									<div class="summary-promo hide"></div>
								</div>

					</c:forEach>

				</div>
				<div class="summary-total">
					<div class="total-title">Total</div>
					<div class="total-value final-value" id="basket-total">
					
					<span>${sum} 원</span>
					
					</div>
				</div>
				<div class="summary-checkout">
					<button class="checkout-cta" onclick="location.href='order'">Go to Checkout</button>
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
</html>