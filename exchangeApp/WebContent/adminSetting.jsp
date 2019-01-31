<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="model.DBUtil" %>
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
	div.content {display:inline-block; width:450px; height:450px; background-color:white; margin:15px; border:solid 1px gray; border-radius:15px;}
	
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
	
	function dosetting() {
		var start = document.settingForm.start.value;
		var end = document.settingForm.end.value;
		
		location.href='setServicePeriod?start='+start+'&end='+end;
	}
</script>

<!--로그인 후 세션이 있어야 접근 가능 -->		
<% if (session.getAttribute("mode")==null) {%>
	<script>
	alert('잘못된 접근입니다. 올바른 로그인 후 이용해주세요.');location.href='main.html';
	</script>
<%}
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
		display="style=\"display:none;\"";
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
			<div class="contentTitle"><b>시스템 설정</b></div><br><br>
			<div class="content">
			<%
			ServletContext sc = getServletContext();
			Connection conn = (Connection) sc.getAttribute("DBconnection");
			ResultSet times = DBUtil.getSettingTime(conn);
			
			String start="";
			String end="";
			if (times.next()) {
				start = times.getString(2);
				end = times.getString(3);
			}
			%>
				<div style="position:relative; top:24%; text-align:left; padding:0px 30px;">
					ㅁ분반 교환 기간 설정
					<form method="get" name="settingForm">
						<table border="1" style="width:100%">
							<tr>
								<th>교환 시작일</th>
								<th>교환 마감일</th>
							</tr>
							<tr>
								<td><input type="text" name="start" value="<%=start%>"></td>
								<td><input type="text" name="end" value="<%=end%>"></td>
							</tr>
						</table><br><br>
						<input type="button" value="설정완료" style="float:right" onclick="dosetting()">
					</form>
					<br><br>
					<hr>
					ㅁ비밀번호 변경하기
					<input type="button" value="비밀번호 변경" onclick="location.href='UpdateAdPW.jsp'" style="float:right">
				</div>
			</div>
		</div>
	</div>

</body>
</html>
