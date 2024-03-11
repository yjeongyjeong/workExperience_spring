<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
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

	function idChk(){
		var userId = $j('#userId').val();
		var checkIdResult = "";
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
			    	alert(userIdCnt);
			    	
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

	function pwChk(){
		var userPw = $j('#userPw').val();
		var userPwChk = $j('#userPwChk').val();
		var checkPwResult = "";
		
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
			    	alert(userPwCnt);
			    	
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

		function handleOnInput(el, maxlength) {
			if (el.value.length > maxlength) {
				el.value = el.value.substr(0, maxlength);
			};
		};
		
		function formCheck(){
			var regId = /^[a-zA-Z0-9]{6,10}$/;
			var regIdPw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,12}$/;
			var form = document.frm;
			
			//아이디 확인
			if (document.frm.userId.value.length == 0) {
				alert("아이디를 입력해주세요.");
				document.frm.userId.focus;
				return false;
			} else if (!regId.test(document.frm.userId.value)) { //아이디 영어 대소문자 확인
				alert("6~10자 영문 대소문자, 숫자만 입력해주세요.")
				userId.focus();
				return false;
			} else if (!idChk()) {
				alert("아이디를 다시 확인해주세요.");
				return false;
			}
			
			//비밀번호 확인
			else if (document.frm.userPw.value.length == 0) {
				alert("비밀번호를 입력하세요.")
				userPw.focus();
				return false;
			} else if (!regIdPw.test(document.frm.userPw.value)) {
				alert("6~10자 영문 대소문자, 숫자, 특수문자를 입력해주세요.")
				userPw.focus();
				return false;
			} else if (document.frm.userPw.value == document.frm.userId.value) {
				alert("아이디와 동일한 비밀번호를 사용할 수 없습니다.")
				userPw.focus();
				return false;
			} else if (!checkPw()) {
				alert("비밀번호를 다시 확인해주세요.");
				return false;
			}else if (document.frm.userPhone1.value.length == 0) {
				alert("휴대전화번호를 다시 확인해주세요.")
				document.frm.userPhone1.focus;
				return false;
			} else if (document.frm.userPhone2.value.length == 0
					|| document.frm.userPhone2.value.length < 4) {
				alert("휴대전화번호 가운데 자리를 다시 확인해주세요(4글자).")
				document.frm.userPhone2.focus;
				return false;
			} else if (document.frm.userPhone3.value.length == 0
					|| document.frm.userPhone3.value.length < 4) {
				alert("휴대전화번호 마지막 자리를 다시 확인해주세요(4글자).")
				document.frm.userPhone3.focus;
				return false;
			} else if (document.frm.userAddr1.value.length == 0) {
				alert("우편번호를 다시 확인해주세요.")
				document.frm.userAddr1.focus;
				return false;
			} else if (document.frm.userAddr2.value.length == 0) {
				alert("주소를 다시 확인해주세요.")
				document.frm.userAddr2.focus;
				return false;
			}
			//disabled="disabled"
			submitButton.disabled = 'disable';
			//spinner.type = 'text';

			form.submit();
		}

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
			<table id="boardTable" border = "1">
				<tr>
					<td width="120" align="center">
						id
					</td>
					<td width="300">
					<input type="text" id="userId" name="userId" maxlength="5">
					<button id="idChk" onclick="return idChk()">Duplicate Check</button>
					</td>
				</tr>

				<tr>
					<td align="center">
						pw
					</td>
					<td>
					<input type="password" name="userPw" id="userPw" maxlength="12" >
					</td>
				</tr>

				<tr>
					<td align="center">
						pw check
					</td>
					<td>
					<input type="password" name="userPwChk" id="userPwChk" maxlength="12" onchange="return pwChk()" >
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
					<input type="text" name="userName">
					</td>
				</tr>

				<tr>
					<td align="center">
						phone
					</td>
					<td >
					<select name="userPhone1">
						<c:forEach items="${codeList}" var="codeList">
							<option value="${codeList.codeId}">${codeList.codeName}</option>						
						</c:forEach>
					</select>
					<input type="text" name="userPhone2" style="width: 40px" maxlength="4"
					oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1')">
					-
					<input type="text" name="userPhone3" style="width: 40px" maxlength="4"
					oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1')">
					</td>
				</tr>

				<tr>
					<td align="center">
						postNo
					</td>
					<td >
					<input type="text" name="userAddr1">
					</td>
				</tr>

				<tr >
					<td align="center" align="center">
						address
					</td>
					<td>
					<input type="text" name="userAddr2">
					</td>
				</tr>

				<tr >
					<td align="center">
						company
					</td>
					<td>
					<input type="text" name="userCompany">
					</td>
				</tr>

			</table>
		</td>
	</tr>
	
	<tr>
		<td align="right">
			<a href ="/board/boardWrite.do">join</a>
		</td>
	</tr>
</table>
</body>
</html>