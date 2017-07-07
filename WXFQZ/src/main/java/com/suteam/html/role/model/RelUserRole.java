package com.suteam.html.role.model;

import java.io.Serializable;

import com.suteam.html.common.dao.Entity;

@SuppressWarnings("serial")
public class RelUserRole implements Entity<String>, Serializable {
	// 编号
	private String id;
	// 用户编号
	private String userId;
	// 角色编号
	private String roleId;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

}
