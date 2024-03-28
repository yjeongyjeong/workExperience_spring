<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>boardWrite</title>
</head>
<script type="text/javascript">
	
	$j(document).ready(function(){
	var count = 0;
	var excludeRowCnt = document.querySelectorAll("#tableWriter").length;
	const table = document.getElementById('boardTable');
	var beforeTotalRowCnt = table.rows.length; //tr의 개수
	
	console.log("count >> " + count);
	console.log("excludeRowCnt >> " + excludeRowCnt);
	console.log("beforeTotalRowCnt >> " + beforeTotalRowCnt);
	
		
//	행추가함수
		$j("#addColumn").on("click",function(){
			console.log("행추가함수"); //보인다!

 			$j.ajax({
			    url : "/board/boardTypesAction.do",
			    dataType: "json",
			    type: "GET",
			    contentType: "application/json; charset=utf-8",
//			    data : JSON.stringify(param),
			    success: function(data, textStatus, jqXHR)
			    {
			    	//javascript에서 ${codeList}를 변수로 받고 데이터를 처리하고 싶은데 변수로 받는 순간 json형태에서 벗어나게 되어서 전부 문자열(변수)로 인식됨..
			    	//따라서 ajax로 호출하여 성공시 행추가 로직을 실행함
			    	codeNames = data.map(function(item) {
			    		    return item.codeName;
			    	});
			    	codeIds = data.map(function(item){
			    		return item.codeId;
			    	});
			    	//alert(codeNames);
			    	
			    	// select 요소 생성 및 옵션 추가
		            var addedSelect = document.createElement('select');
		            addedSelect.name = "boardType";
		            addedSelect.id = "boardType";

		            codeNames.forEach(function(codeName, index) {
		                var option = document.createElement('option');
		                option.value = codeIds[index]; // 각 option의 value에 codeId를 설정
		                option.textContent = codeName;
		                addedSelect.appendChild(option);
		            });
		            
		            /* codeNames.forEach(function(codeName) {
		                var option = document.createElement('option');
		                //option.value = codeName; codeName으로 값이 들어가서 controller에서 읽어오지 못함!!
		                option.textContent = codeName;
		                addedSelect.appendChild(option);
		            }); */

		            // 추가된 select 요소를 셀에 추가
		            var newCell6 = newType.insertCell(1);
		            newCell6.appendChild(addedSelect);
		    
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			}); //end ajax
			
			count++;
			console.log("count >> " + count);
			
			//새 행(row)추가 ==> writer보다 앞에.. -1로 잡고 해도 될 것 같고 writer id나 name값으로 해도 될 것 같음 
			//그래서 그냥 boardWriter 선택해서 하는걸로 했다..ㅎㅎ
			const boardWriter = document.getElementById('tableWriter');
			const writerIndex = boardWriter.rowIndex;
			console.log("insert될 위치 writerIndex >> " + writerIndex ); 
			
			const newComment = table.insertRow(writerIndex);
			const newTitle = table.insertRow(writerIndex);
			const newType = table.insertRow(writerIndex);
			
			
			//새 행(orw)에 cell추가
			const newCell1 = newTitle.insertCell(0);
			const newCell2 = newTitle.insertCell(1);
			const newCell3 = newComment.insertCell(0);
			const newCell4 = newComment.insertCell(1);
			const newCell5 = newType.insertCell(0);
			//const newCell6 = newType.insertCell(1); //ajax에서 처리함!
			
			//cell에 텍스트 추가
			newCell1.innerText = 'Title';
			newCell3.innerText = 'Comment';
			newCell5.innerText = 'Type';
			
			//추가된 애들 스타일 넣기
			newCell1.align = "center";
			newCell3.align = "center";
			newCell5.align = "center";
			
			//input 박스로 변환... 이라기보단 추가
			var addedTitle = document.createElement( 'input' );
			addedTitle.size = 50;
			addedTitle.name = "boardTitle";
			newCell2.appendChild(addedTitle);
			
			var checkBox = document.createElement( 'input' );
			checkBox.type = "checkbox";
			checkBox.name = "deleteCheck";
			newCell3.appendChild(checkBox);
			
			var addedComment = document.createElement( 'textarea' );
			addedComment.cols = 55;
			addedComment.rows = 20;
			addedComment.name = "boardComment";	
			newCell4.appendChild(addedComment);

		});
		
		
//	행삭제함수
		$j("#deleteColumn").on("click",function(){
			console.log("행삭제함수"); 
			
			count--;
			console.log("count >> " + count);
			
			const table = document.getElementById('boardTable');
			var checkbox = $j("input:checkbox[name=deleteCheck]:checked"); //jQuery 객체로 데이터가 담겨있는 상태
			
			checkbox.each(function(){
				//$j(this).parent() : checkbox의 부모는 td
				//$j(this).parent().parent() : td의 부모는 tr	
		    var tr = $j(this).closest('tr'); // 현재 체크박스가 속한 tr 요소를 찾음
		    var titleTr = tr.prev(); // title tr 요소를 찾음
		    var commentTr = tr; // comment tr 요소는 현재 체크박스가 속한 tr 요소
		    var typeTr = titleTr.prev(); // type 요소를 찾음
		    
		    console.log("title의 index >> " + titleTr[0].rowIndex);
		    console.log("comment의 index >> " + commentTr[0].rowIndex);
		    
		    table.deleteRow(titleTr[0].rowIndex); // title tr 요소 삭제
		    table.deleteRow(commentTr[0].rowIndex); // comment tr 요소 삭제
		    table.deleteRow(typeTr[0].rowIndex); // comment tr 요소 삭제

			});
			
			if(checkbox.length == 0){
				alert("삭제할 행이 없습니다.");
			}
			
		});
		
		
//board 제출 함수		
	$j("#submit").on("click",function(e){
			
			const table = document.getElementById('boardTable');
			var boardTitles = $j("input[name='boardTitle']");
			var boardComments = $j("textarea[name='boardComment']");
			var boardTypes = $j("select[name='boardType']");
			var creator = $j('#creator').text().trim();
			
			console.log(boardTitles);
			console.log(boardComments);
			console.log(boardTypes);
			console.log(creator);
			
			//var boardMap = new Map(); -> 키값이 중복되므로 사용을 지양해야함 왜냐면 키값이 중복되면 마지막에 저장된값으로 저장되기 때문!
			var boardData = [];
			
			var AfterTotalRowCnt = table.rows.length;
			console.log("AfterTotalRowCnt >> " + AfterTotalRowCnt);

			//count가 0이 되는 경우(아무런 변화가 없는 경우) => NaN
			if( count == 0 ){			
				var divisionNum = (beforeTotalRowCnt-excludeRowCnt);
				console.log("divisionNum >> "+ (beforeTotalRowCnt-excludeRowCnt) );
			} else{
				var divisionNum = ( (AfterTotalRowCnt-excludeRowCnt) - (beforeTotalRowCnt-excludeRowCnt) ) /count;
				console.log("divisionNum >> "+ divisionNum);
				//boardData.push(divisionNum);
			}
			
			for(var i =0; i< boardTitles.length; i++){
				var title = boardTitles.eq(i).val();
				var comment = boardComments.eq(i).val();
				var type = boardTypes.eq(i).val();
				
				var deleteSpaceTitle = title.replace(/\s/gi, ""); // 정규식 => s : 공백 g : 글로벌 매칭.. 일치하는 모든 부분을 찾음 i : 대소문자 구별없이
				var deleteSpaceComment = comment.replace(/\s/gi, "");
				
				const boardVo = { // BoardVo 객체 생성
						"boardType": type,
			            "boardTitle": title,
			            "boardComment": comment,
			            "creator": creator
			        };
				
				console.log("######################");
				console.log(boardVo);
				
				boardData.push(boardVo );
			}
			
			// 아무것도 없거나 공백만 입력한 경우 제외
			if( boardTitles.val() == null || boardTitles.val() == "" || deleteSpaceTitle == ""  ){
				//e.preventDefault();
				alert("제목을 입력해주세요.");
				console.log("deleteSpaceTitle >>> " + deleteSpaceTitle);
				return false;
			} 
			if( boardComments.val() == null || boardComments.val() == "" || deleteSpaceComment == ""   ){
				//e.preventDefault();
				alert("내용을 입력해주세요.");
				console.log("deleteSpaceComment >>> " + deleteSpaceComment);
				return false;
			}
		
//			var $frm = $j('.boardWrite :input');
//			var param = $frm.serialize();

			var param = boardData; //배열
	
 			$j.ajax({
			    url : "/board/boardWriteAction.do",
			    dataType: "json",
			    type: "POST",
			    contentType: "application/json; charset=utf-8",
			    data : JSON.stringify(param),
			    success: function(data, textStatus, jqXHR)
			    {
					alert("작성완료");
					
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
			<td align="right">
			<input id="deleteColumn" type="button" value="행삭제(Title&Comment)">
			<input id="addColumn" type="button" value="행추가(Title&Comment)">
			<input id="submit" type="button" value="작성">
			</td>
		</tr>
		<tr>
			<td>
				<table  id="boardTable" border ="1"> 
				
					<tr id="tableType">
						<td width="120" align="center">
						Type
						</td>
						<td width="400">
							<select name="boardType" id="boardType">
								<c:forEach items="${codeList}" var="codeList">
									<option value="${codeList.codeId}">${codeList.codeName}</option>						
								</c:forEach>
							</select>
						</td>
					</tr>

					<tr id="tableTitle">
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						<input name="boardTitle" type="text" size="50" >
						</td>
					</tr>
					<tr id="tableComment">
						<td height="300" align="center">
						Comment
						</td>
						<td valign="top">
						<textarea name="boardComment"  rows="20" cols="55"></textarea>
						</td>
					</tr>
					
					<tr id="tableWriter">
						<td align="center">
						Writer
						</td>
						
						<td id="creator">
						
							<c:choose>
								<c:when test="${loginUser != null}">
									${loginUser.userName}
								</c:when>
								<c:otherwise>
								SYSTEM
									<!-- <input type="hidden" value="SYSTEM" readonly="readonly"> -->
								</c:otherwise>
							</c:choose>
						
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<a href="/board/boardList.do">List</a>
			</td>
		</tr>
	</table>
</form>	
</body>
</html>