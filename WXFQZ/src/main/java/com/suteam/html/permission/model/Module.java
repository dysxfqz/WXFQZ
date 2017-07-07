package com.suteam.html.permission.model;

import java.io.Serializable;
import java.util.List;

import com.suteam.html.common.dao.Entity;

@SuppressWarnings("serial")
public class Module implements Entity<String>, Serializable, Comparable<Module> {

	//编号
	private String id;
	//序号
	private Integer sort;
	//模块名称
	private String name;
	//模块描述
	private String description;
	//菜单编号(模块所属二级菜单)
	private String menuId;
	//主菜单编号(所属主菜单)
	private String mainMenuPermissionId;
	//当前用户是否已有权限的状态 1.有  2没有
	private String status;
	//模块下的权限集合
	private List<UserPermission> userPermission;
	//级联代码
	private Integer code;
	//勾选级联代码
	private String yesCode;
	//勾掉级联代码
	private String noCode;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
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

	public List<UserPermission> getUserPermission() {
		return userPermission;
	}

	public void setUserPermission(List<UserPermission> userPermission) {
		this.userPermission = userPermission;
	}

	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

	public String getMainMenuPermissionId() {
		return mainMenuPermissionId;
	}

	public void setMainMenuPermissionId(String mainMenuPermissionId) {
		this.mainMenuPermissionId = mainMenuPermissionId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getYesCode() {
		return yesCode;
	}

	public void setYesCode(String yesCode) {
		this.yesCode = yesCode;
	}

	public String getNoCode() {
		return noCode;
	}

	public void setNoCode(String noCode) {
		this.noCode = noCode;
	}

	@Override
	public int compareTo(Module o) {
		return this.sort - o.getSort();
	}
	
}
