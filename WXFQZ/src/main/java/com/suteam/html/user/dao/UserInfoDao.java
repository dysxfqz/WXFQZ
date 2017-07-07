package com.suteam.html.user.dao;

import com.suteam.html.common.dao.GenericDao;
import com.suteam.html.user.model.UserInfo;


public interface UserInfoDao extends GenericDao<UserInfo> {
	/**
	 * 根据用户名查询对象
	 * @param userName
	 * @return
	 */
	public UserInfo findByUserId(String userId);
	
	/**
	 * 根据用户邮箱查询用户信息对象
	 * @author zyz
	 * @param email	: 邮箱
	 * @return		: 用户信息对象
	 */
	public UserInfo findByUserEmail(String email);
}
