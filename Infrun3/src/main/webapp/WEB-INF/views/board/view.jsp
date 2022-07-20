<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/styles.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/style.css"
	rel="stylesheet" />

<script type="text/javascript">
	
	function errCodeCheck(){
		var errCode=<%=request.getParameter("errCode")%>
		
		if(errCode!=null || errCode!= ""){
			switch(errCode){
			case 1:
				alert("댓글내용이 없습니다");
				break;
			case 2:
				alert("이미 추천하셨습니다");
				break;
			case 3:
				alert("자기 글은 추천할 수 없습니다");
				break;
			case 4:
				alert("로그인하셔야 추천할 수 있습니다");
				break;
			
				
			}
		}
		
	}
	
	function replyDelete(rno,bno){
		if(confirm("선택하신 댓글을 삭제하시겠습니까?")){
			location.href = "deleteReply?rno="+rno+"&bno="+bno;
		}
	}
	
	function replyRecommand(rno,bno){
		if(confirm("선택하신 댓글을 추천하시겠습니까?")){
			location.href = "recommandReply?rno="+rno+"&bno="+bno;
		}
	}
	
	
	

	function moveAction(where) {
		switch (where) {
		case 1:
			location.href = "delete?bno=${board.bno}";
			break;

		case 2:
			location.href = "modify?bno=${board.bno}";
			break;
		case 3:
			location.href = "list";
			break;
			
		case 4:
			location.href="recommend?bno=${board.bno}";
			break;
		}
		
		
	}
</script>
</head>

<body onload="errCodeCheck()">

	<!-- 헤더부분 -->
	<%@include file="./mainheader.jsp"%>
	<!-- 헤더부분 -->

	<div class="wrapper">
		<table class="boardView">
			<tr>
				<td colspan="4"><h3>${board.title}</h3></td>
			</tr>
			<tr>
				<th>작성자</th>
				<th>조회수</th>
				<th>추천수</th>
				<th>작성일</th>
			</tr>
			<tr>
				<td>${board.writerId}</td>
				<td>${board.viewcnt}</td>
				<td>${board.recommendcnt}</td>
				<td>${board.regDate}</td>
			</tr>
			<tr>
				<th colspan="4">내용</th>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td colspan="4" align="left"><c:forEach var="file"
						items="${fileList}">
						<a href="filedown?fileName=${file.ofilename}" class="fileview">
							<font size="2px">${file.ofilename}</font> <font size="2px">(${file.filesize}
								byte)</font><br>
						</a>
					</c:forEach> <c:if test="${empty fileList}">
						<font color="#A6A6A6" size="2px"> 첨부된 파일이 없습니다. </font>
					</c:if></td>
			</tr>

			<tr>
				<td colspan="4" align="left"><pre>
						<p>
						<c:out value="${board.content}" />
					</p>
					</pre> <br /> <br /> <c:if test="${board.writerId != userId}">
						<p align="center">
							<a href="#" onclick="moveAction(4)"> <small
								style="color: red">추천: ${board.recommendcnt} </small></a> <span><small
								style="color: red">:${message}</small></span>
						</p>
					</c:if></td>
			</tr>
		</table>
		<table class="commentView">
			<tr>
				<th colspan="2">댓글</th>
			</tr>
			<c:forEach var="reply" items="${replyList}">
				<tr>
					<td class="writer">
						<p>${reply.writerId}
							<c:if test="${reply.writerId == userId}">
								<br />
								<a href="#" onclick="replyDelete(${reply.rno},${reply.bno})">
									<small align="center" style="color: red">삭제</small>
								</a>
							</c:if>
						</p>
					</td>
					<td class="content" align="left"><span class="date">${reply.regDate}</span>
						<p>${reply.content}</p> <c:if test="${board.writerId != userId}">
							<p align="center">
								<a href="#" onclick="replyRecommand(${reply.rno}, ${reply.bno})">
									<small style="color: red">추천 ${reply.recommendcnt}</small>
								</a> <span><small style="color: red">:${message}</small></span>
							</p>
						</c:if></td>
				</tr>
			</c:forEach>

			<tr>
				<td class="writer"><strong>댓글 쓰기</strong></td>
				<td class="content">
					<form action="writeReply" method="post">
						<input type="hidden" id="writer" name="writer" value="${userName}" />
						<input type="hidden" id="writerId" name="writerId"
							value="${userId}" /> <input type="hidden" id="bno" name="bno"
							value="${board.bno}" />
						<textarea id="content" name="content" class="commentForm"></textarea>
						<input type="submit" value="확인" class="commentBt" />

					</form>
				</td>
			</tr>
		</table>
		<br /> <input type="button" value="삭제" class="writeBt"
			onclick="moveAction(1)" /> <input type="button" value="수정"
			class="writeBt" onclick="moveAction(2)" /> <input type="button"
			value="목록" class="writeBt" onclick="moveAction(3)" /> <input
			type="button" value="목록" class="writeBt" onclick="moveAction(3)" />

	</div>
	<!-- 하단부분 -->
	<%@ include file="./footer.jsp"%>
	<!-- 하단부분 -->
	<script src="https://kit.fontawesome.com/20556dcc55.js"
		crossorigin="anonymous"></script>
</body>

</html>