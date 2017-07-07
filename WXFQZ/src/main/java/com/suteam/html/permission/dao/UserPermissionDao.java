package com.suteam.html.permission.dao;

import java.util.List;

import com.suteam.html.common.dao.GenericDao;
import com.suteam.html.permission.model.UserPermission;

public interface UserPermissionDao extends GenericDao<UserPermission> {
	/**
	 * 根据url查询对象
	 * 
	 * @param url
	 * @return
	 */
	public UserPermission findByUrl(String url);
	/**
	 * 根据类型查询集合
	 * @return
	 */
	public List<UserPermission> findAllByType(String type);
	/**
	 * 通过功能模块ID查询集合
	 * @param moduleId
	 * @return
	 */
	public List<UserPermission> findByModuleId(String moduleId);
	
	/**
	 * 通过模块类型，模块编号查询权限集合
	 * @param moduleType
	 * @param moduleId
	 * @return
	 */
	public List<UserPermission> findByModuleTypeModuleId(int moduleType, String moduleId);
	/**
	 * @description 根据模块编号分页查询权限编号集合
	 * ltl
	 * @param moduleId:权限编号；index:分页首条数据的索引；size：每页的数据个数
	 * @return
	 */
	public List<String> findPerIdsByPage(String moduleId, int index, int size);
	
}
