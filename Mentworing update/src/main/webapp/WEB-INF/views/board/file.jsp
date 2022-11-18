<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

		<table border="0" class="boardTable">
			
			<c:forEach var="file" items="${fileList}">
				${file.fno}
				${file.bno}
				${file.ofilename}
				${file.sfilename}
				${file.filesize}
			</c:forEach>
		</table>
	
</body>
</html>