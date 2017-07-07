package com.suteam.html.user.dao;

import com.suteam.html.common.dao.GenericDao;
import com.suteam.html.user.model.OrganizationInfo;

public interface OrganizationInfoDao extends GenericDao<OrganizationInfo>{
	/**
	 * 根据用户名查询对象
	 * @param id
	 * @return
	 */
	public OrganizationInfo findByUserId(String userId);
}
