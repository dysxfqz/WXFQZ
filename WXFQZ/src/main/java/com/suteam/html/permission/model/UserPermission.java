package com.suteam.html.permission.model;

import java.io.Serializable;

import com.suteam.html.common.dao.Entity;

@SuppressWarnings("serial")
public class UserPermission implements Entity<String>, Serializable {
	// 编号
	private String id;
	// 权限名称
	private String name;
	// 权限URL
	private String url;
	// 权限类型
	private String type;
	//描述
	private String description;
	//模块编号
	private String moduleId;
	//模块类型
	private Integer moduleType;
	
	//当前用户是否已有权限的状态 1.有  2没有
	private String status;
	//权限所属模块
	private Module module;
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

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

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getModuleId() {
		return moduleId;
	}

	public void setModuleId(String moduleId) {
		this.moduleId = moduleId;
	}

	public Module getModule() {
		return module;
	}

	public void setModule(Module module) {
		this.module = module;
	}

	public Integer getModuleType() {
		return moduleType;
	}

	public void setModuleType(Integer moduleType) {
		this.moduleType = moduleType;
	}


}
