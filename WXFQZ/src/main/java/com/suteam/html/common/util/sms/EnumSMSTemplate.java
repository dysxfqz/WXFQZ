package com.suteam.html.common.util.sms;

/**
 * 短信模板枚举
 */
public enum EnumSMSTemplate {
	/**
	 * 中数云计算-注册、登录等--验证码
	 */
	CODE_117373("117373","10"),
	/**
	 * 中数云计算-重置密码---通知
	 */
	CODE_116902("116902","10");
	public String code;
	public String time;
	

	EnumSMSTemplate(String code,String time) {
		this.code = code;
		this.time = time;
	}
}
