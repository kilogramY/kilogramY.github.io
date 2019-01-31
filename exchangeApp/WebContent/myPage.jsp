<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="model.DBUtil" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.util.ArrayList" %>
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
	
	function doSearch() {
		document.lectureInfo.target='_self';
		document.lectureInfo.action='searchLecture';
		document.lectureInfo.submit();
	}
	
	function addMyLecList() {
		document.lectureInfo.target='_self';
		document.lectureInfo.action='addMyLecList';
		document.lectureInfo.submit();
	}
	
	function removeMyLecList(lecNo) {
		location.href='removeMyLecList?lecNo='
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

	String uEmail = request.getParameter("email");
	String passwd = request.getParameter("passwd");
	
	ServletContext sc = getServletContext();
	Connection conn = (Connection) sc.getAttribute("DBconnection");
	
	ResultSet rs = DBUtil.findUser(conn, uEmail);
	
	if (rs != null) {
		try {
			if(rs.next()) { 
				// existing user
				String checkpw = rs.getString(1);
				
				if (checkpw.equals(passwd)){
					// valid user and passwd
					HttpSession se = request.getSession();
					
					if(uEmail.equals("admin@sungshin.ac.kr")) {
						//관리자 모드로 로그인
						se.setAttribute("mode", "admin");
						se.setAttribute("passwd", passwd);
					} else {
						//사용자 모드로 로그인
						se.setAttribute("mode", "user");
						se.setAttribute("major", rs.getString(2));
						se.setAttribute("stu_no", rs.getString(3));
						se.setAttribute("name", rs.getString(4));
					}
				} else {
					// wrong passwd
					//%>
					<script type='text/javascript'>
						alert('비밀번호를 확인하세요.');location.href='main.html';
					</script>						
			<%	}
			} else if (uEmail != null){
				// invalid user
				%>
				<script type='text/javascript'>
					alert('등록되지 않은 이메일 주소입니다.');location.href='main.html'
				</script>
		<%	}
		} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
		}		
	}%>

<%		//로그인해서 세션이 있어야 접근 가능
			if (session.getAttribute("mode")==null) {%>
				<!-- 이메일 값에 따라 스크립트 실행,무시 -->
		 		<script>
					alert('잘못된 접근입니다.\n올바른 로그인 후 이용해주세요.'); location.href='main.html';
				</script>
		<%	}%>
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
	welcomeMsg = major+" "+stu_no+"<br>"+name+"님 로그인 중입니다.";

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
						<td style="width:34%; valign:middle;"><a href="main.jsp"><img src="./image/img_symbol.png" width="100%"></a></td>
						<td style="valign:middle; text-align:center"><a href="main.jsp">
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
	<%
	ResultSet lecList = DBUtil.getLecture(conn);
	
	ArrayList<String> majorOfLec = new ArrayList<String>();
	ArrayList<String> subject = new ArrayList<String>();
	//ArrayList<String> classNo = new ArrayList<String>();
	
	if (lecList != null) {
		try {
			while (lecList.next()) {
				majorOfLec.add(lecList.getString(1));
			}
		}catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
		}	
	} else {%>
		<div style="display:none">결과값 없음</div>
	<%}%>
	
	<div class="bottom">
		<div class="bottomcell">
			<div class="contentTitle"><b>마이페이지</b></div><br><br>
			<div class="content">
				<table>
					<tr>
						<td class="selected"><h2>수강<br>과목<br>등록</h2></td>
						<td><h2><a href="checkPW.jsp">내<br>정보<br>변경</a></h2></td>
					</tr>
				</table>
				<%
				String smajor = String.valueOf(request.getAttribute("major"));
				String lecNo = String.valueOf(request.getAttribute("lecNo"));
				String lecName = String.valueOf(request.getAttribute("lecName"));
				String classNo = String.valueOf(request.getAttribute("classNo"));
				String day = String.valueOf(request.getAttribute("day"));
				String time = String.valueOf(request.getAttribute("time"));
				String professor = String.valueOf(request.getAttribute("professor"));
				String classroom = String.valueOf(request.getAttribute("classroom"));
				String campus = String.valueOf(request.getAttribute("campus"));
				String flag = String.valueOf(request.getAttribute("flag"));
				
				if (flag != "done") {
					%>
				<form name="lectureInfo" method="post">
					<input type="text" name="from" style="display:none;" value="myPage.jsp">
					*학수번호: <input type="text" name="lecNo" size="10""> 
					*분반: <input type="number" min=01 max=09 name="classNo"> ex) xx
					<div style="display:inline-block; float:right">
						<input type="button" value="검색하기" onclick="doSearch()">
					</div><br><br>
					<hr>
					전공: <input type="text" name="major">
					강의명: <input type="text" name="lecName"><br><br>
					교수명: <input type="text" name="professor">
					요일: 
					<select name="day">
						<option value="월">월</option>
						<option value="화">화</option>
						<option value="수">수</option>
						<option value="목">목</option>
						<option value="금">금</option>
					</select>
					교시: <input type="text" name="time" size="10"> ex) x,x,x
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
						<input type="button" value="수강 목록에 등록하기" onclick="addMyLecList()">
					</div>
				</form>
				<%} else { %>
				<form name="lectureInfo" method="post">
				<input type="text" name="from" style="display:none;" value="myPage.jsp">
					*학수번호: <input type="text" name="lecNo" size="10" value="<%=lecNo%>">
					*분반: <input type="number" min=01 max=09 name="classNo" value="<%=classNo%>">
					<div style="display:inline-block; float:right">
						<input type="button" value="검색하기" onclick="doSearch()">
					</div><br><br>
					<hr>
					전공: <input type="text" name="major" value="<%=smajor%>">
					강의명: <input type="text" name="slecName" value="<%=lecName%>" disabled="true"><br><br>
					교수명: <input type="text" value="<%=professor%>" disabled="true">
					요일: 
					<input type="text" name="sday" value="<%=day%>" disabled="true">
					교시: <input type="text" name="stime" size="10" value="<%=time%>" disabled="true"> ex) x,x,x
					캠퍼스: 
					<input type="text" value="<%=campus%>" disabled="true">
					강의실: 
					<input type="text" value="<%=classroom%>" disabled="true"><br><br>
					<input type="text" name="flag" style="display:none;" value="<%=flag%>">
					<div style="display:inline; float:right">
						<input type="button" value="수강 목록에 등록하기" onclick="addMyLecList()">
					</div>
				</form>
				<%} %>
			<!-- </div>
			<div class="content">-->
			<br>
				<h2><strong>나의 수강목록</strong></h2>
				<table style="width:100%" border="1">
					<tr> 
						<th>학수번호</th>
						<th>과목명</th>
						<th>분반</th>
						<th>요일</th>
						<th>교시</th>
						<th>담당교수</th>
						<th>삭제</th>
					</tr>
				<%
				ResultSet timetable = DBUtil.loadTimetable(conn, stu_no);
				
				if (timetable != null) {
					//학생이 수강과목 등록한경우
					while (timetable.next()) {
						lecNo = timetable.getString(1);
						lecName = timetable.getString(2);
						classNo = timetable.getString(3);
						day = timetable.getString(4);
						time = timetable.getString(5);
						professor = timetable.getString(6);
						
						%>
					<tr> 
						<td><%=lecNo%></td>
						<td><%=lecName%></td>
						<td><%=classNo%></td>
						<td><%=day%></td>
						<td><%=time%></td>
						<td><%=professor%></td>
						<td><input type="button" value="삭제" onclick="location.href='removeMyLecList?lecNo=<%=lecNo%>&classNo=<%=classNo%>'"></td>
					</tr>
			<%		}
				}
				%>
				
					
				</table>
			</div>
		</div>

	</div>
</body>
</html>