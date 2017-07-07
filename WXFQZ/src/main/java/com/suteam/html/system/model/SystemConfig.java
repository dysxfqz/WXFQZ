package com.suteam.html.system.model;

import java.io.Serializable;

import com.suteam.html.common.dao.Entity;

/**
 * 系统参数
 * @author lxl
 *
 */
@SuppressWarnings("serial")
public class SystemConfig implements Entity<String>, Serializable{
	
	//编号
	private String id;
	//参数名称
	private String name;
	//参数值
	private String value;
	//参数描述
	private String describe;
	
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
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getDescribe() {
		return describe;
	}
	public void setDescribe(String describe) {
		this.describe = describe;
	}
}
