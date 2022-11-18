<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link href="${pageContext.request.contextPath}/resources/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet" />

<!-- 헤더부분 -->
<%@include file="./mainheader.jsp"%>
<!-- 헤더부분 -->



<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>

<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.9.2/i18n/jquery.ui.datepicker-ko.min.js"></script>


<body>
	<div class="mentor_mypage_chart_body">

		<div class="mentee_mypage_title_container">
			<div class="mentee_mypage_title_wraper">
				<span class=mentee_mypage_title_title>You can check the
					sales.</span> <span class=mentee_mypage_title_subtitle>매출을 확인할 수
					있습니다.</span>
			</div>
		</div>
		<div class="metee_mypage_container">
			<div class="metee_mypage_side_wraper">
				<span class="menu_title_box_span">Menu</span>
			<button onclick="location.href='../Mentor/Myvideo'">My강의</button>
			<button onclick="location.href='../Mentor/Mentor_Mypage'">개인정보수정</button>
			<button onclick="location.href='../Mentor/Mentor_Mypage_Chart'" id="selet_my_upload_lecture">월매출통계</button>
			<button onclick="location.href='../Mentor/videoupload'">강의업로드</button>
			<button onclick="location.href='../Mentor/mente_list'">멘티목록</button>


			</div>
			<div class="metor_mypage_chart_main_wraper">


				<div>

					<div id="myAreaChart">

						<canvas id="canvas"></canvas>

					</div>

				</div>
				<div class="mentor_chart_submit_box">
					<tr>
						<td class="tle">시작일</td>
						<td class="table_cont"><input class='ed' type='text'
							id='start_date' name='birthday' size='10' maxlength='10'
							minlength='10' required numeric value='' placeholder="0000-00-00"></td>
					</tr>
					&nbsp~
					<tr>
						<td class="tle">종료일</td>
						<td class="table_cont"><input class='ed' type='text'
							id='end_date' name='birthday' size='10' maxlength='10'
							minlength='10' required numeric value='' placeholder="0000-00-00"></td>
					</tr>
					<button onclick="chart_search();">조회</button>
				</div>
			</div>

		</div>
	</div>
</body>

<script>
	$(document).ready(function() {
		$("#start_date").datepicker({
			dateFormat : 'yy-mm-dd',
			changeMonth : true,
			changeYear : true,
			yearRange : "1950:2022"
		});

	});

	$(document).ready(function() {
		$("#end_date").datepicker({
			dateFormat : 'yy-mm-dd',
			changeMonth : true,
			changeYear : true,
			yearRange : "1950:2022"
		});

	});

	var chartLabels = [];

	var chartData = [];

	var chartLabels2 = [];

	var chartData2 = [];

	var viewChart1 = null;

	$.getJSON("http://localhost:8080/Mentor/incomeList", function(data) {

		$.each(data, function(inx, obj) {

			console.log(obj);

			chartLabels.push(obj.payment_date);

			chartData.push(obj.price);

		});

		createChart();
		viewChart1 = true;
		console.log("create Chart")

	});

	function chart_search() {

		chartLabels2 = [];

		chartData2 = [];

		var start_date = document.getElementById("start_date").value

		var end_date = document.getElementById("end_date").value

		$.getJSON("http://localhost:8080/Mentor/chartsearch?start_date="
				+ start_date + "&end_date=" + end_date, function(data) {

			$.each(data, function(inx, obj) {

				chartLabels2.push(obj.payment_date);

				chartData2.push(obj.price);

			});

			createChart2();
			console.log("create Chart")

		});

	}

	var lineChartData = {

		labels : chartLabels,

		datasets : [

		{
			

			label : "월별 매출통계표",

			data : chartData,
			
			 backgroundColor: [
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	                'rgba(153, 102, 255, 0.2)',
	                'rgba(255, 159, 64, 0.2)',
	                'rgba(255, 99, 132, 0.2)',
	                'rgba(54, 162, 235, 0.2)',
	                'rgba(255, 206, 86, 0.2)',
	                'rgba(75, 192, 192, 0.2)',
	                'rgba(153, 102, 255, 0.2)',
	                'rgba(255, 159, 64, 0.2)'
	            ],
	            borderColor: [
	                'rgba(255, 99, 132, 1)',
	                'rgba(54, 162, 235, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(153, 102, 255, 1)',
	                'rgba(255, 159, 64, 1)',
	                'rgba(255, 99, 132, 1)',
	                'rgba(54, 162, 235, 1)',
	                'rgba(255, 206, 86, 1)',
	                'rgba(75, 192, 192, 1)',
	                'rgba(153, 102, 255, 1)',
	                'rgba(255, 159, 64, 1)'
	            ],
	            borderWidth: 1

		}

		]

	}

	function createChart() {
		var ctx = document.getElementById("canvas").getContext("2d");
		
		
		LineChartDemo = new Chart(ctx, {

			type : 'bar',
			
			data : lineChartData,

			options : {

				scales : {

					yAxes : [ {

						ticks : {

							beginAtZero : true

						}

					} ]

				}

			}

		})

	}

	function createChart2() {

		console.log(chartLabels2);
		console.log(chartData2);
		var ctx = document.getElementById("canvas").getContext("2d");

		var lineChartData2 = {

			labels : chartLabels2,

			datasets : [

			{

				label : "월별 매출통계표",

				data : chartData2,
				
				 backgroundColor: [
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(54, 162, 235, 0.2)',
		                'rgba(255, 206, 86, 0.2)',
		                'rgba(75, 192, 192, 0.2)',
		                'rgba(153, 102, 255, 0.2)',
		                'rgba(255, 159, 64, 0.2)',
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(54, 162, 235, 0.2)',
		                'rgba(255, 206, 86, 0.2)',
		                'rgba(75, 192, 192, 0.2)',
		                'rgba(153, 102, 255, 0.2)',
		                'rgba(255, 159, 64, 0.2)'
		            ],
		            borderColor: [
		                'rgba(255, 99, 132, 1)',
		                'rgba(54, 162, 235, 1)',
		                'rgba(255, 206, 86, 1)',
		                'rgba(75, 192, 192, 1)',
		                'rgba(153, 102, 255, 1)',
		                'rgba(255, 159, 64, 1)',
		                'rgba(255, 99, 132, 1)',
		                'rgba(54, 162, 235, 1)',
		                'rgba(255, 206, 86, 1)',
		                'rgba(75, 192, 192, 1)',
		                'rgba(153, 102, 255, 1)',
		                'rgba(255, 159, 64, 1)'
		            ],
		            borderWidth: 1

			}

			]

		}

		console.log(lineChartData2);
		LineChartDemo = new Chart(ctx, {
	
			type : 'bar',
			
			data : lineChartData2,

			options : {

				scales : {

					yAxes : [ {

						ticks : {

							beginAtZero : true

						}

					} ]

				}

			}

		})

	}
</script>
</html>
