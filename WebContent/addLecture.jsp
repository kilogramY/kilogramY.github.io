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
	
	function doAdd(){
		document.lectureInfo.target='_self';
		document.lectureInfo.action='addLecture';
		document.lectureInfo.submit();
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
	div.content {display:inline-block; margin:15px; text-align:left;}
	
	.content td {padding:0px 15px; color:purple; background-color:white;}
	td.selected {color:white; background-color:purple;}
	form {padding:25px 25px 50px 25px; background-color:white;}
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
				
		if (passwd.equals("1234")) {%>
			<script>
				alert('초기 비밀번호와 같은 비밀번호는 사용할 수 없습니다.\n비밀번호를 변경해야합니다.');
				location.href='./UpdateAdPW.jsp';
			</script>
			
		<%}
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
			<div class="content">
				<table>
					<tr>
						<td class="selected"><h2>강의<br>추가</h2></td>
						<td><a href="removeLecture.jsp"><h2>강의<br>삭제</h2></a></td>
						<td><a href="editLecture.jsp"><h2>강의<br>수정</h2></a></td>
					</tr>
				</table>
				<form name="lectureInfo" method="post">
					전공 : <select name="major">
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
					학수번호: <input type="text" name="lecNo" size="10"><br><br>
					강의명: <input type="text" name="lecName"><br><br>
					분반: <input type="number" min=01 max=09 name="classNo"><br><br>
					교수명: <input type="text" name="professor"><br><br>
					요일: 
					<select name="day">
						<option value="월">월</option>
						<option value="화">화</option>
						<option value="수">수</option>
						<option value="목">목</option>
						<option value="금">금</option>
					</select><br><br>
					교시: <input type="text" name="time" size="10"> ex) x,x,x<br><br>
					캠퍼스: 
					<select name="campus">
						<option value="수정">수정</option>
						<option value="운정">운정</option>
					</select><br><br>
					강의실: 
					<select name="building">
						<option value="수정관">수정</option>
						<option value="성신관">성신</option>
						<option value="난향관">난향</option>
						<option value="미정관">미정</option>
					</select>관
					<input type="text" name="classroom">호<br><br>
					<div style="display:inline; float:right">
						<input type="button" value="추가하기" onclick="doAdd()"> 
						<input type="reset" value="모두 지우기" >
					</div>
				</form>
			</div>
		</div>
	</div>	
</body>
</html>