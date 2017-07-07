package com.suteam.html.role.dao;

import java.util.List;

import com.suteam.html.common.dao.GenericDao;
import com.suteam.html.role.model.RelRolePermission;

public interface RelRolePermissionDao extends GenericDao<RelRolePermission> {
	/**
	 * 根据角色编号查询对象集合
	 * 
	 * @param roleId
	 * @return
	 */
	public List<RelRolePermission> findByRoleId(String roleId);
	/**
	 * 根据权限id查询对象集合
	 * mzl
	 * @param roleId
	 * @return
	 */
	public List<RelRolePermission> findByPermissionId(String perId);
	/**
	 * @description 根据权限编号获取角色编号集合
	 * @param permissionId
	 * @return
	 */
	public List<String> findRoleIdsByPermissionId(String permissionId);
	/**
	 * @description 根据角色编号删除角色权限关系
	 * ltl
	 * @param
	 * @return
	 */
	public void deleteByRoleId(String roleId);
	/**
	 * @description 根据角色编号和权限编号获取角色权限关系对象
	 * ltl
	 * @param roleId:角色编号,perId:权限编号
	 * @return
	 */
	public List<RelRolePermission> findByRoleIdAndPerId(String roleId, String perId);
	/**
	 * @description 根据角色编号获取角色权限关系记录的数量
	 * ltl
	 * @param
	 * @return
	 */
	public Integer findSizeByRoleId(String roleId);
	/**
	 * @description 根据权限编号获取角色权限关系记录的数量
	 * ltl
	 * @param
	 * @return
	 */
	public Integer findSizeByPerId(String perId);
	/**
	 * @description 根据权限编号删除角色权限关系
	 * ltl
	 * @param
	 * @return
	 */
	public void deleteByPerId(String perId);
}
