<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>boardView</title>
</head>

<script type="text/javascript">

	$j(document).ready(function(){
		
		$j("#submit").on("click",function(){
			var $frm = $j('.boardWrite :input');
			var param = $frm.serialize();
			
			$j.ajax({
			    url : "/board/boardRemoveAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
					alert("삭제완료");
					
					alert("메세지:"+data.success);
					
					location.href = "/board/boardList.do?pageNo=1";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			});
		});
	});
	

</script>

<body>
<form class="boardWrite">
	<table align="center">
		<tr>
			<td>
				<table border ="1">
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						${board.boardTitle}
						<input name="boardTitle" type="hidden" value="${board.boardTitle}">
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td>
						${board.boardComment}
						<input name="boardComment" type="hidden" value="${board.boardComment}">
						</td>
					</tr>
					<tr>
						<td align="center">
						Writer
						</td>
						<td>
							${board.creator}
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
			<c:if test="${loginUser.userName == board.creator}">
				<input id="submit" type="button" value="삭제">
				<input type="button" onclick="location.href='/board/${boardType}/${boardNum}/boardModify.do'" value="수정"></input>
			</c:if>
			<%-- <button onclick="location.href='/board/${boardType}/${boardNum}/boardModify.do'">수정</button> --%>
			<input name="boardType" type="hidden" value="${board.boardType}">
			<input name="boardNum" type="hidden" value="${board.boardNum}">
				<a href="/board/boardList.do?pageNo=${cri.pageNo}&amount=${cri.amount}">List</a>
			</td>
		</tr>
	</table>	
	
</form>
</body>
</html>