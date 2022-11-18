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
	<div class="board_view_body">
	<div class=board_view_container>
	<div class="board_view_wrapper">
		<div class="board_view">
			<div class="board_view_title_date">
				<span class="board_view_title">${board.title}</span><span class="board_view_date">${board.regDate}</span></td>
			</div>
			<div class="writer_viewcnt_recommendcnt_box">
				<div class="board_view_writer_name">
					<span>작성자 ${board.writerId}</span>
				</div>
				<div class="board_view_viewcnt_recommendcnt">
					<span>조회 수 ${board.viewcnt}</span>
					<span>추천 수${board.recommendcnt}</span>
				</div>
			</div>
			<p class="board_view_text_box">
				<c:out value="${board.content}" />
			</p>
			<c:if test="${board.writerId != userId}">
						<p class="board_view_recommend_btn_box" align="center">
							<a href="#" onclick="moveAction(4)" class="board_view_recommend_btn"><i class="fa-solid fa-thumbs-up"></i> 추천하기</a> <span
								style="color: red">${message}</span>
								<div class="delete_reroad_goback_btn_box">
								<input type="button" value="글수정"
			class="writeBt" onclick="moveAction(2)" />
								<input type="button" value="글삭제" class="writeBt"
			onclick="moveAction(1)" />  <input type="button"
			value="목록" class="writeBt" onclick="moveAction(3)" />
			</div>
						</p>
					</c:if>
			<div class="attachments_box">		
				 <span>첨부파일&nbsp</span>
				<c:forEach var="file"
						items="${fileList}">
						<a href="filedown?fileName=${file.ofilename}" class="file_view_link">
							<font size="2px">${file.ofilename}</font> <font size="2px">(${file.filesize}
								byte)</font><br>
						</a>
					</c:forEach> <c:if test="${empty fileList}">
						<font color="#A6A6A6" size="2px"> 첨부된 파일이 없습니다. </font>
					</c:if>
			</div>
		
			<c:forEach var="reply" items="${replyList}">
			<div class="border_view_commnet_box_flex">
				<div class="comment_writer_name_regdate">
					<span class="comment_writer">${reply.writerId}</span><span class="comment_writer_date">${reply.regDate}</span>
					<span>
					<c:if test="${board.writerId != userId}">
		
								<a href="#" onclick="replyRecommand(${reply.rno}, ${reply.bno})">
									<small class="recomment_small_btn"><i class="fa-solid fa-thumbs-up"></i> ${reply.recommendcnt}</small>
								</a> <span><small style="color: red">${message}</small></span>
							
						</c:if>
						</span>
							<c:if test="${reply.writerId == userId}">
								<a href="#" onclick="replyDelete(${reply.rno},${reply.bno})">
									<span class="border_comment_delete_btn" align="center" style="color: red">삭제</span>
								</a>
							</c:if>
							
					</div>
						<div class="comment_text_area_box">
							<p>${reply.content}</p> 
						</div>
			</div>			
				
				
			</c:forEach>

					<form action="writeReply" class="board_view_comment_box_area_submit" method="post">
						<input type="hidden" id="writer" name="writer" value="${userName}" />
						<input type="hidden" id="writerId" name="writerId"
							value="${userId}" /> <input type="hidden" id="bno" name="bno"
							value="${board.bno}" />
						<textarea class="board_view_comment_box_area" name="content" class="commentForm" placeholder="댓글내용을 입력해주세요."></textarea>
							<div class="comment_account_button_box">
								<input type="submit" value="댓글등록" class="comment_account_button" />
							</div>
					</form>
		 
			
</div>
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