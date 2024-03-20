<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>boardLogin</title>
</head>

<script type="text/javascript">
	$j(document).ready(function(){
		const mbtiResult = sessionStorage.getItem('mbtiResult');
		
		var mbtiResultRow = document.getElementById('mbtiResultRow');
		mbtiResultRow.textContent = mbtiResult;
	});
	
	$j(document).ready(function(){
		 $j("#restart").on("click", function(e){
			 sessionStorage.removeItem('mbtiResult');
	    	 location.href = 'http://localhost:8081/mbti/mbtiTest.do';
		 });
	});
</script>

<body>
<table  align="center" id="wrapTable">
	
	<tr>
		<td align="center">
			<strong>✨당신의 성격 유형은✨</strong>
		</td>
	</tr>	
	<tr>
		<td align="center" id="mbtiResultRow" style="font-style: italic ; font-size: 2em; ">
		</td>
	</tr>
	<tr>
		<td align="center">
			<button type="button" id="restart" name="restart">다시하기</button>
		</td>
	</tr>
</table>
</body>
</html>