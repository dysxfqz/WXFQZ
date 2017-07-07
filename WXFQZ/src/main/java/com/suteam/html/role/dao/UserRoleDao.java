package com.suteam.html.role.dao;

import com.suteam.html.common.dao.GenericDao;
import com.suteam.html.role.model.UserRole;

public interface UserRoleDao extends GenericDao<UserRole> {
	/**
	 * 根据名称查询对象
	 * 
	 * @param name
	 * @return
	 */
	public UserRole findByName(String name);

}
