package com.suteam.html.role.service;

import java.util.List;

import com.suteam.html.role.model.RelUserRole;

public interface RelUserRoleMgr {
	/**
	 * 保存对象
	 * 
	 * @param relUserRole
	 */
	public void saveRelUserRole(RelUserRole relUserRole);

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
	public List<RelUserRole> getByRoleId(String userRoleId);
	
	/**
	 * 根据主键删除记录
	 * 
	 * @author zyz
	 * @param id : 主键
	 */
	public void dropById(String id);
}
