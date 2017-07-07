package com.suteam.html.role.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.suteam.html.common.dao.Entity;
import com.suteam.html.permission.model.Module;
import com.suteam.html.permission.model.UserPermission;

@SuppressWarnings("serial")
public class Menu implements Entity<String>, Serializable, Comparable<Menu> {
	
	//编号
	private String id;
	//菜单名称
	private String name;
	//权限编号
	private String permissionId;
	//父类ID
	private String pid;
	//排序
	private Integer sort;
	//等级
	private Integer rank;
	//标识
	private String htmlId;
	//类名
	private String htmlClass;
	//用户权限
	private UserPermission userPermission;
	//子类菜单
	private List<Menu> children = new ArrayList<>();
	//父类菜单
	private Menu father;
	//所属模块
	private List<Module> moduleList;
	
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
	public String getPermissionId() {
		return permissionId;
	}
	public void setPermissionId(String permissionId) {
		this.permissionId = permissionId;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	public Integer getRank() {
		return rank;
	}
	public void setRank(Integer rank) {
		this.rank = rank;
	}
	public UserPermission getUserPermission() {
		return userPermission;
	}
	public void setUserPermission(UserPermission userPermission) {
		this.userPermission = userPermission;
	}
	public String getHtmlId() {
		return htmlId;
	}
	public void setHtmlId(String htmlId) {
		this.htmlId = htmlId;
	}
	public String getHtmlClass() {
		return htmlClass;
	}
	public void setHtmlClass(String htmlClass) {
		this.htmlClass = htmlClass;
	}
	public List<Menu> getChildren() {
		return children;
	}
	public void setChildren(List<Menu> children) {
		this.children = children;
	}
	public Menu getFather() {
		return father;
	}
	public void setFather(Menu father) {
		this.father = father;
	}
	public List<Module> getModuleList() {
		return moduleList;
	}
	public void setModuleList(List<Module> moduleList) {
		this.moduleList = moduleList;
	}
	@Override
	public int compareTo(Menu o) {
		return this.sort - o.getSort();
	}
	
	
}
