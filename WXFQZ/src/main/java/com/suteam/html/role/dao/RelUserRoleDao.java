package com.suteam.html.role.dao;

import java.util.List;
import com.suteam.html.common.dao.GenericDao;
import com.suteam.html.role.model.RelUserRole;

public interface RelUserRoleDao extends GenericDao<RelUserRole> {

	/**
	 * 根据用户编号查询对象集合
	 * 
	 * @param userId
	 * @return
	 */
	public List<RelUserRole> findByUserId(String userId);
	
	/**
	 * 根据角色获取角色关系列表
	 * 
	 * @author zyz
	 * @param userRoleId
	 * @return
	 */
	public List<RelUserRole> findByRoleId(String userRoleId);
}
