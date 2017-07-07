package com.suteam.html.role.model;

import java.io.Serializable;

import com.suteam.html.common.dao.Entity;

@SuppressWarnings("serial")
public class UserRole implements Entity<String>, Serializable {
	// 编号
	private String id;
	// 名称
	private String name;
	// 描述
	private String description;
	// 系统默认(0非, 1真)
	private Integer defaultRole;
	

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getDefaultRole() {
		return defaultRole;
	}

	public void setDefaultRole(Integer defaultRole) {
		this.defaultRole = defaultRole;
	}
	
	
}
