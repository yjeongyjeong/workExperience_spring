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
	
	//학교명(소재지)
	const koreaArea = ['강원도', '경기도', '경상남도', '경상북도',
				'광주광역시', '대구광역시', '대전광역시', '부산광역시', '서울특별시', '세종특별자치시',
				'울산광역시', '인천광역시', '전라남도', '전라북도', '제주특별자치도', '충청남도', '충청북도'];
	//재학상태
	const schoolPeriod = ['졸업', '재학', '중퇴'];
	
	//현재날짜
	const currentDate = new Date();
	const currentYear = currentDate.getFullYear();
	const currentMonth = String(currentDate.getMonth() + 1).padStart(2, '0'); // January is 0!
	const formattedDate = currentYear +'.' +currentMonth;
	
	
	
	
//학력 행추가함수
	$j("#addEducation").on("click",function(){
		console.log("행추가함수"); //보인다!

		const newEducation = tableEducation.insertRow(-1);
		
		//새 행(row)에 cell추가
		const newCell1 = newEducation.insertCell(0);
		const newCell2 = newEducation.insertCell(1);
		const newCell3 = newEducation.insertCell(2);
		const newCell4 = newEducation.insertCell(3);
		const newCell5 = newEducation.insertCell(4);
		const newCell6 = newEducation.insertCell(5); //ajax에서 처리함!
		
		//checkBox 추가
		var checkBox = document.createElement( 'input' );
		checkBox.type = "checkbox";
		checkBox.name = "eduDeleteCheck";
		checkBox.id = "eduDeleteCheck";
		newCell1.appendChild(checkBox);
		
		// 재학기간
		var firstEnrollmentPeriod = createInputPeriod();
		firstEnrollmentPeriod.name = "eduPeriodFirst";
		var tildeText = document.createTextNode('~');
		var secondEnrollmentPeriod = createInputPeriod();
		secondEnrollmentPeriod.name = "eduPeriodSecond";
		// 셀에 요소 추가
		newCell2.align="center";
		newCell2.appendChild(firstEnrollmentPeriod);
		newCell2.appendChild(tildeText);
		newCell2.appendChild(secondEnrollmentPeriod);
	
		//졸업, 재학, 중퇴 구분!
		var periodSelect = document.createElement('select');
        periodSelect.name = "eduStatus";
        periodSelect.id = "eduStatus";

        schoolPeriod.forEach(function(schoolPeriod, index){
        	var option = document.createElement('option');
        	option.value = schoolPeriod;
        	option.textContent = schoolPeriod;
        	periodSelect.appendChild(option);
        })
        
		newCell3.appendChild(periodSelect); 
        
        //학교명
	 	var areaSelect = document.createElement('select');
	 	areaSelect.name = "eduSchoolArea";
        areaSelect.id = "eduSchoolArea";
	 	var educationSchool = document.createElement('input');
	 	educationSchool.name = "eduSchoolName";
	 	educationSchool.id = "eduSchoolName";
        
        koreaArea.forEach(function(koreaArea, index){
        	var option = document.createElement('option');
        	option.value = koreaArea;
        	option.textContent = koreaArea;
        	areaSelect.appendChild(option);
        })
        
		newCell4.appendChild(educationSchool); 
		newCell4.appendChild(areaSelect); 
        
        var educationMajor = document.createElement( 'input' );
        educationMajor.name = "eduMajor";
        educationMajor.id = "eduMajor";
        newCell5.appendChild(educationMajor);

        var educationScore = document.createElement( 'input' );
        educationScore.name = "eduScore";
        educationScore.id = "eduScore";
        newCell6.appendChild(educationScore);
	});
	
	
	$j("#deleteEducation").on("click",function(){
		console.log("행삭제함수");
		
		const table = document.getElementById('tableEducation');
		var checkbox = $j("input:checkbox[name=eduDeleteCheck]:checked"); //jQuery 객체로 데이터가 담겨있는 상태
		
		checkbox.each(function(){
	    var selectedTr = $j(this).closest('tr'); // 현재 체크박스가 속한 tr 요소를 찾음
	    console.log("title의 index >> " + selectedTr[0].rowIndex);
	    table.deleteRow(selectedTr[0].rowIndex); // title tr 요소 삭제
	    
		});
		
		if(checkbox.length == 0){
			alert("삭제할 행이 없습니다.");
		}
	});
	
	
	
	$j("#saveResume").on("click",function(){
		
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
			
			var start_period_array = start_period.text.split(".");
			var end_period_array = end_period.text.split(".");
			
			//재학기간 날짜가 앞보다 뒤가 크면 false
			if(start_period > end_period ){
				console.log(start_period);
				console.log(end_period);
				$j('#start_period').focus();
				alert("재학기간을 다시 확인해주세요.");
				return false;
			};
			//재학기간의 형식이 올바르지 않은 경우 false
			if(start_period.length != 7 ){
				$j('#start_period').focus();
				alert("재학기간을 다시 확인해주세요.");
				return false;
			};
			if(end_period.length != 7 ){
				$j('#end_period').focus();
				alert("재학기간을 다시 확인해주세요.");
				return false;
			};
			//재학기간의 마지막날이 현재보다 큰 경우 false
			if(end_period > formattedDate ){
				$j('#end_period').focus();
				alert("재학기간을 다시 확인해주세요.");
				return false;
			};
			//월 단위가 01~12가 아닌 경우
			if(start_period_array[1] > 12 && start_period_array[1] < 1){
				$j('#start_period').focus();
				alert("재학기간을 다시 확인해주세요.");
				return false;
			};
			if(end_period_array[1] > 12 && end_period_array[1] < 1){
				$j('#end_period').focus();
				alert("재학기간을 다시 확인해주세요.");
				return false;
			};
			
			if(grade > 4.50){
				console.log(grade);
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
		
		
	});
	
});

	//입력 필드 생성 함수
	function createInputPeriod() {
	    var inputField = document.createElement('input');
	    inputField.type = "text";
	    inputField.maxLength = 7;
	    inputField.placeholder = "xxxx.xx";
	    inputField.addEventListener('input', function() {
	        this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{4})(\d{2})$/, '$1.$2');
	    });
	    return inputField;
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
							<option>남자</option>
							<option>여자</option>
						</select>
					</td>
					<td align="center">
						<strong>연락처</strong>
					</td>
					<td>
					${recruitLoginUser.phone}
					</td>
				</tr>
				
				<tr>
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
			
			<tr>
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
			<tr id="trCarrer">
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
			
			<tr>
				<td align="center">
					<input type="checkbox" id="careerDeleteCheck" name="careerDeleteCheck">
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
			
			<tr>
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