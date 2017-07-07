package com.suteam.html.common.util;

/**
 * aupress接口枚举
 */
public enum EnumPortCode {
	/**
	 * 获取省（地区）
	 */
	GetProvinces("GetProvinces", "http://59.151.39.72/Aupres_WebService.asmx"),
	/**
	 * 获取市（根据省ID）
	 */
	GetCitys("GetCitys", "http://59.151.39.72/Aupres_WebService.asmx"),
	/**
	 * 获取服务器时间
	 */
	GetServerTime("GetServerTime", "http://59.151.39.72/Aupres_WebService.asmx"),
	/**
	 * 抢红包摇一摇
	 */
	Ipaychecks_Insert("Ipaychecks_Insert", "http://59.151.39.72/Aupres_Exchange.asmx"),
	/**
	 * 获取短信密码-输入会员卡号、姓名、手机号
	 */
	GetAupresUserFindPwd_1("AupresUserFindPwd_1", "http://59.151.39.72/Aupres_WebService.asmx"),
	/**
	 * 通过密保找回密码
	 */
	AupresAnswerFindPwd_1("AupresAnswerFindPwd_1", "http://59.151.39.72/Aupres_WebService.asmx"),
	/**
	 * 通过密保找回密码—重置密码
	 */
	AupresAnswerFindPwd_2("AupresAnswerFindPwd_2", "http://59.151.39.72/Aupres_WebService.asmx"),
	/**
	 * 查询会员积分
	 */
	QueryCredits("QueryCredits", "http://59.151.39.72/Aupres_Members.asmx"),
	/**
	 * 获取用户登陆信息
	 */
	AupresUserLogin_type("AupresUserLogin_type", "http://59.151.39.72/Aupres_WebService.asmx"),
	/**
	 * 用户激活
	 */
	ActiveMember("ActiveMember", "http://59.151.39.72/Aupres_WebService.asmx"),
	/**
	 * 用户激活_提交用户信息
	 */
	IUpdateMemberMessage_type_2("IUpdateMemberMessage_type_2", "http://59.151.39.72/Aupres_WebService.asmx"),
	/**
	 * 用户激活_获取用户信息 
	 */
	IGetMemberMessage("IGetMemberMessage", "http://59.151.39.72/Aupres_WebService.asmx"),
	/**
	 * 通过短信验证码登录
	 */
	AupresUserFindPwd_2("AupresUserFindPwd_2", "http://59.151.39.72/Aupres_WebService.asmx"),
	/**
	 * 输入手机号发送验证码 
	 */
	P_GetApppassword("P_GetApppassword", "http://59.151.39.72/Aupres_WebService.asmx"),
	/**
	 * 会员登陆_通过手机号密码登录 
	 */
	AupresUserTelLogin_nopc("AupresUserTelLogin_nopc", "http://59.151.39.72/Aupres_WebService.asmx"),
	/**
	 * 检测用户名是否存在
	 */
	IsExistsUserName("IsExistsUserName","http://59.151.39.72/Aupres_WebService.asmx");

	public String portName;
	public String portDomain;

	EnumPortCode(String portName, String portDomain) {
		this.portName = portName;
		this.portDomain = portDomain;
	}
}
