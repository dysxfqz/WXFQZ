package com.suteam.html.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.suteam.html.user.dao.UserInfoDao;
import com.suteam.html.user.model.UserInfo;
import com.suteam.html.user.service.UserInfoMgr;

@Service
@SuppressWarnings("unchecked")
public class UserInfoMgrImpl implements UserInfoMgr {
	@Autowired
	private UserInfoDao userInfoDao;

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void saveUserInfo(UserInfo userInfo) {
		userInfoDao.save(userInfo);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public UserInfo findByUserId(String userId) {
		return userInfoDao.findByUserId(userId);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public UserInfo getByEmail(String email) {
		return userInfoDao.findByUserEmail(email);
	}

}
