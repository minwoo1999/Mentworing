<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 글 목록</title>
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet" />

<link href="${pageContext.request.contextPath}/resources/css/styles.css"
	rel="stylesheet" />

<script type="text/javascript">
	function SuccessCode() {
		var SuccessCode =
<%=request.getParameter("SuccessCode")%>
	console.log(SuccessCode);
		if (SuccessCode != null || SuccessCode != "") {
			switch (SuccessCode) {
			case 1:
				alert("성공적으로 로드하였습니다");
				break;
			}
		}

	}

	function selectedOptionCheck() {
		$("#type > option[value=${param.type}]").attr("selected", "true");
	}

	function moveAction(where) {
		switch (where) {
		case 1:
			location.href = "write";
			break;

		case 2:
			location.href = "list";
			break;
		}
	}
</script>
<style>
.move {
	font-size: 15px;
	display: block;
	margin-top: 10px;
	margin-left: 446px;
	margin-bottom: 80px;
}
</style>
</head>
<body onload="SuccessCode();selectedOptionCheck()">

	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->


	<div class="board_list_body">
	<div class="board_list_title_container">
				<div class="board_list_title_wraper">
					<span class=board_list_title_title>Q & A</span>
					<span class=board_list_title_subtitle>궁금한 것이 있다면 꼼꼼히 읽어봐주세요!</span>
				</div>
			</div>
<div class= "board_list_container">
	<div class="board_list_wrapper">
		<div class="board_list_navBar">
			<div class="board_list_navBar_main">
			<form action="list" modelAttribute="searchVO" method="get"
				class="search_form">
				<select class="search_sel" id="board_list_type" name="type">
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="writerId">작성자</option>
				</select>
				<button type="submit" class="searchButton">
					<i class="fa fa-search"></i>
				</button>
		
				 <input class="searchTerm" type="text" id="keyword" name="keyword"
					value="<%if (request.getParameter("keyword") != null) {
	out.print(request.getParameter("keyword"));
} else {
	out.print("");
}%>" />	
				
				
			</form>
			</div>
		</div>
		<table  class="board_table">
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>댓글수</th>
				<th>조회수</th>
				<th>추천수</th>
				<th>작성일</th>
			</tr>
			<c:forEach var="board" items="${boardList}">
				<tr>
					<td class="idx">${board.bno}</td>
					<td align="left" class="subject"><c:if
							test="${board.replycnt >= 10}">
							<img
								src="${pageContext.request.contextPath}/resources/img/hit.jpg" />
						</c:if> <a href="view?bno=${board.bno}">${board.title}</a></td>
					<td class="writer">${board.writerId}</td>
					<td class="comment">${board.replycnt}</td>
					<td class="hitcount">${board.viewcnt}</td>
					<td class="recommendcount">${board.recommendcnt}</td>
					<td class="writeDate">${board.regDate}</td>
				</tr>
			</c:forEach>
		</table>
		<div class="write" align="center">
		<span class="number_btn">
		${pageHttp}
		</span>


		
			<%
			Object loginUser2 = session.getAttribute("userId");
			Object mentoryn2 = session.getAttribute("mentoryn");
			if (loginUser2 == null) {
			%>
			<%
			} else {
			%>
			<button type="button" onclick="moveAction(1)" class="list_upload_button">
				<i class="fa-solid fa-pencil"></i><span>글쓰기</span>
			</button>
		</div>

		<%
		}
		%>
	</div>
</div>
	
	</div>
	<!-- 하단부분 -->
	<%@ include file="./footer.jsp"%>
	<!-- 하단부분 -->
	<script src="https://kit.fontawesome.com/20556dcc55.js"
		crossorigin="anonymous"></script>
</body>
</html>
