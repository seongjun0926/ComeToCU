package Util;

import javax.mail.PasswordAuthentication;

public class Mail extends javax.mail.Authenticator {
	public PasswordAuthentication getPasswordAuthentication(){
		return new PasswordAuthentication("네이버 메일 아이디","아이디 비밀번호");
	}
}
