package com.suteam.html.user.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.suteam.html.common.dao.GenericDaoDefault;
import com.suteam.html.user.dao.UserInfoDao;
import com.suteam.html.user.model.UserInfo;

@Repository
@SuppressWarnings("unchecked")
public class UserInfoDaoImpl extends GenericDaoDefault<UserInfo> implements UserInfoDao {

	@Override
	public UserInfo findByUserId(String userId) {
		String hqlString = "from UserInfo where userId='" + userId + "'";
		List<UserInfo> list = super.query(hqlString);
		if (list != null && list.size() > 0) {
			return list.get(0);
		}
		return null;
	}

	@Override
	public UserInfo findByUserEmail(String email) {
		String hqlString = "from UserInfo where email ='" + email + "'";
		List<UserInfo> list = super.query(hqlString);
		if (list != null && list.size() > 0) {
			return list.get(0);
		}
		return null;
	}
		
	
	
}
