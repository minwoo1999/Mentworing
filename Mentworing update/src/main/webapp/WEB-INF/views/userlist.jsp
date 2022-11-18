<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./jsp_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet" />
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.8.2.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->

	<div class="userlist_body">
	<!--  메인 검색기능 -->
	<div class="user_search_container">
	<form action="userlist" modelAttribute="searchVO" method="get"
			class="usersearch">
			<div class="user_serch_main">
				<div class="user_search_title">
					<span>찾고싶은 회원을 검색해보세요.</span>
				</div>
				
				<div class="user_serach_input">
				<select id="type" name="type" class="searchtype">
				<option value="id">아이디</option>
				<option value="name">이름</option>
				<option value="email">이메일</option>
				</select>
					<input type="text" class="user_serach_input" placeholder="찾고싶은 회원의 정보를 입력하세요"  id="keyword" name="keyword"
				value="<%if (request.getParameter("keyword") != null) {
	out.print(request.getParameter("keyword"));
} else {
	out.print("");
}%>" />
					<input type="submit" class="userlist_search_submit_btn" value="검색"/>
				</div>
			</div>
		</div>
		
			
		<div class="user_list_main_container">
			<div class="user_list_main_wraper">
				<form:form id="userlistForm" name="userlistForm" method="post">


					<table class="user_management_table" border="1">
						<tr class="table_title">
							<th>회원번호</th>
							<th>아이디</th>
							<th>이름</th>
							<th>전화번호</th>
							<th>이메일</th>
							<th>주소</th>
						</tr>
						<tr class="user_deco_line">
							<th></th>
							<th></th>
							<th></th>
							<th></th>
							<th></th>
							<th></th>
						</tr>
						<c:forEach var="user" items="${userList}" varStatus="status">
							<tr>
								<td>${user.no}</td>
								<td>${user.id}</td>
								<td>${user.name}</td>
								<td>${user.phone}</td>
								<td>${user.email}</td>
								<td>${user.addr1}</td>

							</tr>
						</c:forEach>
					</table>
					<span class="pagehelper">${pageHttp}</span>
				</form:form>
			</div>
		</div>
		<!-- 하단부분 -->
		<%@ include file="./footer.jsp"%>
		<!-- 하단부분 -->
	</div>
	<script src="https://kit.fontawesome.com/20556dcc55.js"
		crossorigin="anonymous"></script>
</body>
</html>