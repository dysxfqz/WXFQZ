package com.suteam.html.role.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.suteam.html.role.dao.RelRolePermissionDao;
import com.suteam.html.role.dao.UserRoleDao;
import com.suteam.html.role.model.UserRole;
import com.suteam.html.role.service.UserRoleMgr;

@Service
public class UserRoleMgrImpl implements UserRoleMgr {

	@Autowired
	private UserRoleDao userRoleDao;
	@Autowired
	private RelRolePermissionDao relRolePermissionDao;

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void saveUserRole(UserRole userRole) {
		userRoleDao.save(userRole);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public UserRole findByName(String name) {
		return userRoleDao.findByName(name);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public UserRole findById(String id) {
		return userRoleDao.get(id);
	}

	@SuppressWarnings("unchecked")
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<UserRole> findAll() {
		return userRoleDao.findAll();
	}
	
	/**
	 * 删除单条记录
	 * @author zyz
	 * @param userRoleId : 主键
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void dropById(String userRoleId) {
		this.userRoleDao.delete(userRoleId);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void deleteRoleAndPermission(UserRole userRole) {
		//1、删除该角色
		userRoleDao.delete(userRole);
		//获取角色编号
		String roleId = userRole.getId();
		//2、删除角色权限关系
		//根据角色编号查询是否存在角色权限集合
		Integer size = relRolePermissionDao.findSizeByRoleId(roleId);
		if(size >0){
			//如果存在角色权限关系，则根据角色编号删除角色权限关系
			relRolePermissionDao.deleteByRoleId(roleId);
		}
	}
}
