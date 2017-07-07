package com.suteam.html.user.model;

import java.io.Serializable;
import java.util.Date;

import com.suteam.html.common.dao.Entity;

@SuppressWarnings("serial")
public class OrganizationInfo implements Entity<String>, Serializable{

	private String id;
	//用户编号 
	private String userId;
	//企业名称
	private String name;
	//企业邮箱
	private String email;
	//地址
	private String address;
	//邮编
	private String postCode;
	//营业执照注册号（统一社会信用代码）
	private String regNo;
	//营业执照所在地
	private String regAdd;
	//成立日期
	private Date regDate;
	//营业期限
	private String regTime;
	//税务登记证号
	private String taxNo;
	//营业执照副本扫描url
	private String regUrl;
	//税务登记证url
	private String taxUrl;
	//运营者身份证姓名
	private String makerName;
	//运营者身份证号
	private String makerId;
	//运营者手持身份证件照
	private String makerUrl;
	//运营者手机号
	private String phone;
	//创建时间
	private Date createTime;
	//更新时间
	private Date updateTime;
	
	//所属行业
	private Integer jobType;
	//证件类型  0 三证合一(一照一码)  1三证合一   2三证分离
	private Integer documentType;
	
	
	
	
	public Integer getDocumentType() {
		return documentType;
	}
	public void setDocumentType(Integer documentType) {
		this.documentType = documentType;
	}
	public Integer getJobType() {
		return jobType;
	}
	public void setJobType(Integer jobType) {
		this.jobType = jobType;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPostCode() {
		return postCode;
	}
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}
	
	public String getRegNo() {
		return regNo;
	}
	public void setRegNo(String regNo) {
		this.regNo = regNo;
	}
	public String getRegAdd() {
		return regAdd;
	}
	public void setRegAdd(String regAdd) {
		this.regAdd = regAdd;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public String getRegTime() {
		return regTime;
	}
	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}
	public String getTaxNo() {
		return taxNo;
	}
	public void setTaxNo(String taxNo) {
		this.taxNo = taxNo;
	}
	public String getRegUrl() {
		return regUrl;
	}
	public void setRegUrl(String regUrl) {
		this.regUrl = regUrl;
	}
	public String getTaxUrl() {
		return taxUrl;
	}
	public void setTaxUrl(String taxUrl) {
		this.taxUrl = taxUrl;
	}
	public String getMakerName() {
		return makerName;
	}
	public void setMakerName(String makerName) {
		this.makerName = makerName;
	}
	public String getMakerId() {
		return makerId;
	}
	public void setMakerId(String makerId) {
		this.makerId = makerId;
	}
	public String getMakerUrl() {
		return makerUrl;
	}
	public void setMakerUrl(String makerUrl) {
		this.makerUrl = makerUrl;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
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
	
}
