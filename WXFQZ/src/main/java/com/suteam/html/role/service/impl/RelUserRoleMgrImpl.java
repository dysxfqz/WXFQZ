package com.suteam.html.role.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.suteam.html.role.dao.RelUserRoleDao;
import com.suteam.html.role.model.RelUserRole;
import com.suteam.html.role.service.RelUserRoleMgr;

@Service
public class RelUserRoleMgrImpl implements RelUserRoleMgr {

	@Autowired
	private RelUserRoleDao relUserRoleDao;

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void saveRelUserRole(RelUserRole relUserRole) {
		relUserRoleDao.save(relUserRole);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<RelUserRole> findByUserId(String userId) {
		return relUserRoleDao.findByUserId(userId);
	}
	
	/**
	 * 根据角色获取角色关系列表
	 * 
	 * @author zyz
	 * @param userRoleId
	 * @return
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public List<RelUserRole> getByRoleId(String userRoleId) {
		return this.relUserRoleDao.findByRoleId(userRoleId);
	}
	
	/**
	 * 根据主键删除记录
	 * 
	 * @author zyz
	 * @param id : 主键
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void dropById(String id) {
		this.relUserRoleDao.delete(id);
	}

}
