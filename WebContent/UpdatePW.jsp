<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.lang.*" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>성신여자대학교 분반 변경 시스템</title>
<style>
	body{
		height:100%;width:100%;text-align:center;
	}
	table {
		clear:both; width:500px; border:2px solid #b4aec5; padding:20px;
	}
	td{
		font-family:"굴림", "굴림체", "Arial", "Verdana"; 
		font-size:12px;
		background-color:#fff;
	}
	div#error{
		display:inline-block; clear:both; width:500px; border:2px solid #b4aec5; padding:20px;
	}
	div#form{
		display:inline-block;
	}
</style>	
<script>
function updatePasswd() {
	if (document.updatePW.passwd.value.length == 0){
		alert('비밀번호를 입력해주세요.');
		document.updatePW.passwd.focus();
		return;
	}
		
	if (document.updatePW.re_passwd.value.length==0){
		alert('비밀번호를 입력해주세요.');
		document.updatePW.re_passwd.focus();
		return;
	}
	
	if (document.updatePW.passwd.value!=document.updatePW.re_passwd.value) {
		alert('두 비밀번호가 서로 다릅니다.');
		document.updatePW.passwd.focus();
		return;
	}
	
	document.updatePW.target='_self';
	document.updatePW.action='updatePW';
	document.updatePW.submit();

}
</script>
</head>
<body>
<% 
request.setCharacterEncoding("utf-8");

String getTime = (String)request.getParameter("sTime");
String email = (String)request.getParameter("email");

long sTime = Long.parseLong(getTime);
%>
<%if (System.currentTimeMillis()-sTime < 600000) {%>
<div style="margin-top:20px;"><b>[<%=email%> 계정의 비밀번호 변경페이지]</b></div><br><br>
<div id="form">
	<form method="post" name="updatePW">
		<table>
			<tr>
				<td> 새 비밀번호 </td>
				<td><input type="password" name="passwd"></td>
			</tr>
			<tr>
				<td> 새 비밀번호 확인 </td>
				<td><input type="password" name="re_passwd"></td>
			</tr>	
		</table>
		<input type="text" name="email" value="<%=email%>" style="display:none;">
		<br><br>
		<input type="button" value="변경완료" onclick="updatePasswd()">
		<input type="button" onclick="self.close();" value="창닫기">
	</form>
	
</div>	<%} else { %>
<font size=7 color="red"><b>ERROR : Time Over</b></font><br><br><br>
<div id="error">
	이 링크는 10분이 지나 만료되었습니다.<br>
	비밀번호 찾기를 처음부터 다시 진행해주세요.<br>
</div>	
<br><br><br>
<input type="button" onclick="location.href='findEmailPW.html';" value="사이트로 이동하기">
<input type="button" onclick="self.close();" value="창닫기">
<% }%>
</body>
</html>