<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		});
	

</script>
<body>
<table  align="center">
	<tr>
		<td align="left">
			<a href=""> login</a> 
			<a href="/board/boardJoin"> join</a> 
		</td>
		<td align="right">
			total : ${totalCnt}
		</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1">
				<tr>
					<td width="80" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<td width="300" align="center">
						Title
					</td>
				</tr>
				<c:forEach items="${list}" var="list">
					<tr>
						<td align="center">
							${list}
						</td>
						<td>
							${list}
						</td>
						<td>
							${list}
						</td>
					</tr>	
				</c:forEach>
			</table>
		</td>
	</tr>
	
	
	<tr>
		<td align="center">
			<input type="checkbox" id="select_all" name="selectall" onclick="selectAll(this)" >전체
			<input type="checkbox" id="a01" name="menu" onclick="return checkSelectAll()" value="selectall">일반
			<input type="checkbox" id="a02" name="menu" onclick="return checkSelectAll()" value="selectall">Q&A
			<input type="checkbox" id="a03" name="menu" onclick="return checkSelectAll()" value="selectall">익명
			<input type="checkbox" id="a04" name="menu" onclick="return checkSelectAll()" value="selectall">자유
			
			<input id="search" type="button" value="조회" onclick="location.href='/board/${boardType}/${boardNum}/boardSearch.do?pageNo=1'">
		</td>
	</tr>
	
	<tr>
		<td align="right">
			<a href ="/board/boardWrite.do">글쓰기</a>
		</td>
	</tr>
</table>	
</body>
</html>