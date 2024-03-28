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
		
//행추가함수
$j("#addEducation").on("click",function(){
	console.log("행추가함수"); //보인다!
	//새 행(row)추가 ==> writer보다 앞에.. -1로 잡고 해도 될 것 같고 writer id나 name값으로 해도 될 것 같음 
	//그래서 그냥 boardWriter 선택해서 하는걸로 했다..ㅎㅎ
	const tableEducation = $j('#tableEducation');
	const educationIndex = tableEducation.rowIndex;
	console.log("insert될 위치 educationIndex >> " + educationIndex ); 
/*	
	const newEducation = table.insertRow(writerIndex);
	
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
	checkBox.name = "deleteCheck";
	newCell1.appendChild(checkBox);
		
	//input 박스로 변환... 이라기보단 추가
	var addedEnrollmentPeriod= document.createElement( 'input' );
	addedEnrollmentPeriod.type = "text";
	addedEnrollmentPeriod.placeholder="xxxx.xx";
	addedEnrollmentPeriod.oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{4})(\d{2})$/, '$1.$2');"
	newCell1.appendChild(addedEnrollmentPeriod);
	
 	var addedComment = document.createElement( 'textarea' );
	addedComment.cols = 55;
	addedComment.rows = 20;
	addedComment.name = "boardComment";	
	newCell4.appendChild(addedComment); */

});
		
		
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
					${loginUser.name}
					</td>
					<td width="120" align="center">
						<strong>생년월일</strong>
					</td>
					<td width="120">
					<input type="text" name="name" id="name" maxlength="4" placeholder="name"
 					oninput="this.value = this.value.replace(/[^ㄱ-힣]/ig, '')">
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
					${loginUser.phone}
					</td>
				</tr>
				
				<tr>
					<td align="center">
						<strong>email</strong>
					</td>
					<td>
					${loginUser.email }
					</td>
					<td align="center">
						<strong>주소</strong>
					</td>
					<td>
					${loginUser.addr}
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
		<table align="center" id="" class="" border = "1" width="800px">
			<tr id="tableEducation">
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
					<input type="checkbox">
				</td>
				<td  align="center">
					<input type="text" maxlength="7" placeholder="xxxx.xx"  
					oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{4})(\d{2})$/, '$1.$2');">
					~
					<input type="text" maxlength="7" placeholder="xxxx.xx"  
					oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{4})(\d{2})$/, '$1.$2');">
				</td>
				<td align="center">
				<select>
					<option>졸업</option>
					<option>재학</option>
					<option>중퇴</option>
				</select>
				</td>
				
				<td align="center">
					<input type="text">
				<select>
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
					<input>
				</td>

				<td align="center">
					<input>
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
		<table align="center" id="" class="" border = "1" width="800px">
			<tr>
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
					<input type="checkbox">
				</td>
				<td align="left">
					<input>
					~
					<input>
				</td>
				<td align="center">
					<input>
				</td>
				
				<td align="center">
					<input type="text">
				</td>
				<td align="center">
					<input>
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
		<table align="center" id="" class="" border = "1" width="800px">
			<tr>
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
					<input type="checkbox">
				</td>
				<td align="center">
					<input>
				</td>
				<td align="center">
					<input>
				</td>
				<td align="center">
					<input type="text">
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
		<button>저장</button>
		<button>제출</button>
		</td>
</tr>
		
</table>
</body>
</html>