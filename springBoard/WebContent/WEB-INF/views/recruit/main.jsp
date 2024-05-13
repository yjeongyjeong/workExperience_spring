<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>recruitMain</title>
</head>

<script type="text/javascript">
$j(document).ready(function(){
	var submitCheck = `${recruitLoginUser.submit}`;
	//console.log("submitCheck >> "+submitCheck);
	
	if(submitCheck == 'Y'){
		submitDisable();
	}
	if(submitCheck == 'N'){
		var targetSubmitButtons = $j('#submitResume');
		targetSubmitButtons.prop("disabled", false);
	}
	
	const tableEducation = document.getElementById('tableEducation');
	
	//현재날짜
	const currentDate = new Date();
	const currentYear = currentDate.getFullYear();
	const currentMonth = String(currentDate.getMonth() + 1).padStart(2, '0'); // January is 0!
	const formattedDate = currentYear +'.' +currentMonth; //2024.04
	
	//console.log("formattedDate >>> " + formattedDate);
	//console.log("recruitLoginUser >>> " + `${recruitLoginUser}`);

	//학력 행추가함수
	$j("#addEducation").on("click",function(){
		console.log("학력행추가함수"); //보인다!
		var targetTD = $j('#trEducation').next().children();
		var tableName = document.getElementById('tableEducation');
		addRowFunc(targetTD, tableName);
	});
	
	//경력 행추가함수
	$j("#addCareer").on("click",function(){
		console.log("경력행추가함수"); //보인다!
		var targetTD = $j('#trCareer').next().children();
		var tableName = document.getElementById('tableCareer');

		addRowFunc(targetTD, tableName);
	});//end addCarrer
	
	//자격증 행추가함수
	$j("#addCertificate").on("click",function(){
		console.log("자격증행추가함수"); //보인다!
		var targetTD = $j('#trCertificate').next().children();
		var tableName = document.getElementById('tableCertificate');
		addRowFunc(targetTD, tableName);
	});	
	
	//학력 행삭제	
	$j("#deleteEducation").on("click",function(){
		console.log("학력행삭제함수");
		const tableName = document.getElementById('tableEducation');
		var checkbox = $j("input:checkbox[name=eduDeleteCheck]:checked"); //jQuery 객체로 데이터가 담겨있는 상태
		var tableRowNum = tableName.rows.length;

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
	
	$j("#resumeLogout").on("click",function(){
		alert("로그아웃 되었습니다.");
		location.href = '/recruit/login.do';
	});
	
	
	$j("#saveResume").on("click",function(){
		var data = submitData();
		console.log("data >>>> "+ data);
		
		if (data) {
			$j.ajax({
			    url : "/recruit/resumeSaveAction.do",
			    dataType: "json",
			    type: "POST",
			    contentType: "application/json; charset=utf-8", //컨트롤러에서 받아오는 타입
			    data : JSON.stringify(data),
			    //async : false,
			    success: function(data, textStatus, jqXHR)
			    {
					console.log("data ***** \n"+ data);
			    	alert("작성이 완료되었습니다.");
			    	location.href='/recruit/main.do';
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패" + textStatus + "\n" + jqXHR + "\n" + errorThrown);
			    }
			}); //end ajax  
		}//end if(data)
	}); //end saveResume
	
	
	$j("#submitResume").on("click",function(){
		/* 	    var targetInputs = $j('#wrapTable td input, #wrapTable td select');
//			    var targetTDChildren = $j('#trEducationContent td').find('*');
			    targetInputs.prop("disabled", true); */
			    var data = submitData();
				if (data) {
					$j.ajax({
					    url : "/recruit/resumeSubmitAction.do",
					    dataType: "json",
					    type: "POST",
					    contentType: "application/json; charset=utf-8", //컨트롤러에서 받아오는 타입
					    data : JSON.stringify(data),
					    success: function(data, textStatus, jqXHR)
					    {
							alert("제출이 완료되었습니다.");
							//submitDisable();
							location.href='/recruit/main.do';
					    },
					    error: function (jqXHR, textStatus, errorThrown)
					    {
					    	alert("실패" + textStatus + "\n" + jqXHR + "\n" + errorThrown);
					    }
					}); //end ajax  
				}//end if(data)
					
	});//end submitResume
	
}); //end entireJQuery..


//제출 시 disable
	function submitDisable(){
		//input, select 전부
		var targetInputs = $j('#wrapTable td input, #wrapTable td select');
		//행추가삭제 button
		var targetRowButtons = $j('#wrapTable td button');
		var targetSaveButtons = $j('#saveResume');
		var targetSubmitButtons = $j('#submitResume');
		
	    targetInputs.prop("disabled", true);
	    targetRowButtons.prop("disabled", true);
	    targetSaveButtons.prop("disabled", true);
	    targetSubmitButtons.prop("disabled", true);
	}

//데이터 묶어서 전송해주는 함수!
	function submitData() {
		var currentDate = new Date();
		var currentYear = currentDate.getFullYear();
		var currentMonth = String(currentDate.getMonth() + 1).padStart(2, '0'); // January is 0!
		var formattedDate = currentYear +'.' +currentMonth; //2024.04
		
		//recruit 인적사항
		var recruitData= [];
		
		var birthData = `${recruitLoginUser.birth}`;
		var genderData = `${recruitLoginUser.gender}`;
		var emailData = `${recruitLoginUser.email}`;
		var addrData = `${recruitLoginUser.addr}`;
		var locationData = `${recruitLoginUser.location}`;
		var workTypeData = `${recruitLoginUser.workType}`;
		
		var name = `${recruitLoginUser.name}`;
		var birth = birthData.length != 0 ? birthData : $j("input[name='birth']").val();
		var gender = genderData.length != 0 ? genderData : $j("select[name='gender']").val();
		var phone = `${recruitLoginUser.phone}`;
		var email = emailData.length != 0 ? emailData : $j("input[name='email']").val();
		var addr = addrData.length != 0 ? addrData : $j("input[name='addr']").val();
		var location = locationData.length != 0 ? locationData : $j("select[name='location']").val();
		var workType = workTypeData.length != 0 ? workTypeData : $j("select[name='workType']").val();
		
		//var regex = /^(?=.*[a-zA-Z])(?=.*[@])(?=.*\.)[a-zA-Z0-9@.]{6,100}$/;
		var regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
		
		//01 23 45
		var birthYear = birth.substr(0, 2);
		var birthMonth = birth.substr(2, 2);
		var birthDate = birth.substr(4, 2);
		
		//###################수정이 필요한 부분...
		var birthFullYear = birthYear < 50 ? '20'+birthYear : '19'+birthYear;
		
		if(birth.length != 6){
			alert("생년월일(YYMMDD)을 확인해주세요. \n6자리를 입력해주시기 바랍니다.");
			$j("input[name='birth']").focus();
			return false;
		}
		if(birthMonth < 1 || birthMonth > 12){
			alert("생년월일(YYMMDD)의 월을 확인해주세요.");
			$j("input[name='birth']").focus();
			return false;
		}
		//birthDate는 1에서 31일의 값을 가질 수 있음
		if(birthDate < 1 || birthDate > 31){
			alert("생년월일(YYMMDD)의 일자를 확인해주세요.");
			$j("input[name='birth']").focus();
			return false;
		}
		//4월, 6월, 9월, 11월은 30일까지 존재
		if(birthMonth == 4 || birthMonth == 6 || birthMonth == 9 || birthMonth == 11){
			if(birthDate < 1 || birthDate > 30){
				alert("생년월일(YYMMDD)의 일자를 확인해주세요.31");
				$j("input[name='birth']").focus();
				return false;
			}
		}
		if(birthMonth == '02' ){
			if(birthDate > 29 && birthFullYear % 4 == 0 && birthFullYear % 100 != 0 || birthFullYear % 400 == 0){
				//console.log("윤년");
				alert("생년월일(YYMMDD)의 일자를 확인해주세요.29초과");
				$j("input[name='birth']").focus();
				return false;
			}
			else if(birthDate > 28) {
				//console.log("2월 28일 이상");
				alert("생년월일(YYMMDD)의 일자를 확인해주세요.28초과");
				$j("input[name='birth']").focus();
				return false;
			}
		}
		
		
		if(email.length == 0){
			alert("이메일을 확인해주세요.");
			$j("input[name='email']").focus();
			return false;
		}
		if( !regex.test(email) ){
			alert("이메일을 확인해주세요.\n(입력형식 : hongGilDong@xxxx.xxx)");
			$j("input[name='email']").focus();
			return false;
		}
		if(addr.length == 0){
			alert("주소를 확인해주세요.");
			$j("input[name='addr']").focus();
			return false;
		}
		
		
		const recruitVo = {
				"name": name,
				"birth": birth,
				"gender": gender,
				"phone": phone,
				"email": email,
				"addr": addr,
				"location": location,
				"workType": workType
		}
		
		//console.log ("recruitVo >>>>> " + recruitVo);
		recruitData.push(recruitVo);
		
		
		//education 관련
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
				eduPeriodFirst.eq(i).focus();
				alert("재학기간을 확인해주세요.");
				return false;
			};
			//재학기간의 형식이 올바르지 않은 경우 false
			if(start_period.length != 7 ){
				eduPeriodFirst.eq(i).focus();
				alert("재학기간을 확인해주세요. \n ");
				return false;
			};
			if(end_period.length != 7 ){
				eduPeriodSecond.eq(i).focus();
				alert("재학기간을 확인해주세요.");
				return false;
			};
			//재학기간의 마지막날이 현재보다 큰 경우 false
			if(end_period > formattedDate ){
				eduPeriodSecond.eq(i).focus();
				alert("재학기간을 확인해주세요.");
				return false;
			};
			//월 단위가 01~12가 아닌 경우
			if(start_period_array[1] > 12 || start_period_array[1] < 1){
				eduPeriodFirst.eq(i).focus();
				alert("재학기간을 확인해주세요.");
				return false;
			};
			if(end_period_array[1] > 12 || end_period_array[1] < 1){
				eduPeriodSecond.eq(i).focus();
				alert("재학기간을 확인해주세요.");
				return false;
			};
			//end_period랑 formattedDate가 다른데 division이 '재학'인경우
			if(end_period != formattedDate && division == '재학'){
				eduPeriodSecond.eq(i).focus();
				alert("재학기간을 확인해주세요.");
				return false;
			}
			
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
				alert("학점을 확인해주세요.");
				return false;
			}
			//학점이 x.xx가 아닌 경우
			if(grade.length != 4){
				eduScore.eq(i).focus();
				alert("학점을 확인해주세요.\n(입력형식 : x.xx)");
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
			//console.log(educationVo);
			eduData.push(educationVo);
		}//end for
		
		//경력
		var careerCheckResult = careerCheck();
		
		var careerData = [];
		
		var name = `${recruitLoginUser.name}`;
		var phone = `${recruitLoginUser.phone}`;
	
		var careerStart_period = $j("input[name='careerPeriodFirst']");
		var careerEnd_period = $j("input[name='careerPeriodSecond']");
		var careerComp_name = $j("input[name='careerName']");
		var careerTask = $j("input[name='careerPosition']");
		var careerLocation = $j("input[name='careerArea']");
		
		for(var i = 0; i < careerStart_period.length; i++ ){
			var start_period = careerStart_period.eq(i).val();
			var end_period = careerEnd_period.eq(i).val();
			var comp_name = careerComp_name.eq(i).val();
			var task = careerTask.eq(i).val();
			var location = careerLocation.eq(i).val();
		
			const careerVo = {
					"name": name,
					"phone": phone,
					"location": location,
					"comp_name": comp_name,
					"start_period": start_period,
					"end_period": end_period,
					"task": task
			}
		
			//console.log("careerVo >> \n" + careerVo);
			
			//아예 안쓴경우 name이랑 phone이 있어서 내용이 빈 배열이 생성됨..!! 따라서 값이 있는 경우에만 담도록 함..
			if(start_period.length != 0)
				careerData.push(careerVo);
			
		}//end for
	
		var periodCheckResult = periodDuplicateCheck();
		
		//자격증
		var certificateCheckResult = certificateCheck();
	
		var certiData = [];
		
		var certiQualifi_name = $j("input[name='certiName']");
		var certiAcqu_date = $j("input[name='certiDate']");
		var certiOrganize_name = $j("input[name='certiPublisher']");
		
		
		for(var i = 0; i < certiQualifi_name.length ; i++ ){
			var qualifi_name = certiQualifi_name.eq(i).val();
			var acqu_date = certiAcqu_date.eq(i).val();
			var organize_name = certiOrganize_name.eq(i).val();
			
			const certificateVo = {
				"name": name,
				"phone": phone,
				"qualifi_name": qualifi_name,
				"acqu_date": acqu_date,
				"organize_name": organize_name
			}
			//console.log(certificateVo);
			
			//아예 안쓴경우 name이랑 phone이 있어서 내용이 빈 배열이 생성됨..!! 따라서 값이 있는 경우에만 담도록 함..
			if(qualifi_name.length != 0){
				certiData.push(certificateVo);
			}
		}//end for
		
	    var data = {
	        "recruitVo": recruitData,
	        "educationList": eduData,
	        "careerList": careerData,
	        "certificateList": certiData
	    };

		
	    // 경력 및 자격증 유효성 검사를 모두 통과한 경우 데이터 반환
	    // 근데 굳이 여기까지 오지 않아도 위에서 return false가 날 수 있다면 좋을 것 같음
	    if(careerCheckResult  == true && certificateCheckResult == true && periodCheckResult == true){
	    	return data;
	    } else {
	    	return false;
	    }
		
	}; //end submitData

	//행추가 함수...
	function addRowFunc(targetTD, tableName){
		//console.log(targetTD); //td들(jQuery로 선택됨)..
		var newRowTR = tableName.insertRow(-1); // 맨 마지막 행에 tr 생성
		var className = targetTD.parent().attr('class'); //부모 찾아가서 class 이름 가져옴!
		newRowTR.classList.add(className); //tr(javascript)에 class 이름 추가
		
		targetTD.each(function(){
		    var clonedTD = $j(this).clone(true); // 내부 데이터를 복제
		    // td 내부의 input과 select 요소의 값을 비움
		    clonedTD.find('input').val('');
		    // select 요소를 비우고 첫 번째 옵션을 선택하도록 설정
		    clonedTD.find('select').prop('selectedIndex', 0);
		    // input type이 checkbox인 경우에는 checked 속성을 false로 설정하여 체크를 해제
		    clonedTD.find('input[type="checkbox"]').prop('checked', false);
		    
		    clonedTD.appendTo(newRowTR);
		})
		
		/*
			$j("#addEducation").on("click",function(){
				
				var targetTD = $j('#trEducation').next().children(); //content 행
				var tableName = document.getElementById('tableEducation');
				
				addRowFunc(targetTD, tableName);
			});
		*/
	}
	
	//행삭제 함수...
	function deleteRowFunc(tableName, checkbox ){
		
		//학력 전부 삭제하는 경우
		if(tableName.getAttribute('id') == 'tableEducation' && (tableName.rows.length -1 == checkbox.length) ){
			console.log(tableName.getAttribute('id')); // table객체를 선택해서 true로 나옴...
			console.log("//학력 전부 삭제하는 경우"); 
	    	alert("학력은 필수사항입니다.");
	    	return false;
	    }

		//경력, 자격증 전부 삭제하는 경우
		else if(tableName.getAttribute('id') != 'tableEducation' && (tableName.rows.length -1 == checkbox.length) ){
 			console.log("//경력, 자격증 전부 삭제하는 경우"); 
 		    for (var i = 0; i < checkbox.length-1 ; i++) {
 		    	tableName.deleteRow(1);
 		    }
 			/* checkbox.each(function(){
 			    var selectedTr = $j(this).closest('tr'); // 현재 체크박스가 속한 tr 요소를 찾음
 			    	//jQuery로 선택한거라 [0] 해서 DOM메서드 사용가능하도록함(별의미없음)
 			    	tableName.deleteRow(selectedTr[0].rowIndex); // title tr 요소 삭제
 				}); */
 			
  			var inputs = tableName.querySelectorAll('input');
 		    var selects = tableName.querySelectorAll('select');
 		    var checkboxes = tableName.querySelectorAll('input[type="checkbox"]');

 		    inputs.forEach(function(input) {
 		        input.value = '';
 		    });

 		    selects.forEach(function(select) {
 		        select.selectedIndex = 0;
 		    });

 		    checkboxes.forEach(function(checkbox) {
 		        checkbox.checked = false;
 		    });

		} 

		//전부 삭제하는 게 아닌 경우
		else if(tableName.rows.length -1 != checkbox.length){
			console.log("//전부 삭제하는 게 아닌 경우");
		    checkbox.each(function(){
		    var selectedTr = $j(this).closest('tr'); // 현재 체크박스가 속한 tr 요소를 찾음
		    	//jQuery로 선택한거라 [0] 해서 DOM메서드 사용가능하도록함(별의미없음)
		    	tableName.deleteRow(selectedTr[0].rowIndex); // title tr 요소 삭제
			});
		}
		
		//체크된 게 없는 경우
		if(checkbox.length == 0){
			console.log("//체크된 게 없는 경우");
			alert("삭제할 행이 없습니다.");
		}
		
/* 		$j("#deleteCareer").on("click",function(){
			console.log("경력행삭제함수");
			const tableName = document.getElementById('tableCareer');
			var checkbox = $j("input:checkbox[name=careerDeleteCheck]:checked"); //jQuery 객체로 데이터가 담겨있는 상태
			
			deleteRowFunc(tableName, checkbox);
		}); */
	}
	
	function careerCheck(){
		var currentDate = new Date();
		var currentYear = currentDate.getFullYear();
		var currentMonth = String(currentDate.getMonth() + 1).padStart(2, '0'); // January is 0!
		var formattedDate = currentYear +'.' +currentMonth; //2024.04

		var careerRow = $j('.trCareerContent');
		    //console.log(careerRow);
		   //console.log("***");
		    
		var isValid = true; // 기본적으로 유효한 값으로 설정

		careerRow.each(function() {
		        var careerPeriodFirst = $j(this).find('#careerPeriodFirst').val(); // 자격증명 input 요소의 값 가져오기
		        var careerPeriodSecond = $j(this).find('#careerPeriodSecond').val(); // 취득일 input 요소의 값 가져오기
		        var careerName = $j(this).find('#careerName').val(); // 발행처 input 요소의 값 가져오기
		        var careerPosition = $j(this).find('#careerPosition').val(); // 발행처 input 요소의 값 가져오기
		        var careerArea = $j(this).find('#careerArea').val(); // 발행처 input 요소의 값 가져오기
		        
		        var careerPeriodFirst_array = careerPeriodFirst.split(".");
		        var careerPeriodSecond_array = careerPeriodSecond.split(".");

		        //입력된게 하나라도 있으면
		        if(careerPeriodFirst.length + careerPeriodSecond.length + careerName.length + careerPosition.length + careerArea.length != 0){
		        	//근무기간의 앞이 뒤보다 큰경우
		        	if(careerPeriodFirst > careerPeriodSecond){
		        		alert("근무기간을 확인해주세요");
		        		$j(this).find('#careerPeriodFirst').focus();
		        		isValid = false;
		        		return isValid;
		        	}
		        	
		        	//근무기간의 마지막날이 현재보다 큰 경우
		        	if(careerPeriodSecond > formattedDate ){
		        		alert("근무기간을 확인해주세요");
		        		$j(this).find('#careerPeriodSecond').focus();
		        		isValid = false;
		        		return isValid;
		        	}
		        	
		        	//근무기간의 월단위가 01~12가 아닌 경우
		        	if(careerPeriodFirst_array[1] > 12 || careerPeriodFirst_array[1] < 1){
		        		alert("근무기간을 확인해주세요");
		        		$j(this).find('#careerPeriodFirst').focus();
		        		isValid = false;
		        		return isValid;
		        	}
		        	//근무기간의 월단위가 01~12가 아닌 경우
		        	if(careerPeriodSecond_array[1] > 12 || careerPeriodSecond_array[1] < 1){
		        		alert("근무기간을 확인해주세요");
		        		$j(this).find('#careerPeriodSecond').focus();
		        		isValid = false;
		        		return isValid;
		        	}
		        	
		        	//근무기간 xxxx.xx형식이 안지켜진경우
		        	if(careerPeriodFirst.length != 7){
		        		alert("근무기간을 확인해주세요");
		        		$j(this).find('#careerPeriodFirst').focus();
		        		isValid = false;
		        		return isValid;
		        	}
		        	
		        	if(careerPeriodSecond.length != 7){
		        		alert("근무기간을 확인해주세요");
		        		$j(this).find('#careerPeriodSecond').focus();
		        		isValid = false;
		        		return isValid;
		        	}
		        	
		        	if(careerName.length == 0){
		        		alert("회사명을 확인해주세요");
		        		$j(this).find('#careerName').focus();
		        		isValid = false;
		        		return isValid;
		        	}
		        	if(careerPosition.length == 0){
		        		alert("부서/직급/직책란을 확인해주세요");
		        		$j(this).find('#careerPosition').focus();
		        		isValid = false;
		        		return isValid;
		        	}
		        	if(careerArea.length == 0){
		        		alert("지역을 확인해주세요");
		        		$j(this).find('#careerArea').focus();
		        		isValid = false;
		        		return isValid;
		        	}
		        	
		        }// end if(행 내에 입력된 값이 하나라도 있는 경우)
		        	
		})//end each(행 별로 if 실행)
		    
		    return isValid;
	}//end careerCheck
	
	function certificateCheck(){
		
		var currentDate = new Date();
		var currentYear = currentDate.getFullYear();
		var currentMonth = String(currentDate.getMonth() + 1).padStart(2, '0'); // January is 0!
		var formattedDate = currentYear +'.' +currentMonth; //2024.04
		
		var certificateRow = $j('.trCertificateContent');
	    //console.log(certificateRow);
	    //console.log("***");
	    
	    var isValid = true; // 기본적으로 유효한 값으로 설정
	    
	    certificateRow.each(function() {
	        var certiName = $j(this).find('#certiName').val(); // 자격증명 input 요소의 값 가져오기
	        var certiDate = $j(this).find('#certiDate').val(); // 취득일 input 요소의 값 가져오기
	        var certiPublisher = $j(this).find('#certiPublisher').val(); // 발행처 input 요소의 값 가져오기
	        
	        var certiDate_array = certiDate.split(".");
	        
	        //입력된게 하나라도 있으면
	        if(certiName.length != 0 || certiDate.length != 0 || certiPublisher.length != 0){
	        	if(certiName.length == 0){
	        		alert("자격증명을 입력해주세요");
	        		$j(this).find('#certiName').focus();
	        		isValid = false; // 유효하지 않은 값으로 설정
	        		return isValid;
	        	}
	        	if(certiDate.length == 0){
	        		alert("취득일을 입력해주세요.");
	        		$j(this).find('#certiDate').focus();
	        		isValid = false; // 유효하지 않은 값으로 설정
	        		return isValid;
	        	}
	        	if(certiDate.length != 7){
	        		alert("취득일을 확인해주세요.");
	        		$j(this).find('#certiDate').focus();
	        		isValid = false; // 유효하지 않은 값으로 설정
	        		return isValid;
	        	}
	        	if(certiDate_array[1] > formattedDate){
	        		alert("취득일을 확인해주세요.");
	        		$j(this).find('#certiDate').focus();
	        		isValid = false; // 유효하지 않은 값으로 설정
	        		return isValid;
	        	}
	        	if(certiDate_array[1] > 12 || certiDate_array[1] < 1){
	        		alert("취득일을 확인해주세요.");
	        		$j(this).find('#certiDate').focus();
	        		isValid = false; // 유효하지 않은 값으로 설정
	        		return isValid;
	        	}
	        		
	        	if(certiPublisher.length == 0){
	        		alert("발행처를 입력해주세요");
	        		$j(this).find('#certiPublisher').focus();
	        		isValid = false; // 유효하지 않은 값으로 설정
	        		return isValid;
	        	}
	        	
	        }// end if(행 내에 입력된 값이 하나라도 있는 경우)
		})//end each(행 별로 if 실행)
	    
	    return isValid;
	}//end certificateCheck
	
	function periodDuplicateCheck(){

		var eduPeriodFirst = $j("input[name='eduPeriodFirst']");
		var eduPeriodSecond = $j("input[name='eduPeriodSecond']");
		var careerPeriodFirst = $j("input[name='careerPeriodFirst']");
		var careerPeriodSecond = $j("input[name='careerPeriodSecond']");
		var isValid = true; // 기본적으로 유효한 값으로 설정
		
		for(var i= 0; i < eduPeriodFirst.length; i++ ){
			var eduStart_period = eduPeriodFirst.eq(i).val();
			var eduEnd_period = eduPeriodSecond.eq(i).val();
			
			for(var j = 0; j < careerPeriodFirst.length; j++){
				var careerStart_period = careerPeriodFirst.eq(j).val();
				var careerEnd_period = careerPeriodSecond.eq(j).val();
				//재학기간(학력) 내에 근무기간(경력)이 있는 경우
				if(eduStart_period <= careerStart_period && careerStart_period <= eduEnd_period){
	        		alert("근무기간을 확인해주세요.\n재학기간과 근무기간이 중복됩니다.");
	        		careerStart_period.eq(j).focus();
	        		isValid = false; // 유효하지 않은 값으로 설정
	        		return isValid;
				}
				if(eduStart_period < careerEnd_period && careerEnd_period < eduEnd_period){
	        		alert("근무기간을 확인해주세요.\n재학기간과 근무기간이 중복됩니다.");
	        		careerEnd_period.eq(j).focus();
	        		isValid = false; // 유효하지 않은 값으로 설정
	        		return isValid;
				}
			}//end for career
			
		}// end for edu
		
		return isValid;
	}// end function periodDuplicateCheck
	
</script>

<body>
<table align="center" id="resumeTable">
	<tr>
		<td align="center" style="font-size: 1.5em; font-weight: bold;" >
			입사지원서
		</td>
	</tr>
	
	
<tr>
<td style="border: 1px; ">
<table  align="center" id="wrapTable" width="80%" >

	<tr>
		<td>
			<table align="center" id="userDetail" class="userDetail" border = "1">
				<tr>
					<td width="120" align="center">
						<strong>이름</strong>
					</td>
					<td width="120">
					<input type="text" id="name" name="name"
					value="${recruitLoginUser.name}" maxlength="100" readonly="readonly">
					</td>
					<td width="120" align="center">
						<strong>생년월일</strong>
					</td>
					<td width="120">
					
					<c:choose>
						<c:when test="${recruitLoginUser.birth != null}">
							<input type="text" maxlength="6" placeholder="YYMMDD" id="birth" name="birth" readonly="readonly"
							value="${recruitLoginUser.birth}"
							oninput="this.value = this.value.replace(/[^0-9]/g, '');">
						</c:when>
						<c:otherwise>
							<input type="text" maxlength="6" placeholder="YYMMDD" id="birth" name="birth"
							oninput="this.value = this.value.replace(/[^0-9]/g, '');" >
						</c:otherwise>
					</c:choose>
					</td>
				</tr>

				<tr>
					<td align="center">
						<strong>성별</strong>
					</td>
					<td>
						<select id="gender" name="gender">
							<option value="M" ${recruitLoginUser.gender eq 'M' ? 'selected' : ''}>남자</option>
							<option value="W" ${recruitLoginUser.gender eq 'W' ? 'selected' : ''}>여자</option>
						</select>
					</td>
					<td align="center">
						<strong>연락처</strong>
					</td>
					<td>
					<input type="text" name="phone" id="phone" maxlength="13" placeholder="xxx-xxxx-xxxx" 
					value="${recruitLoginUser.phone}" readonly="readonly"
					oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{3})(\d{4})(\d{4})$/, '$1-$2-$3');">
					</td>
				</tr>
				
				<tr >
					<td align="center">
						<strong>email</strong>
					</td>
					
					<c:choose>
						<c:when test="${recruitLoginUser.email != null}">
							<td>
								<input type="text" id="email" name="email" maxlength="100" placeholder="hongGilDong@xxxx.xxx"
 								oninput="this.value = this.value.replace(/[^a-zA-Z0-9@.]/g, '');"								value="${recruitLoginUser.email}"
								>
							</td>
						</c:when>
						<c:otherwise>
							<td>
								<input type="text" id="email" name="email" maxlength="100" placeholder="hongGilDong@xxxx.xxx"
								oninput="this.value = this.value.replace(/[^a-zA-Z0-9@.]/g, '');"								>
							</td>
						</c:otherwise>
					</c:choose>
					
					<td align="center">
						<strong>주소</strong>
					</td>
					<td>
					<c:choose>
						<c:when test="${recruitLoginUser.addr != null}">
							<input type="text" id="addr" name="addr" maxlength="100" placeholder="주소"
							value="${recruitLoginUser.addr}"
							>
						</c:when>
						<c:otherwise>
							<input type="text" id="addr" name="addr" maxlength="100" placeholder="주소">
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
				
				<tr>
					<td align="center">
						<strong>희망근무지</strong>
					</td>
					<td>
						<select id="location" name="location">
							<option value="전국" ${recruitLoginUser.location eq '강원도' ? 'selected' : ''}>전국</option>
							<option value="강원도" ${recruitLoginUser.location eq '강원도' ? 'selected' : ''}>강원도</option>
							<option value="경기도" ${recruitLoginUser.location eq '경기도' ? 'selected' : ''}>경기도</option>
							<option value="경상남도" ${recruitLoginUser.location eq '경상남도' ? 'selected' : ''}>경상남도</option>
							<option value="경상북도" ${recruitLoginUser.location eq '경상북도' ? 'selected' : ''}>경상북도</option>
							<option value="광주광역시" ${recruitLoginUser.location eq '광주광역시' ? 'selected' : ''}>광주광역시</option>
							<option value="대구광역시" ${recruitLoginUser.location eq '대구광역시' ? 'selected' : ''}>대구광역시</option>
							<option value="대전광역시" ${recruitLoginUser.location eq '대전광역시' ? 'selected' : ''}>대전광역시</option>
							<option value="부산광역시" ${recruitLoginUser.location eq '부산광역시' ? 'selected' : ''}>부산광역시</option>
							<option value="서울특별시" ${recruitLoginUser.location eq '서울특별시' ? 'selected' : ''}>서울특별시</option>
							<option value="세종특별자치시" ${recruitLoginUser.location eq '세종특별자치시' ? 'selected' : ''}>세종특별자치시</option>
							<option value="울산광역시" ${recruitLoginUser.location eq '울산광역시' ? 'selected' : ''}>울산광역시</option>
							<option value="인천광역시" ${recruitLoginUser.location eq '인천광역시' ? 'selected' : ''}>인천광역시</option>
							<option value="전라남도" ${recruitLoginUser.location eq '전라남도' ? 'selected' : ''}>전라남도</option>
							<option value="전라북도" ${recruitLoginUser.location eq '전라북도' ? 'selected' : ''}>전라북도</option>
							<option value="제주특별자치도" ${recruitLoginUser.location eq '제주특별자치도' ? 'selected' : ''}>제주특별자치도</option>
							<option value="충청남도" ${recruitLoginUser.location eq '충청남도' ? 'selected' : ''}>충청남도</option>
							<option value="충청북도" ${recruitLoginUser.location eq '충청북도' ? 'selected' : ''}>충청북도</option>
						</select>
					</td>
					<td align="center">
						<strong>근무형태</strong>
					</td>
					<td>
						<select id="workType" name="workType">
							<option value="계약직" ${recruitLoginUser.workType eq '계약직' ? 'selected' : ''}>계약직</option>
							<option value="정규직" ${recruitLoginUser.workType eq '정규직' ? 'selected' : ''}>정규직</option>
						</select>
					</td>
				</tr>
				

			</table>
		</td>
	</tr>
	
	<c:choose>
	<c:when test="${recruitLoginUser.birth != null}">
		<tr>
		<td>
			<table align="center" id="userSummary" class="userSummary" border = "1">
				<tr id="trUserSammary" class="trUserSammary">
					<td width="180" align="center">
						<strong>학력사항</strong>
					</td>
					<td width="180" align="center">
						<strong>경력사항</strong>
					</td>
					<td width="180" align="center">
						<strong>희망연봉</strong>
					</td>
					<td width="180" align="center">
						<strong>희망근무지/근무형태</strong>
					</td>
				</tr>
				<tr id="trUserSammaryContent" class="trUserSammaryContent">
					<td width="180">
					${calEdu }
					</td>
					<td width="180">
					${calCareer }
					</td>
					<td width="180" >
						회사내규에 따름
					</td>
					<td width="180">
						${recruitLoginUser.location} <br>
						${recruitLoginUser.workType}
					</td>
				</tr>
			</table>
		</td>
	</tr>

	</c:when>
	</c:choose>
	
	<tr>
		<td style="font-size: 1.5em; font-weight: bold; padding-top: 10px;">
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
		
		<c:choose>
			<c:when test="${empty eduList}">
				<tr class="trEducationContent">
					<td align="center">
						<input type="checkbox" id="eduDeleteCheck" name="eduDeleteCheck">
					</td>
					<td  align="center">
						<input type="text" maxlength="7" placeholder="YYYY.MM" id="eduPeriodFirst" name="eduPeriodFirst"
						oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{4})(\d{2})$/, '$1.$2');">
						~
						<input type="text" maxlength="7" placeholder="YYYY.MM" id="eduPeriodSecond" name="eduPeriodSecond"
						oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{4})(\d{2})$/, '$1.$2');">
					</td>
					<td align="center">
					<select id="eduStatus" name="eduStatus">
						<option value="졸업">졸업</option>
						<option value="재학">재학</option>
						<option value="중퇴">중퇴</option>
					</select>
					</td>
					
					<td align="center">
						<input type="text" id="eduSchoolName" name="eduSchoolName" maxlength="100" 
						placeholder="학교명"
						>
					<select id="eduSchoolArea" name="eduSchoolArea">
						<option value="강원도">강원도</option>
						<option value="경기도" >경기도</option>
						<option value="경상남도" >경상남도</option>
						<option value="경상북도" >경상북도</option>
						<option value="광주광역시" >광주광역시</option>
						<option value="대구광역시" >대구광역시</option>
						<option value="대전광역시" >대전광역시</option>
						<option value="부산광역시" >부산광역시</option>
						<option value="서울특별시" >서울특별시</option>
						<option value="세종특별자치시" >세종특별자치시</option>
						<option value="울산광역시" >울산광역시</option>
						<option value="인천광역시" >인천광역시</option>
						<option value="전라남도" >전라남도</option>
						<option value="전라북도" >전라북도</option>
						<option value="제주특별자치도" >제주특별자치도</option>
						<option value="충청남도" >충청남도</option>
						<option value="충청북도" >충청북도</option>
					</select>
					</td>
				
					<td align="center">
						<input type="text" id="eduMajor" name="eduMajor" maxlength="100" placeholder="전공"
						>
					</td>
	
					<td align="center">
						<input type="text" id="eduScore" name="eduScore" maxlength="4" placeholder="x.xx"
						oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{1})(\d{2})$/, '$1.$2');">
					</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${eduList}" var="eduItem">
					<tr class="trEducationContent">
						<td align="center">
							<input type="checkbox" id="eduDeleteCheck" name="eduDeleteCheck">
						</td>
						<td  align="center">
							<input type="text" maxlength="7" placeholder="YYYY.MM" id="eduPeriodFirst" name="eduPeriodFirst"
							 value="${eduItem.start_period}"
							oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{4})(\d{2})$/, '$1.$2');">
							~
							<input type="text" maxlength="7" placeholder="YYYY.MM" id="eduPeriodSecond" name="eduPeriodSecond"
							 value="${eduItem.end_period}"
							oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{4})(\d{2})$/, '$1.$2');">
						</td>
						<td align="center">
						<select id="eduStatus" name="eduStatus">
							<option value="졸업" ${eduItem.division eq '졸업' ? 'selected' : ''}>졸업</option>
							<option value="재학" ${eduItem.division eq '재학' ? 'selected' : ''}>재학</option>
							<option value="중퇴" ${eduItem.division eq '중퇴' ? 'selected' : ''}>중퇴</option>
						</select>
						</td>
						
						<td align="center">
							<input type="text" id="eduSchoolName" name="eduSchoolName" maxlength="100" 
							 value="${eduItem.school_name}" placeholder="학교명"
							>
						<select id="eduSchoolArea" name="eduSchoolArea">
							<option value="강원도" ${eduItem.location eq '강원도' ? 'selected' : ''}>강원도</option>
							<option value="경기도" ${eduItem.location eq '경기도' ? 'selected' : ''}>경기도</option>
							<option value="경상남도" ${eduItem.location eq '경상남도' ? 'selected' : ''}>경상남도</option>
							<option value="경상북도" ${eduItem.location eq '경상북도' ? 'selected' : ''}>경상북도</option>
							<option value="광주광역시" ${eduItem.location eq '광주광역시' ? 'selected' : ''}>광주광역시</option>
							<option value="대구광역시" ${eduItem.location eq '대구광역시' ? 'selected' : ''}>대구광역시</option>
							<option value="대전광역시" ${eduItem.location eq '대전광역시' ? 'selected' : ''}>대전광역시</option>
							<option value="부산광역시" ${eduItem.location eq '부산광역시' ? 'selected' : ''}>부산광역시</option>
							<option value="서울특별시" ${eduItem.location eq '서울특별시' ? 'selected' : ''}>서울특별시</option>
							<option value="세종특별자치시" ${eduItem.location eq '세종특별자치시' ? 'selected' : ''}>세종특별자치시</option>
							<option value="울산광역시" ${eduItem.location eq '울산광역시' ? 'selected' : ''}>울산광역시</option>
							<option value="인천광역시" ${eduItem.location eq '인천광역시' ? 'selected' : ''}>인천광역시</option>
							<option value="전라남도" ${eduItem.location eq '전라남도' ? 'selected' : ''}>전라남도</option>
							<option value="전라북도" ${eduItem.location eq '전라북도' ? 'selected' : ''}>전라북도</option>
							<option value="제주특별자치도" ${eduItem.location eq '제주특별자치도' ? 'selected' : ''}>제주특별자치도</option>
							<option value="충청남도" ${eduItem.location eq '충청남도' ? 'selected' : ''}>충청남도</option>
							<option value="충청북도" ${eduItem.location eq '충청북도' ? 'selected' : ''}>충청북도</option>
						</select>
						</td>
					
						<td align="center">
							<input type="text" id="eduMajor" name="eduMajor" maxlength="100"
							 value="${eduItem.major}" placeholder="전공"
							>
						</td>
		
						<td align="center">
							<input type="text" id="eduScore" name="eduScore" maxlength="4" placeholder="x.xx"
							 value="${eduItem.grade}"
							oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{1})(\d{2})$/, '$1.$2');">
						</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
			</table>
			
			
	<tr>
		<td style="font-size: 1.5em; font-weight: bold; padding-top: 10px;">
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
			
			<c:choose>
				<c:when test="${empty careerList}">
					<tr class="trCareerContent">
							<td align="center">
								<input type="checkbox" id="careerDeleteCheck" name="careerDeleteCheck">
							</td>
							<td align="left">
								<input type="text" maxlength="7" placeholder="YYYY.MM" id="careerPeriodFirst" name="careerPeriodFirst"
								oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{4})(\d{2})$/, '$1.$2');">
								~
								<input type="text" maxlength="7" placeholder="YYYY.MM" id="careerPeriodSecond" name="careerPeriodSecond"
								oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{4})(\d{2})$/, '$1.$2');">
							</td>
							<td align="center">
								<input type="text" id="careerName" name="careerName" maxlength="100" placeholder="회사명"
								>
							</td>
							
							<td align="center">
								<input type="text" id="careerPosition" name="careerPosition" maxlength="100" placeholder="부서/직급/직책"
								>
							</td>
							<td align="center">
								<input type="text" id="careerArea" name="careerArea" maxlength="100" placeholder="지역"
								>
							</td>
						</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${careerList}" var="careerItem">
						<tr class="trCareerContent">
							<td align="center">
								<input type="checkbox" id="careerDeleteCheck" name="careerDeleteCheck">
							</td>
							<td align="left">
								<input type="text" maxlength="7" placeholder="YYYY.MM" id="careerPeriodFirst" name="careerPeriodFirst"
								value="${empty careerItem.start_period ? '' : careerItem.start_period }"
								oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{4})(\d{2})$/, '$1.$2');">
								~
								<input type="text" maxlength="7" placeholder="YYYY.MM" id="careerPeriodSecond" name="careerPeriodSecond"
								value="${empty careerItem.end_period ? '' : careerItem.end_period }"
								oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{4})(\d{2})$/, '$1.$2');">
							</td>
							<td align="center">
								<input type="text" id="careerName" name="careerName" maxlength="100"
								value="${empty careerItem.comp_name ? '' : careerItem.comp_name }"
								placeholder="회사명"
								>
							</td>
							
							<td align="center">
								<input type="text" id="careerPosition" name="careerPosition" maxlength="100"
								value="${empty careerItem.task ? '' : careerItem.task }"
								placeholder="부서/직급/직책"
								>
							</td>
							<td align="center">
								<input type="text" id="careerArea" name="careerArea" maxlength="100"
								value="${empty careerItem.location ? '' : careerItem.location }"
								placeholder="지역"
								>
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
	</td>
	</tr>


	<tr>
		<td style="font-size: 1.5em; font-weight: bold; padding-top: 10px;">
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
			
			<c:choose>
			<c:when test="${empty certiList}">
				<tr class="trCertificateContent">
					<td align="center">
						<input type="checkbox" id="certiDeleteCheck" name="certiDeleteCheck" >
					</td>
					<td align="center">
						<input type="text" id="certiName" name="certiName" maxlength="100" placeholder="자격증명"
						>
					</td>
					<td align="center">
						<input type="text" id="certiDate" name="certiDate" maxlength="7" 
						placeholder="YYYY.MM" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{4})(\d{2})$/, '$1.$2');" >
					</td>
					<td align="center">
						<input type="text" id="certiPublisher" name="certiPublisher" maxlength="100" placeholder="발행처">
					</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${certiList}" var="certiItem">
					<tr class="trCertificateContent" >
						<td align="center">
							<input type="checkbox" id="certiDeleteCheck" name="certiDeleteCheck" >
						</td>
						<td align="center">
							<input type="text" id="certiName" name="certiName" maxlength="100"
							 value="${empty certiItem.qualifi_name ? '' : certiItem.qualifi_name}" placeholder="자격증명">
						</td>
						<td align="center">
							<input type="text" id="certiDate" name="certiDate" maxlength="7"
							 value="${empty certiItem.acqu_date ? '' : certiItem.acqu_date}"
							placeholder="YYYY.MM" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{4})(\d{2})$/, '$1.$2');" >
						</td>
						<td align="center">
							<input type="text" id="certiPublisher" name="certiPublisher" maxlength="100" placeholder="발행처"
							 value="${empty certiItem.organize_name ? '' : certiItem.organize_name}"
							>
						</td>
					</tr>
				</c:forEach>
			</c:otherwise>
			</c:choose>
		</table>
	</td>
	</tr>

</table>
</td>
</tr>

<tr>
	<td align="center">
		<button id="saveResume" name="saveResume">저장</button>
		<button id="submitResume" name="submitResume" disabled="disabled">제출</button>
		<button id="resumeLogout" name="resumeLogout">로그아웃</button>
		</td>
</tr>

		
</table>
</body>
</html>