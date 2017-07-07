package com.suteam.html.user.model;

import java.io.Serializable;
import java.util.Date;

import com.suteam.html.common.dao.Entity;

@SuppressWarnings("serial")
public class User implements Entity<String>, Serializable {
	// 编号
	private String id;
	// 用户号
	private String userNumber;
	// 用户名
	private String userName;
	// 手机号
	private String phone;
	// 邮箱
	private String email;
	// 密码
	private String password;
	// 状态 0 禁用（若禁用相关授权都禁用） 1 使用
	private Integer status;
	// 创建时间
	private Date createTime;
	// 角色类型 0 超级管理员 1 系统管理员 2 普通用户
	private Integer roleType;
	// 更新时间
	private Date updateTime;
	// 认证类型 0 个人 1 企业
	private Integer qualificationType;
	// 认证状态 0 未认证 1 认证中 2 认证通过 3 认证失败
	private Integer qualificationStatus;

	// 认证申请时间
	private Date applyTime;
	// 认证通过时间
	private Date passedTime;

	// 认证不通过原因
	private String noPassReason;

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNoPassReason() {
		return noPassReason;
	}

	public void setNoPassReason(String noPassReason) {
		this.noPassReason = noPassReason;
	}

	public String getUserNumber() {
		return userNumber;
	}

	public void setUserNumber(String userNumber) {
		this.userNumber = userNumber;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getRoleType() {
		return roleType;
	}

	public void setRoleType(Integer roleType) {
		this.roleType = roleType;
	}

	public Integer getQualificationStatus() {
		return qualificationStatus;
	}

	public void setQualificationStatus(Integer qualificationStatus) {
		this.qualificationStatus = qualificationStatus;
	}

	public Integer getQualificationType() {
		return qualificationType;
	}

	public void setQualificationType(Integer qualificationType) {
		this.qualificationType = qualificationType;
	}

	public Date getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}

	public Date getPassedTime() {
		return passedTime;
	}

	public void setPassedTime(Date passedTime) {
		this.passedTime = passedTime;
	}

}
