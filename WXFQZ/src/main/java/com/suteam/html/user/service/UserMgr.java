package com.suteam.html.user.service;

import java.util.List;
import com.suteam.html.user.model.User;

public interface UserMgr {
	/**
	 * 保存用户
	 * 
	 * @param user
	 */
	public void saveUser(User user);

	/**
	 * 根据编号删除对象
	 * 
	 * @param id
	 */
	public void deleteById(String id);

	/**
	 * 根据编号查询对象
	 * 
	 * @param id
	 * @return
	 */

	public User findById(String id);

	/**
	 * 根据用户名查询对象
	 * 
	 * @param userName
	 * @return
	 */
	public User findByUserName(String userName);

	/**
	 * 查询所有用户
	 * 
	 * @return
	 */
	public List<User> findAllUser();
	
	/**
	 * 通过手机号查用户
	 * wd
	 */
	public User findUserByPhone(String phone);
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
	/**
	 * ehcache测试清空缓存
	 * fqz
	 */
	public void evictUserTest(String id);
	
}
