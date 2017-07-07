package com.suteam.html.user.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.suteam.html.common.dao.GenericDaoDefault;
import com.suteam.html.user.dao.OrganizationInfoDao;
import com.suteam.html.user.model.OrganizationInfo;
@Repository
@SuppressWarnings("unchecked")
public class OrganizationInfoDaoimpl extends GenericDaoDefault<OrganizationInfo> implements OrganizationInfoDao {

	@Override
	public OrganizationInfo findByUserId(String userId) {
		String hqlString = "from OrganizationInfo where userId='" + userId + "'";
		List<OrganizationInfo> list = super.query(hqlString);
		if (list != null && list.size() > 0) {
			return list.get(0);
		}
		return null;
	}

	
		
}
