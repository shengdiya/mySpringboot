package com.myapp.demo.Tool;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
public class EmailSender {
	 public static void sendEmail(String to, String subject, String emailBody) throws MessagingException {
	      final String username = "sdygdd2023@163.com"; // 发送者的邮箱地址
	      final String password = "WPAYCIOBEQSCHMRY"; // 发送者的授权码

	      Properties prop = new Properties();
	      prop.setProperty("mail.transport.protocol", "smtp"); //协议
	      prop.put("mail.smtp.host", "smtp.163.com"); // 配置SMTP服务器地址
	      prop.put("mail.smtp.port", "465"); // SMTP端口号
	      prop.put("mail.smtp.auth", "true"); // 需要请求认证
	      prop.put("mail.smtp.ssl.enable","true"); //ssl认证
	      Session session = Session.getInstance(prop,
	              new javax.mail.Authenticator() {
	                  protected PasswordAuthentication getPasswordAuthentication() {
	                      return new PasswordAuthentication(username, password);
	                  }
	              });

	      Message message = new MimeMessage(session);
	      message.setFrom(new InternetAddress("sdygdd2023@163.com"));
	      message.setRecipients(
	              Message.RecipientType.TO,
	              InternetAddress.parse(to)
	      );
	      
	      message.setSubject(subject);
	      message.setText(emailBody);
	      Transport.send(message);
	 }
}
