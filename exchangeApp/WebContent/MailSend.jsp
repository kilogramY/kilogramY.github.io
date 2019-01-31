<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.Address" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Authenticator" %>
<%@ page import="java.util.Properties" %>
<%@ page import="web.SMTPAuthenticator" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
<% 
	request.setCharacterEncoding("UTF-8");
	String receiver = (String)request.getAttribute("email");
	String sTime = (String)request.getAttribute("sendTime");
	String sender = "kmhjn95@gmail.com";
	String subject = "성신여자대학교 분반 교환시스템 비밀번호 변경 링크입니다.";
	String link = "\"http://49.167.9.18:8080/SSWUClassChangeApp/UpdatePW.jsp?email="+receiver+"&sTime="+sTime+"\"";
	String content = "<div style=\"padding:8px 15px;\"><font color=\"purple\" size=\"3\">"
				+"<img src=\"http://49.167.9.18:8080/SSWUClassChangeApp/image/img_symbol.png\" width=\"30px\"> <b>성신여자대학교 분반 교환시스템<b></font></div>"
				+"<div style=\"background-color:#e7e7f7; display:table-cell; vertical-align:middle; text-align:center; width:500px; padding:10px\">이 <a href="
				+link
				+"target=\"_blank\">링크</a>를 눌러 비밀번호 변경을 마칩니다.</div>";

	//정보를 담기 위한 객체
	Properties p = new Properties();
	
	//SMTP 서버의 계정 설정
	//Naver와 연결할 경우 네이버 아이디 지정
	//Google과 연결할 경우 본인의 Gmail 주소
	p.put("mail.smtp.user", "kmhjn95");
	
	//SMTP 서버 정보 설정
	//네이버일 경우 smtp.naver.com
	//Google일 경우 smtp.gmail.com
	p.put("mail.smtp.host", "smtp.gmail.com");
	 
	//아래 정보는 네이버와 구글이 동일하므로 수정하지 마세요.
	p.put("mail.smtp.port", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");
	
	try {
	    Authenticator auth = new SMTPAuthenticator();
	    Session ses = Session.getInstance(p, auth);
	
	    // 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
	    ses.setDebug(true);
	        
	    // 메일의 내용을 담기 위한 객체
	    MimeMessage msg = new MimeMessage(ses);
	
	    // 제목 설정
	    msg.setSubject(subject);
	        
	    // 보내는 사람의 메일주소
	    Address fromAddr = new InternetAddress(sender);
	    msg.setFrom(fromAddr);
	        
	    // 받는 사람의 메일주소
	    Address toAddr = new InternetAddress(receiver);
	    msg.addRecipient(Message.RecipientType.TO, toAddr);
	        
	    // 메시지 본문의 내용과 형식, 캐릭터 셋 설정
	    msg.setContent(content, "text/html;charset=UTF-8;");
	        
	    // 발송하기
	    Transport.send(msg);
	        
	} catch (Exception mex) {
	    mex.printStackTrace();
	    String script = "<script type='text/javascript'>\n";
	    script += "alert('메일발송에 실패했습니다.');\n";
	    script += "history.back();\n";
	    script += "</script>";
	    out.print(script);
	    return;
	}

%>

<script  type='text/javascript'>
	alert('인증되었습니다.\n비밀번호 변경 링크를 해당 메일로 전송하였습니다.');
	location.href='main.html';
</script>
  

</body>
</html>