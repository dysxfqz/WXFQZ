package com.suteam.html.user.model;

import java.io.Serializable;
import java.util.Date;

import com.suteam.html.common.dao.Entity;

/**
 * 手机验证码实体类
 */
public class IdentifyingCode implements Entity<String>, Serializable {
	private static final long serialVersionUID = 5313243349415992305L;
	private String id;
	private String phoneNumber;// 手机号
	private String stateCode;// 发送状态码 000000 为发送成功，其他均为发送失败
	private String errorContext;// 发送失败原因
	private String identifyingCode;// 验证码
	private Date createTime;// 创建时间
	private String time;// 有效时间（分钟）
	private String smsType;// 短信类型
	private Integer type;// 类型 0 验证码 1 邀请码

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getStateCode() {
		return stateCode;
	}

	public void setStateCode(String stateCode) {
		this.stateCode = stateCode;
	}

	public String getErrorContext() {
		return errorContext;
	}

	public void setErrorContext(String errorContext) {
		this.errorContext = errorContext;
	}

	public String getSmsType() {
		return smsType;
	}

	public void setSmsType(String smsType) {
		this.smsType = smsType;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getIdentifyingCode() {
		return identifyingCode;
	}

	public void setIdentifyingCode(String identifyingCode) {
		this.identifyingCode = identifyingCode;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

}
