<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/board.css"
	rel="stylesheet" type="text/css" />
</head>
<body>
	<div class="wrapper">
		<h3>글 수정</h3>
		<form name="writeForm" action="modify" method="post"
			onsubmit="return formCheck()" enctype="multipart/form-data">
			<table class="boardWrite">
				<tr>
					<th><label for="subject">제목</label></th>
					<td><input type="text" id=“title " name="title"
						class="boardSubject" /> <input type="hidden" id="writer"
						name="writer" value="${userName}" /> <%
 //세션변수
 %> <input type="hidden" id="writerId" name="writerId" value="${userId}" />
					</td>
				</tr>
				<tr>
					<input type="hidden" id="bno" name="bno"
							value="${board.bno}" />
					<th><label for="content">내용</label></th>
					<td><textarea id="content" name="content" class="boardContent"></textarea></td>
				</tr>
				
				<tr>
					<th><label for="file">첨부파일</label></th>
					<td align="left">
					
						<c:forEach var="file" items="${fileList}">
						
							<p> <input type="checkbox" name="fileno" value="<c:out value="${file.fno}"/>">
							<c:out value="${file.ofilename}"/><c:out value="(${file.filesize} byte)"/><span class="date">&nbsp;&nbsp;*&nbsp; -삭제</span>
							</p>
						</c:forEach>
						
						<c:if test="${empty fileList}">
							<font color="#A6A6A6" size="2px"> 첨부된 파일이 없습니다.</font>
						</c:if>
					
					</td>
				
				</tr>
				
				
				<tr>

					<th><label for="file">파일수정</label></th>
					<td><input type="file" id="file" name="file" multiple /> <span
						class="date">&nbsp;&nbsp;*&nbsp;임의로 파일명이 변경될 수 있습니다.</span></td>
				</tr>
			</table>
			<br /> <input type="reset" value="재작성" class="writeBt" /> <input
				type="submit" value="확인" class="writeBt" />
		</form>
	</div>
</body>
</html>