<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="model.DBUtil" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.Calendar" %>
<%@page import="java.text.SimpleDateFormat" %>
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
	
	function tableColor() {
        document.getElementById("월1,2,3").style.backgroundColor = "green"
    }
	
	function doremove(lecNo,classWants) {
		if (confirm('신청을 취소할까요?')) {
			location.href="removeMatching?lecNo="+lecNo+"&classWants="+classWants;
		} else {
			alert('대기상태를 유지합니다.');
		}
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
	
	.timetable{width:860px; background-color:white;}
	.timetable td{padding:10px;}
	.NN {background-color:#86caf9;}
	
	        .black_overlay{ 
            display: none; 
            position: absolute; 
            top: 0%; 
            left: 0%; 
            width: 100%; 
            height: 1500px; 
            background-color: black; 
            z-index:1001; 
            -moz-opacity: 0.8; 
            opacity:.80; 
            filter: alpha(opacity=80); 
        } 
        .white_content { 
            display: none; 
            position: absolute; 
            top: 25%; 
            left: 25%; 
            width: 50%; 
            height: 50%; 
            padding: 16px; 
            border: 16px solid purple; 
            background-color: white; 
            z-index:1002; 
            overflow: auto; 
        } 
</style>



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
			} else if (uEmail!=null){
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
	} 
%>
<!--로그인 후 세션이 있어야 접근 가능 -->		
<% if (session.getAttribute("mode")==null) {%>
	<script>
	alert('잘못된 접근입니다. 올바른 로그인 후 이용해주세요.');location.href='main.html'
	</script>
<%}
%>
	<%
	//로그인 후 보여줄 정보 담을 String 객체 생성
	String mode = String.valueOf(session.getAttribute("mode"));
	String major="";
	String stu_no="";
	String name="";
	String upasswd="";
	String welcomeMsg = "";
	String display = "";
	String lecNo = "";
	String lecName="";
	String classNo="";
	String day="";
	String time="";
	String professor="";
	int count = 0;
	
	if (mode != "admin") {
		
		ResultSet times = DBUtil.getSettingTime(conn);
		
		String svStart="";
		String svEnd="";
		String[] array; 
		String today="";
		int itoday=0;
		
		if (times.next()) {
			today = times.getString(1);
			itoday = Integer.parseInt(today);
			
			svStart = times.getString(2);
			svEnd = times.getString(3);
			array = svStart.split("-");
			svStart = array[0]+array[1]+array[2];
			array = svEnd.split("-");
			svEnd = array[0]+array[1]+array[2];
		}
		
		System.out.println(itoday+svStart+svEnd);
		if ((itoday < Integer.parseInt(svStart)) | (itoday > Integer.parseInt(svEnd))) {%>
			<script>
			alert('분반 교환 기간이 아닙니다.');location.href='main.html';
			</script>
	<%	} else {
			
		}
		
		//학생이 로그인 했을때 세션에서 값 받아옴
		major =String.valueOf(session.getAttribute("major"));
		stu_no =String.valueOf(session.getAttribute("stu_no"));
		name =String.valueOf(session.getAttribute("name"));
		welcomeMsg = major+" "+stu_no+"<br>"+name+"님 로그인 중입니다.";
		
		
		
		%>
		
		<style>
			div#admin {display:none;}
		</style>
<%} else {
		welcomeMsg = "<font color=\"red\">관리자모드로<br>로그인 중입니다.</font>"; //정보 안받아오고 관리자 메세지 띄움
		display="style=\"display:none;\"";
		
		//관리자의 비밀번호가 초기 비밀번호 1234인 경우
		upasswd=String.valueOf(session.getAttribute("passwd"));
				
		if (upasswd.equals("1234")) {%>
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
							<td><input type="button" value="마이페이지" <%=display %> onclick="location.href='myPage.jsp'"></td>
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
		
	<div class="bottom">
		<div class="bottomcell" id="student">
			<!-- 학생용 Bottom -->
			<div class="contentTitle"><b>내 수강목록</b></div><br><br>
			<h3>흰색으로 표시된 과목은 단일 분반이므로 분반 교환 신청이 불가능합니다.</h3>
			<div style="display:inline-block;">
			
			<%//수강하고있는 과목을 DB에서 가져옴
				ResultSet timetable = DBUtil.loadTimetable(conn, stu_no);
				String flag="";
				String estu_no = String.valueOf(session.getAttribute("stu_no"));
				
				String eclassNo = "";
				String eday = "";
				String etime = "";
				String eprofessor = "";
				String eclassroom = "";
				String ecampus = "";
				
				ResultSet classList=null;
				ResultSet countClass=null;
				int classListsize=-1;
						
				if (timetable != null) {
					//학생이 수강과목 등록한경우
					%>
					<table border="1" class="timetable">
						<tr>
							<th>요일</th>
							<th>시간</th>
							<th>과목명</th>
							<th>분반</th>
						</tr>
					<%
					while (timetable.next()) {
						lecNo = timetable.getString(1);
						lecName = timetable.getString(2);
						classNo = timetable.getString(3);
						day = timetable.getString(4);
						time = timetable.getString(5);
						professor = timetable.getString(6);
						
						classList = DBUtil.getAllClass(conn, lecNo);
						countClass = DBUtil.getNumberOfClass(conn, lecNo);
						
						if (countClass!=null) {
							if (countClass.next()) {
							classListsize = Integer.parseInt(countClass.getString(1));
							}
						}
					
						System.out.print(lecNo);
						System.out.print(classListsize);
						
						if (classList != null && classListsize>1) { %>
							<!-- 메인페이지에 나타날 내 수강목록 항목-->
							<tr style="background-color: skyblue;">
								<td><%=day%></td>
								<td><%=time%></td>
								<td>
									<span onClick="document.getElementById('<%=day+time%>popup').style.display='block';document.getElementById('fade').style.display='block'"><%=lecName %><br></span>
								</td>
								<td><%=classNo%></td>
							</tr>
						
							<%
							if(timetable.isLast()) {%>
						</table>
							<%}
						} else {%>
							<!-- 메인페이지에 나타날 내 수강목록 항목-->
							<tr>
								<td><%=day%></td>
								<td><%=time%></td>
								<td>
									<span onClick="document.getElementById('<%=day+time%>popup').style.display='block';document.getElementById('fade').style.display='block'"><%=lecName %><br></span>
								</td>
								<td><%=classNo%></td>
							</tr>
							<%
							if(timetable.isLast()) {%>
						</table>
							<%}
						}
					}%></table><%
					timetable.beforeFirst();
					
					while (timetable.next()) {
						lecNo = timetable.getString(1);
						lecName = timetable.getString(2);
						classNo = timetable.getString(3);
						day = timetable.getString(4);
						time = timetable.getString(5);
						professor = timetable.getString(6);
						
						classList = DBUtil.getAllClass(conn, lecNo);
						countClass = DBUtil.getNumberOfClass(conn, lecNo);
						
						
						if (countClass!=null) {
							if (countClass.next()) {
							classListsize = Integer.parseInt(countClass.getString(1));
							}
						}
						
						if (classList != null && classListsize>1) {
							//분반이 여러개일때%>	
							
							<!-- 눌렀을때 나오는거 -->
							<div id="<%=day+time%>popup" class="white_content">
							
								<%=lecName %><br><br>
								<!-- 분반목록 띄우는 table -->
								<table border="1" style="width:100%">
									<tr> 
										<th>분반</th>
										<th>요일</th>
										<th>교시</th>
										<th>담당교수</th>
										<th>강의실</th>
										<th>캠퍼스</th>
										<th>신청</th>
									</tr>
										
								<%while (classList.next()) {
									
									eclassNo = classList.getString(4);
									eday = classList.getString(5);
									etime = classList.getString(6);
									eprofessor = classList.getString(7);
									eclassroom = classList.getString(8);
									ecampus = classList.getString(9);
									%>
									
										<tr> 
											<td><%=eclassNo%></td>
											<td><%=eday%></td>
											<td><%=etime%></td>
											<td><%=eprofessor%></td>
											<td><%=eclassroom%></td>
											<td><%=ecampus%></td>
											<!-- 신청/신청취소 버튼 -->
											<td>
												<%
												flag = "nothing";
												if (eclassNo.equals(classNo)) {
													flag = "current";%>	
													내 현재 분반
												<%}
	
												ResultSet myMatch = DBUtil.searchMatching(conn, estu_no, lecNo);
												
												if (myMatch!=null) {
													while (myMatch.next()) {
														if (eclassNo.equals(myMatch.getString(4))) {
															flag="matching";%>
															<input type="button" value="신청취소" onclick="doremove('<%=lecNo%>','<%=eclassNo%>')"><br>
															(신청일시 : <%=myMatch.getString(5)%>)
													<%	}
													} myMatch.beforeFirst();
												}
												
												if (flag=="nothing") { %>
													<input type="button" value="신청" onclick="location.href='doExchange?lecNo=<%=lecNo%>&classNow=<%=classNo%>&classWants=<%=eclassNo%>'">
											<%	}
												%>
											</td>
										</tr>
								<%	}%>
								</table>
								<br>
								<br>
								<br>
								이 강의에 대한 나의 교환 내역<br><br>
								<table border="1" style="width:100%">
									<tr>
										<th>일 시</th>
										<th>내 용</th>
										<th>상 태</th>
									</tr>
									<%
										ResultSet exchangeDone = DBUtil.searchLogs(conn, estu_no, lecNo);
									
										if(exchangeDone != null) {
											//성사된 교환이 있는 경우 
											if (!exchangeDone.next()) {
										%>	<tr>
												<td colspan="3">이 과목의 교환 신청 내역이 없습니다.</td>
											</tr>
										<%	}
											exchangeDone.beforeFirst();
											while (exchangeDone.next()) {
											%>
												<tr>
													<td><%=exchangeDone.getString(6)%></td>
												<%
													if (exchangeDone.getString(1).equals(estu_no)) {
														//내가 waiter였음%>
														<td><%=exchangeDone.getString(5)%><strong> -> </strong><%=exchangeDone.getString(4)%></td>
												<%	} else if (exchangeDone.getString(2).equals(estu_no)) {
														//내가 dealer였음%>
														<td><%=exchangeDone.getString(4)%><strong> -> </strong><%=exchangeDone.getString(5)%></td>
												<%	}%>
													<td><font color="green">교환 성공</font></td>
												</tr>
										<%	} 
										} else {%>
											<tr>
												<td colspan="3">이 과목의 교환 신청 내역이 없습니다.</td>
											</tr>
										<%}%>
								</table>
								<br>
								<br>
								<br>
								<a href = "javascript:void(0)" onclick = "document.getElementById('<%=day+time%>popup').style.display='none';document.getElementById('fade').style.display='none'">닫기</a>
								
								<%
						}%>
						</div>
					<%}%>
					
					
			<%	}%>
				<div id="fade" class="black_overlay"></div>
			</div>
		</div>
	
				
		<div class="bottomcell" id="admin">
			<!-- 관리자용 Bottom -->
			<div class="contentTitle"><b>관리자 메뉴</b></div><br><br>
			<div class="box">
				<div style="display:table-cell; vertical-align:middle; text-align:center; width:450px; height:450px; margin:0px">
					<a href="./addLecture.jsp"><img src="./image/courses.png"><br><h1><b>강의 관리</b></h1></a>
				</div>
			</div>
			<div class="box">
				<div style="display:table-cell; vertical-align:middle; text-align:center; width:450px; height:450px; margin:0px">
					<a href="adminSetting.jsp"><img src="./image/setting.png"><br><h1><b>시스템 설정</b></h1></a>
				</div>		
			</div>
		</div>
	</div>
</body>
</html>