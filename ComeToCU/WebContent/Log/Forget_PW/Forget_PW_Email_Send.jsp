<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="javax.mail.Transport"%>
<%@ page import="javax.mail.Message"%>
<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="javax.mail.Address"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.mail.Session"%>
<%@ page import="javax.mail.Authenticator"%>
<%@ page import="java.util.Properties"%>
<%@ page import="Util.Mail"%>
<%@ page import="Util.DB"%>
<%@ page import="java.sql.*"%>

<%@ page import="sun.misc.BASE64Encoder" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");
		
		BASE64Encoder base64Encoder = new BASE64Encoder();	
		
		String Write_Num = request.getParameter("S_Num");

		String En_Write_Num=base64Encoder.encode(Write_Num.getBytes());
		
		

		String sender = "mongshared@naver.com";
		String receiver_ = request.getParameter("receiver");
		String receiver = receiver_ + "@cu.ac.kr";
		String subject = "ComeToCU 암호 찾기 인증 메일입니다.";
		String content = "<a href="
				+ "http://cometocu.com/Log/Forget_PW/Alter_PW.jsp?S_Num="
				+ En_Write_Num + ">암호 찾기 인증 메일입니다. 본 링크를 우클릭해서 새탭으로 열기 후 이용해주세요.</a>";
		
		String S_ID = "";

		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			conn = DB.getConnection();
			stmt = conn.createStatement();
			rs = stmt
					.executeQuery("select S_ID from C_students where S_Num='"
							+ Write_Num + "';");

			while (rs.next()) {
				S_ID = rs.getString("S_ID");

			}

			if (receiver_.equals(S_ID)) {

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
				p.put("mail.smtp.socketFactory.class",
						"javax.net.ssl.SSLSocketFactory");
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
	%>
	<script>
		alert("이메일이 발송 되었습니다.\n메일 전송까지 약 3분가량 걸립니다.\n이메일 인증 후 암호를 변경해주세요!")
		location.href = "/index.jsp";
	</script>
	<%
		} else {
	%>
	<script>
		alert("대가대 ID와 ID 일치하지 않습니다.\n확인 후 이용해주세요.")
		history.go(-1);
	</script>
	<%
		}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
				}
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException e) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {
				}
		}
	%>



</body>
</html>