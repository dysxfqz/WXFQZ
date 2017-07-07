package com.suteam.html.role.service;

import java.util.List;

import com.suteam.html.role.model.UserRole;

public interface UserRoleMgr {
	/**
	 * 保存对象
	 * 
	 * @param userRole
	 */
	public void saveUserRole(UserRole userRole);

	/**
	 * 根据名称查询对象
	 * 
	 * @param name
	 * @return
	 */
	public UserRole findByName(String name);

	/**
	 * 根据编号查询对象
	 * 
	 * @param id
	 * @return
	 */
	public UserRole findById(String id);
	/**
	 * 查询所有
	 * @return
	 */
	public List<UserRole> findAll();
	
	/**
	 * 删除单条记录
	 * @author zyz
	 * @param userRoleId : 主键
	 */
	public void dropById(String userRoleId);

	/**
	 * @description 删除角色和角色权限关系
	 * ltl
	 * @param
	 * @return
	 */
	public void deleteRoleAndPermission(UserRole userRole);

}
