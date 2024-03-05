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
		 $j("#search").on("click", function(e){
			
			 var boardList = [];
			 var boardTypes = $j("input:checkbox[name='menu']:checked");
			 
			 boardTypes.each(function(){
				 var type = $j(this).attr('id');
				 console.log(type);
				 
				 const boardVo = {
					 "boardType": type
				 };
				 
				 boardList.push(boardVo);
			 });
			 
/* 			 var param = boardList;
			 
 			$j.ajax({
			    url : "/board/boardSearchAction.do",
			    dataType: "json",
			    type: "POST",
			    contentType: "application/json; charset=utf-8",
			    data : JSON.stringify(param),
			    success: function(data, textStatus, jqXHR)
			    {
					console.log("조회완료");
					
					console.log("메세지:"+data.success);
					
					location.href = "/board/boardSearch.do";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			}); */
		});
	}); 
	
	//전체선택
	function selectAll(selectAll){
		const checkboxes = document.getElementsByName('menu');
		checkboxes.forEach((checkbox) => {
			checkbox.checked = selectAll.checked;
		});
	};
	
	//하나라도 체크되지 않으면 전체 선택이 해제되고 전부 체크하면 전체선택이 체크
	function checkSelectAll(){
		//전체 체크 박스
		const checkboxes = document.querySelectorAll("input[name='menu']");
		const checked = $j("input:checkbox[name=menu]:checked");
		
		//select all 체크 박스
		const selectAll = document.querySelector("input[name='selectall']");
		
		if( (checkboxes.length === checked.length) ){
			selectAll.checked = true;
		} else {
			selectAll.checked = false;
		}
	};
	
	
/* 	 var boardList = [];
	 var boardTypes = $j("input:checkbox[name='menu']:checked");
	 
	 boardTypes.each(function(){
		 var type = $j(this).attr('id');
		 alert(type);
		 
		 const boardVo = {
			 "boardType": type
		 };
		 
		 boardList.push(boardVo);
	 }); */
	
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
				<c:forEach items="${boardList}" var="list">
					<tr>
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
			
			<input id="search" type="button" value="조회"  >
			<input id="search2" type="button" value="조회" onclick="location.href='/board/boardSearch.do?'" >
		</td>
	</tr>
	
	<tr>
		<td align="right">
			<a href ="/board/boardWrite.do">글쓰기</a>
		</td>
	</tr>
</table>	
<input type="hidden" name="msg" id="msg" value="${msg}">
</body>
</html>