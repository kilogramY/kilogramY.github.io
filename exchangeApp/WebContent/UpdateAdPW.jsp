<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>성신여자대학교 분반교환시스템</title>
<script>
	function doLogin() {
		
		if(document.formLogin.email.value.length == 0) { 
	      alert("이메일을 입력하세요."); 
	      document.formLogin.email.focus();
	      return;
	    } 
		
		if(document.formLogin.passwd.value.length == 0) { 
	      alert("패스워드를 입력하세요."); 
	      document.formLogin.passwd.focus();
	      return;
	    }
		
		document.formLogin.target='_self';
		document.formLogin.action='main.jsp';
		document.formLogin.submit();
	}
	
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
<style>	
	html,body {height:100%; margin:0px; padding:0px; font-size:0.9em;}
	div.top {display:table; width:100%; height:22%; margin:0px; }
	div.topcell {display:table-cell; width:100%; margin:0px; vertical-align:middle;}
	table.login {width:400px; padding:40px 40px 40px 15px;}
	div.logo {display:inline-block; margin:0px 15px 0px 0px; float:right;}
	
	div.bottom {display:table; width:100%; height:78%; background-color:#e7e7f7; margin:0px; text-align: right; padding-right: 10px;}
	div.bottomcell {display:table-cell; width:100%; vertical-align:middle; text-align:center;}
	div.contentTitle {font-size:2em; color:white; background-color:purple; display:inline; padding:8px 15px; position:relative; left:-400px;}
	div.box {display:inline-block; width:450px; height:450px; background-color:white; margin:15px; border:solid 1px gray; border-radius:15px;}
	
	.timetable{width:860px; height:450px; background-color:white;}
</style>
</head>
<%
	//로그인해서 세션이 있어야 main.jsp접근 가능
	if (session.getAttribute("mode")==null) {%>
		<!-- 세션유무에 따라 스크립트 실행,무시 -->
		<script>
			alert('잘못된 접근입니다.\n로그인 후 이용해주세요.'); location.href='main.html';
		</script>
<%	}
	
	
	//로그인 후 보여줄 정보 담을 String 객체 생성
	String mode = String.valueOf(session.getAttribute("mode"));
	String major="";
	String stu_no="";
	String name="";
	String passwd="";
	String welcomeMsg = "";
	String display = "";
	
	if (mode != "admin") {
		//학생이 로그인 했을때 세션에서 값 받아옴
		major =String.valueOf(session.getAttribute("major"));
		stu_no =String.valueOf(session.getAttribute("stu_no"));
		name =String.valueOf(session.getAttribute("name"));
		welcomeMsg = major+" "+stu_no+"<br>"+name+"님 로그인 중입니다.";%>
		
		<style>
			div#admin {display:none;}
		</style>
<%} else {
		welcomeMsg = "<font color=\"red\">관리자모드로<br>로그인 중입니다.</font>"; //정보 안받아오고 관리자 메세지 띄움
		display="style=\"display:none;\"";
		
		//관리자의 비밀번호가 초기 비밀번호 1234인 경우
		passwd=String.valueOf(session.getAttribute("passwd"));
				
		
		%>
		<style>
			div#student {display:none;}
		</style>
		<%
	}
%>
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
			<div class="box">
				<div style="position:relative; top:27%; text-align:left; padding:0px 30px;">
				<h2>[관리자 비밀번호 변경페이지입니다.]</h2><br><br>
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
						<input type="text" name="email" value="admin@sungshin.ac.kr" style="display:none;">
						<br><br>
						<input type="button" value="변경완료" onclick="updatePasswd()" style="float:right;">
					</form>
				</div>
			</div>
		</div>
	</div>	
</body>
</html>