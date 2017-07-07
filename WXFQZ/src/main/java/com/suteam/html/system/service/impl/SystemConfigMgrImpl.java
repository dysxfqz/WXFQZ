package com.suteam.html.system.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.suteam.html.common.util.ThreadUtil;
import com.suteam.html.common.util.VelocityHelper;
import com.suteam.html.system.dao.SystemConfigDao;
import com.suteam.html.system.model.SystemConfig;
import com.suteam.html.system.service.SystemConfigMgr;

/**
 * 系统参数Impl
 * 
 * @author ywd
 *
 */
@Service
public class SystemConfigMgrImpl implements SystemConfigMgr {

	@Autowired
	private SystemConfigDao systemConfigDao;

	private final Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public String getValueByName(String string) {
		return systemConfigDao.getValueByName(string);
	}
	
	/**
	 * 用户绑定邮箱
	 * 
	 * @author zyz
	 * @param companyName	:	邮件发送者名称
	 * @param userName		:	邮件接收者名称
	 * @param email			:	邮件地址
	 * @param scopeName		:	邮件发送者主页
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void sendBoundEmail(String mailServer, String paramtitle, String userName, String email, String scopeName) {
				// 发送邮件
				VelocityHelper velocity = VelocityHelper.getInstance(Band_Email);
				/* velocity.put("name", name); */
				velocity.put("email", email);
				velocity.put("userName", userName);
				velocity.put("scopeName", scopeName);
				velocity.put("paramtitle", paramtitle);
				velocity.put("mailServer", mailServer);
				String content = velocity.getResult();
				//多进程发送邮件    
				ThreadUtil thread = new ThreadUtil();
				//接收邮件名称
				thread.setEmail(email);
				//接收邮件标题
				thread.setTitle(paramtitle + "- 绑定邮件");
				//接收邮件内容
				thread.setContent(content);
				String mail = systemConfigDao.getValueByName("mail_smtp_server");
				thread.setMail(mail);
				String mailUserName = systemConfigDao.getValueByName("mail_user_name");
				thread.setMailUserName(mailUserName);
				String mailPassword = systemConfigDao.getValueByName("mail_password");
				thread.setMailPassword(mailPassword);
				thread.start();
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void sendVmEmail(String paramtitle, String userName,String msg, String email) {
		// 发送邮件
		VelocityHelper velocity = VelocityHelper.getInstance(Vm_Email);
		/* velocity.put("name", name); */
		velocity.put("email", email);
		velocity.put("userName", userName);
		velocity.put("paramtitle", paramtitle);
		velocity.put("msg", msg);
		String content = velocity.getResult();
		//多进程发送邮件    
		ThreadUtil thread = new ThreadUtil();
		//接收邮件名称
		thread.setEmail(email);
		//接收邮件标题
		thread.setTitle(paramtitle + "- 绑定邮件");
		//接收邮件内容
		thread.setContent(content);
		String mail = systemConfigDao.getValueByName("mail_smtp_server");
		thread.setMail(mail);
		String mailUserName = systemConfigDao.getValueByName("mail_user_name");
		thread.setMailUserName(mailUserName);
		String mailPassword = systemConfigDao.getValueByName("mail_password");
		thread.setMailPassword(mailPassword);
		thread.start();
		
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void sendCodeEmail(String paramtitle, String userName, String email, String code) {
		// 发送邮件
		VelocityHelper velocity = VelocityHelper.getInstance(Code_Email);
		velocity.put("paramtitle", paramtitle);
		velocity.put("userName", userName);
		velocity.put("email", email);
		velocity.put("code", code);
		String content = velocity.getResult();
		//多进程发送邮件    
		ThreadUtil thread = new ThreadUtil();
		//接收邮件名称
		thread.setEmail(email);
		//接收邮件标题
		thread.setTitle(paramtitle + "- 修改云服务器系统密码");
		//接收邮件内容
		thread.setContent(content);
		String mail = systemConfigDao.getValueByName("mail_smtp_server");
		thread.setMail(mail);
		String mailUserName = systemConfigDao.getValueByName("mail_user_name");
		thread.setMailUserName(mailUserName);
		String mailPassword = systemConfigDao.getValueByName("mail_password");
		thread.setMailPassword(mailPassword);
		thread.start();
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void save(SystemConfig systemConfig) {
		systemConfigDao.save(systemConfig);		
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public SystemConfig findValueByName(String name) {
		return systemConfigDao.findValueByName(name);	
	}
}
