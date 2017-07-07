package com.suteam.html.user.model;

import java.io.Serializable;
import java.util.Date;

import com.suteam.html.common.dao.Entity;

@SuppressWarnings("serial")
public class UserInfo implements Entity<String>, Serializable {
	
	//编号
	private String id;
	//用户编号
	private String userId;
	//姓名
	private String name;
	//性别  0 女  1 男
	private Integer sex;
	//省份
	private String province;
	//城市
	private String city;
	//地区
	private String area;
	//地址
	private String address;
	//手机号
	private String phone;
	//邮编
	private String postCode;
	//邮箱
	private String email;
	//头像url
	private String headUrl;
	//身份证姓名
	private String idCardName;
	//身份证url
	private String idCardUrl;
	//创建时间
	private Date createTime;
	//更新时间
	private Date updateTime;
	
	//证件类型0 身份证
	private Integer documentType;
	//证件id
	private String documentId;
	//录入邮箱时间
	private Date emailStartDate;
	
	public String getDocumentId() {
		return documentId;
	}
	public void setDocumentId(String documentId) {
		this.documentId = documentId;
	}
	public Integer getDocumentType() {
		return documentType;
	}
	public void setDocumentType(Integer documentType) {
		this.documentType = documentType;
	}
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPostCode() {
		return postCode;
	}
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getHeadUrl() {
		return headUrl;
	}
	public void setHeadUrl(String headUrl) {
		this.headUrl = headUrl;
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
	
	public String getIdCardName() {
		return idCardName;
	}
	public void setIdCardName(String idCardName) {
		this.idCardName = idCardName;
	}
	public String getIdCardUrl() {
		return idCardUrl;
	}
	public void setIdCardUrl(String idCardUrl) {
		this.idCardUrl = idCardUrl;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public Date getEmailStartDate() {
		return emailStartDate;
	}
	public void setEmailStartDate(Date emailStartDate) {
		this.emailStartDate = emailStartDate;
	}
	
}
