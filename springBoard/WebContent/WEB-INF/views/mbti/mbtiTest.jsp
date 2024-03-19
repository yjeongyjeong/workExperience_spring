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
	 $j("#next").on("click", function(e){
		 
		 var mbtiTypes = $j("input:radio:checked");
		 
		 var resultList = [];
		 
		 mbtiTypes.each(function() {
	            var name = $j(this).attr('name');
	            var value = $j(this).val();
	            resultList.push(name+'_'+value);
		 });
		 
		console.log("resultList >> " + resultList);
       
		  $j.ajax({
			    url : "/mbti/mbtiResultAction.do",
			    dataType: "text",
			    type: "POST",
			    contentType: "application/json; charset=utf-8",
			    data : JSON.stringify(resultList),
//			    data : resultList,
			    success: function(data)
			    {
			    	console.log(data);
					
			    	if(data <= 4){ //pageNo=4까지
			    		location.href = 'http://localhost:8081/mbti/mbtiTest.do?pageNo='+data;
					}
			    	else { //pageNo=5 되는 순간
                        console.log(data);		
			    	
                        var mbtiArray = ["J", "P", "E", "T", "F", "N", "S", "I"];
                        for (var i = 0; i < mbtiArray.length; i++) {
                            var pattern = new RegExp(mbtiArray[i], "gi");
                            var matches = data.match(pattern);
                            var count = matches ? matches.length : 0;
                            console.log("Count of '" + mbtiArray[i] + "': " + count);
                        }

					}
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			});
//		  }
		
		});
	}); 
		
</script>

<body>
<table  align="center" id="wrapTable">
	
	<c:forEach items="${mbtiList}" var="list">
		<tr id="mbtiList">
			<td align="center">
			 <fieldset style="text-align: center;" id="mbtiField">
				${list.boardComment}
				<br><br>
					 <span>동의 <input type="radio" value="+3" name="${list.boardType}_${list.boardNum}"> </span>
					<span><input type="radio" value="+2" name="${list.boardType}_${list.boardNum}"> </span>
					<span><input type="radio" value="+1" name="${list.boardType}_${list.boardNum}"> </span>
					<span><input type="radio" value="0" name="${list.boardType}_${list.boardNum}"> </span>
					<span><input type="radio" value="-1" name="${list.boardType}_${list.boardNum}"> </span>
					<span><input type="radio" value="-2" name="${list.boardType}_${list.boardNum}"> </span>
					<span><input type="radio" value="-3" name="${list.boardType}_${list.boardNum}"> 비동의</span>
			</fieldset>
			</td>
		</tr>	
	</c:forEach>
	
	<tr>
		<td align="center">
			<button type="button" id="next" name="next">다음 →</button>
		</td>
	</tr>
</table>
</body>
</html>