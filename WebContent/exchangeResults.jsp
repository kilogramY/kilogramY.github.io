<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
 
<html>
<head>
<meta charset="UTF-8">
<TITLE>성신여자대학교 분반교환 시스템</TITLE>
<style>
	html,body {height:100%; margin:0px; padding:0px; font-size:0.9em;}
	div.top {display:table; width:100%; height:22%; margin:0px; }
	div.topcell {display:table-cell; width:100%; margin:0px; vertical-align:middle;}
	table.login {width:400px; padding:40px 40px 40px 15px;}
	div.logo {display:inline-block; margin:0px 15px 0px 0px; float:right;}
	
	div.bottom {display:table; width:100%; height:78%; background-color:#e7e7f7; margin:0px; text-align: right; padding-right: 10px;}
	div.bottomcell {display:table-cell; width:100%; vertical-align:middle; text-align:center;}
	div.contentTitle {font-size:2em; color:white; background-color:purple; display:inline; padding:8px 15px; position:relative; left:-400px;}
	div.content {display:inline-block; margin:15px; text-align:left;}
	
	.content td {padding:0px 15px; color:purple; background-color:white;}
	td.selected {color:white; background-color:purple;}
	form {padding:25px 25px 50px 25px; background-color:white;}
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
	
	function doCheck() {
		if(document.checkPWForm.passwd.value.length==0){
			alert('비밀번호를 입력해 주세요.');
			document.checkPWForm.passwd.focus();
			return;
		}
		
		document.checkPWForm.target = '_self';
		document.checkPWForm.action = 'checkAndGo';
		document.checkPWForm.submit();
	}
	
</script>
<%
	//로그인 후 보여줄 정보 담을 String 객체 생성
	String mode = String.valueOf(session.getAttribute("mode"));
	String major="";
	String stu_no="";
	String name="";
	String upasswd="";
	String welcomeMsg = "";
	String display = "";
	
	major =String.valueOf(session.getAttribute("major"));
	stu_no =String.valueOf(session.getAttribute("stu_no"));
	name =String.valueOf(session.getAttribute("name"));
	if (mode != "admin") {
		welcomeMsg = major+" "+stu_no+"<br>"+name+"님 로그인 중입니다.";
	} else {
		welcomeMsg = "<font color=\"red\">관리자모드로<br>로그인 중입니다.</font>";
	}

%>
</head>
<body>
<div class="top">
		<div class="topcell">
			<form method="post" name="formLogin" style="display:inline-block;" action="doLogout">
				<table class="login">
						<tr>
							<td><img src="./image/user_img.png"></td>
							<td>
								<%=welcomeMsg %>
							</td>
						</tr>		 
						<tr>
							<td><input type="button" value="마이페이지" <%=display %>></td>
							<td><input type="submit" value="로그아웃"></td>
						</tr>
				</table>
			</form>
			<div class="logo">
				<table>
					<tr>
						<td style="width:34%; valign:middle;"><a href="./main.jsp"><img src="./image/img_symbol.png" width="100%"></a></td>
						<td style="valign:middle; text-align:center"><a href="./main.jsp">
						<h2>성 신 여 자 대 학 교<br>
						분 반 교 환 시 스 템<br>
						SungShin W Univ.<br>
						Class Exchange System</h2>
						</a></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div class="bottom">
		<div class="bottomcell">
			<div class="contentTitle"><b>마이페이지</b></div><br><br>
			<div class="content">
				<table>
					<tr>
						<td class="selected"><h2>변경<br>이력<br>확인</h2></td>
						<td><a href="myPage.jsp"><h2>수강<br>과목<br>등록</h2></a></td>
						<td><a href="updateInfo.jsp"><h2>내<br>정보<br>변경</h2></a></td>
					</tr>
				</table>
				<form method="post" name="checkPWForm">
				회원 정보 변경을 위해 비밀번호를 한번 더 입력해주세요.<br><br><br>
					비밀번호 : <input type="password" name="passwd">
					<input type="button" value="확인" onclick="doCheck()">
				</form>
			</div>
		</div>
	</div>

</body>
</html>
