package com.suteam.html.role.model;

import java.io.Serializable;

import com.suteam.html.common.dao.Entity;

@SuppressWarnings("serial")
public class RelRolePermission implements Entity<String>, Serializable {
	// 编号
	private String id;
	// 角色编号
	private String roleId;
	// 权限编号
	private String permissionId;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getPermissionId() {
		return permissionId;
	}

	public void setPermissionId(String permissionId) {
		this.permissionId = permissionId;
	}

}
