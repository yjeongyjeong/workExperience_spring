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
		
		 var boardTypes = $j("input:checkbox[name='menu']:checked");
		 var boardList = [];

		 boardTypes.each(function(){
               var type = $j(this).attr('id');
               
               /* const boardVo = {
  					 "boardType": type
  				 };
  				 
               boardList.push(boardVo);
				 */
               boardList.push(type);
               console.log(boardList);
           });

	        // 폼 생성
	        var formData = $j("<form>")
	            .attr("method", "GET")  // GET 요청으로 변경
	            .attr("action", "/board/boardSearch.do");

	        // boardList의 각 요소에 대해 숨겨진 입력 요소 생성 및 설정
	        boardList.forEach(function(boardVo, index) {
	            $j("<input>")
	                .attr("type", "hidden")
	                .attr("name", "boardTypes")
	                .val(boardVo)
	                .appendTo(formData);
	        });

	        // 생성된 폼을 body에 추가하고 제출
	        formData.appendTo("body").submit();	        
       
       
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
			<!-- onclick="location.href='/board/boardSearch.do'" -->
		</td>
	</tr>
	
		
	<tr>
		<td align="right">
			<a href ="/board/boardList.do">전체목록보기</a>
			<a href ="/board/boardWrite.do">글쓰기</a>
		</td>
	</tr>
</table>	
</body>
</html>