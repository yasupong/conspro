package conspro.util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * CONSPROメール部品
 * @author yasupong
 */
public class MailUtil {
	
	/** メール送信者 */
	private static final String MAIL_FROM = "iowadesmoinesyakkun@yahoo.co.jp";
	/** メール受信者：ADMIN_PC */
	private static final String MAIL_ADMIN_PC = "iowadesmoinesyakkun@yahoo.co.jp";

	/** メール題名：Signup */
	private static final String MSG_SIGNUP = "SignupがCONSPRO英語ページから投稿されました。「CONSPRO」よりご確認お願いいたします。";
	/** メール題名：e-査定 */
	private static final String MSG_ESATEI = "査定受付がCONSPRO日本語ページから投稿されました。「CONSPRO」よりご確認お願いいたします。";
	/** メール内容：Signup */
	private static final String SUB_SIGNUP = "[CONSPRO]Signup received";
	/** メール内容：e-査定 */
	private static final String SUB_ESATEI = "[CONSPRO]Satei received";
	
	/**
	 * e-査定受付用メール送信
	 * @param isDev 開発モードかどうか
	 */
	public static void sendMailForEsatei(boolean isDev){
		
		Properties props = new Properties();
		Session session = Session.getDefaultInstance(props, null);
		
		try {
			Message msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(MAIL_FROM, MAIL_FROM));
			
			if (isDev) {
				msg.addRecipient(Message.RecipientType.TO,new InternetAddress(MAIL_ADMIN_PC, MAIL_ADMIN_PC));
			}
			else 
			{
				msg.addRecipient(Message.RecipientType.BCC,new InternetAddress(MAIL_ADMIN_PC, MAIL_ADMIN_PC));
			}
			
			msg.setSubject(SUB_ESATEI);
			msg.setText(MSG_ESATEI);
			Transport.send(msg);
		} catch (Throwable th) {
			th.printStackTrace();
		}
	}
	
	/**
	 * Signup受付用メール送信
	 * @param isDev
	 */
	public static void sendMailForSignup(boolean isDev){
		
		Properties props = new Properties();
		Session session = Session.getDefaultInstance(props, null);
		
		try {
			Message msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(MAIL_FROM, MAIL_FROM));
			
			if (isDev) {
				msg.addRecipient(Message.RecipientType.TO,new InternetAddress(MAIL_ADMIN_PC, MAIL_ADMIN_PC));
			}
			else 
			{
				msg.addRecipient(Message.RecipientType.BCC,new InternetAddress(MAIL_ADMIN_PC, MAIL_ADMIN_PC));
			}
			
			msg.setSubject(SUB_SIGNUP);
			msg.setText(MSG_SIGNUP);
			Transport.send(msg);
		} catch (Throwable th) {
			th.printStackTrace();
		}
	}
}
