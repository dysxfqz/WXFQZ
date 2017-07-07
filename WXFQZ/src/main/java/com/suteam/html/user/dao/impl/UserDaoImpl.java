package com.suteam.html.user.dao.impl;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.suteam.html.common.dao.GenericDaoDefault;
import com.suteam.html.user.dao.UserDao;
import com.suteam.html.user.model.User;

@Repository
@SuppressWarnings("unchecked")
public class UserDaoImpl extends GenericDaoDefault<User>implements UserDao {

	@Override
	public User findByUserName(String userName) {
		String hqlString = "from User where userName='" + userName + "'";
		List<User> userList = super.query(hqlString);
		if (userList != null && userList.size() > 0) {
			return userList.get(0);
		}
		return null;
	}

	@Override
	public User selectUserByPhone(String phone) {
		String hql = "from User where phone = '" + phone + "'";
		List<User> userList = super.query(hql);
		if (null != userList && userList.size() > 0) {
			return userList.get(0);
		}
		return null;
	}

	@Override
	public User findByUemail(String email) {
		String hql = "from User where email = '" + email + "'";
		List<User> userList = super.query(hql);
		if (null != userList && userList.size() > 0) {
			return userList.get(0);
		}
		return null;
	}

	@Override
	public User findByUserNumber(String userNumber) {
		String hql = "from User where userNumber = '" + userNumber + "'";
		List<User> userList = super.query(hql);
		if (null != userList && userList.size() > 0) {
			return userList.get(0);
		}
		return null;
	}

	@Override
	public User findByIdTest(String id) {
		User user = super.get(id);
		System.out.println("ehcache查询数据库测试");
		return user;
	}

	@Override
	public User saveUserTest(User user) {
		System.out.println("ehcache更新数据库测试");
		super.save(user);
		return user;
	}

}
