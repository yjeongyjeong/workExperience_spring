<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Home</title>
</head>
<script type="text/javascript">
	
</script>
<body>
	<h1 align="center">원하시는 서비스를 아래에서 선택해주세요.</h1>
	<div align="center">
		<button type="button" id="board" name="board"
			onclick="location.href='/board/boardList.do'">BOARD</button>
		<button type="button" id="mbti" name="mbti"
			onclick="location.href='/mbti/mbtiTest.do'">MBTI</button>
		<button type="button" id="recruit" name="recruit"
			onclick="location.href='/recruit/main.do'">RECRUIT</button>
	</div>
</body>
</html>
