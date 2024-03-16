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
		
		function radioList(){

		    	var frm = $j('#wrapTable');  // jQuery로 선택된 문서 객체로 변경

		    	
			
		};
		
</script>

<body>
<table  align="center" id="wrapTable">
	<tr id="inform">
		<td align="left">
			<a href="/board/boardList.do">Board</a> 
		</td>
	</tr>
	<tr>
	
		<c:forEach items="${mbtiList}" var="list">
			<tr id="boardList">
				<td align="center">
					${list.boardType}
				</td>
				<td>
					${list.boardNum}
				</td>
				<td>
					<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
				</td>
			</tr>	
		</c:forEach>
				
				
		<!--<td>
			 <fieldset style="text-align: center;">
			<div>주기적으로 새로운 친구를 만든다.</div>
			<br>
			<span>동의 <input type="radio"> </span>
			<span><input type="radio" name="mbti_01"> </span>
			<span><input type="radio" name="mbti_01"> </span>
			<span><input type="radio" name="mbti_01"> </span>
			<span><input type="radio" name="mbti_01"> </span>
			<span><input type="radio" name="mbti_01"> </span>
			<span><input type="radio" name="mbti_01"> 비동의</span>
			</fieldset>
		</td> -->
	</tr>
	
</table>
</body>
</html>