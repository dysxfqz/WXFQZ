package com.suteam.html.role.service;

import java.util.List;
import com.suteam.html.role.model.RelRolePermission;

public interface RelRolePermissionMgr {
	/**
	 * 保存对象
	 * 
	 * @param relRolePermission
	 */
	public void saveRelRolePermission(RelRolePermission relRolePermission);

	/**
	 * 根据角色编号查询对象集合
	 * 
	 * @param roleId
	 * @return
	 */
	public List<RelRolePermission> findByRoleId(String roleId);
	/**
	 * 删除对象
	 * @param relRolePermission
	 */
	public void deleteRelRolePermission(RelRolePermission relRolePermission);
	/**
	 * 根据权限id查询对象集合
	 * mzl
	 * @param roleId
	 * @return
	 */
	public List<RelRolePermission> findByPermissionId(String perId);

	/**
	 * @description 添加角色权限关系
	 * ltl
	 * @param roleId:角色编号,mids:模块编号组
	 * @return
	 * @throws Exception 
	 */
	public void createRolePermission(String roleId, String mids) throws Exception;

	/**
	 * @description 根据角色编号和权限编号获取角色权限关系对象
	 * ltl
	 * @param roleId:角色编号,perId:权限编号
	 * @return
	 */
	public List<RelRolePermission> findByRoleIdAndPerId(String roleId, String perId);
}
