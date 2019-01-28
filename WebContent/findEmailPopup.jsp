<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
 
<html>
<head>
<meta charset="UTF-8">
<TITLE>성신여자대학교 분반 교환 시스템</TITLE>
<style>
	body{
		height:100%;width:100%;text-align:center;
	}
	table {
		clear:both;height:151px; width:500px; border:2px solid #b4aec5;
	}
	td{
		font-family:"굴림", "굴림체", "Arial", "Verdana"; 
		font-size:12px;
		background-color:#fff;
	}
	div#form{
		display:inline-block;
	}
	div#viewResult{
		clear:both; width:500px; border:2px solid #b4aec5; display:inline-block; font-size:12px; padding:10px 0px;
	}
</style>

<script language="javascript">
	function doFindEmail(){
		if(document.form1.uname.value.length==0){
			alert('이름을 입력해 주세요.');
			document.form1.uname.focus();
			return;
		}
	
		if(document.form1.phone1.value.length==0|document.form1.phone2.value.length==0|document.form1.phone3.value.length==0){
			alert('연락처를 입력해 주세요.');
			document.form1.phone1.focus();
			return;
		}
		
		if(isNaN(document.form1.phone1.value)|isNaN(document.form1.phone2.value)|isNaN(document.form1.phone3.value)){
			alert('연락처는 숫자만 입력 가능합니다.');
			document.form1.phone1.focus();
			return;
		}
	
		document.form1.target = '_self';
		document.form1.action = 'findEmail';
		document.form1.submit();
		
	}
	
</script>
</head>
<body>
<div style="margin-top:20px;"><b>[가입한 이메일 주소 찾기]</b></div><br>
<div id="form">
	<form name="form1" method="post">
		<div>
			<table>
				<tr>
					<td><label for="이름">이름</label></td>
					<td><input type="text" name="uname" title="이름" tabindex="1"></td>
					<td rowspan="2"><input type="button" name="search" value="찾기" onclick="doFindEmail(); return false;"/></td>
				</tr>
				<tr>
					<td><label for="연락처">연락처</label></td>
					<td>
						<input type="text" size="3" maxlength="3" name="phone1" title="연락처" tabindex="2"> - 
						<input type="text" size="4" maxlength="4" name="phone2" tabindex="3"> - 
						<input type="text" size="4" maxlength="4" name="phone3" tabindex="4">
					</td>
					<td></td>
				</tr>
			</table>
		</div>
	</form>
</div>
<br><br><br>
<%String result = (String)request.getAttribute("result");
if (result!=null) {
	if (result=="invalid") {%>							
			<div id="viewResult"><b>등록되지 않은 회원정보입니다.</b></div>
	<%} else{%>
		<div id="viewResult">가입하신 이메일 주소는 <font color="blue"><b>[<%=result %>]</b></font>입니다.</div>
	<%}
}%>
<br><br>
<div><input type="button" value="닫기" onclick="self.close();"></div><br>

</body>
</html>
