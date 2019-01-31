<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.DBUtil" %>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
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

<script>
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
	
	function dowithdraw() {
		if (confirm('정말로 탈퇴하시겠습니까? TT')) {
			location.href='deleteUser';
		} else {
			alert ('감사합니다. 더 좋은 서비스로 보답하겠습니다!'); location.href="checkPW.jsp";
		}
	}
	
	function doUpdate() {
		if(document.updateForm.name.value.length==0){
			alert('이름을 입력해 주세요.');
			document.updateForm.name.focus();
			return;
		}
		
		if(document.updateForm.major.value.length==0){
			alert('학과를 입력해 주세요.');
			document.updateForm.major.focus();
			return;
		}
	
		if(document.updateForm.phone.value.length==0){
			alert('연락처를 입력해 주세요.');
			document.updateForm.phone.focus();
			return;
		}
		
		if(isNaN(document.updateForm.phone.value)){
			alert('연락처는 숫자만 입력 가능합니다.');
			document.updateForm.phone.focus();
			return;
		}
		
		if (document.updateForm.passwd.value.length == 0){
			alert('비밀번호를 입력해주세요.');
			document.updateForm.passwd.focus();
			return;
		}
			
		if (document.updateForm.re_passwd.value.length==0){
			alert('비밀번호를 입력해주세요.');
			document.updateForm.re_passwd.focus();
			return;
		}
		
		if (document.updateForm.passwd.value!=document.updateForm.re_passwd.value) {
			alert('두 비밀번호가 서로 다릅니다.');
			document.updateForm.passwd.focus();
			return;
		}
		
		document.updateForm.target = '_self';
		//입력된 정보로 업데이트 시키기. 업데이트 후에는 로그아웃.
		document.updateForm.action = 'doUpdate';
		document.updateForm.submit();
	}
</script>
<!--로그인 후 세션이 있어야 접근 가능 -->		
<% if (session.getAttribute("mode")==null) {%>
	<script>
	alert('잘못된 접근입니다. 올바른 로그인 후 이용해주세요.');location.href='main.html'
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
	String email = "";
	String phone= "";
	String passwd="";
	
	major =String.valueOf(session.getAttribute("major"));
	stu_no =String.valueOf(session.getAttribute("stu_no"));
	name =String.valueOf(session.getAttribute("name"));
	if (mode != "admin") {
		welcomeMsg = major+" "+stu_no+"<br>"+name+"님 로그인 중입니다.";
	} else {
		welcomeMsg = "<font color=\"red\">관리자모드로<br>로그인 중입니다.</font>";
	}
	
	ServletContext sc = getServletContext();
	Connection conn = (Connection) sc.getAttribute("DBconnection");
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
						<td><a href="myPage.jsp"><h2>수강<br>과목<br>등록</h2></a></td>
						<td class="selected"><h2>내<br>정보<br>변경</h2></td>
					</tr>
				</table>
			<%if (mode != "admin") { 
				ResultSet rs = DBUtil.isExist(conn, String.valueOf(session.getAttribute("stu_no")));
	
				if (rs!=null){
					if (rs.next()) {
						email = rs.getString(1);
						passwd = rs.getString(2);
						phone = rs.getString(6);
					}
				}
				
			%>
				<form method="post" name="updateForm">
				수정할 내용으로 재입력 후 수정 버튼을 누르세요.<br><br><br>
					<table>
						<tr>
						<td>이메일:</td>
						<td><input type="email" name="email" value="<%=email%>" disabled="true"><br></td>
						</tr>
						<tr>
						<td>비밀번호:</td>
						<td><input type="password" name="passwd"></td>
						</tr>
						<tr>
						<td>비밀번호 확인:</td>
						<td><input type="password" name="re_passwd"></td>
						</tr>
						<tr>
						<td>이름:</td>
						<td><input type="text" name="name" value="<%=name%>"></td>
						</tr>
						<tr>
						<td>학과:</td>
						<td>
						<input type="text" name="major" value="<%=major%>">
						</td>
						</tr>
						<tr>
						<td>학번:</td>
						<td><input type="text" name="stu_no" size="8" value="<%=stu_no%>" disabled="true"></td>
						</tr>
						<tr>
						<td>연락처:</td>
						<td><input type="text" name="phone" value="<%=phone%>"></td>
						</tr>
					</table>
					<br><br>
					<div style="display:inline; float:right">
						<input type="button" value="수정하기" onclick="doUpdate()">
					</div>
				</form>
				<hr>
				회원탈퇴를 원하시나요?
				<input type="button" value="회원탈퇴" onclick="dowithdraw()" style="float:right">
			<%} else { %>
				<form>
				</form>
			<%} %>
			</div>
		</div>
	</div>

</body>
</html>
