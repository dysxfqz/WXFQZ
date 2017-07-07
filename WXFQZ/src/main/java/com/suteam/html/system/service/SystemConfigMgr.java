package com.suteam.html.system.service;

import com.suteam.html.system.model.SystemConfig;

/**
 * 系统参数方法类
 * 
 * @author lxl
 *
 */
public interface SystemConfigMgr {
	// 自动注册模板
	public static final String Band_Email = "com/suteam/html/system/templates/BandEmail.vm";
	public static final String Vm_Email = "com/suteam/html/system/templates/Vm_Email.vm";
	public static final String Code_Email = "com/suteam/html/system/templates/CodeEmail.vm";

	/**
	 * 根据参数名称查询value值
	 * 
	 * @param string
	 * @return
	 */
	String getValueByName(String string);
	
	/**
	 * 用户绑定邮箱
	 * 
	 * @author zyz
	 * @param companyName	:	邮件发送者名称
	 * @param userName		:	邮件接收者名称
	 * @param email			:	邮件地址
	 * @param scopeName		:	邮件发送者主页
	 */
	public void sendBoundEmail(String mailServer, String paramtitle, String userName, String email, String scopeName);
	/**
	 * 云服务器未到期、到期、过期邮件提醒
	 * 
	 * @author zyz
	 * @param companyName	:	邮件发送者名称
	 * @param userName		:	邮件接收者名称
	 * @param email			:	邮件地址
	 * @param scopeName		:	邮件发送者主页
	 */
	public void sendVmEmail(String paramtitle, String userName, String email, String msg);
	/**
	 * 用户修改云服务器系统密码发送验证码至邮箱
	 * 
	 * @author wjl
	 * @param paramtitle	:	邮件系统参数
	 * @param userName		:	邮件接收者名称
	 * @param email			:	邮件地址
	 * @param code			:	验证码
	 */
	public void sendCodeEmail(String paramtitle, String userName, String email, String code);

	/**
	 * 保存
	 */
	public void save(SystemConfig systemConfig);
	/**
	 * 查找对象
	 */
	public SystemConfig findValueByName(String name);
}
