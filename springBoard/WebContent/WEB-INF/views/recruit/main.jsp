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
	const tableEducation = document.getElementById('tableEducation');
	
/* 	//학교명(소재지)
	const koreaArea = ['강원도', '경기도', '경상남도', '경상북도',
				'광주광역시', '대구광역시', '대전광역시', '부산광역시', '서울특별시', '세종특별자치시',
				'울산광역시', '인천광역시', '전라남도', '전라북도', '제주특별자치도', '충청남도', '충청북도'];
	//재학상태
	const schoolPeriod = ['졸업', '재학', '중퇴']; */
	
	//현재날짜
	const currentDate = new Date();
	const currentYear = currentDate.getFullYear();
	const currentMonth = String(currentDate.getMonth() + 1).padStart(2, '0'); // January is 0!
	const formattedDate = currentYear +'.' +currentMonth;

	//학력 행추가함수
	$j("#addEducation").on("click",function(){
		console.log("학력행추가함수"); //보인다!
		var targetTD = $j('#trEducationContent td');
		var tableName = document.getElementById('tableEducation');
		addRowFunc(targetTD, tableName);
	});
	
	//경력 행추가함수
	$j("#addCareer").on("click",function(){
		console.log("경력행추가함수"); //보인다!
		var targetTD = $j('#trCareerContent td');
		var tableName = document.getElementById('tableCareer');

		addRowFunc(targetTD, tableName);
	});//end addCarrer
	
	//자격증 행추가함수
	$j("#addCertificate").on("click",function(){
		console.log("자격증행추가함수"); //보인다!
		var targetTD = $j('#trCertificateContent td');
		var tableName = document.getElementById('tableCertificate');
		addRowFunc(targetTD, tableName);
	});	
	
	//학력 행삭제	
	$j("#deleteEducation").on("click",function(){
		console.log("학력행삭제함수");
		const tableName = document.getElementById('tableEducation');
		var checkbox = $j("input:checkbox[name=eduDeleteCheck]:checked"); //jQuery 객체로 데이터가 담겨있는 상태
		
		deleteRowFunc(tableName, checkbox);
	});

	//경력 행삭제	
	$j("#deleteCareer").on("click",function(){
		console.log("경력행삭제함수");
		const tableName = document.getElementById('tableCareer');
		var checkbox = $j("input:checkbox[name=careerDeleteCheck]:checked"); //jQuery 객체로 데이터가 담겨있는 상태
		
		deleteRowFunc(tableName, checkbox);
	});

	//자격증 행삭제	
	$j("#deleteCertificate").on("click",function(){
		console.log("자격증행삭제함수");
		const tableName = document.getElementById('tableCertificate');
		var checkbox = $j("input:checkbox[name=certiDeleteCheck]:checked"); //jQuery 객체로 데이터가 담겨있는 상태
		
		deleteRowFunc(tableName, checkbox);
	});
	
	
	
	
	
	$j("#saveResume").on("click",function(){
	    var targetInputs = $j('#wrapTable td input, #wrapTable td select');
//	    var targetTDChildren = $j('#trEducationContent td').find('*');
	    targetInputs.prop("disabled", true);
	});
	
	
	
	
	$j("#submitResume").on("click",function(){
		const table = document.getElementById('wrapTable');
		var eduPeriodFirst = $j("input[name='eduPeriodFirst']");
		var eduPeriodSecond = $j("input[name='eduPeriodSecond']");
		var eduStatus = $j("select[name='eduStatus']");
		var eduSchoolName = $j("input[name='eduSchoolName']");
		var eduSchoolArea = $j("select[name='eduSchoolArea']");
		var eduMajor = $j("input[name='eduMajor']");
		var eduScore = $j("input[name='eduScore']");
		var name = `${recruitLoginUser.name}`;
		var phone = `${recruitLoginUser.phone}`;
				
		var eduData = [];
		
		for(var i= 0; i < eduPeriodFirst.length; i++ ){
			var start_period = eduPeriodFirst.eq(i).val();
			var end_period = eduPeriodSecond.eq(i).val();
			var division = eduStatus.eq(i).val();
			var school_name = eduSchoolName.eq(i).val();
			var location = eduSchoolArea.eq(i).val();
			var major = eduMajor.eq(i).val();
			var grade = eduScore.eq(i).val();
			
			var start_period_array = start_period.split(".");
			var end_period_array = end_period.split(".");
			
			//재학기간 날짜가 앞보다 뒤가 크면 false
			if(start_period > end_period ){
				console.log(start_period);
				console.log(end_period);
				eduPeriodFirst.eq(i).focus();
				alert("재학기간을 다시 확인해주세요.");
				return false;
			};
			//재학기간의 형식이 올바르지 않은 경우 false
			if(start_period.length != 7 ){
				eduPeriodFirst.eq(i).focus();
				alert("재학기간을 다시 확인해주세요.");
				return false;
			};
			if(end_period.length != 7 ){
				eduPeriodSecond.eq(i).focus();
				alert("재학기간을 다시 확인해주세요.");
				return false;
			};
			//재학기간의 마지막날이 현재보다 큰 경우 false
			if(end_period > formattedDate ){
				eduPeriodSecond.eq(i).focus();
				alert("재학기간을 다시 확인해주세요.");
				return false;
			};
			//월 단위가 01~12가 아닌 경우
			if(start_period_array[1] > 12 && start_period_array[1] < 1){
				eduPeriodFirst.eq(i).focus();
				alert("재학기간을 다시 확인해주세요.");
				return false;
			};
			if(end_period_array[1] > 12 && end_period_array[1] < 1){
				eduPeriodSecond.eq(i).focus();
				alert("재학기간을 다시 확인해주세요.");
				return false;
			};
			
			//학력 필수체크확인 => 재학기간이랑 학점은 각각 7이아닐때와 4가 아닐때로 들어가서 제외
			if(eduSchoolName.length == 0){
				eduSchoolName.eq(i).focus();
				alert("학교명을 입력해주세요.");
				return false;
			}
			//학력 필수체크확인 => 재학기간이랑 학점은 각각 7이아닐때와 4가 아닐때로 들어가서 제외
			if(eduMajor.length == 0){
				eduMajor.eq(i).focus();
				alert("전공을 입력해주세요.");
				return false;
			}
			
			//학점이 4.5 이상인 경우
			if(grade > 4.50){
				eduScore.eq(i).focus();
				alert("학점을 다시 확인해주세요.");
				return false;
			}
			//학점이 x.xx가 아닌 경우
			if(grade.length != 4){
				eduScore.eq(i).focus();
				alert("학점을 다시 확인해주세요.");
				return false;
			}
			
			const educationVo = {
					"name": name,
					"phone": phone,
					"start_period": start_period,
					"end_period": end_period,
					"division": division,
					"school_name": school_name,
					"location": location,
					"major": major,
					"grade": grade
			}
			console.log(educationVo);
			eduData.push(educationVo);
		}//end for
		
		$j.ajax({
		    url : "/recruit/resumeSubmitAction.do",
		    dataType: "json",
		    type: "POST",
		    contentType: "application/json; charset=utf-8", //컨트롤러에서 받아오는 타입
		    data : JSON.stringify(eduData),
		    success: function(data, textStatus, jqXHR)
		    {
				alert("작성완료");
				alert("메세지:"+data.success);
		    },
		    error: function (jqXHR, textStatus, errorThrown)
		    {
		    	alert("실패");
		    }
		}); //end ajax  
		
	}); //end submitResume
	
	

}); //end entireJQuery..

	//행추가 함수...
	function addRowFunc(targetTD, tableName){
		var newCareer = tableName.insertRow(-1); // 맨 마지막 행에 tr 생성
		for(var i = 0; i < targetTD.length; i++){
			targetTD.eq(i).clone(true).appendTo(newCareer);
		}
		
		/*
		var newRow = $j('#trCareerContent td'); //trCareerContent의 자식 td 선택(복사하려는 내용행들!)
		var newCareer = tableCareer.insertRow(-1); //tr 생성
		console.log(newRow);
		for(var i = 0; i < newRow.length; i++){
			//console.log(newRow.eq(i));
			newRow.eq(i).clone(true).appendTo(newCareer);
		}		 
		*/
	}
	
	//행삭제 함수...
	function deleteRowFunc(tableName, checkbox ){
		checkbox.each(function(){
	    var selectedTr = $j(this).closest('tr'); // 현재 체크박스가 속한 tr 요소를 찾음
	    console.log("title의 index >> " + selectedTr[0].rowIndex);
	    tableName.deleteRow(selectedTr[0].rowIndex); // title tr 요소 삭제
	    
		});
		
		if(checkbox.length == 0){
			alert("삭제할 행이 없습니다.");
		}
	}
		
</script>

<body>
<table>
	<tr>
		<td align="center" style="font-size: 1.5em; font-weight: bold;" >
			입사지원서
		</td>
	</tr>
	
	
<tr>
<td style="border: 1px">
<table  align="center" id="wrapTable" width="80%">
	<tr>
		<td>
			<table align="center" id="" class="" border = "1">
				<tr>
					<td width="120" align="center">
						<strong>이름</strong>
					</td>
					<td width="120">
					${recruitLoginUser.name}
					</td>
					<td width="120" align="center">
						<strong>생년월일</strong>
					</td>
					<td width="120">
					${recruitLoginUser.birth}
					</td>
				</tr>

				<tr>
					<td align="center">
						<strong>성별</strong>
					</td>
					<td>
						<select>
						<c:choose>
								<c:when test="${recruitLoginUser.gender == 'W'}">
									<option>여자</option>
								</c:when>
								<c:otherwise>
									<option>남자</option>
								</c:otherwise>
							</c:choose>
						</select>
					</td>
					<td align="center">
						<strong>연락처</strong>
					</td>
					<td>
					${recruitLoginUser.phone}
					</td>
				</tr>
				
				<tr >
					<td align="center">
						<strong>email</strong>
					</td>
					<td>
					${recruitLoginUser.email }
					</td>
					<td align="center">
						<strong>주소</strong>
					</td>
					<td>
					${recruitLoginUser.addr}
					</td>
				</tr>
				
				<tr>
					<td align="center">
						<strong>희망근무지</strong>
					</td>
					<td>
						<select>
							<option value="전국">전국</option>
							<option value="강원도">강원도</option>
							<option value="경기도">경기도</option>
							<option value="경상남도">경상남도</option>
							<option value="경상북도">경상북도</option>
							<option value="광주광역시">광주광역시</option>
							<option value="대구광역시">대구광역시</option>
							<option value="대전광역시">대전광역시</option>
							<option value="부산광역시">부산광역시</option>
							<option value="서울특별시">서울특별시</option>
							<option value="세종특별자치시">세종특별자치시</option>
							<option value="울산광역시">울산광역시</option>
							<option value="인천광역시">인천광역시</option>
							<option value="전라남도">전라남도</option>
							<option value="전라북도">전라북도</option>
							<option value="제주특별자치도">제주특별자치도</option>
							<option value="충청남도">충청남도</option>
							<option value="충청북도">충청북도</option>
						</select>
					</td>
					<td align="center">
						<strong>근무형태</strong>
					</td>
					<td>
						<select>
							<option>계약직</option>
							<option>정규직</option>
						</select>
					</td>
				</tr>
				

			</table>
		</td>
	</tr>
	<tr>
		<td style="font-size: 1.5em; font-weight: bold;">
		학력
		</td>
	</tr>
	
	<tr>
		<td align="right" style="border: 0px">
			<button id="addEducation">추가</button>
			<button id="deleteEducation">삭제</button>
		</td>
	</tr>
	
	<tr>
	<td>		
		<table align="center" id="tableEducation" class="tableEducation" border = "1" width="800px">
			<tr id="trEducation">
				<td  align="center">
				</td>
				<td  align="center">
					<strong>재학기간</strong>
				</td>
				<td align="center">
					<strong>구분</strong>
				</td>
				<td align="center">
					<strong>학교명(소재지)</strong>
				</td>
				<td align="center">
					<strong>전공</strong>
				</td>
				<td align="center">
					<strong>학점</strong>
				</td>
			</tr>
			
			<tr id="trEducationContent">
				<td align="center">
					<input type="checkbox" id="eduDeleteCheck" name="eduDeleteCheck">
				</td>
				<td  align="center">
					<input type="text" maxlength="7" placeholder="xxxx.xx" id="eduPeriodFirst" name="eduPeriodFirst"
					oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{4})(\d{2})$/, '$1.$2');">
					~
					<input type="text" maxlength="7" placeholder="xxxx.xx" id="eduPeriodSecond" name="eduPeriodSecond"
					oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{4})(\d{2})$/, '$1.$2');">
				</td>
				<td align="center">
				<select id="eduStatus" name="eduStatus">
					<option>졸업</option>
					<option>재학</option>
					<option>중퇴</option>
				</select>
				</td>
				
				<td align="center">
					<input type="text" id="eduSchoolName" name="eduSchoolName">
				<select id="eduSchoolArea" name="eduSchoolArea">
					<option value="강원도">강원도</option>
					<option value="경기도">경기도</option>
					<option value="경상남도">경상남도</option>
					<option value="경상북도">경상북도</option>
					<option value="광주광역시">광주광역시</option>
					<option value="대구광역시">대구광역시</option>
					<option value="대전광역시">대전광역시</option>
					<option value="부산광역시">부산광역시</option>
					<option value="서울특별시">서울특별시</option>
					<option value="세종특별자치시">세종특별자치시</option>
					<option value="울산광역시">울산광역시</option>
					<option value="인천광역시">인천광역시</option>
					<option value="전라남도">전라남도</option>
					<option value="전라북도">전라북도</option>
					<option value="제주특별자치도">제주특별자치도</option>
					<option value="충청남도">충청남도</option>
					<option value="충청북도">충청북도</option>
				</select>
				</td>
			
				<td align="center">
					<input type="text" id="eduMajor" name="eduMajor">
				</td>

				<td align="center">
					<input type="text" id="eduScore" name="eduScore" maxlength="4"
					oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{1})(\d{2})$/, '$1.$2');">
				</td>
			</tr>
			</table>
			
			
	<tr>
		<td style="font-size: 1.5em; font-weight: bold;">
		경력
		</td>
	</tr>
	
	<tr>
		<td align="right" style="border: 0px">
			<button id="addCareer">추가</button>
			<button id="deleteCareer">삭제</button>
		</td>
	</tr>

	<tr>
	<td>
		<table align="center" id="tableCareer" class="tableCareer" border = "1" width="800px">
			<tr id="trCareer">
				<td align="center">
				</td>
				<td align="center">
					<strong>근무기간</strong>
				</td>
				<td align="center">
					<strong>회사명</strong>
				</td>
				<td align="center">
					<strong>부서/직급/직책</strong>
				</td>
				<td align="center">
					<strong>지역</strong>
				</td>
			</tr>
			
			<tr id="trCareerContent">
				<td align="center">
					<input type="checkbox" id="careerDeleteCheck" name="careerDeleteCheck" >
				</td>
				<td align="left">
					<input type="text" maxlength="7" placeholder="xxxx.xx" id="careerPeriodFirst" name="careerPeriodFirst"
					oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{4})(\d{2})$/, '$1.$2');">
					~
					<input type="text" maxlength="7" placeholder="xxxx.xx" id="careerPeriodSecond" name="careerPeriodSecond"
					oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{4})(\d{2})$/, '$1.$2');">
				</td>
				<td align="center">
					<input type="text" id="careerName" name="careerName">
				</td>
				
				<td align="center">
					<input type="text" id="careerPosition" name="careerPosition">
				</td>
				<td align="center">
					<input type="text" id="careerArea" name="careerArea">
				</td>
			</tr>
		
		</table>
	</td>
	</tr>


	<tr>
		<td style="font-size: 1.5em; font-weight: bold;">
		자격증
		</td>
	</tr>
	
	<tr>
		<td align="right" style="border: 0px">
			<button id="addCertificate">추가</button>
			<button id="deleteCertificate">삭제</button>
		</td>
	</tr>

	<tr>
	<td>
		<table align="center" id="tableCertificate" class="tableCertificate" border = "1" width="800px">
			<tr id="trCertificate">
				<td align="center">
				</td>
				<td align="center">
					<strong>자격증명</strong>
				</td>
				<td align="center">
					<strong>취득일</strong>
				</td>
				<td align="center">
					<strong>발행처</strong>
				</td>
			</tr>
			
			<tr id="trCertificateContent">
				<td align="center">
					<input type="checkbox" id="certiDeleteCheck" name="certiDeleteCheck">
				</td>
				<td align="center">
					<input type="text" id="certiName" name="certiName">
				</td>
				<td align="center">
					<input type="text" id="certiDate" name="certiDate">
				</td>
				<td align="center">
					<input type="text" id="certiPublisher" name="certiPublisher">
				</td>
			</tr>
		
		</table>
	</td>
	</tr>

</table>
</td>
</tr>

<tr>
	<td align="center">
		<button id="saveResume" name="saveResume">저장</button>
		<button id="submitResume" name="submitResume">제출</button>
		</td>
</tr>
		
</table>
</body>
</html>