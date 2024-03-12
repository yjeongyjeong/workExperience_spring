<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>boardView</title>

<style type="text/css">
	.userPwd_ok {
		font-size: small;
		color: #008000;
		display: none;
	}
	
	.userPwd_already {
		font-size: small;
		color: rgb(201, 0, 0);
		display: none;
	}
</style>

</head>

<script type="text/javascript">
		var checkIdResult = false;
		var checkPwResult = false;

	function idChk(){
		var userId = $j('#userId').val();
		console.log(userId);
		
		const userVo = { // BoardVo 객체 생성
				"userId": userId
	        };
		
			$j.ajax({
			    url : "/board/boardUserIdCheckAction.do",
			    dataType: "json",
			    type: "POST",
			    contentType: "application/json; charset=utf-8",
			    data : JSON.stringify(userVo),
			    success: function(userIdCnt)
			    {
			    	console.log(userIdCnt);
			    	//alert(userIdCnt);
			    	
			    	if(userIdCnt == 0){ //0이면 사용가능 1이면 중복
						alert("사용할 수 있는 아이디입니다.");
						checkIdResult = true;
			    	} else{ //0이 아닌경우(중복일 때)
				    	alert("중복된 아이디입니다.");
				    	checkIdResult = false;
			    	}
					
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("fail");
			    }
			});
			//ajax end
			
			return checkIdResult; //true 인지 false인지 반환 => 추후 if문에서 확인
		};
		
		function onkeyupCheckIdResult(){
			checkIdResult = false;
			};

	function pwChk(){
		var userPw = $j('#userPw').val();
		var userPwChk = $j('#userPwChk').val();
		
		var pwList=[];
		
		console.log(userPw);
		console.log(userPwChk);
		
		pwList.push(userPw);
		pwList.push(userPwChk);
		
			$j.ajax({
			    url : "/board/boardUserPwCheckAction.do",
			    dataType: "json",
			    type: "POST",
			    contentType: "application/json; charset=utf-8",
			    data : JSON.stringify(pwList),
			    success: function(userPwCnt)
			    {
			    	console.log(userPwCnt);
			    	//alert(userPwCnt);
			    	
			    	if (userPwCnt == 1) { //1이면 일치(확인됨)
						$j('.userPwd_ok').css("display", "inline-block");
						$j('.userPwd_already').css("display", "none");
						checkPwResult = true;
					} else if (userPwCnt == 0) { // 0 불일치
						$j('.userPwd_ok').css("display", "none");
						$j('.userPwd_already').css("display", "inline-block");
						//값을 지우면 확인못할것같아서 주석처리함
						checkPwResult = false;
					} else { //-1 : controller에서 문제가 발생
						alert("오류가 발생하였습니다.");
					}
					
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	console.log("fail");
			    }
			});
			//ajax end
			
			return checkPwResult; //true 인지 false인지 반환 => 추후 if문에서 확인
		};

/* 		function handleOnInput(el, maxlength) {
			if (el.value.length > maxlength) {
				el.value = el.value.substr(0, maxlength);
			};
		}; */
		
		
		$j(document).ready(function(){
		    $j("#formSubmit").on("click",function(){
		        var regId = /^[a-zA-Z0-9]{6,10}$/;
		        var regIdPw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,12}$/;
		        var frm = $j('#boardTable');  // jQuery로 선택된 문서 객체로 변경

		        //아이디 확인
				if ($j('#userId').val().length == 0) {
					alert("아이디를 입력해주세요.");
					console.log(1);
					$j('#userId').focus;
					return false;
				} else if (!regId.test($j('#userId').val())) { //아이디 영어 대소문자 확인
					alert("6~10자 영문 대소문자, 숫자만 입력해주세요.")
					console.log(2);
					$j('#userId').focus();
					return false;
				} else if (!checkIdResult) {
					console.log(3);
					alert("아이디 중복확인이 되지않았습니다.");
					return false;
				}
				
				//비밀번호 확인
				else if ($j('#userPw').val().length == 0) {
					alert("비밀번호를 입력하세요.")
					$j('#userPw').focus();
					return false;
				} else if (!regIdPw.test($j('#userPw').val())) {
					alert("6~10자 영문 대소문자, 숫자, 특수문자를 입력해주세요.")
					$j('#userPw').focus();
					return false;
				} else if ($j('#userPw').val() == $j('#userId').val()) {
					alert("아이디와 동일한 비밀번호를 사용할 수 없습니다.")
					$j('#userPw').focus();
					return false;
				} else if (!checkPwResult) {
					alert("비밀번호를 다시 확인해주세요.");
					return false;
				
				// 이름 확인
				}else if ($j('#userName').val().length == 0) {
						alert("이름을 입력하세요.")
						$j('#userName').focus();
						return false;
					
				//휴대전화번호 확인
				} else if ( ($j('#userPhone2').val().length == 0)
						|| ($j('#userPhone2').val().length < 4) ) {
					alert("휴대전화번호 가운데 자리를 다시 확인해주세요(4글자).")
					$j('#userPhone2').focus();
					return false;
				} else if ($j('#userPhone3').val().length == 0
						|| $j('#userPhone3').val().length < 4) {
					alert("휴대전화번호 마지막 자리를 다시 확인해주세요(4글자).")
					 $j('#userPhone3').focus();
					return false;
					
				//우편번호 확인 postNo
				} else if ( ($j('#userAddr1').val().length != 0 )
						&& ($j('#userAddr1').val().length < 7 ) ) {
					alert("우편번호를 다시 확인해주세요.")
					$j('#userAddr1').focus();
					return false;
				}
		        
		        
		        //Invalid left-hand side in assignment 에러 발생..ㅎㅎ
				 else if ( $j('#userAddr2').val().length == 0 ) {
					$j('#userAddr2').val() = "none";
				}
				
				 else if ( $j('#userCompany').val().length != 0 ) {
					$j('#userAddr2').val() = "none";
				}
	
				var frm = $j('.boardTable :input');
				var param = frm.serialize(); 

				console.log("*************************");
				console.log(frm);
				console.log(param);
				
				var userData = [];
				
				var userId = $j('#userId').val();
				var userPw = $j('#userPw').val();
				var userName = $j('#userName').val();
				var userPhone1 = $j('#userPhone1').val();
				var userPhone2 = $j('#userPhone2').val();
				var userPhone3 = $j('#userPhone3').val();
				var userAddr1 = $j('#userAddr1').val();
				var userAddr2 = $j('#userAddr2').val();
				var userCompany = $j('#userCompany').val();
				
				const userVo = {
						"userId": userId
						,"userPw": userPw
						,"userName": userName
						,"userPhone1": userPhone1
						,"userPhone2": userPhone2
						,"userPhone3": userPhone3
						,"userAddr1": userAddr1
						,"userAddr2": userAddr2
						,"userCompany": userCompany
				};
				
				userData.push(userVo);
				
				$j.ajax({
				    url : "/board/boardUserjoinAction.do",
				    dataType: "json",
				    type: "POST",
				    contentType: "application/json; charset=utf-8",
				    data : JSON.stringify(userData),
				    success: function(data, textStatus, jqXHR)
				    {
				    	console.log(data);
				    },
				    error: function (jqXHR, textStatus, errorThrown)
				    {
				    	console.log("실패~~~ㅜㅜ");
				    }
				});
				//ajax end
		        
			});
		});
		
</script>

<body>
<table  align="center" id="wrapTable">
	<tr id="inform">
		<td align="left">
			<a href="/board/boardList.do">List</a> 
		</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" class="boardTable" border = "1">
				<tr>
					<td width="120" align="center">
						id
					</td>
					<td width="300">
					<input type="text" id="userId" name="userId" maxlength="15"
					oninput="this.value = this.value.replace(/[^a-z0-9]/g, '')" onkeyup="return onkeyupCheckIdResult()">
					<button id="idChk" onclick="return idChk()">중복확인</button>
					</td>
				</tr>

				<tr>
					<td align="center">
						pw
					</td>
					<td>
					<input type="password" name="userPw" id="userPw" maxlength="16" onkeyup="return pwChk()">
					</td>
				</tr>

				<tr>
					<td align="center">
						pw check
					</td>
					<td>
					<input type="password" name="userPwChk" id="userPwChk" maxlength="16" oninput="return pwChk()" >
					<span
								class="userPwd_ok">&nbsp;&nbsp;success</span> <span
								class="userPwd_already">&nbsp;&nbsp;fail</span>
					</td>
				</tr>

				<tr>
					<td align="center">
						name
					</td>
					<td>
					<input type="text" name="userName" id="userName" maxlength="5"
 					oninput="this.value = this.value.replace(/[^가-힣]/ig, '')">
					<!-- oninput="handleOnInputKor(this)"> -->
					</td>
				</tr>

				<tr>
					<td align="center">
						phone
					</td>
					<td >
					<select name="userPhone1" id="userPhone1">
						<c:forEach items="${codeList}" var="codeList">
							<option value="${codeList.codeId}">${codeList.codeName}</option>						
						</c:forEach>
					</select>
					-
					<input type="text" name="userPhone2" id="userPhone2" style="width: 40px" maxlength="4"
					oninput="this.value = this.value.replace(/[^0-9]/g, '')">
					-
					<input type="text" name="userPhone3" id="userPhone3" style="width: 40px" maxlength="4"
					oninput="this.value = this.value.replace(/[^0-9]/g, '')">
					</td>
				</tr>

				<tr>
					<td align="center">
						postNo
					</td>
					<td >
					<input type="text" name="userAddr1" id="userAddr1" placeholder="xxx-xxx" maxlength="7"
					oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{3})(\d{3})$/, '$1-$2');">
					</td>
				</tr>

				<tr >
					<td align="center" align="center">
						address
					</td>
					<td>
					<input type="text" name="userAddr2" id="userAddr2" maxlength="50">
					</td>
				</tr>

				<tr >
					<td align="center">
						company
					</td>
					<td>
					<input type="text" name="userCompany" id="userCompany" maxlength="20">
					</td>
				</tr>

			</table>
		</td>
	</tr>
	
	<tr>
		<td align="right">
			<a id="formSubmit" name="formSubmit">join</a>
		</td>
	</tr>
</table>
</body>
</html>