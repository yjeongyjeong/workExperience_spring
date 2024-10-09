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

				$j.ajax({
				    url : "/board/boardUserLoginAction.do",
				    dataType: "json",
				    type: "POST",
				    //contentType: "application/json; charset=utf-8",
				    data : param,
				    success: function(data, textStatus, jqXHR)
				    {
				    	console.log("data >>> "+data);
						location.href = "/board/boardList.do?pageNo=1";
				    },
				    error: function (jqXHR, textStatus, errorThrown, data)
				    {
				    	// select 검색 결과가 0인경우 error 로직을 타게 됨..
				    	console.log(jqXHR);
				    	console.log(textStatus);
				    	console.log(errorThrown);
			    		alert("아이디 혹은 비밀번호가 일치하지 않습니다.");
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
					oninput="this.value = this.value.replace(/[^a-z0-9A-Z]/g, '')" >
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