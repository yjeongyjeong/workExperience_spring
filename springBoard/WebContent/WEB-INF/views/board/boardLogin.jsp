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

		
		$j(document).ready(function(){
		    $j("#formSubmit").on("click",function(){

		    	var frm = $j('#boardTable');  // jQuery로 선택된 문서 객체로 변경

		        //아이디 확인
				if ($j('#userId').val().length == 0) {
					alert("아이디를 입력해주세요.");
					$j('#userId').focus;
					return false;
				} 
				
				//비밀번호 확인
				else if ($j('#userPw').val().length == 0) {
					alert("비밀번호를 입력하세요.")
					$j('#userPw').focus();
					return false;
				}
	
				var frm = $j('.boardTable :input');
				var param = frm.serialize(); 

				console.log("*************************");
				console.log(frm);
				console.log(param);
/*				
				var userData = [];
				
				var userId = $j('#userId').val();
				var userPw = $j('#userPw').val();
				
				const userVo = {
						"userId": userId
						,"userPw": userPw
				};
				
				userData.push(userVo);
				console.log(userVo);
 */				
				$j.ajax({
				    url : "/board/boardUserLoginAction.do",
				    dataType: "json",
				    type: "POST",
				    //contentType: "application/json; charset=utf-8",
				    data : param,
				    success: function(data, textStatus, jqXHR)
				    {
				    	console.log(data);

				    	if(data == 0){ //select 검색 결과가 0인 경우
				    		console.log(data);
				    		alert("아이디 혹은 비밀번호가 일치하지 않습니다.");
				    	}else{
							location.href = "/board/boardList.do?pageNo=1";
				    	}
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
					oninput="this.value = this.value.replace(/[^a-z0-9]/g, '')" >
					</td>
				</tr>

				<tr>
					<td align="center">
						pw
					</td>
					<td>
					<input type="password" name="userPw" id="userPw" maxlength="16">
					</td>
				</tr>

			</table>
		</td>
	</tr>
	
	<tr>
		<td align="right">
			<a id="formSubmit" name="formSubmit">login</a>
		</td>
	</tr>
</table>
</body>
</html>