package com.suteam.html.common.util.sms;

/**
 * 短信类型枚举
 */
public enum EnumSMSType {
	/**
	 * 开发测试 
	 */
	CODE_DevelopmentTesting("0"),
	/**
	 * 生产环境使用
	 */
	CODE_Production("1");
	public String code;

	EnumSMSType(String code) {
		this.code = code;
	}
}
