<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.List"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="Util.DB"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.Address" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Authenticator" %>
<%@ page import="java.util.Properties" %>
<%@ page import="Util.Mail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%

String sender = "mongshared@naver.com";
String receiver = request.getParameter("receiver");
String receiver_ = receiver+"naver.com";
String subject = "ComeToCU 회원가입 인증 메일입니다.";
String content = "http://cometocu.com/Log/E_Mail_Certification.jsp?E_Mail="+receiver;

//정보를 담기 위한 객체
Properties p = new Properties();

//SMTP 서버의 계정 설정
//Naver와 연결할 경우 네이버 아이디 지정
//Google과 연결할 경우 본인의 Gmail 주소
p.put("mail.smtp.user", "mongshared");

//SMTP 서버 정보 설정
//네이버일 경우 smtp.naver.com
//Google일 경우 smtp.gmail.com
p.put("mail.smtp.host", "smtp.naver.com");
 
//아래 정보는 네이버와 구글이 동일하므로 수정하지 마세요.
p.put("mail.smtp.port", "465");
p.put("mail.smtp.starttls.enable", "true");
p.put("mail.smtp.auth", "true");
p.put("mail.smtp.debug", "true");
p.put("mail.smtp.socketFactory.port", "465");
p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
p.put("mail.smtp.socketFactory.fallback", "false");

try {
    Authenticator auth = new Mail();
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
    msg.setContent(content, "text/html;charset=UTF-8");
        
    // 발송하기
    Transport.send(msg);
        
} catch (Exception mex) {
    mex.printStackTrace();
    String script = "<script type='text/javascript'>\n";
    script += "alert('메일발송에 실패했습니다. 다시 시도해주세요.');\n";
    script += "history.back();\n";
    script += "</script>";
    out.print(script);
    return;
}
	
	
		String Wrtie_Name = request.getParameter("S_Name");
		String Write_Num_Parse = request.getParameter("S_Num");
		int Write_Num=Integer.parseInt(Write_Num_Parse);
		String Write_PassWord = request.getParameter("S_Password");

		System.out.println(Wrtie_Name+","+Write_Num+","+Write_PassWord);
		
		Connection conn = null;
		PreparedStatement pstmt = null;


		try {
			//디비 연결

			conn = DB.getConnection();
			conn.setAutoCommit(false);

			pstmt = conn.prepareStatement("insert into C_students(S_Name,S_Num,S_PassWord)value(?,?,?)");

			pstmt.setString(1, Wrtie_Name);
			pstmt.setInt(2, Write_Num);
			pstmt.setString(3, Write_PassWord);
		

			
		
			
			pstmt.executeUpdate();
			conn.commit();
			pstmt.close();
			conn.close();
			
			%>
			<script>
			alert("회원 가입이 완료되었습니다. 이메일 인증 후 로그인해주세요!")
			location.href="/index.jsp";

			</script>
			<%

		} catch (Exception e) {
			out.println(e.getMessage());
			%>
			<script>
			alert("에러 발생 : "+e.getMessage()+"관리자에게 문의해주세요.");
			</script>
			<%
		}
	%>






</body>
</html>