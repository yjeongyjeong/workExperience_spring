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
		    $j("#formSubmit").on("click",function(){

		    	console.log($j('#name').val());
		    	console.log($j('#phone').val());
		    	
		    	
		    	var frm = $j('#recruitTable');  // jQuery로 선택된 문서 객체로 변경

		        //아이디 확인
				if ($j('#name').val().length == 0) {
					alert("이름을 입력해주세요.");
					$j('#name').focus();
					return false;
				} 
				
				//비밀번호 확인
				else if ($j('#phone').val().length == 0) {
					alert("휴대폰 번호를 입력해주세요.")
					$j('#phone').focus();
					return false;
				}
				else if ($j('#phone').val().length == 12) {
					alert("휴대폰 번호를 확인해주세요.")
					$j('#phone').focus();
					return false;
				}
	
				var frm = $j('.recruitTable :input');
				var param = frm.serialize(); //name and phone

				console.log("*************************");
				console.log(frm);
				console.log(param);
				$j.ajax({
				    url : "recruitLoginAction.do",
				    //dataType: "json",
				    type: "POST",
				    //contentType: "application/json; charset=utf-8",
				    data : param,
				    success: function(data, textStatus, jqXHR)
				    {
				    	console.log(data); //recruitLoginUser
						location.href = "/recruit/main.do";
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
	<tr>
		<td colspan="2">
			<table id="recruitTable" class="recruitTable" border = "1">
				<tr>
					<td width="120" align="center">
						<strong>이름</strong>
					</td>
					<td width="300">
					<input type="text" name="name" id="name" maxlength="10" placeholder="홍길동"
 					oninput="this.value = this.value.replace(/[^ㄱ-힣]/ig, '')">
					</td>
				</tr>

				<tr>
					<td align="center">
						<strong>휴대폰번호</strong>
					</td>
					<td>
					<input type="text" name="phone" id="phone" maxlength="13" placeholder="xxx-xxxx-xxxx" 
					oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/^(\d{3})(\d{4})(\d{4})$/, '$1-$2-$3');">
					</td>
				</tr>

			</table>
		</td>
	</tr>
	
	<tr>
		<td align="left">
			<button type="button" id="home" name="home" onclick="location.href='/'">HOME</button>
		</td>
		<td align="right">
			<button id="formSubmit" name="formSubmit">입사지원</button>
		</td>
	</tr>
</table>
</body>
</html>