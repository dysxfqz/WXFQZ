package com.suteam.html.user.service;

import com.suteam.html.user.model.UserInfo;

public interface UserInfoMgr {
	/**
	 * 保存对象mzl
	 */
	public void saveUserInfo(UserInfo userInfo);

	/**
	 * 根据用户Id查询对象
	 * mzl
	 * @param id
	 * @return
	 */
	public UserInfo findByUserId(String userId);
	
	/**
	 * 根据用户邮箱查询用户信息对象
	 * @author zyz
	 * @param email	: 邮箱
	 * @return		: 用户信息对象
	 */
	public UserInfo getByEmail(String email);
	
	
}
