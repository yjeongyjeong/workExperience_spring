<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>list</title>
</head>
<script type="text/javascript">

	 $j(document).ready(function(){
		 $j("#search").on("click", function(e){
			
			 var boardTypes = $j("input:checkbox[name='menu']:checked");
			 var boardList = [];
			 console.log(boardTypes);
			 if(boardTypes.length == 0){
				 alert("조회 타입을 선택하세요.");
				 return false;
			 }

			 boardTypes.each(function(){
				 var type = $j(this).val();
				 
                 const pageVo = {
	   					 "boardType": type
	   				 };
	   				 
                 boardList.push(type);
				 console.log(boardList);
					 
	            });
			 
			 var param = boardList;
			 
			 $j.ajax({
				    url : "/board/boardSearchAction.do",
				    dataType: "json",
				    type: "POST",
				    contentType: "application/json; charset=utf-8",
				    data : JSON.stringify(param),
				    success: function(data, textStatus, jqXHR)
				    {
						console.log(data);
						changeList(data);
										    },
				    error: function (jqXHR, textStatus, errorThrown)
				    {
				    	alert("실패");
				    }
				});

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
	
	//forEach 테이블 데이터 넣는 함수
	function changeList(data) {
	  const table = document.getElementById('boardTable'); // 테이블 요소 가져오기
	  const boardListName = document.getElementById('boardListName'); // 테이블 요소 가져오기
	  const tbody = table.querySelector('tbody'); // tbody 요소 가져오기

	  const wrapTable = document.getElementById('wrapTable'); // 테이블 요소 가져오기
	  const informTr = document.getElementById('inform');
	  
	  console.log(table);
	  console.log(tbody);
	  
	  //음 테이블에서 맨처음 tr빼고 나머지 행은 삭제하고 데이터 만들어서 그 밑에 끼워넣어도 될 것 같기두...
      //var boardListTr = $('#boardTable tr:nth-child(2)'); //boardTable의 tr중에 두번째 tr을 선택
	  //tbody.innerHTML = ''; tbody내의 모든걸 초기화시키는데 스타일까지 날아므로.. 조금 귀찮음
 		$j('#boardTable tr:not(:first-child)').remove(); //첫번째 빼고 전부 제거

 		
 		
 		
 		// 데이터를 forEach로 순회하며 테이블에 추가
 	  data.forEach(function(item) {
	    const row = document.createElement('tr'); // 새로운 행 생성

	    // boardType 추가하기
	    const typeCell = document.createElement('td');
	    //textContent : 내부 텍스트 내용 boardType : ajax로 받아온 data에서 boardType에 해당하는 데이터
	    //즉 typeCell이라는 td 내부의 글자를 boardType에 해당하는 문자로 바꾼다는 의미
	    typeCell.textContent = item.boardType; 
	    typeCell.align="center";
	    row.appendChild(typeCell); // 행에다가 추가

	    // boardNum 추가하기
	    const numCell = document.createElement('td');
	    numCell.textContent = item.boardNum;
	    row.appendChild(numCell);

//	    console.log(item);

		// boardTitle 추가하기
	    const titleCell = document.createElement('td');
	    const link = document.createElement('a');

	    const hrefLink = '/board/'+item.boardType + '/' + item.boardNum + '/boardView.do?pageNo=' + item.pageNo;
	    //console.log(hrefLink);
//	    아래대로 하면 값이 안들어옴...
//	    link.href = `/board/${item.boardType}/${item.boardNum}/boardView.do?pageNo=${item.pageNo}`;
	    link.href = hrefLink;
	    link.textContent = item.boardTitle;
	    titleCell.appendChild(link);
	    row.appendChild(titleCell);
 
	    // 행(tr 이하 전부)을 tbody(boardTable내의 tbody에 추가)
	    tbody.appendChild(row); 
	  }); //end forEach
	  
	 //table전체 행의 개수를 세야하므로 forEach보다 아래에 있어야 함 => 테이블에 표시되는 행을 무조건 10으로 해놔서 최대값이 고정되어버림
 	  if (data != "") {
		  $j('#totalCnt').remove();
			const totalCnt = data[0].totalCnt; 
		    console.log(totalCnt);
		    
		    const totalrow = document.createElement('td');
		    totalrow.id = "totalCnt"
		    totalrow.textContent = 'total : ' + totalCnt;
		    totalrow.align = "right";
		    informTr.appendChild(totalrow);
		}else{ // data가 없는 경우
			$j('#totalCnt').remove();
			const totalCnt = 0; 
		    console.log(totalCnt);
		    
		    const totalrow = document.createElement('td');
		    totalrow.id = "totalCnt"
		    totalrow.textContent = 'total : ' + totalCnt;
		    totalrow.align = "right";
		    informTr.appendChild(totalrow);
		}
	 //end if
		
	}; // end changeList
	
	
	//로그아웃
	 $j(document).ready(function(){
		 $j("#logout").on("click", function(e){

			 //그냥 ${loginUser.userId}를 사용하면 값이 아니라 변수로 인식해서
			 //Uncaught ReferenceError: 변수명 is not defined라는 오류 발생 ==> 백틱으로 해결
			 var userId = `${loginUser.userId}`;
			 var userPw = `${loginUser.userPw}`;
			 
			 var param = {
					 "userId": userId,
					 "userPw": userPw
			 }
			 console.log("***");
			 console.log(param);
			 console.log("***");
			
			 $j.ajax({
				    url : "/board/boardUserLogoutAction.do",
				    dataType: "json",
				    type: "POST",
				    data : param,
				    success: function(data, textStatus, jqXHR)
				    {
				    	console.log("로그아웃");
						alert("로그아웃 되었습니다.");
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

<table  align="center" id="wrapTable">
	<tr id="inform">
		<td align="left">
  <c:choose>
  	<c:when test="${loginUser != null}">
			<a> ${loginUser.userName} </a> 
	</c:when>
	<c:otherwise>
			<a href="/board/boardLogin.do"> login</a> 
			<a href="/board/boardJoin.do"> join</a> 
	</c:otherwise>
  </c:choose>
		</td>
			<td align="right" id="totalCnt">
				total : ${totalCnt}
			</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1">
				<tr id="boardListName">
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
			</table>
		</td>
	</tr>
	
	<tr>
		<td align="center">
			<input type="checkbox" id="select_all" name="selectall" onclick="selectAll(this)" >전체
	<c:forEach items="${codeList}" var="codeList">
			<input type="checkbox" id="${codeList}.codeId" name="menu" onclick="return checkSelectAll()" value="${codeList.codeId }">${codeList.codeName }
	</c:forEach>
			<input id="search" type="button" value="조회"  >
		</td>
	</tr>
	
	<tr>
		<td align="right">
			<a href ="/board/boardWrite.do">글쓰기</a>
		<c:if test="${loginUser != null}" var="loginUser" >
			<a href="#" id="logout" name="logout">로그아웃</a>
		</c:if>
		</td>
	</tr>
	
</table>

<input type="hidden" name="msg" id="msg" value="${msg}">
</body>
</html>