package com.suteam.html.common.util.logs;

import java.io.Serializable;

import com.suteam.html.common.dao.Entity;

/**
 * 日志实体类
 * @author zsyun
 *
 */
@SuppressWarnings("serial")
public class Logs implements Entity<String>, Serializable{

	//日志号
	private String  logCode;
	//请求体
	private String  requstBody;
	//请求参数
	private String  requstParam;
	//返回结果
	private String  values;
	//请求来源
	private String  requstSource;
	//请求IP
	private String  sourceIP;
	//访问时间
	private String beginTime;
	//结束时间
	private String endTime;
	
	public String getLogCode() {
		return logCode;
	}
	public void setLogCode(String logCode) {
		this.logCode = logCode;
	}
	public String getRequstBody() {
		return requstBody;
	}
	public void setRequstBody(String requstBody) {
		this.requstBody = requstBody;
	}
	public String getRequstParam() {
		return requstParam;
	}
	public void setRequstParam(String requstParam) {
		this.requstParam = requstParam;
	}
	public String getValues() {
		return values;
	}
	public void setValues(String values) {
		this.values = values;
	}
	public String getRequstSource() {
		return requstSource;
	}
	public void setRequstSource(String requstSource) {
		this.requstSource = requstSource;
	}
	public String getSourceIP() {
		return sourceIP;
	}
	public void setSourceIP(String sourceIP) {
		this.sourceIP = sourceIP;
	}
	public String getBeginTime() {
		return beginTime;
	}
	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

}
