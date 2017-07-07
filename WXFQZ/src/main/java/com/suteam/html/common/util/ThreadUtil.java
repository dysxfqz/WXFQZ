package com.suteam.html.common.util;

import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.mail.MessagingException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.suteam.html.system.service.SystemConfigMgr;

/**
 * 多进程发邮件
 * 
 * @author zsyun_Fangqingzhu
 *
 */
public class ThreadUtil extends Thread {
	private String email;
	private String title;
	private String content;
	private String mail;
	private String mailUserName;
	private String mailPassword;
	private final Logger logger = LoggerFactory.getLogger(getClass());

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public String getMailUserName() {
		return mailUserName;
	}

	public void setMailUserName(String mailUserName) {
		this.mailUserName = mailUserName;
	}

	public String getMailPassword() {
		return mailPassword;
	}

	public void setMailPassword(String mailPassword) {
		this.mailPassword = mailPassword;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public void run() {
		try {
			logger.info("开始发送邮件：" + email);
			MailUtil.sendEmail(mail, mailUserName, mailPassword, email, title, content);
			logger.info("结束发送邮件：" + email);
		} catch (MessagingException e) {
			logger.error("未设置邮件服务器，邮件发送失败！");
		}
//		logger.info("邮件发送已屏蔽：" + email);
	}
	public static void main(String[] args) {
		System.out.println("---进入修改元数据文件方法。 ");
		Properties prop = new Properties();
		try {
			String filePath="H:\\1.txt";
			String parameterName="mac";
			String parameterValue="i2:23:43";
			System.out.println(parameterValue);
					
			InputStream fis = new FileInputStream(filePath);
			// 从输入流中读取属性列表（键和元素对）
			prop.load(fis);
			FileWriter fos = new FileWriter(filePath);
			prop.setProperty(parameterName, parameterValue);
			// 以适合使用 load 方法加载到 Properties 表中的格式，
			// 将此 Properties 表中的属性列表（键和元素对）写入输出流
			prop.store(fos, "Update '" + parameterName + "' value");
			System.out.println("---完成修改元数据文件方法。 ");
		} catch (IOException e) {
			System.err.println("value error");
		}
	}

}
