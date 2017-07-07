package com.suteam.html.common.util;

import java.util.Date;
import java.util.Properties;
import java.util.StringTokenizer;
import javax.mail.BodyPart;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import org.apache.log4j.Logger;

public class MailUtil {
	public static Logger log = Logger.getLogger(MailUtil.class);

	public static void sendEmail(String mail,String mailUserName,String mailPassword,String userName, String title, String content) throws MessagingException {
		String host = "";
		String username = "";
		String password = "";
		if (mail == null || mail.equalsIgnoreCase("") || mailUserName == null || mailUserName.equalsIgnoreCase("")
				|| mailPassword == null || mailPassword.equalsIgnoreCase("")) {
			log.error("未设置邮件服务器，邮件发送失败！");
			return;
		}
		host = mail;
		username = mailUserName;
		password = mailPassword;
		String to = userName;
		// 获得默认的Session对象
		Properties props = System.getProperties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.auth", "true");
		Session s = Session.getDefaultInstance(props);
		// s.setDebug(true); //打开调试信息
		Transport transport = s.getTransport("smtp");
		try {
			transport.connect(host, username, password);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 生成邮件
		MimeMessage mimeMessage = new MimeMessage(s);
		mimeMessage.setSubject(title);

		String from = username;
		mimeMessage.setFrom(new InternetAddress(from)); // 设置发件人邮件地址
		StringTokenizer tokenTO = new StringTokenizer(to, ",");
		InternetAddress[] addrArrTO = new InternetAddress[tokenTO.countTokens()];
		int i = 0;
		while (tokenTO.hasMoreTokens()) {
			String str = new String(tokenTO.nextToken().toString());
			addrArrTO[i] = new InternetAddress(str);
			i++;
		}
		mimeMessage.setRecipients(javax.mail.Message.RecipientType.TO, addrArrTO);
		if (transport.isConnected()) {
			// 给消息对象设置内容
			// 新建一个存放信件内容的BodyPart对象
			BodyPart mbp = new MimeBodyPart();
			mbp.setContent(content, "text/html;charset=UTF-8"); // 给BodyPart对象设置内容和格式/编码方式
			Multipart mm = new MimeMultipart(); // 新建一个MimeMultipart对象用来存放BodyPart对象(事实上可以存放多个)
			mm.addBodyPart(mbp); // 将BodyPart加入到MimeMultipart对象中(可以加入多个BodyPart)
			mimeMessage.setContent(mm); // 把mm作为消息对象的内容
			mimeMessage.setSentDate(new Date()); // 设置发信时间

			// 发送邮件
			// 存储邮件信息
			mimeMessage.saveChanges();
			// 发送邮件,其中第二个参数是所有

			try {
				transport.sendMessage(mimeMessage, mimeMessage.getAllRecipients());
				transport.close();
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException(e);
			}

		}
	}

	public static void main(String[] args) {
		ThreadUtil t = new ThreadUtil();
		t.setContent("sdfsdff");
		t.setTitle("sdfdsf");
		t.setEmail("dysxfqz@163.com");
		// t.run(); //这里也不能直接调用方法
		t.start();
		for (int i = 0; i < 100; i++) {
			System.out.println("main:" + i);
		}
	}
}
