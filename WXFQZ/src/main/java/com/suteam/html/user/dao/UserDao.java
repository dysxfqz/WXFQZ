package com.suteam.html.user.dao;

import com.suteam.html.common.dao.GenericDao;
import com.suteam.html.user.model.User;

public interface UserDao extends GenericDao<User> {
	/**
	 * 根据用户名查询对象
	 * 
	 * @param userName
	 * @return
	 */
	public User findByUserName(String userName);
	/**
	 * 根据手机号查找用户
	 */
	public User selectUserByPhone(String phone); 
	
	
	/**
	 * 通过邮箱查用户
	 * mzl
	 */
	public User findByUemail(String email);
	/**
	 * 通过用户号查用户
	 * mzl
	 */
	public User findByUserNumber(String userNumber);
	
	/**
	 * ehcache测试查询
	 * fqz
	 */
	public User findByIdTest(String id);
	/**
	 * ehcache测试更新
	 * fqz
	 */
	public User saveUserTest(User user);
}
