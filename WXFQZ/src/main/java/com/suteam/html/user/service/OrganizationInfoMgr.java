package com.suteam.html.user.service;

import com.suteam.html.user.model.OrganizationInfo;
import com.suteam.html.user.model.UserInfo;

public interface OrganizationInfoMgr {

	/**
	 * 测试插入
	 */
	public void saveOrganizationInfo(OrganizationInfo orgInfo);
	/**
	 * 根据用户Id查询对象
	 * mzl
	 * @param 
	 * @return
	 */
	public OrganizationInfo findByUserId(String userId);
	/**
	 * 根据用户Id删除
	 * mzl
	 * @param 
	 * @return
	 */
	public void deleteByUserId(OrganizationInfo orgInfo);
}
