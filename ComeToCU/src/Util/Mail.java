package Util;

import javax.mail.PasswordAuthentication;

public class Mail extends javax.mail.Authenticator {
	public PasswordAuthentication getPasswordAuthentication(){
		return new PasswordAuthentication("���̹� ���� ���̵�","���̵� ��й�ȣ");
	}
}
