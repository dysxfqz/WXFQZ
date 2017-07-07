package com.suteam.html.user.model;

import java.io.Serializable;
import java.util.Date;

import com.suteam.html.common.dao.Entity;


@SuppressWarnings("serial")
public class Authorize implements Entity<String>, Serializable {
	//id
	private String id;
	//主机名
	private String hostName;
	//域名
	private String domainName;
	//ip
	private String ipAddress;
	//状态0 正常 1 维修
	private int status;
	//创建时间
	private Date createTime;
	
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getHostName() {
		return hostName;
	}
	public void setHostName(String hostName) {
		this.hostName = hostName;
	}
	public String getDomainName() {
		return domainName;
	}
	public void setDomainName(String domainName) {
		this.domainName = domainName;
	}
	public String getIpAddress() {
		return ipAddress;
	}
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
 
 
	
}
