<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>성신여자대학교 분반교환시스템</title>
<script>
	function doLogin() {
		
		if(document.formLogin.email.value.length == 0) { 
	      alert("이메일을 입력하세요."); 
	      document.formLogin.email.focus();
	      return;
	    } 
		
		var filter = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		if (filter.test(document.formLogin.email.value)!=true){
		  alert('이메일 형식이 올바르지 않습니다.');
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
	
	function verify() {
		if(document.registerForm.stu_no.value.length == 0) { 
		      alert("학번을 입력하세요."); 
		      document.registerForm.stu_no.focus();
		      return;
		}
		if(isNaN(document.registerForm.stu_no.value)) { 
		      alert("학번은 숫자로만 입력해주세요."); 
		      document.registerForm.stu_no.focus();
		      return;
		}
		
		document.registerForm.target='_self';
		document.registerForm.action='doVerify';
		document.registerForm.submit();
	}
	
	function doRegister() {
		if(document.registerForm.email.value.length == 0) { 
		      alert("이메일을 입력하세요."); 
		      document.registerForm.email.focus();
		      return;
		}
		var filter = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		if (filter.test(document.registerForm.email.value)!=true) {
			  alert('이메일 형식이 올바르지 않습니다.');
			  document.registerForm.email.focus();
			  return;
		}
		if(document.registerForm.stu_no.value.length == 0) { 
		      alert("학번을 입력하세요."); 
		      document.registerForm.stu_no.focus();
		      return;
		}
		if(isNaN(document.registerForm.stu_no.value)) { 
		      alert("학번은 숫자로만 입력해주세요."); 
		      document.registerForm.stu_no.focus();
		      return;
		}
		
		if(document.registerForm.name.value.length==0){
			alert('이름을 입력해 주세요.');
			document.registerForm.name.focus();
			return;
		}
	
		if(document.registerForm.phone1.value.length==0|document.registerForm.phone2.value.length==0|document.registerForm.phone3.value.length==0){
			alert('연락처를 입력해 주세요.');
			document.registerForm.phone1.focus();
			return;
		}
		
		if(isNaN(document.registerForm.phone1.value)|isNaN(document.registerForm.phone2.value)|isNaN(document.registerForm.phone3.value)){
			alert('연락처는 숫자만 입력 가능합니다.');
			document.registerForm.phone1.focus();
			return;
		}
		
		if(document.registerForm.major.value.length==0){
			alert('학과를 입력해 주세요.');
			document.registerForm.major.focus();
			return;
		}
		document.registerForm.target='_self';
		document.registerForm.action='doRegister';
		document.registerForm.submit();
	}
</script>
<style>	
	html,body {height:100%; margin:0px; padding:0px; font-size:0.9em;}
	
	div.top {display:table; width:100%; height:22%; margin:0px; }
	div.topcell {display:table-cell; width:100%; margin:0px; vertical-align:middle;}
	table#login {width:400px; text-align:center; padding:40px 40px 40px 15px; }
	div.logo {display:inline-block; margin:0px 15px 0px 0px; float:right;}
	
	div.bottom {display:table; width:100%; height:78%; background-color:#e7e7f7; margin:0px; text-align: right; padding-right: 10px;}
	div.bottomcell {display:table-cell; width:100%; vertical-align:middle; text-align:center;}
	div.find {display:inline-block; width:450px; height:450px; background-color:white; margin:15px; border:solid 1px gray; border-radius:15px;}
	
</style>
</head>
<body>
	<div class="top">
		<div class="topcell">
			<form method="post" name="formLogin" style="display:inline-block;">
				<table id="login">
						<tr>
							<td>이   메   일: <input type="email" name="email" size="20" tabindex="1"></td>
							<td rowspan=2><input type="button" id="login" value="로그인" onClick="doLogin()" tabindex="3"></td>
						</tr>
						<tr>
							<td>비밀번호: <input type="password" name="passwd" tabindex="2"></td>
						</tr>			 
						<tr>
							<td><a href="./findEmailPW.html">아이디/비밀번호찾기</a></td>
							<td><a href="./register.html">회원가입</a></td>
						</tr>
				</table>
			</form>
			<div class="logo">
				<table>
					<tr>
						<td style="width:34%; valign:middle;"><a href="./main.html"><img src="./image/img_symbol.png" width="100%"></a></td>
						<td style="valign:middle; text-align:center"><a href="./main.html">
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
			<div class="find">
			<div style="position:relative; top:25%; text-align:left; padding:0px 30px;">
				<form method="post" name="registerForm">
					<table>
						<tr>
						<td>학번:</td>
						<td><input type="text" name="stu_no" size="8"> <input type="button" value="중복확인" onClick="verify()"></td>
						</tr>
						<tr>
						<td>이메일:</td>
						<td><input type="email" name="email"><br></td>
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
						<td><input type="text" name="name"></td>
						</tr>
						<tr>
						<td>학과:</td>
						<td>
						<select name="major">
							<option value="none" >----------------------</option>
						 	<option value="국어국문학과" >국어국문학과</option>
				            <option value="영어영문학과" >영어영문학과</option>
				            <option value="독어독문학과" >독어독문학과</option>
				            <option value="불어불문학과" >불어불문학과</option>
				            <option value="일어일문학과" >일어일문학과</option>
				            <option value="중어중문학과" >중어중문학과</option>
				            <option value="사학과" >사학과</option>
				            <option value="정치외교학과" >정치외교학과</option>
				            <option value="심리학과" >심리학과</option>
				            <option value="지리학과" >지리학과</option>
				            <option value="경제학과" >경제학과</option>
				            <option value="경영학과" >경영학과</option>
				            <option value="미디어커뮤니케이션학과" >미디어커뮤니케이션학과</option>
				            <option value="융합보안학과" >융합보안학과</option>
				            <option value="법학과" >법학과</option>
				            <option value="수학과" >수학과</option>
				            <option value="통계학과">통계학과</option>
				            <option value="생명과학ㆍ화학부" >생명과학ㆍ화학부</option>
				            <option value="IT학부" >IT학부</option>
				            <option value="청정융합과학과" >청정융합과학과</option>
				            <option value="의류학과" >의류학과</option>
				            <option value="식품영양학과" >식품영양학과</option>
				            <option value="생활문화소비자학과" >생활문화소비자학과</option>
				            <option value="사회복지학과" >사회복지학과</option>
				            <option value="스포츠레저학과" >스포츠레저학과</option>
				            <option value="운동재활복지학과" >운동재활복지학과</option>
				            <option value="간호학과" >간호학과</option>
				            <option value="글로벌의과학과" >글로벌의과학과</option>
				            <option value="교육학과" >교육학과</option>
				            <option value="사회교육과" >사회교육과</option>
				            <option value="윤리교육과" >윤리교육과</option>
				            <option value="한문교육과" >한문교육과</option>
				            <option value="유아교육과" >유아교육과</option>
				            <option value="동양화과" >동양화과</option>
				            <option value="서양화과" >서양화과</option>
				            <option value="조소과" >조소과</option>
				            <option value="공예과" >공예과</option>
				            <option value="산업디자인과" >산업디자인과</option>
				            <option value="성악과" >성악과</option>
				            <option value="기악과" >기악과</option>
				            <option value="작곡과" >작곡과</option>
				            <option value="문화예술경영학과" >문화예술경영학과</option>
				            <option value="미디어영상연기학과" >미디어영상연기학과</option>
				            <option value="현대실용음악학과" >현대실용음악학과</option>
				            <option value="무용예술학과" >무용예술학과</option>
				            <option value="메이크업디자인학과" >메이크업디자인학과</option>
				            <option value="인문과학대학" >인문과학대학</option>
				            <option value="생활과학대학" >생활과학대학</option>
				            <option value="미술대학" >미술대학</option>
				            <option value="융합문화예술대학" >융합문화예술대학</option>
						</select>
						</td>
						</tr>
						<tr>
						<td>연락처:</td>
						<td><input type="text" size="3" maxlength="3" name="phone1">-
						<input type="text" size="4" maxlength="4" name="phone2">-
						<input type="text" size="4" maxlength="4" name="phone3"></td>
						</tr>
					</table>
					<br>
					<br>
					<div style="display:inline; float:right">
						<input type="button" value="회원가입" onclick="doRegister()"> 
						<input type="reset" value="모두 지우기" >
					</div>
				</form>
			</div>
			</div>
		</div>
	</div>
</body>
</html>