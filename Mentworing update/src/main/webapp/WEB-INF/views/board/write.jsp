<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>새 글 쓰기</title>
<link href="${pageContext.request.contextPath}/resources/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	function formCheck() {
		if (writeForm.title.value.length < 1) {
			alert("제목을 입력하세요.");
			writeForm.title.focus();
			return false;
		}
		if (writeForm.content.value.length < 1) {
			alert("내용을 입력하세요.");
			writeForm.content.focus();
			return false;
		}
		return true;
	}
</script>
</head>

<body>
<div class="board_write_title_container">
			<div class="board_write_title_wraper">
				<span class="board_write_title_title">Please think about it before you post</span> 
				<span class="board_write_title_subtitle">글을 올리기 전에 한번 생각해 주세요!</span>
			</div>
		</div>
	<div class="board_write_continer">
		<div class="board_write_wraper">
		<div class="board_write_title">
			<span>게시판 글 쓰기</span>
		</div>
			<form class="board_write_form" name="writeForm" action="write" method="post"
				onsubmit="return formCheck()" enctype="multipart/form-data">
				<div class="board_write_wrtie_title">
					<input type="text" name="title"
							class="boardSubject" placeholder="글 제목"/> 
							<input type="hidden" id="writer"
							name="writer" value="${userName}" />
							</div> <%
	 //세션변수
	 %> <input
							type="hidden" id="writerId" name="writerId" value="${userId}" />
						
						
						<textarea class="board_write_content" name="content" class="boardContent"></textarea>
					
						<div class="board_write_file_up">
						<input type="file" id="board_write_file" name="file" multiple /> <span
							class="date">*&nbsp;임의로 파일명이 변경될 수 있습니다.</span>
					</div>
				<div class="board_wirte_write_rewrite">
				 <input type="reset" id="rewrite_btn" value="재작성" class="writeBt" /> <input
					type="submit" value="글쓰기" class="writeBt" />
					</div>
			</form>
		</div>
	</div>
	<!-- 하단부분 -->
		<%@ include file="./footer.jsp"%>
		<!-- 하단부분 -->
</body>
</html>
