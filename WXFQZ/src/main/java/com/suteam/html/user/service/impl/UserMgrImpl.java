package com.suteam.html.user.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import com.suteam.html.user.dao.UserDao;
import com.suteam.html.user.model.User;
import com.suteam.html.user.service.UserMgr;

@Service
@SuppressWarnings("unchecked")
public class UserMgrImpl implements UserMgr {

	@Autowired
	private UserDao userDao;

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void saveUser(User user) {
		userDao.save(user);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void deleteById(String id) {
		userDao.delete(id);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public User findById(String id) {
		return userDao.get(id);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public User findByUserName(String userName) {
		return userDao.findByUserName(userName);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<User> findAllUser() {
		return userDao.findAll();
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public User findUserByPhone(String phone) {
		return userDao.selectUserByPhone(phone);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public User findByUemail(String email) {
		return userDao.findByUemail(email);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public User findByUserNumber(String userNumber) {
		return userDao.findByUserNumber(userNumber);
	}

	@Cacheable(value = "userCache", key = "#id")
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public User findByIdTest(String id) {
		return userDao.findByIdTest(id);
	}

	@CachePut(value = "userCache", key = "#user.id")
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public User saveUserTest(User user) {
		return userDao.saveUserTest(user);
	}

	@Override
	@CacheEvict(value = "userCache", key = "#id")
	public void evictUserTest(String id) {
		System.out.println("清空缓存");
	}

}
